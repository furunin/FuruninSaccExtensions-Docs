# MCLOSの設定

MCLOSでは、射手が飛翔中のミサイルへ直接上下左右への旋回指令を送ります。入力を戻すと、その時点の進行方向を維持します。

## 導入手順

1. 共通セットアップで作成した本ギミック用のオブジェクト（例：`FSE Guided Missile`）に`FSE_MCLOSInputController`を追加します。
2. `Launcher`へ`FSE_DFUNC_MissileLauncher`を指定します。
3. 共通セットアップで作成した各飛翔処理用ミサイルへ空のオブジェクトを作成し、`FSE_MCLOSGuidance`を追加します。
4. `Missile`へ同じミサイルの`FSE_MissileController`を指定します。
5. `CommandSource`へ1.で追加した`FSE_MCLOSInputController`を指定します。
6. `FSE_MissileController`の`GuidanceModule`へ、3.で作成した`FSE_MCLOSGuidance`を指定します。
7. 飛翔処理用ミサイルの全てに同じ設定を行います。

## 入力設定

- `InputDeadZone`はVRスティックの中央付近だけに適用されます。
- `InvertPitch`と`InvertYaw`で操作方向を軸ごとに反転できます。
- `SyncInterval`は操作の応答性と通信頻度のバランスで設定します。

`MaxPitchRate`、`MaxYawRate`、`MaxLateralAcceleration`は、上下・左右の旋回能力を決めます。単一方向と斜め入力のどちらも同じ制限を受けます。
