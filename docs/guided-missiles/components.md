# 設定項目一覧

## FSE_DFUNC_MissileLauncher

| Field | 説明 |
|---|---|
| `SAVControl` / `EntityControl` | 搭載車両のSacc制御Componentと`SaccEntity`です。 |
| `CollisionHostRoot` | 発射直後の衝突対象から除外する車両階層です。 |
| `GuidanceReference` | 誘導基準方向を示すTransformです。青いZ軸を使用します。 |
| `OperatorSeat` | 操作に使用する一席です。 |
| `PassengerFunctionsController` | PassengerSeat構成で使用します。PilotSeat構成では未設定にします。 |
| `LaunchStations` | 各格納状態ミサイルの`FSE_MissileLaunchStation`を発射順に登録します。 |
| `ProjectilePool` / `PoolRoot` / `WorldParent` | 再利用するミサイル、待機時の親、飛翔中の親です。 |
| `EnableOnSelected` | ミサイル機能の選択中だけ有効にする表示物です。 |
| `LaunchEffectsRoot` | 発射時に再生するParticleSystemとAudioSourceの親Transformです。 |
| `TriggerEffectsRoot` | 発射入力の開始時に再生する任意のエフェクトの親Transformです。 |
| `MaxAmmo` | 装填弾と予備弾を合わせた総搭載数です。 |
| `HUDText_Missile_ammo` / `HUDText_Missile_ammo_TMP` / `HUDText_Missile_ammo_TMPUGUI` | `FSE_DFUNC_MissileLauncher`の総残弾数を表示する任意のText参照です。使用するTextの種類に対応するFieldへ指定します。 |
| `MissileAnimator` / `AnimFloatName` | `FSE_DFUNC_MissileLauncher`の残弾割合を受け取る任意のAnimatorとFloat Parameter名です。 |
| `RackReloadTimeSeconds` / `FireCooldown` | ラック再装填時間と発射間隔です。 |
| `FireTriggerHoldSeconds` | 発射入力を押し続ける時間（秒）です。0なら押した時点で発射します。 |
| `MaxConcurrentGuidedShots` | 同時に誘導状態を維持できる最大数です。 |
| `MaxLaunchSightAngle` | 発射方向と誘導基準方向の許容角です。 |
| `AllowFiringWhenGrounded` | Sacc航空機の`Taxiing`中に発射を許可するかを指定します。 |
| `MaximumFiringSpeed` | 発射可能な車両合成速度の上限（m/s）です。0以下は無制限です。 |
| `InheritHostVelocity` | 発射時に車両速度を引き継ぐかを指定します。 |

## FSE_MissileLaunchStation

| Field | 説明 |
|---|---|
| `LaunchPoint` | 必須の発射位置です。青いZ軸が発射方向です。 |
| `VisualRoot` | 任意の搭載弾表示です。残弾に応じてこのオブジェクトだけが非表示になります。未設定なら表示切替は行いません。ステーション本体・その祖先・`LaunchPoint`・ワイヤー始点を含むオブジェクトを指定しないでください。 |
| `FirstCommandWireOrigin` / `SecondCommandWireOrigin` | 任意のワイヤー始点です。それぞれ未設定なら`LaunchPoint`を使用します。 |

## FSE_MissileController

| Field | 説明 |
|---|---|
| `MissileRigidbody` / `MissileCollider` / `MissileAnimator` / `MissileVisualRoot` | 飛翔物理、衝突、Animator、表示を担当する参照です。 |
| `RollVisualRoot` / `RollRateDegreesPerSecond` | 回転させるMeshの共通親と見た目のロール速度です。物理rootは指定しません。 |
| `EffectGroupRoots` / `EffectGroupPhaseMasks` | 演出の親Transformと、再生する飛翔段階・着弾時の組み合わせです。 |
| `FlightEffectsDelaySeconds` / `ExplosionLifeTime` | 飛翔演出の開始までの時間と、着弾後に待機状態へ戻るまでの時間です。 |
| `StraightBoostTime` / `GuidedBoostTime` / `GuidedCoastTime` / `BallisticFlightTime` | 直進推進、誘導推進、誘導滑空、弾道飛行の継続時間（秒）です。 |
| `Acceleration` / `MaxSpeed` / `Drag` | 加速度、推進中の最高速度、速度の二乗に応じた抵抗です。`Drag`のInspector入力単位は1/kmで、Rigidbodyの`Drag`と併用できます。 |
| `RemoteVisualTimeout` | 他の参加者側で飛翔表示が残った場合、設定された総飛翔時間とこの時間の両方が過ぎると表示を終了します。 |
| `AlignToVelocityDuringBallistic` | 弾道飛行中に表示方向を速度方向へ合わせます。 |
| `AirPhysicsStrength` | 動力飛翔中の横滑りを抑える強さです。 |
| `FlightWanderAcceleration` / `FlightWanderFrequency` / `FlightWanderRampTime` | 動力飛翔中の揺らぎの強さ、周波数、立ち上がり時間です。加速度または周波数を0にすると無効です。 |
| `WarheadArmingDelaySeconds` | 発射してから弾頭が作動するまでの時間です。作動前に衝突した場合はダメージと爆発演出を発生させず、待機状態へ戻ります。 |
| `GuidanceLostTimeout` | 有効な誘導指令を失ってから終了するまでの猶予です。 |
| `CollisionLayers` / `DamageLayers` | 着弾を検出するLayerと、損傷対象にするLayerです。 |
| `DirectHitDamage` / `SplashDamage` / `SplashRadius` / `WeaponType` / `MaxSplashTargets` | 直撃損傷、範囲損傷、効果範囲、武器種別、範囲損傷の対象数をSaccの損傷設計に合わせます。 |
| `GuidanceModule` | 使用するSACLOSまたはMCLOS誘導Componentです。 |
| `CommandLink` | 任意の指令ワイヤーComponentです。 |

## FSE_MCLOSInputController

| Field | 説明 |
|---|---|
| `Launcher` | 操作対象の`FSE_DFUNC_MissileLauncher`です。 |
| `InputDeadZone` | VRスティック中央付近の入力を無視する範囲です。 |
| `SyncInterval` | 操作状態を同期する間隔です。 |
| `InvertPitch` / `InvertYaw` | 上下または左右の操作方向を反転します。 |

## FSE_MCLOSGuidance

| Field | 説明 |
|---|---|
| `Missile` / `CommandSource` | 同じミサイル本体と操作席側の入力Componentです。 |
| `MaxPitchRate` / `MaxYawRate` | 最大入力時の上下・左右旋回速度です。 |
| `MaxLateralAcceleration` | 横方向に曲がる強さの上限です。 |

## FSE_SACLOSGuidance

| Field | 説明 |
|---|---|
| `Missile` | 同じミサイルの`FSE_MissileController`です。 |
| `GuidanceLookAhead` / `MinimumCommandDistance` | 照準線上の操舵目標距離と最短距離です。 |
| `MaxGuidanceAngle` | 誘導指令を有効とする最大角度です。 |
| `MaxTurnRate` / `MaxLateralAcceleration` | 旋回速度と横加速度の上限です。 |

## FSE_CommandLinkController設定

| Field | 説明 |
|---|---|
| `Missile` | 同じミサイルの`FSE_MissileController`です。 |
| `First Command Wire Renderer`（`CommandWireRenderer`） / `EnableCommandWire` | 1本目のワイヤー表示用LineRendererと表示の有効化です。LineRendererのTransformがミサイル側の接続点です。 |
| `Second Command Wire Renderer`（`SecondCommandWireRenderer`） | 任意の2本目のLineRendererです。そのTransformが2本目のミサイル側接続点です。 |
| Sag項目 | 線の分割数と見た目の垂れを調整します。 |
| `EnableWireCutDetection` / `WireCutLayers` | 障害物による切断判定と対象Layerです。 |
| `WireCutCheckInterval` / `WireCutRadius` | 切断検査の間隔と判定線の太さです。 |
| `EnableDiagnostics` | 調査時だけ診断出力を有効にします。通常運用では無効にします。 |
