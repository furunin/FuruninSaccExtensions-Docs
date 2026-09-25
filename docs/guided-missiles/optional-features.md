# 任意の設定

## 爆発時のメッシュ非表示設定をする

追加したミサイルや照準器などのメッシュが爆発時に消滅するように設定します。

1. 爆発時のアニメーションを開きます。既存のアニメーションを流用する場合は、複製してからアニメーションコントローラー内で参照されるように設定し、2.の手順に進みます。

    !!! Info  "爆発アニメーションの場所"
        例として、SaccのSH-1の場合は`Assets/SaccFlightAndVehicles/AssetFiles/SH-1/Animations/Explode_SH1`にあります。

2. 爆発時に非表示にしたいオブジェクト（ミサイルランチャー、照準器、格納中ミサイルなど）を追加し、チェックを外して表示されないようにします。

## 発射・飛翔・着弾演出を設定する

- 発射地点に残る音とパーティクルは`FSE_DFUNC_MissileLauncher`へ設定します。
- 飛翔用Prefabの`FSE_MissileController`で`Flight & Impact Effect Groups`の`Add Effect Group`を選び、パーティクル・トレイル・音源を子に持つ親Transformを`Group`へ指定します。
- 各`Group`で再生する`Straight Boost`、`Guided Boost`、`Guided Coast`、`Ballistic Flight`、`Impact`をチェックします。
- `Impact`用の親Transformは`MissileVisualRoot`の外に配置します。演出グループ同士を親子に重ねないでください。

## ミサイルの迎撃

配布の飛翔用ミサイルには迎撃判定用の`Intercept Proxy`が設定されています。Bomb、AGM、AAM、FSEミサイルの弾体が直接当たると、残りの`Health`にかかわらず破壊されます。Particleなどから`SaccTarget`へダメージを受けた場合は、`Health`が0になると破壊されます。耐久度を調整する場合は、飛翔用ミサイルPrefabの`Intercept Proxy`にある`SaccTarget.Health`を変更します。

弾頭の作動前に迎撃されたミサイルは爆発せずに消滅します。作動後は設定した範囲ダメージと爆発演出が発生します。ロックオン対象の選択は武器側の設定に従います。

既存の独自飛翔用Prefabでも迎撃を使用する場合は、次のように設定します。

1. 配布の`Missile Round_InFlight`テンプレートから`Intercept Proxy`を独自Prefabへ複製します。
2. 複製先の`FSE_MissileInterceptReceiver`で、`Missile`には同じ飛翔弾の`FSE_MissileController`を、`DamageTarget`、`HitCollider`、`HitRigidbody`には同じ`Intercept Proxy`の各Componentを指定します。
3. `Intercept Proxy`の`SaccTarget.ExplodeOther`と、飛翔弾の`FSE_MissileController.InterceptReceiver`に、複製先の`FSE_MissileInterceptReceiver`を指定します。`SaccTarget.Health`には0より大きい値を設定します。
4. `ProjectilePool`に登録されたすべての飛翔弾に、このPrefabの変更が反映されていることを確認します。

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

`FSE_MissileMassBalance`を使用すると、各Launcherの残弾数と搭載位置に合わせて乗り物の重心位置を変更できます。左右のミサイルを異なる順序で発射する構成にも使用できます。この機能は`SaccEntity.CenterOfMass`の位置だけを変更し、乗り物やミサイルのRigidbodyの質量は変更しません。

1. `SaccEntity.CenterOfMass`へ、ミサイルを含まない状態の重心位置に配置した専用の子Transformを指定します。乗り物のrootは指定しないでください。
2. 乗り物内のGameObjectへ`FSE_MissileMassBalance`を追加し、`SaccEntity.ExtensionUdonBehaviours`へ登録します。
3. `EntityControl`へ乗り物の`SaccEntity`を指定し、`Launchers`へ重心計算に使用する`FSE_DFUNC_MissileLauncher`を登録します。同じLauncherは重複して登録しないでください。
4. 各Launcherの`ProjectilePool`に登録されている飛翔用ミサイルの`Rigidbody`へ、ミサイル1発分の質量を設定します。同じLauncherに属する飛翔用ミサイルには、すべて同じ値を設定してください。質量は0より大きい値にします。
5. `VehicleMassWithoutMissiles`へミサイルを含まない乗り物の質量を設定します。0の場合は、初期化時の乗り物のRigidbodyの質量を使用します。

`MissileCenterOfMassOffsets`を使用すると、搭載弾表示のTransformから重心位置を補正できます。`MaxAmmo`が搭載弾表示の数を超える場合は、`ReserveMassPoints`へ予備弾の重心位置を指定できます。これらを使用する場合は、`Launchers`と同じ要素数で、同じ順序に登録してください。

`FSE_MissileMassBalance`は1台の乗り物に1つだけ使用してください。`SaccEntity.CenterOfMass`を動的に変更する他のComponentとは併用できません。
