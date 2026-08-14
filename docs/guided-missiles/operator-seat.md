# PassengerSeat／PilotSeat

一つの`FSE_DFUNC_MissileLauncher`は、設定した一席だけから操作します。PassengerSeatとPilotSeatへ同じランチャーを同時登録しないでください。

## PassengerSeatで操作する

1. `FSE_DFUNC_MissileLauncher`の`OperatorSeat`へ対象のPassengerSeatを指定します。
2. PassengerSeatの`Sacc Vehicle Seat`の`Passenger Functions`に指定されているオブジェクトをクリックし、インスペクターを開きます。
3. ランチャーをPassenger Functionsの左右どちらか一方のDialFunctionへ一度だけ登録します。
4. `Resupply Trigger`が車両の`InvehicleOnly/PilotOnly`以下にある場合は、`InvehicleOnly`直下に移動してください。パイロットシートに座らなくてもミサイルを補給できるようになります。

## PilotSeatで操作する

1. `FSE_DFUNC_MissileLauncher`の`OperatorSeat`へ対象のPilotSeatを指定します。
2. `PassengerFunctionsController`は未設定にします。
3. `EntityControl`へ対象車両の`SaccEntity`を指定します。
4. `SAVControl`へ対象車両のSacc制御Componentを指定します。
5. ランチャーを`SaccEntity`の左右どちらか一方のDialFunctionへ一度だけ登録します。

PilotSeatでミサイルを選択している間は、機体操作と照準操作が重ならないように飛行入力が抑止されます。
