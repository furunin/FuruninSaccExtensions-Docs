# SACLOSの設定

SACLOSでは、ミサイルが`GuidanceReference`の示す照準線へ自動的に旋回します。射手は飛翔中も照準を目標へ向け続けます。

## 設定手順

1. 各ミサイルへ`FSE_SACLOSGuidance`を一つ追加します。
2. `Missile`へ同じミサイルの`FSE_MissileController`を指定します。
3. `FSE_MissileController.GuidanceModule`へ、その`FSE_SACLOSGuidance`を指定します。
4. 発射装置の`GuidanceReference`へ照準方向を示すTransformを指定します。
5. Pool内のすべてのミサイルに同じ構成を設定します。

## 調整の考え方

- `GuidanceLookAhead`は照準線上で操舵が目指す距離です。
- `MinimumCommandDistance`は近距離で操舵目標がミサイルへ近づきすぎることを防ぎます。
- `MaxGuidanceAngle`は誘導指令を受け付ける角度範囲です。
- `MaxTurnRate`と`MaxLateralAcceleration`は旋回能力を制限します。過大な値は不自然な急旋回につながります。

照準器が必要な場合は[FSE Turret Control](../turret-control/installation.md)を組み合わせられます。
