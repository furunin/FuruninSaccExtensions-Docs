# FSE Guided Missiles

FSE Guided Missilesは、Sacc車両へ誘導ミサイルを搭載するためのギミックです。

- 共通機能：発射、飛翔、着弾、再装填、補給、発射制限、ミサイルのプール管理
- 対応する誘導方式
    - MCLOS：射手が飛翔中のミサイルへ直接上下左右への旋回指令を送ります。
    - SACLOS：照準線へミサイルを誘導します。

## 配布Prefabの選び方

### 完成Sample

`SH-1_GuidedMissile_MCLOS`と`SH-1_GuidedMissile_SACLOS`は、SH-1車両用に接続済みの完成Sampleです。まずは使用する誘導方式のSampleを開き、座席、照準器、補給、発射位置の接続例を確認してください。

### 再利用用Prefab

独自のSacc車両へ搭載する場合は、`FSE_GuidedMissile`を車両階層へ配置します。このPrefabにはランチャー、発射位置、搭載弾表示、飛翔中のミサイル、`FSE_TurretControl`が含まれます。車両ごとに異なる参照だけを接続し、Prefab内で接続済みの参照は通常変更しません。

誘導基準には任意のTransformを使用できます。[FSE Turret Control](../turret-control/index.md)は照準器を用意する選択肢の一つであり、Guided Missilesの必須Componentではありません。

[共通セットアップを開始する](installation.md)
