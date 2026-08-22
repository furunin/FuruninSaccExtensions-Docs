# SACLOSの設定

SACLOSでは、ミサイルが`GuidanceReference`の示す照準線へ自動的に旋回します。射手は飛翔中も照準を目標へ向け続けます。

## 導入手順

### GuidanceReferenceを設定する

`FSE_GuidedMissile`オブジェクトの`GuidanceReference`に、ミサイルの誘導に使用する照準線となるオブジェクトを指定します。`FSE Turret Control`を使用する場合は、`FSE_TurretControl`内の`Aim Origin`を指定します。SACLOSは誘導に照準線を使用するため、この参照が必要です。

### 各ミサイルへ誘導コンポーネントを設定する

1. `FSE_GuidedMissile`オブジェクトの`FSE_DFUNC_MissileLauncher`コンポーネントをインスペクターで開きます。`ProjectilePool`に登録された一番目のオブジェクトに空のオブジェクトを追加し、名前を`FSE_SACLOS Guidance`に変更します。
2. `FSE_SACLOS Guidance`オブジェクトに`FSE_SACLOS Guidance`コンポーネントを追加します。
3. Missile Pool以下の全てのミサイルについて、以下の設定を行います。
  
    - `FSE_SACLOS Guidance`の`Missile`に、同じミサイルの`Missile Round_InFlight`オブジェクトを指定します。
    - `Missile Round_InFlight`オブジェクトの`FSE_MissileController`コンポーネントの`GuidanceModule`に、同じミサイルの`FSE_SACLOSGuidance`オブジェクトを指定します。
