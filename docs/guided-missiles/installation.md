# 共通セットアップ

以下は各誘導方式に共通する手順です。共通セットアップの後に各誘導方式固有の設定を行います。

## 1. 乗り物の事前準備

Guided Missileをセットアップする対象の乗り物にSaccをセットアップし、正常に動作することを確認します。

## 2. FSE_GuidedMissileを配置する

`Assets/Furunin/SaccExtensions/Prefabs/Guided Missile/SubComponents/FSE_GuidedMissile`を乗り物の`Sacc Entity`の下へ配置します。

`FSE_GuidedMissile`オブジェクトの`FSE_DFUNC_MissileLauncher`に以下の設定をします。

- `SAVControl`：乗り物の`Sacc Air Vehicle`コンポーネント
- `EntityControl`：乗り物の`SaccEntity`コンポーネント
- `CollisionHostRoot`：発射直後の衝突判定から除外するオブジェクト
- `OperatorSeat`：ミサイルの発射・誘導を行う操作席のオブジェクト

## 3. 操作席の設定をする

### PassengerSeatで操作する場合

1. PassengerSeatの`Sacc Vehicle Seat`内`Passenger Functions`が参照する`SAV_PassengerFunctionsController`をクリックします。
2. `SAV_PassengerFunctionsController`を`FSE_GuidedMissile`の`FSE_DFUNC_MissileLauncher`内`PassengerFunctionsController`へ登録します。
3. `SAV_PassengerFunctionsController`の`Dial_Functions_L`または`Dial_Functions_R`に`FSE_GuidedMissile`オブジェクトを登録します。

### PilotSeatで操作する場合

PilotSeatでミサイルを選択している間は、機体操作と照準操作が重ならないように機体操作が抑止されます。

1. `PassengerFunctionsController`は未設定にします。
2. `FSE_DFUNC_MissileLauncher`を、セットアップ対象の乗り物の`SaccEntity`の`Dial_Functions_L`または`Dial_Functions_R`に登録します。

## 4. ミサイルの発射位置と搭載弾表示を調整する

`Missile Launcher`以下の各ミサイルの`Launch Point`の位置と回転を調整します。Z軸+（青い矢印）方向が発射方向を向くようにします。メッシュを差し替えることで任意の3Dモデルを使用することができます。

## 5. 照準器を乗り物へ接続する

- 誘導方式にSACLOS以外を使用する場合は、この手順は任意です。
- 誘導方式にSACLOSを使用する場合は、誘導の基準となるオブジェクトを指定する必要があります。可動する照準器（砲塔）に基準オブジェクトを配置することでミサイルを任意方向に誘導できますが、固定のオブジェクトを利用することも可能です。砲塔を使用する場合、FSE Turret Controlを利用することができます（[セットアップ手順](../turret-control/installation.md)）。

## 6. 誘導方式別の導入をする

- [MCLOSを導入する](mclos.md)
- [SACLOSを導入設定する](saclos.md)

## 7. 任意機能を導入する

任意機能は、基本的な発射と誘導が動作した後に[任意機能の導入](optional-features.md)から追加してください。
