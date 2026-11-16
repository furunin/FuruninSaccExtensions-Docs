# 設定項目一覧

## FSE_EXT_Turret

### Reference Rotator

| Field | 説明 |
|---|---|
| `ReferenceRotatorHor` | 基準タレットのローカルY軸で左右に回転するトランスフォームです。 |
| `ReferenceRotatorVert` | 基準タレットのローカルX軸で上下に回転するトランスフォームです。 |
| `ControlsRoot` | VR操作で車両回転を相殺し、VR連続式ズームの前後方向を決める基準トランスフォームです。ローカルの+Z軸を車両前方へ合わせます。 |
| `AimOrigin` | 最終的な照準方向を示すトランスフォームです。 |
| `OperatorSeat` | `FSE_EXT_Turret`をSaccの拡張（`ExtensionUdonBehaviours`またはPassenger Functionsの拡張）として登録しない場合だけ、操作席として使う座席です。登録済みの場合は設定不要で、PilotSeatまたはPassenger Functionsの席を自動で使います。設定しても動作に影響はありません。 |

### Sight Camera

| Field | 説明 |
|---|---|
| `SightCamera` | 照準映像とFOV連動感度に使用するカメラです。 |
| `SightCameraExcludedLayers` | Sight Cameraでのみ描画から除外するレイヤーです。 |
| `ScaleManualAimWithSightFov` | カメラのFOVに応じて手動照準速度、および右グリップによるHEAD SLAVE照準補正の速度を調整します。 |
| `Zoom Reference Fov`（`ZoomReferenceFov`） | 手動照準が設定どおりの速さになるFOV（度）です。これより狭いFOVでは照準が遅くなります。`ScaleManualAimWithSightFov`が無効な場合は使用されません。 |
| `MinManualAimScale` | FOV連動速度の下限倍率です。0に設定すると制限を設けず、FOV比をそのまま適用します。 |

### Drive Mode and Animator

| Field | 説明 |
|---|---|
| `DriveMode` | `Script`は基準タレットと追従タレットを直接回転させます。`Animator`は各軸の角度をアニメーターへ出力し、回転動作をAnimation Clipに任せます。 |
| `ReferenceRotatorAnimator` | 基準タレットのアニメーターです。`Animator`モードでは必須です。`Script`モードでも角度パラメーターの出力先として利用できます。 |
| `FollowerRotatorsAnimator` | 追従タレットへ角度を出力するアニメーターです。基準タレットと同じアニメーターも指定できます。`Script`モードでも角度出力に利用でき、不要なら空欄にできます。 |
| `CurrentYawAnimatorParameter` / `CurrentPitchAnimatorParameter` | 現在の左右・上下角度を出力するFloatパラメーター名です。 |
| `TargetYawAnimatorParameter` / `TargetPitchAnimatorParameter` | 目標角度を出力するFloatパラメーター名です。HEAD SLAVEでは追従の平滑化前の角度を出力し、手動操作時および他の参加者側では現在角度を出力します。空欄にした項目は出力されません。 |

`SideAngleMax`が180以上の場合、左右の角度を出力するFloatパラメーターは0と1が真後ろ、0.5が正面になります。アニメーターで回転させる場合は、左右の軸を-180°から+180°まで等速で1回転させるAnimation Clipを用意してください。真後ろを通るときに値が1から0（または0から1）へ切り替わるため、この値を遷移条件やUIに使用する場合は注意してください。

### Follower Rotators

| Field | 説明 |
|---|---|
| `FollowerRotatorsHor` | 追従タレットのローカルY軸で左右に回転するトランスフォームの配列です。 |
| `FollowerRotatorsVert` | 同じインデックスに対応するローカルX軸で上下に回転するトランスフォームの配列です。 |

存在しない軸は空欄にできます。同じトランスフォームを同じインデックスの両配列へ指定すると、単一のトランスフォームを上下左右へ動かします。

### 手動照準

| Field | 説明 |
|---|---|
| `TurnSpeedMultiX` / `TurnSpeedMultiY` | 上下・左右の基本回転速度（度/秒）です。Sacc `EXT_Turret`の同名項目とは意味が異なるため、値を流用しないでください。 |
| `MaxJoyAngles` | VR仮想ジョイスティックの最大入力角です。 |
| `VJoyRollAsYaw` | 右手コントローラーのロール操作を左右照準の入力として扱います。 |
| `TurningResponseDesktop` | デスクトップで照準キーを押したときに、照準が最高速へ近づく速さです。大きいほどすぐ最高速になり、0ではキー照準が動きません。押し始めの動きを速くしたい場合は値を大きくします（例: 20～50）。 |
| `Keyboard_Up` / `Keyboard_Down` / `Keyboard_Left` / `Keyboard_Right` | デスクトップの照準キーです。既定は`W`/`S`/`A`/`D`です。 |
| `KeyboardSpeedModifier` | 押している間、デスクトップの照準を遅くするキーです。既定は`LeftShift`です。操縦者が砲塔も操作する飛行機・船では、SaccのスロットルにもLeftShiftを使うため、別のキーへの変更を検討してください。 |
| `K_ModifierSpeed` | `KeyboardSpeedModifier`を押している間の照準速度の倍率です。既定は0.2です。 |
| `InvertDesktopPitch` | 有効（既定）では`Keyboard_Up`で照準が上を向きます。無効にすると、Sacc `EXT_Turret`と同じく`Keyboard_Up`で下を向きます。 |
| `UpAngleMax` / `DownAngleMax` / `SideAngleMax` | 基準タレットの可動範囲（角度上限）です。`SideAngleMax`を180以上にすると、左右は真後ろで止まらず全周を回り続けます。真後ろで止める場合は179以下にします。 |
| `MaxDriveYawRate` / `MaxDrivePitchRate` | 砲塔が車体に対して回る左右・上下の最大の速さ（度/秒）です。安定化（`Stabilize`）の動きも含みます。0（既定）で無制限です。手動照準の速さ（`TurnSpeedMultiX/Y`）以上にするのが目安です。 |
| `MaxDriveYawAcceleration` / `MaxDrivePitchAcceleration` | 砲塔が車体に対して回る左右・上下の最大の加速度（度/秒²）です。0（既定）で無制限です。照準キーを離した後に進む角度は、おおよそ「速さの2乗÷(2×加速度)」です。 |
| `InvertVRPitch` | VR手動照準、および右グリップによるHEAD SLAVE照準補正の上下方向を反転します。 |

駆動の上限（`MaxDrive...`）を設定すると、砲塔は上限の範囲で回るため、狙っている角度（Target）と実際の角度（Current）が分かれます。照準映像は実際の砲塔の向きに付いているため、操作者には遅れた照準が見えます。SACLOSのミサイルも実際の照準線に従います。車体の揺れに追いつけなかった場合は揺れが収まると、車体が旋回範囲の外まで回った場合は届く向きに戻ると、元の照準方向へ戻ります。速く細かい揺れは打ち消しきれず、条件によっては安定化しない場合より照準が揺れることがあるため、値は実際の車両で調整してください。

駆動の上限は、上下の回転部（`ReferenceRotatorVert`）が左右の回転部（`ReferenceRotatorHor`）の子で、`AimOrigin`がその下にある構成（片軸の場合はその軸の下）で使用できます。それ以外の構成では上限が無視され、エラーが1回表示されます。

### 同期

| Field | 説明 |
|---|---|
| `Stabilize` | 車体が回転したときの照準安定化を有効にします。 |
| `updateInterval` | 操作者の照準方向を他の参加者へ送信する間隔（秒）です。 |
| `networkSmoothing` | 他の参加者側で砲塔の動きを滑らかに補間・表示する強さです。 |
| `maxRemoteExtrapolation` | 次の同期データが届くまで、直前の角速度から表示方向を外挿予測する時間の上限です。 |

これらは、他の参加者から見える砲塔の動きを調整する上級者向け設定です。照準速度や角度制限を変更する項目ではなく、通常は初期値のまま運用します。`updateInterval`を0.2秒より小さくしても、送信間隔は0.2秒より短くなりません。`networkSmoothing`を大きくすると受信方向へ素早く追従し、小さくすると動きが滑らかになる一方で追従遅れが増えます。`maxRemoteExtrapolation`を大きくするとパケット遅延によるカクつきを抑えられますが、実際の照準方向を行き過ぎる場合があります。変更する際は、複数のクライアントで遅れ・振動・オーバーシュートの度合いを確認してください。

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

PilotSeatで単独の砲塔を手動操作するためのDialFunctionです。`FSE_TurretControl`プレハブでは専用の子オブジェクトに設定済みです。Guided Missilesと組み合わせるパイロット構成や、同乗者席（Passenger）構成では通常は登録しません。

| Field | 説明 |
|---|---|
| `TurretController` | 操作対象の`FSE_EXT_Turret`です。プレハブ内では設定済みです。 |
| `EnableFunconObjects` | 選択中のみ有効化するオブジェクトの配列です。不要なら空配列にします。 |

## FSE_SightController

| Field | 説明 |
|---|---|
| `TurretController` / `SightCamera` | 連動する砲塔（`FSE_EXT_Turret`）と照準カメラです。 |
| `RangefinderOrigin` | 測距方向の基準トランスフォームです。 |
| `Rangefinder Text`（`RangefinderText`） | 任意の距離表示用TextMeshProです。空欄でも測距は動作し、独自UIから結果を読み取れます。 |
| `MinimumFov` / `MaximumFov` | ズームで使用するSight CameraのFOV範囲です。 |
| `ZoomPresetMagnifications` | 切替式ズームで使用する倍率一覧です。正数を昇順で指定します。 |
| `RangefinderDistance` | 距離計の最大測定距離（m）です。 |
| `RangefinderLayers` | 距離計が障害物・目標として検知するLayerMaskです。 |
| `RangefinderUpdateInterval` | 距離計の測定・表示更新間隔（秒）です。 |

### 独自UI用の取得メソッド { #rangefinder-data }

`FSE_SightController`から最後の測距結果を取得します。使用手順は[独自の照準画面・HUD](installation.md#custom-ui-setup)を参照してください。

| メソッド | 取得する情報 |
|---|---|
| `HasRangefinderHit()` | 現在の操作者として有効な測距結果がある場合に`true`を返します。 |
| `GetMeasuredDistance()` | 丸め前の測定距離（m）です。`RangefinderDistance`は測定上限の設定値で、測定結果ではありません。 |
| `GetRangefinderHitCollider()` | 命中したColliderです。 |
| `GetRangefinderHitOrigin()` / `GetRangefinderHitDirection()` | 測定時の原点と方向です。世界座標で返します。 |
| `GetRangefinderHitPoint()` | 世界座標の命中位置です。 |
| `GetRangefinderHitSampleTime()` | 最後に測定した時点の`Time.time`（秒）です。 |

無効な結果では`HasRangefinderHit()`が`false`になり、Colliderは`null`、距離・時刻は0、位置・方向は`Vector3.zero`を返します。

## FSE_DFUNC_SightZoom

| Field | 説明 |
|---|---|
| `SightController` | 操作対象の`FSE_SightController`です。 |
| `UsePresetSteps` | 切替式ズームを使用します。無効時は連続式ズームになります。 |
| `AllowZoomWhileDeselected` | 有効にすると、Sight Zoom以外のDialFunctionを選択している最中でもズーム入力を受け付けます。 |
| `ContinuousZoomRate` | 連続式ズームの倍率変化速度です。 |
| `VrHandZForFullSpeed` | VR連続式ズームで、ズームの全範囲（最小倍率から最大倍率まで）に相当する手の前後移動量（m、`ControlsRoot`の前方基準）です。倍率の変化の速さは`ContinuousZoomRate`で制限されます。 |
