# 任意機能

以下は基本的な発射と誘導が動作した後に追加します。

## 指令ワイヤー

1. 各ミサイルへ`FSE_CommandLinkController`を追加します。
2. `Missile`へ同じミサイルの`FSE_MissileController`を指定します。
3. `FSE_MissileController.CommandLink`へそのComponentを指定します。
4. 表示する場合は`CommandWireRenderer`へLineRendererを指定し、`EnableCommandWire`を有効にします。
5. 障害物で切断する場合は`EnableWireCutDetection`を有効にし、`WireCutLayers`を地形や障害物のLayerへ設定します。

表示と切断判定は個別に有効化できます。`CommandWireSegments`、`CommandWireSagRatio`、`CommandWireMaxSag`は見た目だけを調整し、切断判定は発射位置とミサイルを結ぶ直線で行います。

## Sacc補給

車両の補給通知が`FSE_DFUNC_MissileLauncher`へ届くようにします。開始時から補給区域内に置く車両では、必要な場合に`FSE_ResupplyTriggerBootstrap`を追加し、`ResupplyHost`へ車両側の補給判定用GameObjectを指定します。

## 発射・飛翔・着弾演出

- 発射地点に残る音とパーティクルは`FSE_DFUNC_MissileLauncher`へ設定します。
- ミサイルに追従するParticle、Trail、AudioSourceは`FSE_MissileController`へ設定します。
- 着弾時のParticleとAudioSourceも各ミサイルへ設定します。
- 使用しない演出配列は空にします。

## 照準器との連携

可動照準器、照準カメラ、HEAD SLAVE、追従砲塔が必要な場合は[FSE Turret Control](../turret-control/installation.md)を追加し、その`AimOrigin`をランチャーの`GuidanceReference`へ指定します。

## FSE_CommandLinkController設定

| Field | 説明 |
|---|---|
| `Missile` | 同じミサイルの`FSE_MissileController`です。 |
| `CommandWireRenderer` / `EnableCommandWire` | ワイヤー表示用LineRendererと表示の有効化です。 |
| Sag項目 | 線の分割数と見た目の垂れを調整します。 |
| `EnableWireCutDetection` / `WireCutLayers` | 障害物による切断判定と対象Layerです。 |
| `WireCutCheckInterval` / `WireCutRadius` | 切断検査の間隔と判定線の太さです。 |
| `EnableDiagnostics` | 調査時だけ診断出力を有効にします。通常運用では無効にします。 |

## FSE_ResupplyTriggerBootstrap設定

| Field | 説明 |
|---|---|
| `ResupplyHost` | 初期化後に有効化する車両側の補給判定用GameObjectです。不要な構成ではComponent自体を追加しません。 |
