# Component設定

## FSE_EXT_Turret

### Primary Aim Rotators

| Field | 説明 |
|---|---|
| `AimYawRotator` | 照準器を左右へ動かす主軸です。 |
| `AimPitchRotator` | 照準器を上下へ動かす主軸です。Yaw軸の子にします。 |
| `ControlsRoot` | VR操作で機体回転を相殺する基準Transformです。 |
| `TurretForwardEmpty` | 砲塔の基準方向に使用するTransformです。 |
| `AimOrigin` | 最終的な照準方向を示すTransformです。 |
| `OperatorSeat` | 照準を操作する座席です。 |

### Sight Camera

| Field | 説明 |
|---|---|
| `SightCamera` | 照準映像とFOV連動感度に使用するCameraです。 |
| `SightCameraExcludedLayers` | Sight Cameraだけから除外するLayerです。 |
| `ScaleManualAimWithSightFov` | Camera FOVに応じて手動照準と微調整速度を変えます。 |
| `ZoomReferenceFov` | 通常速度の基準にするFOVです。 |
| `MinManualAimScale` | FOV連動速度の下限です。0ならFOV比をそのまま使用します。 |

### Turret Gun Followers

| Field | 説明 |
|---|---|
| `TurretGunYawRotators` | 追従砲塔の左右軸です。 |
| `TurretGunPitchRotators` | 同じindexに対応する上下軸です。 |

同じTransformを同じindexの両配列へ指定すると、一つのTransformを上下左右へ動かします。

### 手動照準

| Field | 説明 |
|---|---|
| `TurnSpeedMultiX` / `TurnSpeedMultiY` | 上下・左右の基本回転速度です。 |
| `MaxJoyAngles` | VR仮想ジョイスティックの最大入力角です。 |
| `VJoyRollAsYaw` | 右手Controllerのロールを左右入力に使います。 |
| `TurningResponseDesktop` | Desktop入力の応答速度です。 |
| `UpAngleMax` / `DownAngleMax` / `SideAngleMax` | 主照準器の可動範囲です。 |
| `InvertVRPitch` | VR手動照準と微調整の上下方向を反転します。 |

### 同期

| Field | 説明 |
|---|---|
| `Stabilize` | 車体が回転したときの照準安定化を有効にします。 |
| `updateInterval` | 所有者が照準状態を送る間隔です。 |
| `networkSmoothing` | Remote側の表示を滑らかにする強さです。 |
| `maxRemoteExtrapolation` | Remote側で補間に使用する外挿時間の上限です。 |

### HEAD SLAVE

| Field | 説明 |
|---|---|
| `HeadSlaveVROnly` | VR以外でHEAD SLAVEを無効にします。 |
| `HeadSlaveSmoothingHalfLife` / `HeadSlaveDeadZoneDeg` | HMD追従の平滑化と微小動作を無視する角度です。 |
| `HeadSlaveMaxYawSlewRate` / `HeadSlaveMaxPitchSlewRate` | 最大追従速度です。 |
| `HeadSlaveYawOffsetLimit` / `HeadSlavePitchOffsetLimit` | 右Grip微調整の最大範囲です。 |
| `HeadSlaveTrimRate` | 微調整速度です。 |

## FSE_DFUNC_HeadSlave

| Field | 説明 |
|---|---|
| `TurretController` | 操作対象の`FSE_EXT_Turret`です。 |
| `EnableFunconObjects` | HEAD SLAVE選択中だけ有効にする表示物です。不要なら空配列にします。 |
