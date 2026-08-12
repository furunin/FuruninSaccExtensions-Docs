# PassengerSeat／PilotSeat

一つの`FSE_DFUNC_MissileLauncher`は、設定した一席だけから操作します。PassengerSeatとPilotSeatへ同じランチャーを同時登録しないでください。

## PassengerSeatで操作する

1. `OperatorSeat`へ対象のPassengerSeatを指定します。
2. `PassengerFunctionsController`へ、その座席の`SAV_PassengerFunctionsController`を指定します。
3. ランチャーをPassenger Functionsの左右どちらか一方のDialFunctionへ一度だけ登録します。

## PilotSeatで操作する

1. `OperatorSeat`へ対象のPilotSeatを指定します。
2. `PassengerFunctionsController`は未設定にします。
3. `EntityControl`へ対象車両の`SaccEntity`を指定します。
4. `SAVControl`へ対象車両のSacc制御Componentを指定します。
5. ランチャーを`SaccEntity`の左右どちらか一方のDialFunctionへ一度だけ登録します。

PilotSeatでミサイルを選択している間は、機体操作と照準操作が重ならないように飛行入力が抑止されます。

## Auto Hoverを使う一人操作

1. PilotSeatでAuto Hoverを有効にします。
2. ミサイル機能を選択します。
3. 照準、発射、誘導を行います。
4. ミサイル機能の選択を解除します。

ミサイル機能は、自分が追加した飛行入力の抑止だけを解除します。先に有効化したAuto Hoverは維持されます。Auto Hoverを有効にしない場合、ミサイル選択中に姿勢や高度を自動保持する機能はありません。

`DFUNC_TakeControl`による実行中の操作席交換には対応しません。
