# セットアップ

## 1. 主照準軸を作る

次の親子関係を作ります。

```text
Yaw Pivot
└─ Pitch Pivot
   ├─ Aim Origin
   ├─ Sight Camera（任意）
   └─ 照準器の表示物
```

- `Yaw Pivot`は左右方向だけを回転させます。
- `Pitch Pivot`は`Yaw Pivot`の子にし、上下方向だけを回転させます。
- `Aim Origin`の青いZ軸を照準方向へ向けます。
- Blenderなど軸の異なるモデルは、Pivotの子へWrapperを置いて見た目の向きだけを補正します。

## 2. FSE_EXT_Turretを設定する

1. 車両内の適切なGameObjectへ`FSE_EXT_Turret`を追加します。
2. `AimYawRotator`へ`Yaw Pivot`、`AimPitchRotator`へ`Pitch Pivot`を指定します。
3. `AimOrigin`へ照準方向を示すTransformを指定します。
4. `ControlsRoot`へ機体回転の基準となるTransformを指定します。
5. `OperatorSeat`へ照準を操作する座席を指定します。
6. Sight Cameraを使う場合だけ`SightCamera`へCameraを指定します。
7. `FSE_EXT_Turret`を車両の`SaccEntity.ExtensionUdonBehaviours`へ登録し、Saccの搭乗・操作担当の切り替え・Respawnイベントを受け取れるようにします。

同じ主照準Transformを書き換える既存砲塔Componentは無効にし、回転の書き手を一つにしてください。

## 3. 可動範囲と速度を設定する

- `TurnSpeedMultiX`と`TurnSpeedMultiY`で上下・左右の手動速度を設定します。
- `UpAngleMax`、`DownAngleMax`、`SideAngleMax`を車体やモデルへ干渉しない範囲にします。
- VR操作は`MaxJoyAngles`と`VJoyRollAsYaw`を使用します。

## 4. 必要な機能を追加する

- [HEAD SLAVE](head-slave.md)
- Target Tracking（下記）
- [追従砲塔](followers.md)
- [Sight Camera／Zoom](sight-camera.md)

これらを使わない場合、該当する参照や配列は未設定のままにします。

## 5. Target Trackingを追加する（任意）

1. 車両Hierarchyへ`FSE_TurretTargetTracking_Addon` Prefabを配置します。
2. 両Componentの`TurretController`へ対象の`FSE_EXT_Turret`を指定します。
3. `FSE_EXT_Turret.TargetTracker`へ`FSE_TurretTargetTracker`を指定します。
4. HEAD SLAVEも使う場合は、`TargetTracking.ExclusiveHeadSlave`と`HeadSlave.ExclusiveTargetTracking`へ互いのDialFunctionを指定します。
5. `FSE_DFUNC_TargetTracking`を操作席のDialFunctionへ登録します。
6. `CandidateLayers`を、追尾を許可する対象車両のLayerに設定します。

必要に応じて、候補検索の基準に`SearchReference`、状態表示にIndicator、状態音にAudio参照を設定します。配置直後は`TurretController`、`SearchReference`、`ExclusiveHeadSlave`が未設定なので、手動で接続してください。
