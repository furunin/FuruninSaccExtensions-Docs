# MCLOSの設定

MCLOSでは、射手が飛翔中のミサイルへ上下左右の旋回指令を送ります。入力を戻すと、その時点の進行方向を維持します。

## 設定手順

1. 操作席側へ`FSE_MCLOSInputController`を一つ追加します。
2. `Launcher`へ対象の`FSE_DFUNC_MissileLauncher`を指定します。
3. 各ミサイルへ`FSE_MCLOSGuidance`を追加します。
4. `Missile`へ同じミサイルの`FSE_MissileController`を指定します。
5. `CommandSource`へ操作席側の`FSE_MCLOSInputController`を指定します。
6. `FSE_MissileController.GuidanceModule`へ、その`FSE_MCLOSGuidance`を指定します。
7. 再利用用ミサイルのすべてに同じ設定を行います。

SACLOS構成を元にしたVariantでは、各ミサイルの`SACLOS Guidance`を無効にし、`GuidanceModule`がMCLOS側を参照していることを確認します。

## 入力設定

- Desktopは矢印キーを使用します。
- VRは右手Secondary Thumbstickを使用します。
- `InputDeadZone`はVRスティックの中央付近だけに適用されます。
- `InvertPitch`と`InvertYaw`で操作方向を軸ごとに反転できます。
- `SyncInterval`は操作の応答性と通信頻度のバランスで設定します。

`MaxPitchRate`、`MaxYawRate`、`MaxLateralAcceleration`は、上下・左右の旋回能力を決めます。単一方向と斜め入力のどちらも同じ制限を受けます。
