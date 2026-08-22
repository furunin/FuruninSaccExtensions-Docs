# MCLOSの設定

MCLOSでは、射手が飛翔中のミサイルへ直接上下左右への旋回指令を送ります。入力を戻すと、その時点の進行方向を維持します。

## 導入手順

### 1. MCLOS入力を設定する

1. `FSE_GuidedMissile`へ`FSE_MCLOSInputController`を追加します。
2. 追加した`FSE_MCLOSInputController`の`Launcher`に`FSE_GuidedMissile`をドラッグアンドドロップして`FSE_DFUNC_MissileLauncher`を指定します。

    ![PassengerExtensionsを設定](../assets/images/guided-missiles/mclos/1-2_1.png){ width="900" loading=lazy }

### 2. 各ミサイルへ誘導コンポーネントを設定する

1. `FSE_GuidedMissile`オブジェクトの`FSE_DFUNC_MissileLauncher`コンポーネントをインスペクターで開きます。`ProjectilePool`に登録された一番目のオブジェクトに空のオブジェクトを追加し、名前を`FSE_MCLOS Guidance`に変更します。

    ![FSE_MCLOS Guidanceを作成](../assets/images/guided-missiles/mclos/2-1_1.png){ width="900" loading=lazy }

2. `FSE_MCLOS Guidance`オブジェクトに`FSE_MCLOS Guidance`コンポーネントを追加し、`CommandSource`へ`FSE_GuidedMissile`オブジェクト（`FSE_MCLOSInputController`）を指定します。

    ![FSE_MCLOS Guidanceを設定](../assets/images/guided-missiles/mclos/2-2_1.png){ width="900" loading=lazy }

3. `FSE_MCLOS Guidance`オブジェクトを複製し、`ProjectilePool`に登録された二番目以降のオブジェクトの下に配置します。

    ![FSE_MCLOS Guidanceを複製](../assets/images/guided-missiles/mclos/2-3_1.png){ width="900" loading=lazy }

4. Missile Pool以下の全てのミサイルについて、以下の設定を行います。
  
    - `FSE_MCLOS Guidance`の`Missile`に、同じミサイルの`Missile Round_InFlight`オブジェクト（`FSE_MissileController`）を指定します。

        ![FSE_MCLOS Guidanceを設定](../assets/images/guided-missiles/mclos/2-4_1.png){ width="900" loading=lazy }

    - `Missile Round_InFlight`オブジェクトの`FSE_MissileController`コンポーネントの`GuidanceModule`に、同じミサイルの`FSE_MCLOSGuidance`オブジェクトを指定します。

        ![FSE_MCLOS Guidanceを設定](../assets/images/guided-missiles/mclos/2-4_2.png){ width="900" loading=lazy }
