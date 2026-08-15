# MCLOSの設定

MCLOSでは、射手が飛翔中のミサイルへ直接上下左右への旋回指令を送ります。入力を戻すと、その時点の進行方向を維持します。

## 完成Sample

`SH-1_GuidedMissile_MCLOS`は、共有する`FSE_MCLOSInputController`と、Prefabに含まれるすべての飛翔弾に対応する`FSE_MCLOSGuidance`を接続済みの完成Sampleです。

## 導入手順

### MCLOS入力を設定する

1. `FSE_GuidedMissile`へ`FSE_MCLOSInputController`を追加します。
2. `Launcher`へ`FSE_DFUNC_MissileLauncher`を指定します。
### 各飛翔弾へ誘導Componentを設定する

1. `ProjectilePool`に登録された各`Missile Round_InFlight`へ`FSE_MCLOSGuidance`を追加します。
2. `Missile`へ同じミサイルの`FSE_MissileController`を指定します。
3. `CommandSource`へ上記の`FSE_MCLOSInputController`を指定します。
4. `FSE_MissileController.GuidanceModule`へ、同じ飛翔弾の`FSE_MCLOSGuidance`を指定します。
5. `ProjectilePool`に登録されたすべての飛翔弾で同じ設定を行います。

## 入力設定

- `InputDeadZone`はVRスティックの中央付近だけに適用されます。
- `InvertPitch`と`InvertYaw`で操作方向を軸ごとに反転できます。
- `SyncInterval`は操作状態を送る間隔です。

`MaxPitchRate`、`MaxYawRate`、`MaxLateralAcceleration`は、上下・左右の旋回能力を決めます。単一方向と斜め入力のどちらも同じ制限を受けます。
