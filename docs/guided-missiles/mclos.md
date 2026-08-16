# MCLOSの設定

MCLOSでは、射手が飛翔中のミサイルへ直接上下左右への旋回指令を送ります。入力を戻すと、その時点の進行方向を維持します。

## 導入手順

### MCLOS入力を設定する

1. `FSE_GuidedMissile`へ`FSE_MCLOSInputController`を追加します。
2. 追加した`FSE_MCLOSInputController`の`Launcher`に`FSE_GuidedMissile`をドラッグアンドドロップして`FSE_DFUNC_MissileLauncher`を指定します。

### 各ミサイルへ誘導コンポーネントを設定する

1. `FSE_GuidedMissile`オブジェクトの`FSE_DFUNC_MissileLauncher`コンポーネントをインスペクターで開きます。`ProjectilePool`に登録された一番目のオブジェクトに空のオブジェクトを追加し、名前を`FSE_MCLOS Guidance`に変更します。
2. `FSE_MCLOS Guidance`オブジェクトに`FSE_MCLOS Guidance`コンポーネントを追加し、`CommandSource`へ`FSE_GuidedMissile`を指定します。
3. `FSE_MCLOS Guidance`オブジェクトを複製し、`ProjectilePool`に登録された二番目以降のオブジェクトの下に配置します。
4. Missile Pool以下の全てのミサイルについて、以下の設定を行います。
  
    - `FSE_MCLOS Guidance`の`Missile`に、同じミサイルの`Missile Round_InFlight`オブジェクトを指定します。
    - `Missile Round_InFlight`オブジェクトの`FSE_MissileController`コンポーネントの`GuidanceModule`に、同じミサイルの`FSE_MCLOSGuidance`オブジェクトを指定します。

## 入力設定

- `InputDeadZone`はVRスティックの中央付近だけに適用されます。
- `InvertPitch`と`InvertYaw`で操作方向を軸ごとに反転できます。
- `SyncInterval`は操作状態を送る間隔です。

`MaxPitchRate`、`MaxYawRate`、`MaxLateralAcceleration`は、上下・左右の旋回能力を決めます。単一方向と斜め入力のどちらも同じ制限を受けます。
