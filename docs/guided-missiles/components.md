# 設定項目一覧

## FSE_DFUNC_MissileLauncher

| Field | 説明 |
|---|---|
| `SAVControl` / `EntityControl` | 搭載車両のSacc制御コンポーネントと`SaccEntity`です。 |
| `CollisionHostRoot` | ミサイル（指令ワイヤーを含む）が飛翔中ずっと衝突しない機体の階層です。未設定の場合は、そのLauncherを持つ機体全体が対象になります。 |
| `GuidanceReference` | 誘導基準方向を示すトランスフォームです。青いZ軸（+Z）方向を使用します。 |
| `OperatorSeat` | 操作に使用する座席オブジェクトです。 |
| `PassengerFunctionsController` | PassengerSeat構成で使用します。PilotSeat構成では未設定にします。 |
| `LaunchStations` | 各格納状態ミサイルの`FSE_MissileLaunchStation`を発射順に登録します。 |
| `ProjectilePool` / `PoolRoot` / `WorldParent` | 再利用するミサイル群、待機時の親オブジェクト、飛翔中の親オブジェクトです。 |
| `EnableOnSelected` | ミサイル機能の選択中のみ有効化するオブジェクトの配列です。 |
| `LaunchEffectsRoot` | 発射時に再生するParticleSystemやAudioSourceの親トランスフォームです。 |
| `TriggerEffectsRoot` | 発射入力の開始時に再生する任意エフェクトの親トランスフォームです。 |
| `MaxAmmo` | 装填弾と予備弾を合わせた総搭載弾数です。 |
| `UnlimitedAmmo` | 有効にすると、発射しても総残弾数が減らず、補給なしで撃ち続けられます。既定は無効です。有効でも`MaxAmmo`は1以上にしてください。総残弾数の表示と`Remaining Ammo Float Name`の値は減らず、`MaxAmmo`のままです。 |
| `HUDText_Missile_ammo` / `HUDText_Missile_ammo_TMP` / `HUDText_Missile_ammo_TMPUGUI` | `FSE_DFUNC_MissileLauncher`の総残弾数を表示する任意のText参照です。使用するTextの種類に対応するFieldへ指定します。 |
| `MissileAnimator` | 残弾割合と任意の装填状態を受け取るAnimatorです。 |
| `Remaining Ammo Float Name`（`AnimFloatName`） | 総残弾数／`MaxAmmo`を0～1で受け取るFloatパラメーター名です。既定名は`MissileAmmo`です。 |
| `Reloading Bool Name`（`ReloadingBoolName`） | 装填中かどうかを受け取るBoolパラメーター名です。既定名は`MissileReloading`です。 |
| `Reload Progress Float Name`（`ReloadProgressFloatName`） | 装填中の進捗を0～1で受け取るFloatパラメーター名です。装填中でなければ1です。既定名は`MissileReloadProgress`です。 |
| `RackReloadTimeSeconds` / `FireCooldown` | ラック再装填時間と発射間隔（秒）です。 |
| `FireTriggerHoldSeconds` | 発射入力を保持し続ける時間（秒）です。0ならトリガーを押した時点で即時発射します。 |
| `MaxConcurrentGuidedShots` | 同時に誘導状態を維持できる最大弾数です。 |
| `AllowDetachOnFireInput` | 有効（既定）にすると、誘導中のミサイル数が`MaxConcurrentGuidedShots`に達しているときの発射操作で、最も古い誘導中ミサイルの誘導（指令ワイヤー）が切れます。無効にすると、この発射操作では何も起きず、発射操作で誘導を切れません。 |
| `MaxLaunchSightAngle` | 発射方向と誘導基準方向の許容誤差角度です。 |
| `AllowFiringWhenGrounded` | Sacc航空機の地上滑走中（`Taxiing`）に発射を許可するかを指定します。 |
| `MaximumFiringSpeed` | 発射可能な車両合成速度の上限（m/s）です。0以下の場合は無制限となります。 |
| `InheritHostVelocity` | 発射時に母機の移動速度を引き継ぐかを指定します。 |

## FSE_MissileLaunchStation

| Field | 説明 |
|---|---|
| `LaunchPoint` | 必須の発射位置トランスフォームです。青いZ軸（+Z）が発射方向となります。 |
| `VisualRoot` | 任意の搭載弾表示オブジェクトです。配布Stowedではモデルをまとめる`Visual`親を指定しています。残弾と[装填アニメーション](optional-features.md#reload-animation)の設定に応じて表示を切り替えます。未設定なら表示切替は行いません。ステーション本体・その親階層・`LaunchPoint`・ワイヤー始点を含むオブジェクトは指定しないでください。 |
| `FirstCommandWireOrigin` / `SecondCommandWireOrigin` | 任意のワイヤー始点トランスフォームです。未設定の場合は`LaunchPoint`を使用します。 |

## FSE_MissileController

| Field | 説明 |
|---|---|
| `MissileRigidbody` / `MissileCollider` / `MissileAnimator` / `MissileVisualRoot` | 飛翔物理、衝突判定、Animator、外観表示を担当する参照です。 |
| `RollVisualRoot` / `RollRateDegreesPerSecond` | ロール回転させるMeshの共通親オブジェクトと、見た目のロール速度（度/秒）です。物理挙動のルートオブジェクトは指定しません。 |
| `EffectGroupRoots` / `EffectGroupPhaseMasks` | 演出の親トランスフォームと、再生する飛翔段階・着弾時の組み合わせです。 |
| `FlightEffectsDelaySeconds` / `ExplosionLifeTime` | 飛翔演出開始までの遅延時間と、着弾後に待機状態へ戻るまでの時間（秒）です。 |
| `StraightBoostTime` / `GuidedBoostTime` / `GuidedCoastTime` / `BallisticFlightTime` | 直進推進、誘導推進、誘導滑空、弾道飛行の継続時間（秒）です。 |
| `Acceleration` / `MaxSpeed` / `Drag` | 加速度、推進中の最高速度、速度の二乗に応じた空気抵抗係数です。`Drag`のインスペクター入力単位は1/kmで、Rigidbodyの`Drag`と併用できます。 |
| `RemoteVisualTimeout` | 他の参加者側で飛翔表示が残存した場合、設定された総飛翔時間とこの時間の双方が経過した時点で表示を強制終了します。 |
| `AlignToVelocityDuringBallistic` | 弾道飛行中に機首方向を進行速度ベクトルへ合わせます。 |
| `AirPhysicsStrength` | 動力飛翔中の横滑りを抑える空力安定性の強さです。 |
| `FlightWanderAcceleration` / `FlightWanderFrequency` / `FlightWanderRampTime` | 動力飛翔中の弾道揺らぎの強さ、周波数、立ち上がり時間です。加速度または周波数を0にすると無効化されます。 |
| `WarheadArmingDelaySeconds` | 発射から弾頭信管が作動（アーム）するまでの安全遅延時間です。作動前に衝突した場合はダメージ判定や爆発演出を発生させずに待機状態へ戻ります。 |
| `GuidanceLostTimeout` | 有効な誘導指令を喪失してから誘導を終了するまでの猶予時間です。 |
| `CollisionLayers` / `DamageLayers` | 着弾を検出するLayerMaskと、損傷対象とするLayerMaskです。 |
| `DirectHitDamage` / `SplashDamage` / `SplashRadius` / `WeaponType` / `MaxSplashTargets` | 直撃損傷、範囲損傷、効果半径、武器種別、範囲損傷の対象最大数をSaccのダメージ仕様に合わせて指定します。 |
| `GuidanceModule` | 使用するSACLOSまたはMCLOS誘導コンポーネントです。 |
| `CommandLink` | 任意の指令ワイヤーコンポーネントです。 |

## FSE_MCLOSInputController

| Field | 説明 |
|---|---|
| `Launcher` | 操作対象の`FSE_DFUNC_MissileLauncher`です。 |
| `InputDeadZone` | VRスティック中央付近の入力を無視する不感帯の範囲です。 |
| `SyncInterval` | 操作状態を同期送信する間隔（秒）です。 |
| `InvertPitch` / `InvertYaw` | 上下または左右の操作方向を反転します。 |

## FSE_MCLOSGuidance

| Field | 説明 |
|---|---|
| `Missile` / `CommandSource` | 同じミサイル本体の`FSE_MissileController`と、操作席側の入力コンポーネントです。 |
| `MaxPitchRate` / `MaxYawRate` | 最大入力時の上下・左右旋回角速度です。 |
| `MaxLateralAcceleration` | 旋回時に発生させる横加速度の上限値です。 |

## FSE_SACLOSGuidance

| Field | 説明 |
|---|---|
| `Missile` | 同じミサイルの`FSE_MissileController`です。 |
| `GuidanceLookAhead` / `MinimumCommandDistance` | 照準線上の操舵目標先読み距離と最短距離です。 |
| `MaxGuidanceAngle` | 誘導指令を有効とみなす最大角度範囲です。 |
| `MaxTurnRate` / `MaxLateralAcceleration` | 旋回角速度と横加速度の上限値です。 |

## FSE_CommandLinkController

| Field | 説明 |
|---|---|
| `Missile` | 同じミサイルの`FSE_MissileController`です。 |
| `First Command Wire Renderer`（`CommandWireRenderer`） / `EnableCommandWire` | 1本目のワイヤー描画用LineRendererと表示の有効化設定です。LineRendererのトランスフォームがミサイル側の接続点となります。 |
| `Second Command Wire Renderer`（`SecondCommandWireRenderer`） | 任意の2本目のLineRendererです。そのトランスフォームが2本目のミサイル側接続点となります。 |
| Sag項目 | 線の分割数や外観の垂れ下がり具合を調整します。 |
| `EnableWireCutDetection` / `WireCutLayers` | 障害物接触による切断判定の有効化と判定対象LayerMaskです。 |
| `WireCutCheckInterval` / `WireCutRadius` | 切断判定の実行間隔と判定用球の半径です。 |
| `EnableDiagnostics` | トラブルシューティング時のみ診断ログ出力を有効にします。通常運用時は無効にしてください。 |
