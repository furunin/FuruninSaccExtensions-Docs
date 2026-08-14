# 手動照準

## Desktop

- `W`：上
- `S`：下
- `A`：左
- `D`：右

上下左右キーは照準器に使用しません。MCLOSを併用する場合、矢印キーは飛翔中ミサイルの操作に使用できます。

## VR

右手Gripを押した時点を中立位置として、右手Controllerの傾きで照準します。

- 前後方向の操作：上下照準
- 左右方向の操作：左右照準
- `VJoyRollAsYaw`を有効にすると、Controllerのロールを左右照準へ使用します。
- `InvertVRPitch`はVR手動照準の上下方向を反転します。

機体が旋回しても、Grip中に手を固定しているだけでは照準入力が発生しないよう、`ControlsRoot`の回転が補正されます。

## Target Tracking中の手動補正

Target Tracking中も`W/A/S/D`とVRの手動照準で追尾位置へ補正を加えられます。補正は追尾が続く間も保持されます。追尾を失った場合は、その時点の照準角度のまま手動照準へ戻ります。

## Zoom時の速度

`ScaleManualAimWithSightFov`が有効な場合、実際の`SightCamera.fieldOfView`に合わせてDesktop／VR手動照準とHEAD SLAVEの微調整速度を下げます。HMD方向そのものへのHEAD SLAVE追従倍率は変えません。
