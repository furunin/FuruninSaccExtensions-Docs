# 基本的な設定

## 手動照準

### `FSE_EXT_Turret`

- `VJoyRollAsYaw`を有効にすると、Controllerのロールを左右照準へ使用します。
- `InvertVRPitch`を有効にすると、VRモード時の手動照準の上下方向を反転します。
- `ScaleManualAimWithSightFov`を有効にすると、現在のFOVと`ZoomReferenceFov`に基づいて高倍率時に手動照準速度を下げる補正します。
- `MinManualAimScale`は速度倍率の下限です。0にすると制限を適用せずにFOV比をそのまま使用できます。

## HEAD SLAVE

### `FSE_EXT_Turret`

- `HeadSlaveVROnly`を有効にすると、VRモード以外でHEAD SLAVEを無効にします。
- `HeadSlaveSmoothingHalfLife`でHMD追従の滑らかさを調整します。
- `HeadSlaveDeadZoneDeg`で微小な頭の動きを無視する角度を設定します。
- `HeadSlaveMaxYawSlewRate`と`HeadSlaveMaxPitchSlewRate`で最大追従速度を設定します。

HEAD SLAVE機能を使用中に右手コントローラーのグリップ（中指）を押しながら右手コントローラーを傾けると、HMDが向いている方向から照準位置を上下左右へ動かして微調整することができます。

- `HeadSlaveYawOffsetLimit`と`HeadSlavePitchOffsetLimit`で右Grip微調整の最大範囲です。
- `HeadSlaveTrimRate`：微調整速度です。
- `InvertVRPitch`は右Gripによる微調整へ適用されます。HMD追従そのものの上下方向は変えません。

## Sight Camera／Zoom

### `FSE_DFUNC_SightZoom`

`FSE_DFUNC_SightZoom`は、照準映像の倍率を連続式と切替式の2つの方式で制御することができます。連続式では倍率の操作によって映像のFOVが滑らかに変化し、切替式ではあらかじめ設定された倍率に瞬時に切り替わります。

- `UsePresetSteps`を有効にすると、倍率を切替式で制御し、無効にすると連続式で制御します。
- `ContinuousZoomRate`で連続式選択時の倍率変化速度を調整します。

### `FSE_SightController`

- `MinimumFov`と`MaximumFov`で連続式選択時に使用するFOV範囲を決めます。
- `ZoomPresetMagnifications`で、段階式選択時に使用する倍率を設定します。
