# 任意の設定

## 爆発時のメッシュ非表示設定をする

追加したミサイルや照準器などのメッシュが、機体の爆発時に消滅するよう設定します。

1. 爆発時のアニメーションを開きます。既存のアニメーションを流用する場合は複製してからアニメーターコントローラー内で参照されるよう設定し、手順2に進みます。

    !!! Info "爆発アニメーションの場所"
        例として、Sacc付属のSH-1の場合は`Assets/SaccFlightAndVehicles/AssetFiles/SH-1/Animations/Explode_SH1`にあります。

2. 爆発時に非表示にしたいオブジェクト（ミサイルランチャー、照準器、格納中ミサイルなど）を追加し、チェックを外して非表示状態になるようキーフレームを設定します。

## 指令ワイヤーの表示と切断設定を変更する

- 飛翔用ミサイルの`FSE_MissileController`内`Command Link`に`FSE_CommandLinkController`を登録し、`EnableCommandWire`を有効にすると、ミサイルへ操作指令を送る有線ワイヤーが表示されるようになります。
- `EnableWireCutDetection`を有効にすると、ミサイルとランチャーの間が障害物で遮られた際にワイヤーが切断され、誘導が停止します。
- `FSE_CommandLinkController`の`First Command Wire Renderer`へ1本目のワイヤーを描画するLineRendererを指定します。ワイヤーを2本表示する場合は、`Second Command Wire Renderer`へ別のLineRendererを指定してください。
- ランチャー側のワイヤー接続位置は、格納状態ミサイルの`FSE_MissileLaunchStation`にある`First Command Wire Origin`と`Second Command Wire Origin`へ指定したトランスフォームで調整します。未設定の場合は、そのステーションの`Launch Point`を使用します。
- ミサイル側のワイヤー接続位置は、飛翔用ミサイルの各LineRendererが付いたオブジェクトのトランスフォームで調整します。配布プレハブでは`Command Wire`と`Command Wire 2`が該当します。

表示と切断判定は個別に有効化できます。`CommandWireSegments`、`CommandWireSagRatio`、`CommandWireMaxSag`は外観の見た目のみを調整し、切断判定は発射位置とミサイルを結ぶ中心の直線で行われます。

## 操縦席とミサイル操作席の役割を交代する { #fse-take-control }

`FSE_DFUNC_TakeControl`を使用すると、着席したまま操縦とミサイル操作の担当を交代できます。あらかじめ[導入手順](installation.md)のPassengerSeat構成を設定してください。

FSE Turret Controlを[導入手順](../turret-control/installation.md)に従って操作席へ登録している場合は、砲塔の照準操作も交代後の操作席へ追従します。交代後の操作は[Turret Controlの操作方法](../turret-control/operation.md)を参照してください。

1. 乗り物の`SaccEntity`配下にオブジェクトを作成し、`FSE_DFUNC_TakeControl`コンポーネントを追加します。
2. `EntityControl`へ乗り物の`SaccEntity`を、`ThisSVSeat`へ交代前のミサイル操作席の`SaccVehicleSeat`を指定します。
3. 同じ`FSE_DFUNC_TakeControl`を、`SaccEntity.Dial_Functions_L/R`と、ミサイル操作席の`SAV_PassengerFunctionsController.Dial_Functions_L/R`の双方へ登録します。両方に登録することで、交代後も再交代の機能を選択できます。
4. デスクトップモード時の選択キーを設定する場合は、各席で使用する`SAV_KeyboardControls`の空きスロットへ同じ`FSE_DFUNC_TakeControl`を指定し、選択キーを設定します。`SAV_KeyboardControls`がない場合は、各席の`Enable In Seat`に登録されたオブジェクトへ追加してください。`FSE_DFUNC_TakeControl.TakeControlKey`には、選択後に交代を実行するキーを設定します。
5. Take Controlを選択し、VRでは選択した側のコントローラーのトリガー、デスクトップでは`TakeControlKey`に設定したキーで交代を実行します。両席から、交代後の操縦・ミサイル操作と再交代ができることを確認してください。

交代は、操縦者とミサイル操作担当のどちらからでも開始できます。

操縦者の許可を必要とする場合は、操縦者が有効／無効を切り替えられるオブジェクトを`PermissionObject`へ指定します。許可が必要になるのは、ミサイル操作担当が交代を求める場合だけです。操縦席に搭乗者がいる場合、そのオブジェクトが有効な間だけミサイル操作担当が操縦を引き継げます。操縦者が自分で交代を開始する場合、`PermissionObject`が未設定の場合、または操縦席が空席の場合は、許可なしで交代できます。

交代後の操縦者は、いつでも元の役割へ戻せます。ミサイル操作席へ移った元の操縦者が元へ戻すには、`PermissionObject`が有効である必要があります。`PermissionObject`が未設定の場合は、どちらの席からでも元へ戻せます。長押しで交代する場合は`HoldToTake`を有効にします。

座席ごとの無線も交代する場合は、操縦席用の`SAV_Radio`を`PilotRadio`へ、ミサイル操作席用を`ThisSeatRadio`へ指定します。交代時に計器などを移動する場合は、`MoveTransforms`へ移動対象を、`MoveTransforms_CoPosition`へ移動先の位置・回転を示すトランスフォームを、同じ要素数・順序で登録してください。

## パイロット席に着席しなくてもミサイルを補給できるようにする

`InVehicleOnly`直下に`ResupplyTrigger`を配置することで、パイロット席に着席していなくてもミサイルの補給が可能になります。`ResupplyTrigger`は、SH-1の場合は初期状態で`InVehicleOnly/PilotOnly`に配置されています。`ResupplyTrigger`の配置変更を行った場合は、オリジナルの`ResupplyTrigger`オブジェクトを削除、無効化、またはEditorOnlyに設定してください。

## 残弾表示を追加する

`FSE_DFUNC_MissileLauncher`は、同期された総残弾数をTextまたはAnimatorへ出力できます。

- Unity UI Textは`HUDText_Missile_ammo`、world-space TextMeshProは`HUDText_Missile_ammo_TMP`、TextMeshProUGUIは`HUDText_Missile_ammo_TMPUGUI`へ、残弾表示専用のオブジェクトを指定します。
- Animatorを使用する場合は、表示対象を子に持つ常時有効なオブジェクトへ配置し、`FSE_DFUNC_MissileLauncher`の`Missile Animator`へ指定します。残弾表示用のFloatパラメーターを作成し、同じ名前を`Remaining Ammo Float Name`へ指定してください。Floatには予備弾を含む総残弾数／`MaxAmmo`が0から1の範囲で出力されます。
- AAM、AGM、Bombなど、別の武器DFUNCが制御するTextやAnimatorパラメーターは指定しないでください。

## 装填アニメーションを追加する { #reload-animation }

残弾表示と共通の`FSE_DFUNC_MissileLauncher`の`Missile Animator`を使用します。出力名の既定値は[設定項目一覧](components.md#fse_dfunc_missilelauncher)を参照してください。

1. Animator Controllerに、装填中を表すBoolパラメーター、装填進捗を表すFloatパラメーターの一方または両方を作成します。同じ名前をLauncherの`Reloading Bool Name`と`Reload Progress Float Name`へそれぞれ指定します。
2. 配布の格納状態ミサイルでは、`Visual`配下のモデルの位置やScaleをアニメーションで動かします。モデルは有効な状態に保ち、`VisualRoot`自体の有効／無効はAnimatorで操作しないでください。
3. 装填中のBoolと、0～1の進捗Floatを使って演出を設定します。進捗は装填中でなければ1です。装填完了時のモデルの姿勢や、粒子・音の終了状態もアニメーションで設定してください。

登録したAnimatorに、指定した名前・型の装填用パラメーターが少なくとも一方ある場合は、装填予定の弾の`VisualRoot`が装填中も有効になります。使用しない出力名は空欄にできます。装填アニメーションを設定しない場合は、装填完了まで弾の見た目は非表示になります。実際の装填確定はラック単位で、装填途中の発射はできません。

## ミサイルの迎撃に関する設定をする

配布の飛翔用ミサイルには迎撃判定用の`Intercept Proxy`が設定されています。Bomb、AGM、AAM、FSEミサイルの弾体が直接接触すると、残りの`Health`にかかわらず破壊されます。パーティクルなどから`SaccTarget`へダメージを受けた場合は、`Health`が0になると破壊されます。耐久度を調整する場合は、飛翔用ミサイルプレハブの`Intercept Proxy`にある`SaccTarget.Health`を変更します。

既存の独自飛翔用プレハブで迎撃機能を使用する場合は、次のように設定します。

1. 配布の`Missile Round_InFlight`テンプレートから`Intercept Proxy`を独自プレハブへ複製します。
2. 複製先の`FSE_MissileInterceptReceiver`で、`Missile`には同じ飛翔弾の`FSE_MissileController`を、`DamageTarget`、`HitCollider`、`HitRigidbody`には同じ`Intercept Proxy`の各コンポーネントを指定します。
3. `Intercept Proxy`の`SaccTarget.ExplodeOther`と、飛翔弾の`FSE_MissileController.InterceptReceiver`に、複製先の`FSE_MissileInterceptReceiver`を指定します。`SaccTarget.Health`には0より大きい値を設定してください。
4. `ProjectilePool`に登録されたすべての飛翔弾に、このプレハブの変更が反映されていることを確認します。

## ミサイル発射による機体の重心位置変化を再現する

`FSE_MissileMassBalance`を使用すると、各Launcherの残弾数と搭載位置に合わせて乗り物の重心位置を動的に変更できます。左右のミサイルを異なる順序で発射する構成にも利用可能です。この機能は`SaccEntity.CenterOfMass`の位置のみを変更し、乗り物やミサイルのRigidbodyの質量自体は変更しません。

1. `SaccEntity.CenterOfMass`へ、ミサイルを含まない状態の重心位置に配置した専用の子トランスフォームを指定します。乗り物のルートは指定しないでください。
2. 乗り物内のオブジェクトへ`FSE_MissileMassBalance`コンポーネントを追加し、`SaccEntity.ExtensionUdonBehaviours`へ登録します。
3. `EntityControl`へ乗り物の`SaccEntity`を指定し、`Launchers`へ重心計算に使用する`FSE_DFUNC_MissileLauncher`を登録します。同じLauncherを重複して登録しないでください。
4. 各Launcherの`ProjectilePool`に登録されている飛翔用ミサイルの`Rigidbody`へ、ミサイル1発分の質量を設定します。同じLauncherに属する飛翔用ミサイルには、すべて同じ値を設定してください（質量は0より大きい値にします）。
5. `VehicleMassWithoutMissiles`へミサイルを含まない乗り物の基本質量を設定します。0の場合は、初期化時の乗り物のRigidbodyの質量が使用されます。

`MissileCenterOfMassOffsets`を使用すると、各発射ステーションのルートトランスフォームを基準に、そのローカル座標で重心位置を補正できます。`MaxAmmo`が`Launch Stations`の数を超える場合は、`ReserveMassPoints`へ予備弾の重心位置を指定できます。これらを使用する場合は、`Launchers`と同じ要素数・順序で登録してください。

`FSE_MissileMassBalance`は1台の乗り物に1つだけ使用してください。`SaccEntity.CenterOfMass`を動的に変更する他のコンポーネントとは併用できません。
