# 共通セットアップ

以下は各誘導方式に共通する手順です。共通セットアップの後に各誘導方式固有の設定を行います。

## 1. 発射装置を配置する

1. セットアップを行う車両に本ギミック用のオブジェクト（例：`FSE Guided Missile`）を作成し、`FSE_DFUNC_MissileLauncher`コンポーネントを追加します。
2. `SAVControl`へ車両の`Sacc Air Vehicle`コンポーネントを、`EntityControl`へ車両の`SaccEntity`を指定します。
3. `CollisionHostRoot`へ、ミサイル発射直後の衝突判定から除外する車両階層のルートを指定します。
4. `OperatorSeat`へミサイル操作に使用する席を指定します。

操作席ごとの登録方法は[PassengerSeat／PilotSeat](operator-seat.md)を参照してください。

## 2. 発射位置と搭載弾表示を設定する

1. ミサイルの発射位置を示すオブジェクトを配置します（例：`LaunchPount`）。車両に複数のランチャーを搭載する場合は一つのランチャーにつき一つの発射位置オブジェクトを作成します。青いZ軸が射出方向を向くようにします。
2. 作成した発射位置オブジェクトを`FSE_DFUNC_MissileLauncher`の`LaunchPoints`へ登録します。ランチャーが複数ある場合は、ここで登録した順番に発射されます。
3. 搭載弾を表示する場合は、対応するメッシュを発射位置オブジェクトと同じ位置に配置し、同じ順序で`AmmoMeshes`へ登録します。搭載弾表示を使わない場合は`AmmoMeshes`を空配列にします。

## 3. 飛翔処理用ミサイルを配置する

1. 飛翔処理用ミサイルを格納する親オブジェクトを作成します（例：`Missile Pool`）。
2. 1.で作成したオブジェクトの下に実際に飛翔処理を行うミサイルのオブジェクト（例：`Missile`）を配置し、非アクティブにします。
3. ミサイルオブジェクトへ`Rigidbody`、任意のCollider、`FSE_MissileController`を追加します。
4. `FSE_MissileController`へRigidbody、Collider、飛翔中の3Dモデル、エフェクトを割り当てます。
5. 対象の車両から発射されたミサイルがワールド内に同時に複数存在し得る場合は、ミサイルオブジェクトを十分な数だけ複製します。本ギミックはあらかじめ作成したミサイルオブジェクトを使って発射から着弾の処理を行うため、ここで作成するミサイルオブジェクトの数が、ワールドに同時に存在できるミサイルの数になります。ミサイルオブジェクトの数は、ランチャーの数と一致する必要はありません。
6. すべての`FSE_MissileController`を`FSE_DFUNC_MissileLauncher`の`ProjectilePool`へ登録します。
7. `PoolRoot`へ1.で作成したオブジェクトを指定します。

`WorldParent`には飛翔中のミサイルを車体へ追従させないTransformを指定するか、未設定にします。

## 4. 誘導基準を設定する

`GuidanceReference`へ照準方向を示すTransformを指定します。青いZ軸が誘導方向です。

FSE Turret Controlを併用する場合は`FSE_EXT_Turret.AimOrigin`を指定できます。固定方向へ発射する構成では、固定Transformも使用できます。

## 5. 各誘導方式の固有設定をする

- [MCLOSを設定する](mclos.md)
- [SACLOSを設定する](saclos.md)

二つの誘導Componentを同じミサイルの`GuidanceModule`へ同時に指定しないでください。

## 6. DialFunctionへ登録する

`FSE_DFUNC_MissileLauncher`を操作席で使用する左右どちらか一方のDialFunctionへ登録します。同じランチャーを複数のDial配列や複数席へ重複登録すると、操作は安全のため無効になります。

任意機能は、基本的な発射と誘導が動作した後に[任意機能](optional-features.md)から追加してください。
