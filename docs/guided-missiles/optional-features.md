# 任意機能の導入

## `ResupplyTrigger`の配置を変更する

`InVehicleOnly`直下に`ResupplyTrigger`を配置することで、パイロット席に着席しなくてもミサイルを補給できるようになります。`ResupplyTrigger`は、SH-1の場合はデフォルトで`InVehicleOnly/PilotOnly`に配置されています。`ResupplyTrigger`の配置変更を行った場合は、オリジナルの`ResupplyTrigger`オブジェクトを削除、無効化、またはEditorOnlyにしてください。

## 指令ワイヤー

飛翔用ミサイルの`FSE_MissileController`内`Command Link`に`FSE_CommandLinkController`を登録し、`EnableCommandWire`を有効にするとミサイルへ操作入力を送る指令ワイヤーが表示されるようになります。`EnableWireCutDetection`を有効にすると、目標と発射位置の間が障害物で遮られた際にワイヤーが切断され、誘導不能になります。

表示と切断判定は個別に有効化できます。`CommandWireSegments`、`CommandWireSagRatio`、`CommandWireMaxSag`は見た目だけを調整し、切断判定は発射位置とミサイルを結ぶ直線で行います。

## 発射・飛翔・着弾演出

- 発射地点に残る音とパーティクルは`FSE_DFUNC_MissileLauncher`へ設定します。
- ミサイルに追従するParticle、Trail、AudioSourceは`FSE_MissileController`へ設定します。

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
