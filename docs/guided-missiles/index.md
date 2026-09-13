# FSE Guided Missiles

FSE Guided Missilesは、Saccの乗り物へ誘導ミサイルを搭載するためのギミックです。

- 共通機能：発射、飛翔、着弾、再装填、補給、発射制限、ミサイルのプール管理
- 対応する誘導方式
    - MCLOS：射手が飛翔中のミサイルへ直接上下左右への旋回指令を送ります。
    - SACLOS：照準線へミサイルを誘導します。

## パッケージに含まれるプレハブ

### 完成品サンプルプレハブ

`Assets\Furunin\SaccExtensions\Prefabs\Guided Missile`以下にあります。

| ファイル名 | 説明 |
| --- | --- |
| `SH-1_GuidedMissile_MCLOS` | SH-1にMCLOSミサイルを設定した完成品サンプル |
| `SH-1_GuidedMissile_SACLOS` | SH-1にSACLOSミサイルを設定した完成品サンプル |

### 部品プレハブ

`Assets\Furunin\SaccExtensions\Prefabs\Guided Missile\SubComponents`以下にあります。


| ファイル名 | 説明 |
| --- | --- |
| `FSE_GuidedMissile` | FSE Guided Missilesの関連コンポーネントをまとめたプレハブ。独自車両にFSE Guided Missilesを搭載する際に利用できます |
| `Missile Round_Stowed` | 発射前ミサイルの関連コンポーネントをまとめたプレハブ。`FSE_GuidedMissile`に使用されます |
| `Missile Round_InFlight` | 飛翔中ミサイルの関連コンポーネントをまとめたプレハブ。`FSE_GuidedMissile`に使用されます |
| `SH-1_GuidedMissile_Base` | 完成品サンプルに誘導方式別設定を行う前のサンプル。完成品サンプルに使用されます |

!!! Warning
    このパッケージのプレハブに変更を加える場合はプレハブを直接編集しないようにし、プレハブバリアントを作成するかプレハブを展開して使用してください。プレハブを編集して使用すると、バージョンアップ時にギミックが正しく動作しなくなる可能性があります。

## ギミック導入手順

[導入手順](installation.md)を参照してください。
