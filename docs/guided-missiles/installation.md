# 共通セットアップ

以下はSACLOSとMCLOSに共通する最低限の手順です。誘導方式固有の設定は、共通設定の後に追加します。

## 1. 車両のVariantを作成する

導入先の車両PrefabからPrefab Variantを作成し、車両固有の変更をそのVariantへ保存します。配布アセット内の元Prefabは直接編集しません。

## 2. 発射装置を配置する

1. Variant内にミサイル用ルートを作成します。
2. 発射装置を置くGameObjectへ`FSE_DFUNC_MissileLauncher`を追加します。
3. `SAVControl`へ車両のSacc制御Component、`EntityControl`へ同じ車両の`SaccEntity`を指定します。
4. `CollisionHostRoot`へ、発射直後の衝突から除外する車両階層のルートを指定します。
5. `OperatorSeat`へ操作に使用する一席を指定します。

操作席ごとの登録方法は[PassengerSeat／PilotSeat](operator-seat.md)を参照してください。

## 3. 発射位置と搭載弾表示を設定する

1. 搭載位置ごとに`LaunchPoint`となるTransformを作ります。
2. 各Transformの青いZ軸を実際の射出方向へ向けます。
3. 発射順に`LaunchPoints`へ登録します。
4. 搭載弾を表示する場合は、対応する表示物を同じ順序で`AmmoMeshes`へ登録します。
5. 搭載弾表示を使わない場合は`AmmoMeshes`を空配列にします。

## 4. 再利用用ミサイルを配置する

1. 待機中ミサイルの親となるGameObjectを作成します。
2. 再利用するミサイルを必要数だけ配置し、待機中は無効にします。
3. 各ミサイルへ`Rigidbody`、Collider、`FSE_MissileController`を追加します。
4. `FSE_MissileController`へRigidbody、Collider、表示物、飛翔・着弾演出を割り当てます。
5. すべての`FSE_MissileController`を発射装置の`ProjectilePool`へ登録します。
6. `PoolRoot`へ待機中ミサイルの親Transformを指定します。
7. `PrewarmPoolCount`は`ProjectilePool`へ登録した数を超えない値にします。

`WorldParent`には飛翔中のミサイルを車体へ追従させないTransformを指定するか、未設定にします。

## 5. 誘導基準を設定する

`GuidanceReference`へ照準方向を示すTransformを指定します。青いZ軸が誘導方向です。

FSE Turret Controlを併用する場合は`FSE_EXT_Turret.AimOrigin`を指定できます。固定方向へ発射する構成では、固定Transformも使用できます。

## 6. 誘導方式を追加する

- [SACLOSを設定する](saclos.md)
- [MCLOSを設定する](mclos.md)

二つの誘導Componentを同じミサイルの`GuidanceModule`へ同時に指定しないでください。

## 7. DialFunctionへ登録する

`FSE_DFUNC_MissileLauncher`を操作席で使用する左右どちらか一方のDialFunctionへ一度だけ登録します。同じランチャーを複数のDial配列や複数席へ重複登録すると、操作は安全のため無効になります。

任意機能は、基本的な発射と誘導が動作した後に[任意機能](optional-features.md)から追加してください。
