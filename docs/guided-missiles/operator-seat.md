# PassengerSeat／PilotSeat

一つの`FSE_DFUNC_MissileLauncher`は、設定した一席だけから操作します。PassengerSeatとPilotSeatへ同じランチャーを同時登録しません。

## 共通ルール

`OperatorSeat`は実際にランチャーを操作する席を参照します。ランチャーはその席で使うDialFunctionの左右どちらか一方へ一度だけ登録します。

ランチャーだけを登録するDialでは、`Dial_Functions_L`または`Dial_Functions_R`の配列サイズを`1`にし、element 0へ`FSE_DFUNC_MissileLauncher`を指定できます。席へ座るとランチャーが自動で選択されるため、キーまたはスティックで選択し直す必要はありません。element 0を未設定にはしません。

複数のDialFunctionを登録するDialは、従来どおりキーまたはスティックでランチャーを選択します。既存の複数項目構成を変更する必要はありません。

ランチャーが選択されても、発射、MCLOS入力、Dialのロックは、設定した席へ座って通常の車両操作を開始した後に有効になります。

## PassengerSeatで操作する

### 必須参照

1. `FSE_DFUNC_MissileLauncher.OperatorSeat`へ、ミサイルを操作するPassengerSeatを指定します。
2. PassengerSeatの`Sacc Vehicle Seat.Passenger Functions`が参照する`SAV_PassengerFunctionsController`を確認します。
3. 同じControllerを`FSE_DFUNC_MissileLauncher.PassengerFunctionsController`へ指定します。
4. `SAVControl`、`EntityControl`、`CollisionHostRoot`へ、ランチャーを搭載する車両の参照を指定します。

### DialFunctionとExtensionの登録

1. `FSE_DFUNC_MissileLauncher`を、同じControllerの`Dial_Functions_L`または`Dial_Functions_R`へ一度だけ登録します。`SaccEntity`のPilot用Dialや別のPassenger Functionsへは登録しません。
2. `FSE_EXT_Turret`を同じControllerの`PassengerExtensions`へ登録します。`FSE_EXT_Turret`はDialFunction配列へ登録しません。

### 座席使用中に有効にするObject

Sight Camera、照準器の操作用Object、Sight表示に必要なObjectをPassengerSeatの`EnableInSeat`へ登録します。

## PilotSeatで操作する

### 必須参照

1. `FSE_DFUNC_MissileLauncher.OperatorSeat`へ、ミサイルを操作するPilotSeatを指定します。
2. `PassengerFunctionsController`は未設定にします。
3. `EntityControl`へ対象車両の`SaccEntity`を指定します。
4. `SAVControl`へ対象車両のSacc制御Componentを指定します。
5. `CollisionHostRoot`へ発射直後の衝突判定から除外する車両階層のrootを指定します。

### DialFunctionへの登録

`FSE_DFUNC_MissileLauncher`を`SaccEntity`の`Dial_Functions_L`または`Dial_Functions_R`へ一度だけ登録します。Passenger Functionsへは登録しません。

PilotSeatでミサイルを選択している間は、機体操作と照準操作が重ならないように飛行入力が抑止されます。

## SH-1 Sampleの座席構成

### 右Dialの構成

SH-1 Sampleの`CoPilotFunctions.Dial_Functions_R`には、無効な`DFUNC_TakeControl`を先頭、`FSE_DFUNC_MissileLauncher`を次の項目として登録します。現在の完成Sampleはこの2項目構成のまま使用します。

### Take Controlを使用しない理由

SH-1 SampleではPilotとミサイル操作席の役割を`DFUNC_TakeControl`で入れ替えません。`DFUNC_TakeControl`と`TakeControlToggler`は無効のままにし、参照されている`DFUNC_TakeControl`を`EditorOnly`に指定しません。
