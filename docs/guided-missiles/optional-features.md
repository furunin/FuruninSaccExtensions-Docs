# 任意機能

## 指令ワイヤー

1. 各ミサイルへ`FSE_CommandLinkController`を追加します。
2. `Missile`へ同じミサイルの`FSE_MissileController`を指定します。
3. `FSE_MissileController.CommandLink`へそのComponentを指定します。
4. 表示する場合は`CommandWireRenderer`へLineRendererを指定し、`EnableCommandWire`を有効にします。
5. 障害物で切断する場合は`EnableWireCutDetection`を有効にし、`WireCutLayers`を地形や障害物のLayerへ設定します。

表示と切断判定は個別に有効化できます。`CommandWireSegments`、`CommandWireSagRatio`、`CommandWireMaxSag`は見た目だけを調整し、切断判定は発射位置とミサイルを結ぶ直線で行います。

## 近接信管

近接信管は任意機能です。配布される`Missile Round_InFlight`には`FSE_ProximityFuze`が含まれず、`FSE_MissileController.FuzeModule`は未設定です。設定しなければ、従来どおり接触時だけ起爆します。

使用する場合は、再利用するミサイルごとに次を設定します。

1. `ProjectilePool`に登録された各`Missile Round_InFlight`へ`FSE_ProximityFuze`を一つ追加します。
2. `Missile`へ同じミサイルの`FSE_MissileController`を指定します。
3. 同じミサイルの`FSE_MissileController.FuzeModule`へ、その`FSE_ProximityFuze`を指定します。
4. `DetonationRadius`へ必要な起爆半径を、`ArmingDelaySeconds`と`ArmingDistance`へ母機や友軍から安全に離れるまでの時間と距離を設定します。

`ArmingDelaySeconds`と`ArmingDistance`の条件を両方満たした後に作動します。どちらかを0にすると、その条件だけを無効にできます。

検出対象は生存している`SaccEntity`または`SaccTarget`です。`DetectionLayers`で対象Layerを絞り、友軍や母機など反応させたくない対象のrootは`IgnoredTargetRoots`へ指定します。`RequireLineOfSight`を有効にした場合、`OcclusionLayers`に含まれる壁などで遮られた対象には反応しません。

近接起爆で与えるのは範囲ダメージのみです。直撃と同じタイミングでは接触起爆が優先されます。

## 発射・飛翔・着弾演出

- 発射地点に残る音とパーティクルは`FSE_DFUNC_MissileLauncher`へ設定します。
- ミサイルに追従するParticle、Trail、AudioSourceは`FSE_MissileController`へ設定します。
- 着弾時のParticleとAudioSourceも各ミサイルへ設定します。
- 使用しない演出配列は空にします。

## FSE_CommandLinkController設定

| Field | 説明 |
|---|---|
| `Missile` | 同じミサイルの`FSE_MissileController`です。 |
| `CommandWireRenderer` / `EnableCommandWire` | ワイヤー表示用LineRendererと表示の有効化です。 |
| Sag項目 | 線の分割数と見た目の垂れを調整します。 |
| `EnableWireCutDetection` / `WireCutLayers` | 障害物による切断判定と対象Layerです。 |
| `WireCutCheckInterval` / `WireCutRadius` | 切断検査の間隔と判定線の太さです。 |
| `EnableDiagnostics` | 調査時だけ診断出力を有効にします。通常運用では無効にします。 |

## FSE_ProximityFuze設定

| Field | 説明 |
|---|---|
| `Missile` | 同じミサイルの`FSE_MissileController`です。 |
| `DetonationRadius` | 検出対象との距離がこの値以下になったときに起爆する半径です。 |
| `ArmingDelaySeconds` / `ArmingDistance` | 発射後に信管を有効にするまでの時間と距離です。0にした項目は条件に使用しません。 |
| `DetectionIntervalSeconds` | 近接対象を確認する間隔です。 |
| `DetectionLayers` | 検出する対象のLayerです。 |
| `OcclusionLayers` / `RequireLineOfSight` | 遮蔽物として判定するLayerと、遮蔽確認の有効化です。 |
| `IgnoredTargetRoots` | 母機や友軍など、近接判定から除外するrootです。 |
| `EnableDiagnostics` | 調査時だけ診断出力を有効にします。通常運用では無効にします。 |
