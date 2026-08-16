# 共通セットアップ

以下は各誘導方式に共通する手順です。共通セットアップの後に各誘導方式固有の設定を行います。

## 1. 乗り物の事前準備

Guided Missileをセットアップする対象の乗り物にSaccをセットアップし、正常に動作することを確認します。

## 2. FSE_GuidedMissileを配置する

`Assets/Furunin/SaccExtensions/Prefabs/Guided Missile/SubComponents/FSE_GuidedMissile`を乗り物の`Sacc Entity`の下へ配置します。

### Prefab内で設定済みの項目

`LaunchPoints`、`AmmoMeshes`、`ProjectilePool`、`PoolRoot`、および各飛翔弾の内部参照はPrefab内で接続済みです。ラック容量を変更する場合以外は、これらの配列と順序を変更しません。

### 乗り物ごとに設定する項目

`FSE_GuidedMissile`オブジェクトの`FSE_DFUNC_MissileLauncher`に以下の設定をします。

- `SAVControl`：乗り物の`Sacc Air Vehicle`コンポーネント
- `EntityControl`：乗り物の`SaccEntity`コンポーネント
- `CollisionHostRoot`：発射直後の衝突判定から除外するオブジェクト
- `OperatorSeat`：ミサイルの発射・誘導を行う操作席のオブジェクト

## 3. 操作席を設定する

### PassengerSeatで操作する場合

1. PassengerSeatの`Sacc Vehicle Seat.Passenger Functions`が参照する`SAV_PassengerFunctionsController`を確認します。
2. 1.で確認した`SAV_PassengerFunctionsController`を、`FSE_GuidedMissile`の`FSE_DFUNC_MissileLauncher.PassengerFunctionsController`へ指定します。
3. `SAV_PassengerFunctionsController`の`Dial_Functions_L/R`に`FSE_DFUNC_MissileLauncher`を登録します。
4. `SAV_PassengerFunctionsController`の`PassengerExtensions`に`FSE_TurretControl`を登録します。

### PilotSeatで操作する場合

PilotSeatでミサイルを選択している間は、機体操作と照準操作が重ならないように機体操作が抑止されます。

1. `PassengerFunctionsController`は未設定にします。
2. `FSE_DFUNC_MissileLauncher`を、セットアップ対象の乗り物の`SaccEntity`の`Dial_Functions_L/R`に登録します。

## 4. 照準器を乗り物へ接続する

`FSE_GuidedMissile/FSE_TurretControl`オブジェクトの`FSE_EXT_Turret`に以下の設定をします。

- `ControlsRoot`：VR操作で機体回転を相殺する基準Transform
- `TurretForwardEmpty`：砲塔の基準方向に使用するTransform
- `OperatorSeat`：ミサイルの発射・誘導を行う操作席のオブジェクト
乗り物の砲塔またはランチャーメッシュを照準器へ追従させる場合は、`TurretGunYawRotators`と`TurretGunPitchRotators`へそのTransformを登録します。

操作席の`Sacc Vehicle Seat`オブジェクトの`EnableInSeat`へ、以下のオブジェクトを登録します。

- `FSE_GuidedMissile/FSE_TurretControl/Yaw Pivot/Pitch Pivot/Aim Origin`
- `FSE_GuidedMissile/FSE_TurretControl/Sight Display`

## 5. 発射位置と搭載弾表示を調整する

`Missile Launcher`以下の各ミサイルの`Launch Point`のTransformを調整します。青いZ軸の方向が発射方向を向くようにします。対応する`Missile Round_Stowed`はラック上の表示位置へ置きます。

## 6. 誘導方式を選択する

- [MCLOSを設定する](mclos.md)
- [SACLOSを設定する](saclos.md)

## 7. `ResupplyTrigger`の配置を変更する（任意）

`InVehicleOnly`直下に`ResupplyTrigger`を配置することで、パイロット席に着席しなくてもミサイルを補給できるようになります。`ResupplyTrigger`は、SH-1の場合はデフォルトで`InVehicleOnly/PilotOnly`に配置されています。`ResupplyTrigger`の配置変更を行った場合は、オリジナルの`ResupplyTrigger`オブジェクトを削除、無効化、またはEditorOnlyにしてください。

## 8. 任意機能を設定する

任意機能は、基本的な発射と誘導が動作した後に[任意機能](optional-features.md)から追加してください。
