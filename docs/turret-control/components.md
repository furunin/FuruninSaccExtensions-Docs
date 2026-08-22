# 設定項目一覧

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
| `updateInterval` | 操作者の照準方向を他の参加者へ送る間隔です。 |
| `networkSmoothing` | 他の参加者側で砲塔の動きを滑らかに表示する強さです。 |
| `maxRemoteExtrapolation` | 次の更新が届くまで、直前の動きから表示方向を予測する時間の上限です。 |

これらは、他の参加者から見える砲塔の動きを調整する上級者向け設定です。照準速度や角度制限を変更する項目ではなく、通常は既定値を使用します。`updateInterval`は`0.2`秒（下限`0.05`秒）です。他の参加者から見た動きが段階的な場合は小さくできますが、通信回数が増えます。`networkSmoothing`は`6`で、大きくすると受信した方向へ速く追従し、小さくすると滑らかになる一方で遅れが増えます。`maxRemoteExtrapolation`は`0.5`秒で、通信が不安定な環境で停止感を減らせますが、大きすぎると実際の照準方向を一時的に行き過ぎる可能性があります。変更する場合は、複数クライアントで遅れ、振動、行き過ぎを確認してください。

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
| `ExclusiveTargetTracking` | 排他的に切り替える`FSE_DFUNC_TargetTracking`です。 |

## FSE_DFUNC_TurretControl

Pilot Seatで単独の砲塔を手動操作するためのDialFunctionです。`FSE_TurretControl` Prefabでは専用の子オブジェクトに設定済みです。Guided Missilesと組み合わせるPilot構成やPassenger構成では通常は登録しません。

| Field | 説明 |
|---|---|
| `TurretController` | 操作対象の`FSE_EXT_Turret`です。Prefab内では設定済みです。 |
| `EnableFunconObjects` | 選択中だけ有効にする表示物です。不要なら空配列にします。 |

## FSE_TurretTargetTracker／FSE_DFUNC_TargetTracking

Target Trackingは対応するSacc車両だけを対象にします。`FSE_DFUNC_TargetTracking`を選択した時に、正面付近にある候補を一度だけ取得します。追尾中に候補を周期的に探し直すことはありません。

| Field | 説明 |
|---|---|
| `TurretController` | 操作対象の`FSE_EXT_Turret`です。TrackerとDFUNCの両方に設定します。 |
| `SearchReference` | 候補を探す基準Transformです。必要に応じて設定します。 |
| `FunctionController` | Trackerと組み合わせる`FSE_DFUNC_TargetTracking`です。 |
| `CandidateLayers` / `OcclusionLayers` | 追尾候補のLayerと、照準線を遮るLayerです。 |
| `MaximumDetectionDistance` | 候補を探す最大距離です。コード既定値は3000 mです。 |
| `SearchHorizontalHalfAngle` / `SearchVerticalHalfAngle` | 候補を探す左右・上下の半角です。コード既定値は30°／20°です。 |
| `MinimumAcquireInterval` / `RequireLineOfSight` | 再選択時の最短検索間隔と、遮蔽確認の有効化です。 |
| `MaximumTrackingYawSlewRate` / `MaximumTrackingPitchSlewRate` | 追尾中の左右・上下の最大旋回速度です。コード既定値は90°/秒／60°/秒です。 |
| `ValidationInterval` | 追尾対象を再確認する間隔です。コード既定値は0.1秒です。 |
| `OcclusionGraceSeconds` / `RangeGraceSeconds` / `OutOfTraverseGraceSeconds` | 遮蔽、距離超過、可動範囲超過で追尾を解除するまでの猶予です。 |
| `TraverseMarginDegrees` | 可動範囲の判定へ加える余裕角です。 |
| `TrackAirVehicles` / `TrackGroundVehicles` / `TrackSeaVehicles` / `TrackAAGunVehicles` | 追尾を許可するSacc車両の種類です。 |
| `ExclusiveHeadSlave` | 排他的に切り替える`FSE_DFUNC_HeadSlave`です。 |
| `EnableWhenSelected` / `EnableWhenLocked` / `EnableWhenNoTarget` | 選択中、追尾中、対象なしの各状態で表示するObjectです。 |
| `LockSound` / `UnlockSound` / `NoTargetSound` | 各状態の任意Audioです。 |

必要に応じて追尾状態のIndicatorやAudio参照を設定できます。

## FSE_SightController

| Field | 説明 |
|---|---|
| `TurretController` / `SightCamera` | 操作する砲塔とSight Cameraです。 |
| `RangefinderOrigin` / `RangefinderText` | 測距方向の基準と距離表示用TextMeshProです。 |
| `MinimumFov` / `MaximumFov` | Zoomで使用するSight CameraのFOV範囲です。 |
| `ZoomPresetMagnifications` | 段階式Zoomの倍率一覧です。正数かつ昇順で設定します。 |
| `RangefinderDistance` | 距離計の最大測定距離です。 |
| `RangefinderLayers` | 距離計が測定するLayerです。 |
| `RangefinderUpdateInterval` | 距離計の更新間隔です。 |

## FSE_DFUNC_SightZoom

| Field | 説明 |
|---|---|
| `SightController` | 操作する`FSE_SightController`です。 |
| `UsePresetSteps` | 段階式Zoomを使用します。無効なら連続式です。 |
| `ContinuousZoomRate` | 連続式Zoomの速度です。 |
| `VrHandZForFullSpeed` | VR連続式で全速になる前後移動量です。 |
