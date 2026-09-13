# 任意の設定

## 爆発時のメッシュ非表示設定をする

追加したミサイルや照準器などのメッシュが爆発時に消滅するように設定します。

1. 爆発時のアニメーションを開きます。既存のアニメーションを流用する場合は、複製してからアニメーションコントローラー内で参照されるように設定し、2.の手順に進みます。

    !!! Info  "爆発アニメーションの場所"
        例として、SaccのSH-1の場合は`Assets/SaccFlightAndVehicles/AssetFiles/SH-1/Animations/Explode_SH1`にあります。

2. 爆発時に非表示にしたいオブジェクト（ミサイルランチャー、照準器、格納中ミサイルなど）を追加し、チェックを外して表示されないようにします。

## 発射・飛翔・着弾演出を設定する

- 発射地点に残る音とパーティクルは`FSE_DFUNC_MissileLauncher`へ設定します。
- ミサイルに追従するパーティクル、トレイル、音源は`FSE_MissileController`へ設定します。

## 指令ワイヤーの表示と切断設定を変更する

飛翔用ミサイルの`FSE_MissileController`内`Command Link`に`FSE_CommandLinkController`を登録し、`EnableCommandWire`を有効にするとミサイルへ操作入力を送る指令ワイヤーが表示されるようになります。`EnableWireCutDetection`を有効にすると、目標と発射位置の間が障害物で遮られた際にワイヤーが切断され、誘導ができなくなります。

表示と切断判定は個別に有効化できます。`CommandWireSegments`、`CommandWireSagRatio`、`CommandWireMaxSag`は見た目だけを調整し、切断判定は発射位置とミサイルを結ぶ直線で行います。

## パイロット席に着席しなくてもミサイルを補給できるようにする

`InVehicleOnly`直下に`ResupplyTrigger`を配置することで、パイロット席に着席しなくてもミサイルを補給できるようになります。`ResupplyTrigger`は、SH-1の場合はデフォルトで`InVehicleOnly/PilotOnly`に配置されています。`ResupplyTrigger`の配置変更を行った場合は、オリジナルの`ResupplyTrigger`オブジェクトを削除、無効化、またはEditorOnlyにしてください。

## 残弾表示を追加する

`FSE_DFUNC_MissileLauncher`は、同期された総残弾数をTextまたはAnimatorへ出力できます。

- Unity UI Textは`HUDText_Missile_ammo`、world-space TextMeshProは`HUDText_Missile_ammo_TMP`、TextMeshProUGUIは`HUDText_Missile_ammo_TMPUGUI`へ、残弾表示専用のObjectを指定します。
- Animatorを使用する場合は、残弾表示専用のFloat Parameterを作成し、`MissileAnimator`へAnimatorを、`AnimFloatName`へParameter名を指定します。Floatには残弾の割合が0から1で出力されます。
- AAM、AGM、Bombなど、別の武器DFUNCが制御するTextやAnimator Parameterは使用しないでください。

## ミサイル発射による機体の重心位置変化を再現する
