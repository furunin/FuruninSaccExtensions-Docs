# セットアップ

## 1. FSE_TurretControl Prefabを配置する

セットアップ対象の車両ヒエラルキーに`FSE_TurretControl`がない場合は、`FSE_TurretControl`プレハブを配置します。

## 2. 参照を設定する

1. `FSE_TurretControl`オブジェクトの`FSE_EXT_Turret`に以下の設定をします。

    - `ControlsRoot`：車両とともに動き、ローカルの+Z軸が車両前方を向くTransform。VR手動照準とVR連続式Zoomの基準になります。
    - `OperatorSeat`：砲塔を操作する座席のオブジェクト

    ![FSE_EXT_Turretに参照を設定](../assets/images/turret-control/installation/2-1_1.png){ width="900" loading=lazy }

    !!! Note "ヨー回転/ピッチ回転軸のいずれか1つしかない照準器を登録する方法"
        ヨー回転軸のみ、またはピッチ回転軸のみを持つ照準器を制御したい場合は`Aim Yaw Rotator`または`Aim Pitch Rotator`の一方にその照準器が持つ回転軸を登録し、他方は空欄にしてください。
        固定軸とは異なる位置や向きを照準の基準にする場合は`Aim Origin`を指定し、ローカルの+Z軸を照準方向へ合わせます。

2. 今セットアップしている砲塔以外の砲塔やランチャー等の向きをこの砲塔へ追従させる場合は、`TurretGunYawRotators`と`TurretGunPitchRotators`へそのTransformを登録します。
3. 操作席の`Sacc Vehicle Seat`オブジェクトの`EnableInSeat`へ、以下のオブジェクトを登録します。

    - `FSE_TurretControl/Yaw Pivot/Pitch Pivot/Aim Origin`
    - `FSE_TurretControl/Sight Display`

    ![Sacc Vehicle SeatのEnableInSeatを設定](../assets/images/turret-control/installation/2-3_1.png){ width="900" loading=lazy }

## 3. 操作席の設定をする

### PassengerSeatで操作する場合

- PassengerSeatの`Sacc Vehicle Seat`内`Passenger Functions`が参照する`SAV_PassengerFunctionsController`をクリックします。インスペクターを開き、`PassengerExtensions`に`FSE_TurretControl`オブジェクト（`FSE_EXT_Turret`）を登録します。

![PassengerExtensionsを設定](../assets/images/turret-control/installation/3_1.png){ width="900" loading=lazy }

### PilotSeatで操作する場合

- 車両の`SaccEntity`内`ExtensionUdonBehaviours`に`FSE_EXT_Turret`を登録します。

- 単独の砲塔として使用する場合は、`FSE_TurretControl`の子`FSE_DFUNC_TurretControl`を操作席の`Dial_Functions_L`または`Dial_Functions_R`へ登録します。

## 4. 任意機能を設定する

デスクトップモードでHEAD SLAVE、Sight Camera／Zoom機能をDialFunctionで選択できるようにするためには、割り当てた座席に対応する`KeyboardControls`でキーを設定します。`KeyboardControls`がない場合は空のオブジェクトを作成し、`SAV_KeyboardControls`コンポーネントを追加します。

### HEAD SLAVE

照準を頭または視点の向きに追従させる機能です。使用する場合は`FSE_DFUNC_HeadSlave`を操作席の`Dial_Functions_L`または`Dial_Functions_R`に登録します。

### Sight Camera／Zoom

照準映像の拡大縮小、照準による測距を行う機能です。使用する場合は`FSE_DFUNC_SightZoom`を操作席の`Dial_Functions_L`または`Dial_Functions_R`に登録します。

![HEAD SLAVE、Sight Camera／Zoomを設定](../assets/images/turret-control/installation/4_1.png){ width="900" loading=lazy }

![任意機能のキー設定](../assets/images/turret-control/installation/4_2.png){ width="900" loading=lazy }

### Turret Follower

照準器とは別の砲塔を同じ照準方向へ向ける機能です。使用する場合は`TurretGunYawRotators`と`TurretGunPitchRotators`に砲塔のヨー回転オブジェクトとピッチ回転オブジェクトを登録します。複数の砲塔を追従させることができます。

!!! Note "ヨー回転/ピッチ回転軸のいずれか1つしかない砲塔を登録する方法"
    `TurretGunYawRotators`と`TurretGunPitchRotators`は同じ要素数にします。ヨー回転軸のみを持つ砲塔では、`TurretGunYawRotators`へ回転軸を登録し、同じindexの`TurretGunPitchRotators`を空欄にしてください。ピッチ回転軸のみを持つ砲塔では逆に設定します。

### Animatorで砲塔を動かす

Animatorで主照準軸と追従砲塔を動かす場合は、次の手順で角度の出力先とAnimation Clipを設定します。

1. `FSE_EXT_Turret`の`Drive Mode`を`Animator`に設定し、`Primary Aim Animator`に主照準軸を動かすAnimatorを指定します。別のAnimatorで追従砲塔を動かす場合は`Turret Gun Animator`にも指定します。同じAnimatorを両方へ指定することもできます。
2. `Aim Yaw Rotator`と`Aim Pitch Rotator`を`Primary Aim Animator`の子階層へ配置します。両軸を使用する場合はピッチ軸をヨー軸の子にします。`Aim Origin`と`Sight Camera`は、最後に動く主照準軸の子に配置します。
3. 割り当てたAnimator Controllerに、`CurrentYawAnimatorParameter`と`CurrentPitchAnimatorParameter`で指定した名前のFloat Parameterを作成します。`TargetYawAnimatorParameter`と`TargetPitchAnimatorParameter`にも名前を設定している場合は、そのFloat Parameterも作成します。
4. モデルに合わせたヨー・ピッチのAnimation Clipを作成し、各Stateの`Motion Time`で`Parameter`を有効にして対応する現在角度のFloatを指定します。Floatの0から1へ、ヨーは`-SideAngleMax`から`+SideAngleMax`、ピッチは`-UpAngleMax`から`+DownAngleMax`まで動くようにします。
5. Animatorの`Update Mode`を`Normal`、`Culling Mode`を`Always Animate`にし、`Apply Root Motion`を無効にします。照準軸を動かすStateに追加の遷移やDampingを設定しないでください。

`Drive Mode`が`Script`の場合も、割り当てたAnimatorへ角度を出力できます。この場合、Animatorから主照準軸や追従砲塔のTransformを動かさないでください。
