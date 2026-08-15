# 共通セットアップ

以下は各誘導方式に共通する手順です。共通セットアップの後に各誘導方式固有の設定を行います。

## 1. 配布Prefabを確認する

`SH-1_GuidedMissile_MCLOS`と`SH-1_GuidedMissile_SACLOS`は完成Sampleです。独自車両へ搭載する場合は、両Sampleを改造するのではなく、`FSE_GuidedMissile`を配置して以下の手順で車両固有参照を接続します。

## 2. FSE_GuidedMissileを配置する

車両階層の下へ`FSE_GuidedMissile`を配置します。配布済みのSubComponent Prefabを展開したり、Prefab Variantを作成したりしません。

### Prefab内で設定済みの項目

`LaunchPoints`、`AmmoMeshes`、`ProjectilePool`、`PoolRoot`、および各飛翔弾の内部参照はPrefab内で接続済みです。ラック容量を変更する場合以外は、これらの配列と順序を変更しません。

### 車両ごとに接続する項目

`FSE_DFUNC_MissileLauncher`で、`SAVControl`へ車両のSacc制御Component、`EntityControl`へ車両の`SaccEntity`、`CollisionHostRoot`へ発射直後の衝突判定から除外する車両階層のroot、`OperatorSeat`へ操作席を指定します。PassengerSeatで操作する場合だけ、同じ席の`SAV_PassengerFunctionsController`を`PassengerFunctionsController`へ指定します。

## 3. 操作席を設定する

操作席ごとの参照とDialFunctionの登録は[PassengerSeat／PilotSeat](operator-seat.md)を参照してください。

## 4. 照準器を車両へ接続する

### FSE_TurretControl

`FSE_TurretControl`内の`FSE_EXT_Turret`で、`OperatorSeat`、`ControlsRoot`、`TurretForwardEmpty`を車両側の対象へ接続します。`AimYawRotator`、`AimPitchRotator`、`AimOrigin`、`SightCamera`、Sight Controllerの参照はPrefab内で接続済みのため、通常変更しません。

車両の砲塔またはランチャーメッシュを照準器へ追従させる場合だけ、`TurretGunYawRotators`と`TurretGunPitchRotators`へそのTransformを登録します。追従させる車両側Transformがない構成では、両配列を空のままにします。

### Sight Cameraと距離表示

操作席の`EnableInSeat`へ、Sight Cameraと照準器の操作に必要なGameObjectを登録します。座席使用中にSight Cameraが有効になり、その`TargetTexture`を使用するMaterialが車両のSight表示へ設定されていることを確認します。距離表示を使用する場合は、`FSE_SightController.RangefinderText`へ表示用Textを指定します。

## 5. 発射位置と搭載弾表示を調整する

各`Launch Point`を発射位置へ置き、ローカルの正Z方向を発射方向へ向けます。対応する`Missile Round_Stowed`はラック上の表示位置へ置きます。`LaunchPoints`、`AmmoMeshes`、`ProjectilePool`は同じ順序で対応するため、いずれかの順序だけを変更しません。

## 6. 誘導方式を選択する

- [MCLOSを設定する](mclos.md)
- [SACLOSを設定する](saclos.md)

二つの誘導Componentを同じミサイルの`GuidanceModule`へ同時に指定しないでください。

## 7. 補給を設定する

搭乗せずに補給できる構成では、`InVehicleOnly`の下に有効な`ResupplyTrigger`を一つ配置します。`PilotOnly`の下へは配置せず、同じ補給範囲に別のSacc補給Triggerを重複配置しません。

## 8. 設定を確認する

`FSE_DFUNC_MissileLauncher`を操作席で使用する左右どちらか一方のDialFunctionへ一度だけ登録します。同じランチャーを複数のDial配列や複数席へ登録すると、操作は安全のため無効になります。

任意機能は、基本的な発射と誘導が動作した後に[任意機能](optional-features.md)から追加してください。

Sampleでは、左Dialへ`FSE_DFUNC_HeadSlave`、`FSE_DFUNC_SightZoom`、右DialへGun、`FSE_DFUNC_MissileLauncher`の順で登録されています。ミサイル選択時の既存連携を使用するため、`FSE_DFUNC_TurretControl`をSampleのDial配列へ追加しません。Target Trackingは任意のAddonで、MCLOS／SACLOSの動作に必須ではありません。
