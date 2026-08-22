# 基本的な設定

## 手動照準

### `FSE_EXT_Turret`

- `TurnSpeedMultiX`と`TurnSpeedMultiY`でそれぞれ上下と左右方向の手動旋回速度を設定します。
- `UpAngleMax`、`DownAngleMax`、`SideAngleMax`を調整して車体やモデルへ干渉しない範囲にします。
- `VJoyRollAsYaw`を有効にすると、Controllerのロールを左右照準へ使用します。
- `InvertVRPitch`を有効にすると、VRモード時の手動照準の上下方向を反転します。
- `ScaleManualAimWithSightFov`を有効にすると、現在のFOVと`ZoomReferenceFov`に基づいて高倍率時に手動照準速度を下げる補正をします。
- `MinManualAimScale`は速度倍率の下限です。0にすると制限を適用せずにFOV比をそのまま使用できます。

## HEAD SLAVE

### `FSE_EXT_Turret`

- `HeadSlaveVROnly`を有効にするとVRだけ、無効にするとDesktopとVRでHEAD SLAVEを使用できます。
- `HeadSlaveSmoothingHalfLife`で頭または視点への追従の滑らかさを調整します。
- `HeadSlaveDeadZoneDeg`で微小な動きを無視する角度を設定します。
- `HeadSlaveMaxYawSlewRate`と`HeadSlaveMaxPitchSlewRate`で最大追従速度を設定します。

VRでHEAD SLAVEを使用中に右手コントローラーのグリップ（中指）を押しながらコントローラーを傾けると、HMDの追従方向に対して照準方向を上下左右へ補正できます。

- `HeadSlaveYawOffsetLimit`と`HeadSlavePitchOffsetLimit`で、左右・上下へ追加できる照準補正角の上限を設定します。
- `HeadSlaveTrimRate`で、右Grip操作による照準補正が反映される速度を設定します。
- `InvertVRPitch`は右Gripによる照準補正へ適用されます。HMD追従そのものの上下方向は変えません。

## Sight Camera／Zoom

### `FSE_DFUNC_SightZoom`

`FSE_DFUNC_SightZoom`は、照準映像の倍率を連続式と切替式の2つの方式で制御することができます。連続式では倍率の操作によって映像のFOVが滑らかに変化し、切替式ではあらかじめ設定された倍率に瞬時に切り替わります。

- `UsePresetSteps`を有効にすると、倍率を切替式で制御し、無効にすると連続式で制御します。
- `ContinuousZoomRate`で連続式選択時の倍率変化速度を調整します。

### `FSE_SightController`

- `MinimumFov`と`MaximumFov`で連続式選択時に使用するFOV範囲を決めます。
- `ZoomPresetMagnifications`で、段階式選択時に使用する倍率を設定します。
