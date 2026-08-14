# セットアップ

## 1. FSE_TurretControl Prefabを配置する

車両Hierarchyへ`FSE_TurretControl` Prefabを配置します。Prefabには次の主照準軸と任意機能用の子オブジェクトが含まれ、内部参照は設定済みです。

```text
FSE_TurretControl
├─ Yaw Pivot
│  └─ Pitch Pivot
│     ├─ Aim Origin
│     ├─ Sight Camera
│     └─ Rangefinder Origin
├─ FSE_SightController
├─ FSE_DFUNC_TurretControl
├─ FSE_DFUNC_HeadSlave
└─ FSE_DFUNC_SightZoom
```

`AimYawRotator`、`AimPitchRotator`、`AimOrigin`、`SightCamera`と、各子Componentから砲塔への参照は設定済みです。Prefab内の子オブジェクトを登録するときは、Prefabのルートではなく対象の子オブジェクトを指定してください。

独自のHierarchyを使う場合は、`Yaw Pivot`を左右方向、子の`Pitch Pivot`を上下方向だけに回転させ、`Aim Origin`の青いZ軸を照準方向へ向けます。モデル固有の回転はPivotではなく、その子のWrapperで補正します。

## 2. 車両固有の参照を設定する

1. Prefab内の`FSE_EXT_Turret.ControlsRoot`へ機体回転の基準となるTransformを指定します。
2. `TurretForwardEmpty`へ砲塔の基準方向を示すTransformを指定します。
3. `OperatorSeat`へ照準を操作する座席を指定します。
4. 別砲塔を追従させる場合は`TurretGunYawRotators`と`TurretGunPitchRotators`を設定します。
5. 距離表示を使う場合は`FSE_SightController.RangefinderText`へ表示用TextMeshProを指定します。
6. `FSE_EXT_Turret`を車両の`SaccEntity.ExtensionUdonBehaviours`へ登録し、Saccの搭乗・操作担当の切り替え・Respawnイベントを受け取れるようにします。

`TargetTracker`は下記のTarget Trackingを使う場合だけ設定します。その他の未使用の任意参照は未設定のままにします。

同じ主照準Transformを書き換える既存砲塔Componentは無効にし、回転の書き手を一つにしてください。

## 3. 可動範囲と速度を設定する

- `TurnSpeedMultiX`と`TurnSpeedMultiY`で上下・左右の手動速度を設定します。
- `UpAngleMax`、`DownAngleMax`、`SideAngleMax`を車体やモデルへ干渉しない範囲にします。
- VR操作は`MaxJoyAngles`と`VJoyRollAsYaw`を使用します。

## 4. 操作機能を登録する

### Pilot Seatで単独の砲塔として使う場合

Prefab内の子`FSE_DFUNC_TurretControl`を操作席のDialFunctionへ登録します。`FSE_DFUNC_TurretControl`を選択している間だけ、Desktopの`W/A/S/D`またはVR右手Gripで手動照準できます。選択中だけ表示する物があれば`EnableFunconObjects`へ登録します。

Guided Missilesと組み合わせるPilot構成では、ミサイル選択による既存の連携を使用するため、この`FSE_DFUNC_TurretControl`をミサイルSampleのDial配列へ追加しません。

### Passenger Seatで使う場合

Passenger構成では専用の`FSE_DFUNC_TurretControl`をDialFunctionへ登録せず、対応するPassenger Functionsから直接手動照準できます。

### 任意機能

- Prefab内の子`FSE_DFUNC_HeadSlave`：[HEAD SLAVE](head-slave.md)
- Prefab内の子`FSE_DFUNC_SightZoom`：[Sight Camera／Zoom](sight-camera.md)
- Target Tracking（下記）
- [追従砲塔](followers.md)

HEAD SLAVEとSight Zoomを使用する場合は、それぞれの子オブジェクトを操作席のDialFunctionへ直接登録します。Prefabのルートは登録しません。使わない機能は登録せず、該当する任意参照は未設定のままにします。

## 5. Target Trackingを追加する（任意）

1. 車両Hierarchyへ`FSE_TurretTargetTracking_Addon` Prefabを配置します。
2. 両Componentの`TurretController`へ対象の`FSE_EXT_Turret`を指定します。
3. `FSE_EXT_Turret.TargetTracker`へ`FSE_TurretTargetTracker`を指定します。
4. HEAD SLAVEも使う場合は、`TargetTracking.ExclusiveHeadSlave`と`HeadSlave.ExclusiveTargetTracking`へ互いのDialFunctionを指定します。
5. `FSE_DFUNC_TargetTracking`を操作席のDialFunctionへ登録します。
6. `CandidateLayers`を、追尾を許可する対象車両のLayerに設定します。

必要に応じて、候補検索の基準に`SearchReference`、状態表示にIndicator、状態音にAudio参照を設定します。配置直後は`TurretController`、`SearchReference`、`ExclusiveHeadSlave`が未設定なので、手動で接続してください。
