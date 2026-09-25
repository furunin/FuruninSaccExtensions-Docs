# ミサイルの動作

## 発射と誘導

- ミサイルは`LaunchPoint`のZ軸+（青い矢印）方向へ発射されます。
- 誘導中、MCLOSの場合は射手の上下左右入力で進行方向を変え、SACLOSの場合は`GuidanceReference`の照準線に沿って飛翔します。

- 複数発が同時飛翔している時は、MCLOSミサイルは同じ操作を、SACLOSミサイルは同じ照準線を誘導に使用します。

## 弾頭の作動

ミサイルは発射直後から衝突を判定します。`WarheadArmingDelaySeconds`が経過する前に衝突した場合は、ダメージと爆発演出を発生させず待機状態へ戻ります。経過後に衝突した場合は、設定したダメージと爆発演出を適用します。

## 飛翔段階

- `Straight Boost`：発射直後は推進しながら直進します。
- `Guided Boost`：推進しながら誘導できます。
- `Guided Coast`：推進を止めた後も誘導できます。
- `Ballistic Flight`：誘導を終え、重力を受けて飛行します。

各段階は`StraightBoostTime`、`GuidedBoostTime`、`GuidedCoastTime`、`BallisticFlightTime`で個別に設定します。`Ballistic Flight`終了時は、ダメージや爆発演出を発生させず待機状態へ戻ります。飛翔中に通常着弾した場合は、設定したダメージと演出を適用します。

## ミサイルのプール処理

発射ごとにミサイルを新規作成せず、`ProjectilePool`へ登録したミサイルのオブジェクトを再利用します。再利用枠がすべて使用中の状態で発射すると、飛翔中の古いミサイルが回収され、爆発せず消滅することがあります。

## 弾薬と再装填

`LaunchPoints`へ装填された弾を撃ち切り、総残弾が残っている場合は、`RackReloadTimeSeconds`経過後に次のラックを装填します。

## 発射制限

- `GuidanceReference`を設定している場合、発射に使用する`LaunchPoint`の発射方向と`GuidanceReference`の照準方向との角度が`MaxLaunchSightAngle`を超えている間は発射できません。
- `AllowFiringWhenGrounded`を無効にしたSacc航空機は、`Taxiing`中に発射できません。`SAVControl`が未設定ならこの制限は適用しません。
- `MaximumFiringSpeed`へ正の値を設定すると、車両Rigidbodyの合成速度がその値（m/s）以上の間は発射できません。0以下は無制限です。Rigidbodyが未設定なら速度制限は適用しません。
- 制限により拒否された入力では、弾薬、再装填、発射間隔、待機中ミサイル、エフェクトを変更しません。
