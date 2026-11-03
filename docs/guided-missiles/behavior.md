# ミサイルの動作

## 飛翔フェーズ { #phases }

発射されたミサイルは、以下の4つのフェーズを順番に遷移します。

| フェーズ | 誘導操作 | 加速 | 重力 |
| --- | --- | --- | --- |
| `Straight Boost` | 受け付けない | あり | なし |
| `Guided Boost` | 受け付ける | あり | なし |
| `Guided Coast` | 受け付ける | なし | なし |
| `Ballistic Flight` | 受け付けない | なし | あり |

- `FSE_MissileController`のインスペクターから各フェーズの継続時間を設定でき、0秒に設定したフェーズはスキップされます。
- `Ballistic Flight`終了時は、ダメージ判定や爆発演出を発生させずにミサイルプールへ自動回収されます。

## ミサイルのプール処理

このギミックは発射のたびにミサイルを新規生成（Instantiate）せず、`ProjectilePool`へ事前登録したミサイルオブジェクトを再利用します。プール枠がすべて使用中の状態でミサイルを発射した場合は、飛翔中の最も古いミサイルが回収され、爆発演出なしで消滅して新弾へ割り当てられます。

## 弾薬と再装填

`LaunchStations`に登録されたすべての発射ステーションを撃ち切ったとき、総残弾（`Max Ammo`）が残っていれば`RackReloadTimeSeconds`秒の経過後に次のラックが自動装填されます。

`UnlimitedAmmo`が有効な場合は、ラックを撃ち切るたびに`RackReloadTimeSeconds`秒の経過後に再装填されます。一度に装填される数は、`MaxAmmo`と発射ステーション数の小さい方です。

## 発射制限

- `GuidanceReference`が設定されている場合、発射に用いる`LaunchPoint`の発射方向と`GuidanceReference`の照準方向とのなす角が`MaxLaunchSightAngle`を超えている間は発射できません。
- `AllowFiringWhenGrounded`を無効にしたSacc航空機は、地上滑走中（`Taxiing`）の発射が制限されます（`SAVControl`が未設定の場合はこの制限は適用されません）。
- `MaximumFiringSpeed`に正の値を設定すると、車両Rigidbodyの合成速度がその値（m/s）以上である間は発射できません。0以下の場合は速度制限なしとなります（Rigidbodyが未設定の場合は速度制限は適用されません）。
