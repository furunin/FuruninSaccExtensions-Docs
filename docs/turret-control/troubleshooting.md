# トラブルシューティング

| 症状 | 確認項目 |
|---|---|
| 照準器が動かない | `OperatorSeat`、`AimYawRotator`、`AimPitchRotator`、SaccEntityのExtension登録を確認します。 |
| Play開始時に意図しない方向を向く | Pivotの軸と親子関係を確認し、モデル固有の回転はPivotではなく子Wrapperへ設定します。 |
| VR操作の方向が逆 | `InvertVRPitch`と`VJoyRollAsYaw`を確認します。 |
| 機体旋回だけで照準が動く | `ControlsRoot`が機体回転を表す適切なTransformか確認します。 |
| HEAD SLAVEが動かない | `FSE_DFUNC_HeadSlave.TurretController`、Dial選択、`HeadSlaveVROnly`を確認します。 |
| HEAD SLAVEとTarget Trackingが意図せず切り替わる | `ExclusiveTargetTracking`と`ExclusiveHeadSlave`が相互に設定されているか確認します。後から選択した機能が有効です。 |
| Target Trackingが開始しない | Trackerと`FSE_DFUNC_TargetTracking`の両方の`TurretController`、`FSE_EXT_Turret.TargetTracker`、Dial登録、`CandidateLayers`を確認します。`SearchReference`を使う場合はその参照も確認します。 |
| Target Trackingが対象を見つけない、またはすぐ失う | 対象が対応するSacc車両であること、Layer、距離・角度・遮蔽条件、猶予時間と車種のFieldを確認します。選択時に一度だけ候補を取得するため、対象が移動した後はDialFunctionを選び直します。 |
| 自分だけ動く、または他者に見えない | 座席と、PilotSeatで連携する武器の設定を確認します。前の操作者が退席した後に座り直し、HEAD SLAVEは再選択して`HeadSlaveVROnly`も確認します。一人での操作を別の参加者にも確認してもらい、必要ならRespawnします。`OperatorSeat`と`TurretController`の参照も確認します。 |
| 追従砲塔が動かない | Yaw／Pitch配列の数、同indexの組、Primary Aimとの重複、別軸構成の親子関係を確認します。 |
| 追従砲塔が90度ずれる | モデルのforward軸をUnityの青いZ軸へ合わせるWrapperを使用します。 |
| 照準画面が黒い | Cameraの有効状態、Target Texture、表示Material、座席の`EnableInSeat`を確認します。 |
| HUDの線が照準画面へ映る | HUD用Layerを`SightCameraExcludedLayers`へ含めます。 |
| Zoomできない | `FSE_DFUNC_SightZoom.SightController`、Dial登録、`MinimumFov`と`MaximumFov`を確認します。段階式DesktopではZoomをDialFunctionで選択してから`Q`／`E`を操作します。 |
| Zoom時の照準速度が合わない | Cameraの実FOV、`ZoomReferenceFov`、`MinManualAimScale`を確認します。 |
| 距離が表示されない、または`RNG ----`になる | 操作席を使用中か、`RangefinderOrigin`またはSight Camera／Aim Originの参照、`RangefinderLayers`、測定範囲内に対象があるか確認します。 |
