# 設定項目一覧

## FSE_EXT_Turret

### Reference Rotator

| Field | 説明 |
|---|---|
| `ReferenceRotatorHor` | 基準タレットのローカルY軸で左右に回転するTransformです。 |
| `ReferenceRotatorVert` | 基準タレットのローカルX軸で上下に回転するTransformです。 |
| `ControlsRoot` | VR操作で車両回転を相殺し、VR連続式Zoomの前後方向を決める基準Transformです。ローカルの+Z軸を車両前方へ合わせます。 |
| `AimOrigin` | 最終的な照準方向を示すTransformです。 |
| `OperatorSeat` | 初期状態で照準を操作する座席です。[導入手順](installation.md)に従って操作席へ登録している場合は、Take Controlで交代した役割の担当座席を使用します。登録がない場合は、この座席を固定で使用します。 |

### Sight Camera

| Field | 説明 |
|---|---|
| `SightCamera` | 照準映像とFOV連動感度に使用するCameraです。 |
| `SightCameraExcludedLayers` | Sight Cameraだけから除外するLayerです。 |
| `ScaleManualAimWithSightFov` | Camera FOVに応じて手動照準と、右GripによるHEAD SLAVEの照準補正速度を変えます。 |
| `Manual Aim Reference FOV`（`ZoomReferenceFov`） | 通常速度の基準にするFOVです。`ScaleManualAimWithSightFov`が無効な場合は使用されません。 |
| `MinManualAimScale` | FOV連動速度の下限です。0ならFOV比をそのまま使用します。 |

### Drive Mode and Animator

| Field | 説明 |
|---|---|
| `DriveMode` | `Script`は基準タレットと追従タレットを直接回転させます。`Animator`は角度をAnimatorへ出力し、回転をAnimation Clipに任せます。 |
| `ReferenceRotatorAnimator` | 基準タレットのAnimatorです。`Animator`モードでは必須です。`Script`モードでも角度出力に使用できます。 |
| `FollowerRotatorsAnimator` | 追従タレットへ角度を出力するAnimatorです。基準タレットと同じAnimatorも指定できます。`Script`モードでも角度出力に使用でき、未使用なら空欄にできます。 |
| `CurrentYawAnimatorParameter` / `CurrentPitchAnimatorParameter` | 現在の左右・上下角度を出力するFloat Parameter名です。 |
| `TargetYawAnimatorParameter` / `TargetPitchAnimatorParameter` | 目標角度を出力するFloat Parameter名です。HEAD SLAVEでは追従の平滑化前の角度、手動操作と他の参加者側では現在角度を出力します。空欄にした項目は出力しません。 |

### Follower Rotators

| Field | 説明 |
|---|---|
| `FollowerRotatorsHor` | 追従タレットのローカルY軸で左右に回転するTransformの配列です。 |
| `FollowerRotatorsVert` | 同じ番号に対応するローカルX軸で上下に回転するTransformの配列です。 |

存在しない軸は空欄にできます。同じTransformを同じ番号の両配列へ指定すると、一つのTransformを上下左右へ動かします。

### 手動照準

| Field | 説明 |
|---|---|
| `TurnSpeedMultiX` / `TurnSpeedMultiY` | 上下・左右の基本回転速度です。 |
| `MaxJoyAngles` | VR仮想ジョイスティックの最大入力角です。 |
| `VJoyRollAsYaw` | 右手Controllerのロールを左右入力に使います。 |
| `TurningResponseDesktop` | Desktop入力の応答速度です。 |
| `UpAngleMax` / `DownAngleMax` / `SideAngleMax` | 基準タレットの可動範囲です。 |
| `InvertVRPitch` | VR手動照準と、右GripによるHEAD SLAVEの照準補正の上下方向を反転します。 |

### 同期

| Field | 説明 |
|---|---|
| `Stabilize` | 車体が回転したときの照準安定化を有効にします。 |
| `updateInterval` | 操作者の照準方向を他の参加者へ送る間隔です。 |
| `networkSmoothing` | 他の参加者側で砲塔の動きを滑らかに表示する強さです。 |
| `maxRemoteExtrapolation` | 次の更新が届くまで、直前の動きから表示方向を予測する時間の上限です。 |

これらは、他の参加者から見える砲塔の動きを調整する上級者向け設定です。照準速度や角度制限を変更する項目ではなく、通常は既定値を使用します。動きが段階的に見える場合は`updateInterval`を小さくできますが、通信回数が増えます。`networkSmoothing`を大きくすると受信した方向へ速く追従し、小さくすると滑らかになる一方で遅れが増えます。`maxRemoteExtrapolation`を大きくすると更新の停止感を減らせますが、実際の照準方向を一時的に行き過ぎることがあります。変更する場合は、複数クライアントで遅れ、振動、行き過ぎを確認してください。

### HEAD SLAVE

| Field | 説明 |
|---|---|
| `HeadSlaveVROnly` | 有効ならVRだけ、無効ならDesktopとVRでHEAD SLAVEを使用できます。 |
| `HeadSlaveSmoothingHalfLife` / `HeadSlaveDeadZoneDeg` | 頭または視点への追従の平滑化と、微小な動きを無視する角度です。 |
| `HeadSlaveMaxYawSlewRate` / `HeadSlaveMaxPitchSlewRate` | 最大追従速度です。 |
| `HeadSlaveYawOffsetLimit` / `HeadSlavePitchOffsetLimit` | HMD追従方向に対して、右Grip操作で追加できる左右・上下の照準補正角の上限です。 |
| `HeadSlaveTrimRate` | 右Grip操作による照準補正が反映される速度です。 |

## FSE_DFUNC_HeadSlave

| Field | 説明 |
|---|---|
| `TurretController` | 操作対象の`FSE_EXT_Turret`です。 |
| `EnableFunconObjects` | HEAD SLAVE選択中だけ有効にする表示物です。不要なら空配列にします。 |

## FSE_DFUNC_TurretControl

Pilot Seatで単独の砲塔を手動操作するためのDialFunctionです。`FSE_TurretControl` Prefabでは専用の子オブジェクトに設定済みです。Guided Missilesと組み合わせるPilot構成やPassenger構成では通常は登録しません。

| Field | 説明 |
|---|---|
| `TurretController` | 操作対象の`FSE_EXT_Turret`です。Prefab内では設定済みです。 |
| `EnableFunconObjects` | 選択中だけ有効にする表示物です。不要なら空配列にします。 |

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
| `AllowZoomWhileDeselected` | 有効にすると、Sight Zoom以外のDialFunctionを選択中でもDesktopとVRのZoom入力を受け付けます。 |
| `ContinuousZoomRate` | 連続式Zoomの速度です。 |
| `VrHandZForFullSpeed` | VR連続式Zoomが最大速度になる、車両前方基準のController前後移動量（m）です。 |
