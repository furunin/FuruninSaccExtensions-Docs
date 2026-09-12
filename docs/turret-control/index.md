# FSE Turret Control

FSE Turret Controlは、照準器や砲塔の上下左右回転を操作し、その向きを同期するギミックです。`FSE_TurretControl` Prefabを車両へ追加し、車両固有の参照を接続して使用できます。

- 上下軸と左右軸を分けた主照準器
- 主照準へ追従する別砲塔
- Desktopの`W/A/S/D`操作
- VR右手Gripによる手動照準
- 頭または視点の方向へ追従するHEAD SLAVE
- Sight Cameraの直接FOV操作、Zoom、距離計
- Sight CameraのFOVに応じた手動照準速度補正

車両の砲塔や照準カメラに使用できるほか、Guided Missilesと組み合わせて使用できます。

## パッケージに含まれるプレハブ

`Assets\Furunin\SaccExtensions\Prefabs\Turret Control`以下にあります。

| ファイル名 | 説明 |
| --- | --- |
| `FSE_TurretControl` | 本ギミック導入用プレハブ。 |
| `Sight Display` | 照準映像の表示に使用するプレハブ。`FSE_TurretControl`に使用されます。 |

!!! Warning
    このパッケージのプレハブに変更を加える場合はプレハブを直接編集しないようにし、プレハブバリアントを作成するかプレハブを展開して使用してください。プレハブを編集して使用すると、バージョンアップ時にギミックが正しく動作しなくなる可能性があります。

## ギミック導入手順

[セットアップ](installation.md)を参照してください。
