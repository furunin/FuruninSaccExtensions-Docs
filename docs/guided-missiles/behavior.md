# ミサイルの動作

## 飛翔フェーズ { #phases }

発射されたミサイルは、以下の4つのフェーズを順番に遷移します。

| フェーズ | 誘導操作 | 加速 | 重力 |
| --- | --- | --- | --- |
| `Straight Boost` | 受け付けない | あり | なし |
| `Guided Boost` | 受け付ける | あり | なし |
| `Guided Coast` | 受け付ける | なし | なし |
| `Ballistic Flight` | 受け付けない | なし | あり |

- `FSE_MissileController`のインスペクターから各フェーズの継続時間を設定でき、0秒に設定するとそのフェーズはスキップされます。
- `Ballistic Flight`終了時は、ダメージや爆発演出を発生させずミサイルプールへ回収されます。

## ミサイルのプール処理

このギミックは発射ごとにミサイルを新規作成せず、`ProjectilePool`へ登録したミサイルのオブジェクトを再利用します。再利用枠がすべて使用中の状態で発射すると、飛翔中の古いミサイルが回収され、爆発せず消滅します。

## 弾薬と再装填

`LaunchStations`へ発射順に登録されたステーションの弾を撃ち切り、総残弾が残っている場合は、`RackReloadTimeSeconds`経過後に次のラックを装填します。弾薬がないステーションでは`VisualRoot`だけが非表示になり、発射位置とワイヤー始点は維持されます。

## 発射制限

- `GuidanceReference`を設定している場合、発射に使用する`LaunchPoint`の発射方向と`GuidanceReference`の照準方向との角度が`MaxLaunchSightAngle`を超えている間は発射できません。
- `AllowFiringWhenGrounded`を無効にしたSacc航空機は、`Taxiing`中に発射できません。`SAVControl`が未設定ならこの制限は適用しません。
- `MaximumFiringSpeed`へ正の値を設定すると、車両Rigidbodyの合成速度がその値（m/s）以上の間は発射できません。0以下は無制限です。Rigidbodyが未設定なら速度制限は適用しません。
