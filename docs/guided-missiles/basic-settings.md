# 基本的な設定

## 飛翔特性の設定

### `FSE_MissileController`

- `Acceleration`で加速し、`MaxSpeed`で最高速度を制限します。
- `AirPhysicsStrength`は動力飛翔中の横滑りを抑えます。
- Flight Instabilityを有効にすると、動力飛翔中に滑らかな上下左右の揺らぎを加えます。
- `RollVisualRoot`を設定すると、物理挙動を変えずに見た目だけをロールできます。

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
