# 基本的な設定

## 飛翔特性の設定

### `FSE_MissileController`

- `StraightBoostTime`、`GuidedBoostTime`、`GuidedCoastTime`、`BallisticFlightTime`で、4つの飛翔段階の継続時間をそれぞれ秒単位で設定します。
- `Acceleration`で発射後の加速度を設定できます。`MaxSpeed`で最高速度を制限します。
- `FSE_MissileController.Drag`は速度の二乗に応じて、`MissileRigidbody`のRigidbodyの`Drag`は速度に応じて減速させます。両方を併用でき、全飛翔段階に作用します。
- `AirPhysicsStrength`は動力飛翔中の横滑りを抑えます。
- Flight Instabilityを有効にすると、動力飛翔中に滑らかな上下左右の揺らぎを加えます。
- `RollVisualRoot`を設定すると、物理挙動を変えずに見た目だけをロールできます。

### インスペクターの参考グラフ

`Flight & Lifetime`の`Speed vs Time`と`Distance vs Time`は、発射速度を0として直進した場合の参考値です。`Acceleration`、`MaxSpeed`、Rigidbodyの`Drag`、`FSE_MissileController.Drag`を反映し、各飛翔段階の終了位置を色付きの破線で示します。グラフ下には最高速度への到達状況と各段階終了時の累積距離が表示されます。誘導、重力、機体から引き継ぐ速度、飛翔中の揺らぎは再現しません。

## 弾頭の作動設定

### `FSE_MissileController`

`WarheadArmingDelaySeconds`で、発射してから弾頭が作動するまでの時間を設定します。ミサイルが発射機の周辺から安全に離れるために必要な時間を指定してください。

## MCLOS誘導の設定

### `FSE_MCLOSInputController`

- `InputDeadZone`はVRスティックの中央付近だけに適用されます。
- `InvertPitch`と`InvertYaw`で操作方向を軸ごとに反転できます。
- `SyncInterval`は操作状態を送る間隔です。

### `FSE_MCLOS Guidance`

- `MaxPitchRate`、`MaxYawRate`は、上下・左右の旋回能力を決めます。
- `MaxLateralAcceleration`は、上下・左右を合わせた旋回にかけられる横加速度の上限です。

## SACLOS誘導の設定

### `FSE_SACLOSGuidance`

- `GuidanceLookAhead`は照準線上で操舵が目指す距離です。
- `MinimumCommandDistance`は近距離で操舵目標がミサイルへ近づきすぎることを防ぎます。
- `MaxGuidanceAngle`は誘導指令を受け付ける角度範囲です。
- `MaxTurnRate`と`MaxLateralAcceleration`は旋回能力を制限します。過大な値は不自然な急旋回につながります。
