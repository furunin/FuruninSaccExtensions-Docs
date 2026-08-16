# 操作席の設定

## PassengerSeatで操作する場合

1. PassengerSeatの`Sacc Vehicle Seat.Passenger Functions`が参照する`SAV_PassengerFunctionsController`を確認します。
2. 1.で確認した`SAV_PassengerFunctionsController`を、`FSE_GuidedMissile`の`FSE_DFUNC_MissileLauncher.PassengerFunctionsController`へ指定します。
3. `SAV_PassengerFunctionsController`の`Dial_Functions_L/R`に`FSE_DFUNC_MissileLauncher`を登録します。
4. `SAV_PassengerFunctionsController`の`PassengerExtensions`に`FSE_EXT_Turret`を登録します。

### PilotSeatで操作する場合

PilotSeatでミサイルを選択している間は、機体操作と照準操作が重ならないように機体操作が抑止されます。

1. `PassengerFunctionsController`は未設定にします。
2. `FSE_DFUNC_MissileLauncher`を、セットアップ対象の乗り物の`SaccEntity`の`Dial_Functions_L/R`に登録します。
