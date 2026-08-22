# 任意機能の導入

## `ResupplyTrigger`の配置を変更する

`InVehicleOnly`直下に`ResupplyTrigger`を配置することで、パイロット席に着席しなくてもミサイルを補給できるようになります。`ResupplyTrigger`は、SH-1の場合はデフォルトで`InVehicleOnly/PilotOnly`に配置されています。`ResupplyTrigger`の配置変更を行った場合は、オリジナルの`ResupplyTrigger`オブジェクトを削除、無効化、またはEditorOnlyにしてください。

## 指令ワイヤー

飛翔用ミサイルの`FSE_MissileController`内`Command Link`に`FSE_CommandLinkController`を登録し、`EnableCommandWire`を有効にするとミサイルへ操作入力を送る指令ワイヤーが表示されるようになります。`EnableWireCutDetection`を有効にすると、目標と発射位置の間が障害物で遮られた際にワイヤーが切断され、誘導ができなくなります。

表示と切断判定は個別に有効化できます。`CommandWireSegments`、`CommandWireSagRatio`、`CommandWireMaxSag`は見た目だけを調整し、切断判定は発射位置とミサイルを結ぶ直線で行います。

## 発射・飛翔・着弾演出

- 発射地点に残る音とパーティクルは`FSE_DFUNC_MissileLauncher`へ設定します。
- ミサイルに追従するParticle、Trail、AudioSourceは`FSE_MissileController`へ設定します。

## FSE_CommandLinkController設定

| Field | 説明 |
|---|---|
| `Missile` | 同じミサイルの`FSE_MissileController`です。 |
| `CommandWireRenderer` / `EnableCommandWire` | ワイヤー表示用LineRendererと表示の有効化です。 |
| Sag項目 | 線の分割数と見た目の垂れを調整します。 |
| `EnableWireCutDetection` / `WireCutLayers` | 障害物による切断判定と対象Layerです。 |
| `WireCutCheckInterval` / `WireCutRadius` | 切断検査の間隔と判定線の太さです。 |
| `EnableDiagnostics` | 調査時だけ診断出力を有効にします。通常運用では無効にします。 |
