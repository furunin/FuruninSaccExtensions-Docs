# 設定項目一覧

## FSE_EXT_Turret

### Reference Rotator

| Field | 説明 |
|---|---|
| `ReferenceRotatorHor` | 基準タレットのローカルY軸で左右に回転するトランスフォームです。 |
| `ReferenceRotatorVert` | 基準タレットのローカルX軸で上下に回転するトランスフォームです。 |
| `ControlsRoot` | VR操作で車両回転を相殺し、VR連続式ズームの前後方向を決める基準トランスフォームです。ローカルの+Z軸を車両前方へ合わせます。 |
| `AimOrigin` | 最終的な照準方向を示すトランスフォームです。 |
| `OperatorSeat` | 照準を操作する座席です。 |

### Sight Camera

| Field | 説明 |
|---|---|
| `SightCamera` | 照準映像とFOV連動感度に使用するCameraです。 |
| `SightCameraExcludedLayers` | Sight Cameraでのみ描画から除外するLayerです。 |
| `ScaleManualAimWithSightFov` | Camera FOVに応じて手動照準速度、および右グリップによるHEAD SLAVE照準補正の速度を調整します。 |
| `Manual Aim Reference FOV`（`ZoomReferenceFov`） | 通常速度の基準とするFOVです。`ScaleManualAimWithSightFov`が無効な場合は使用されません。 |
| `MinManualAimScale` | FOV連動速度の下限倍率です。0に設定すると制限を設けず、FOV比をそのまま適用します。 |

### Drive Mode and Animator

| Field | 説明 |
|---|---|
| `DriveMode` | `Script`は基準タレットと追従タレットを直接回転させます。`Animator`は各軸の角度をAnimatorへ出力し、回転動作をAnimation Clipに任せます。 |
| `ReferenceRotatorAnimator` | 基準タレットのAnimatorです。`Animator`モードでは必須です。`Script`モードでも角度パラメーターの出力先として利用できます。 |
| `FollowerRotatorsAnimator` | 追従タレットへ角度を出力するAnimatorです。基準タレットと同じAnimatorも指定できます。`Script`モードでも角度出力に利用でき、不要なら空欄にできます。 |
| `CurrentYawAnimatorParameter` / `CurrentPitchAnimatorParameter` | 現在の左右・上下角度を出力するFloat Parameter名です。 |
| `TargetYawAnimatorParameter` / `TargetPitchAnimatorParameter` | 目標角度を出力するFloat Parameter名です。HEAD SLAVEでは追従の平滑化前の角度を出力し、手動操作時および他の参加者側では現在角度を出力します。空欄にした項目は出力されません。 |

### Follower Rotators

| Field | 説明 |
|---|---|
| `FollowerRotatorsHor` | 追従タレットのローカルY軸で左右に回転するトランスフォームの配列です。 |
| `FollowerRotatorsVert` | 同じインデックスに対応するローカルX軸で上下に回転するトランスフォームの配列です。 |

存在しない軸は空欄にできます。同じトランスフォームを同じインデックスの両配列へ指定すると、単一のトランスフォームを上下左右へ動かします。

### 手動照準

| Field | 説明 |
|---|---|
| `TurnSpeedMultiX` / `TurnSpeedMultiY` | 上下・左右の基本回転速度です。 |
| `MaxJoyAngles` | VR仮想ジョイスティックの最大入力角です。 |
| `VJoyRollAsYaw` | 右手コントローラーのロール操作を左右照準の入力として扱います。 |
| `TurningResponseDesktop` | デスクトップ操作時の旋回応答速度です。 |
| `UpAngleMax` / `DownAngleMax` / `SideAngleMax` | 基準タレットの可動範囲（角度上限）です。 |
| `InvertVRPitch` | VR手動照準、および右グリップによるHEAD SLAVE照準補正の上下方向を反転します。 |

### 同期

| Field | 説明 |
|---|---|
| `Stabilize` | 車体が回転したときの照準安定化を有効にします。 |
| `updateInterval` | 操作者の照準方向を他の参加者へ送信する間隔（秒）です。 |
| `networkSmoothing` | 他の参加者側で砲塔の動きを滑らかに補間・表示する強さです。 |
| `maxRemoteExtrapolation` | 次の同期データが届くまで、直前の角速度から表示方向を外挿予測する時間の上限です。 |

これらは、他の参加者から見える砲塔の動きを調整する上級者向け設定です。照準速度や角度制限を変更する項目ではなく、通常は初期値のまま運用します。動きが段階的（カクカク）に見える場合は`updateInterval`を小さくすると滑らかになりますが、通信量が増加します。`networkSmoothing`を大きくすると受信方向へ素早く追従し、小さくすると動きが滑らかになる一方で追従遅れが増えます。`maxRemoteExtrapolation`を大きくするとパケット遅延によるカクつきを抑えられますが、実際の照準方向を行き過ぎる場合があります。変更する際は、複数のクライアントで遅れ・振動・オーバーシュートの度合いを確認してください。

### HEAD SLAVE

| Field | 説明 |
|---|---|
| `HeadSlaveVROnly` | 有効にするとVR限定、無効にするとデスクトップとVRの両方でHEAD SLAVEを使用できます。 |
| `HeadSlaveSmoothingHalfLife` / `HeadSlaveDeadZoneDeg` | 頭または視点への追従の平滑化度合いと、微小な動きを無視する不感帯角度です。 |
| `HeadSlaveMaxYawSlewRate` / `HeadSlaveMaxPitchSlewRate` | 最大追従速度です。 |
| `HeadSlaveYawOffsetLimit` / `HeadSlavePitchOffsetLimit` | HMDの追従方向に対して、右グリップ操作で追加できる左右・上下の照準補正角の上限です。 |
| `HeadSlaveTrimRate` | 右グリップ操作による照準補正が反映される速度です。 |

## FSE_DFUNC_HeadSlave

| Field | 説明 |
|---|---|
| `TurretController` | 操作対象の`FSE_EXT_Turret`です。 |
| `EnableFunconObjects` | HEAD SLAVE選択中のみ有効化するオブジェクトの配列です。不要なら空配列にします。 |

## FSE_DFUNC_TurretControl

Pilot Seatで単独の砲塔を手動操作するためのDialFunctionです。`FSE_TurretControl`プレハブでは専用の子オブジェクトに設定済みです。Guided Missilesと組み合わせるパイロット構成や、同乗者席（Passenger）構成では通常は登録しません。

| Field | 説明 |
|---|---|
| `TurretController` | 操作対象の`FSE_EXT_Turret`です。プレハブ内では設定済みです。 |
| `EnableFunconObjects` | 選択中のみ有効化するオブジェクトの配列です。不要なら空配列にします。 |

## FSE_SightController

| Field | 説明 |
|---|---|
| `TurretController` / `SightCamera` | 連動する砲塔（`FSE_EXT_Turret`）と照準カメラ（Camera）です。 |
| `RangefinderOrigin` / `RangefinderText` | 測距方向の基準トランスフォームと、距離表示用のTextMeshProです。 |
| `MinimumFov` / `MaximumFov` | ズームで使用するSight CameraのFOV範囲です。 |
| `ZoomPresetMagnifications` | 切替式ズームで使用する倍率一覧です。正数を昇順で指定します。 |
| `RangefinderDistance` | 距離計の最大測定距離（m）です。 |
| `RangefinderLayers` | 距離計が障害物・目標として検知するLayerMaskです。 |
| `RangefinderUpdateInterval` | 距離計の測定・表示更新間隔（秒）です。 |

## FSE_DFUNC_SightZoom

| Field | 説明 |
|---|---|
| `SightController` | 操作対象の`FSE_SightController`です。 |
| `UsePresetSteps` | 切替式ズームを使用します。無効時は連続式ズームになります。 |
| `AllowZoomWhileDeselected` | 有効にすると、Sight Zoom以外のDialFunctionを選択している最中でもズーム入力を受け付けます。 |
| `ContinuousZoomRate` | 連続式ズームの倍率変化速度です。 |
| `VrHandZForFullSpeed` | VR連続式ズームで最大速度に達する手の前後移動量（m、車両前方基準）です。 |
