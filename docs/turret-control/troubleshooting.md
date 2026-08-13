# トラブルシューティング

| 症状 | 確認項目 |
|---|---|
| 照準器が動かない | `OperatorSeat`、`AimYawRotator`、`AimPitchRotator`、SaccEntityのExtension登録を確認します。 |
| Play開始時に意図しない方向を向く | Pivotの軸と親子関係を確認し、モデル固有の回転はPivotではなく子Wrapperへ設定します。 |
| VR操作の方向が逆 | `InvertVRPitch`と`VJoyRollAsYaw`を確認します。 |
| 機体旋回だけで照準が動く | `ControlsRoot`が機体回転を表す適切なTransformか確認します。 |
| HEAD SLAVEが動かない | `FSE_DFUNC_HeadSlave.TurretController`、Dial選択、`HeadSlaveVROnly`を確認します。 |
| 自分だけ動く、または他者に見えない | 座席と、PilotSeatで連携する武器の設定を確認します。前の操作者が退席した後に座り直し、HEAD SLAVEは再選択して`HeadSlaveVROnly`も確認します。一人での操作を別の参加者にも確認してもらい、必要ならRespawnします。`OperatorSeat`と`TurretController`の参照も確認します。 |
| 追従砲塔が動かない | Yaw／Pitch配列の数、同indexの組、Primary Aimとの重複、別軸構成の親子関係を確認します。 |
| 追従砲塔が90度ずれる | モデルのforward軸をUnityの青いZ軸へ合わせるWrapperを使用します。 |
| 照準画面が黒い | Cameraの有効状態、Target Texture、表示Material、座席の`EnableInSeat`を確認します。 |
| HUDの線が照準画面へ映る | HUD用Layerを`SightCameraExcludedLayers`へ含めます。 |
| Zoomできない | `DFUNC_SlideAnimation`、Animator、Float Parameter、Animation ClipのCamera FOV Bindingを確認します。 |
| Zoom時の照準速度が合わない | Cameraの実FOV、`ZoomReferenceFov`、`MinManualAimScale`を確認します。 |
