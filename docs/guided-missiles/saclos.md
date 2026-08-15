# SACLOSの設定

SACLOSでは、ミサイルが`GuidanceReference`の示す照準線へ自動的に旋回します。射手は飛翔中も照準を目標へ向け続けます。

## 完成Sample

`SH-1_GuidedMissile_SACLOS`は、Prefabに含まれるすべての飛翔弾へ`FSE_SACLOSGuidance`を接続済みの完成Sampleです。

## 導入手順

### GuidanceReferenceを設定する

1. `FSE_DFUNC_MissileLauncher.GuidanceReference`へ、`FSE_TurretControl`内の`Aim Origin`を指定します。SACLOSはこの照準線を使用するため、この参照が必要です。

### 各飛翔弾へ誘導Componentを設定する

1. `ProjectilePool`に登録された各`Missile Round_InFlight`へ`FSE_SACLOSGuidance`を追加します。
2. `Missile`へ同じ飛翔弾の`FSE_MissileController`を指定します。
3. `FSE_MissileController.GuidanceModule`へ、その飛翔弾の`FSE_SACLOSGuidance`を指定します。
4. `ProjectilePool`に登録されたすべての飛翔弾で同じ設定を行います。

## 調整の考え方

- `GuidanceLookAhead`は照準線上で操舵が目指す距離です。
- `MinimumCommandDistance`は近距離で操舵目標がミサイルへ近づきすぎることを防ぎます。
- `MaxGuidanceAngle`は誘導指令を受け付ける角度範囲です。
- `MaxTurnRate`と`MaxLateralAcceleration`は旋回能力を制限します。過大な値は不自然な急旋回につながります。

照準器が必要な場合は[FSE Turret Control](../turret-control/installation.md)を組み合わせられます。
