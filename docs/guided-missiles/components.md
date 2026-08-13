# Component設定

ここでは利用者が接続または調整する項目をComponentごとに説明します。

## FSE_DFUNC_MissileLauncher

| Field | 説明 |
|---|---|
| `SAVControl` / `EntityControl` | 搭載車両のSacc制御Componentと`SaccEntity`です。 |
| `CollisionHostRoot` | 発射直後の衝突対象から除外する車両階層です。 |
| `GuidanceReference` | 誘導基準方向を示すTransformです。青いZ軸を使用します。 |
| `OperatorSeat` | 操作に使用する一席です。 |
| `PassengerFunctionsController` | PassengerSeat構成で使用します。PilotSeat構成では未設定にします。 |
| `LaunchPoints` / `AmmoMeshes` | 発射位置と対応する搭載弾表示です。同じ順序で登録します。 |
| `ProjectilePool` / `PoolRoot` / `WorldParent` | 再利用するミサイル、待機時の親、飛翔中の親です。 |
| `EnableOnSelected` | ミサイル機能の選択中だけ有効にする表示物です。 |
| `LaunchSound` / `LaunchParticle` | 発射地点で再生する任意の音とパーティクルです。 |
| `MaxAmmo` | 装填弾と予備弾を合わせた総搭載数です。 |
| `RackReloadTimeSeconds` / `FireCooldown` | ラック再装填時間と発射間隔です。 |
| `MaxConcurrentGuidedShots` | 同時に誘導状態を維持できる最大数です。 |
| `MaxLaunchSightAngle` | 発射方向と誘導基準方向の許容角です。 |
| `AllowFiringWhenGrounded` | Sacc航空機の`Taxiing`中に発射を許可するかを指定します。 |
| `MaximumFiringSpeed` | 発射可能な車両合成速度の上限（m/s）です。0以下は無制限です。 |
| `PrewarmPoolCount` | 起動時に利用可能にする再利用用ミサイル数です。 |
| `InheritHostVelocity` | 発射時に車両速度を引き継ぐかを指定します。 |

## FSE_MissileController

| Field | 説明 |
|---|---|
| `MissileRigidbody` / `MissileCollider` / `MissileVisualRoot` | 飛翔物理、衝突、表示を担当する参照です。 |
| `RollVisualRoot` / `RollRateDegreesPerSecond` | 回転させるMeshの共通親と見た目のロール速度です。物理rootは指定しません。 |
| `FlightParticles` / `FlightTrails` / `FlightSounds` | 飛翔中にミサイルへ追従する演出です。 |
| `FlightEffectsDelaySeconds` | 飛翔演出を開始するまでの時間です。誘導や衝突は遅延しません。 |
| `ExplosionParticles` / `ExplosionSounds` | 通常着弾時の演出です。 |
| `FlyStraightTime` / `Acceleration` / `MaxSpeed` | 直進時間、加速度、最高速度です。 |
| `MaxLifetime` / `BallisticLifetime` | 動力飛翔時間と、その後の重力飛行時間です。 |
| `AlignToVelocityDuringBallistic` | 弾道飛行中に表示方向を速度方向へ合わせます。 |
| `AirPhysicsStrength` | 動力飛翔中の横滑りを抑える強さです。 |
| Flight Instability項目 | 動力飛翔中の揺らぎの強さ、周期、立ち上がり時間です。加速度または周波数を0にすると無効です。 |
| `ColliderActivationDistance` | 母機付近の誤接触を避けるため、Colliderを有効化するまでの距離です。 |
| `GuidanceLostTimeout` | 有効な誘導指令を失ってから終了するまでの猶予です。 |
| `CollisionLayers` / `DamageLayers` | 着弾を検出するLayerと、損傷対象にするLayerです。 |
| Damage項目 | 直撃損傷、範囲損傷、効果範囲、武器種別をSaccの損傷設計に合わせます。 |
| `GuidanceModule` | 使用するSACLOSまたはMCLOS誘導Componentです。 |
| `CommandLink` | 任意の指令ワイヤーComponentです。 |

## FSE_SACLOSGuidance

| Field | 説明 |
|---|---|
| `Missile` | 同じミサイルの`FSE_MissileController`です。 |
| `GuidanceLookAhead` / `MinimumCommandDistance` | 照準線上の操舵目標距離と最短距離です。 |
| `MaxGuidanceAngle` | 誘導指令を有効とする最大角度です。 |
| `MaxTurnRate` / `MaxLateralAcceleration` | 旋回速度と横加速度の上限です。 |

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
