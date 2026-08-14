# FSE Guided Missiles

FSE Guided Missilesは、Sacc車両へ誘導ミサイルを搭載するためのギミックです。

- 共通機能：発射、飛翔、着弾、再装填、補給、発射制限、ミサイルのプール管理
- 対応する誘導方式
    - MCLOS：射手が飛翔中のミサイルへ直接上下左右への旋回指令を送ります。
    - SACLOS：照準線へミサイルを誘導します。

誘導基準には任意のTransformを使用できます。[FSE Turret Control](../turret-control/index.md)は照準器を用意する選択肢の一つであり、Guided Missilesの必須Componentではありません。

[共通セットアップを開始する](installation.md)
