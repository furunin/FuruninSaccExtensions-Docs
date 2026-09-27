# セットアップ

## 1. FSE_TurretControl Prefabを配置する

セットアップ対象の車両ヒエラルキーに`FSE_TurretControl`がない場合は、`FSE_TurretControl`プレハブを配置します。

## 2. FSE_EXT_Turretの設定をする

### 2-1. 共通の設定をする

`FSE_TurretControl`オブジェクトの`FSE_EXT_Turret`に以下の設定をします。

基準タレットが`Aim Origin`の方向を決め、追従タレットがその方向に追従します。照準器と砲塔のどちらも、いずれの役割にも使用できます。

| Field | 説明 |
|---|---|
| `Reference Rotator Hor` | 基準タレットのローカルY軸で左右に回転するTransformを指定します。 |
| `Reference Rotator Vert` | 基準タレットのローカルX軸で上下に回転するTransformを指定します。 |
| `ControlsRoot` | 対象の乗り物と共に動き、ローカルの+Z軸が車両前方を向くTransformを指定します。 |
| `OperatorSeat` | タレットを操作する座席のオブジェクトを指定します。 |

!!! note
    左右または上下の一方の回転軸しかない場合は、存在しない軸の`Reference Rotator Hor`または`Reference Rotator Vert`を空欄にします。

![FSE_EXT_Turretに参照を設定](../assets/images/turret-control/installation/2-1_1.png){ width="900" loading=lazy }

### 2-2. タレットの制御方式を選択する

タレットの旋回制御をスクリプトによって行うか、アニメーターによって行うかを選択することができます。

!!! note
    アニメーター制御モードを選択した場合は`FSE_EXT_Turret`が各回転軸の目標回転角度の算出までを行います。タレットの旋回はアニメーターが行います。

!!! note
    スクリプト制御モードを選択した場合でも、`Reference Rotator Animator`や`Follower Rotators Animator`に指定したアニメーターから各回転軸の角度に関するfloatパラメーター（`Current/Target Yaw/Pitch Animator Parameter`）を取得することができます。

#### 2-2-A. スクリプトで制御する場合

- `Drive Mode`のプルダウンから`Script`を選択します（初期値は`Script`です）。
- 追従タレットを設定する場合は、各タレットの左右軸を`Follower Rotators Hor`、上下軸を`Follower Rotators Vert`の同じ番号に指定します。存在しない軸は空欄にできます。1つのTransformで両軸を回転させる場合は、両方へ同じTransformを指定します。

#### 2-2-B. 自作アニメーターで制御する場合

- `Drive Mode`のプルダウンから`Animator`を選択します。
- `Reference Rotator Animator`に、基準タレットの旋回制御を設定したアニメーターを指定します。
- アニメーターで`Current/Target Yaw/Pitch Animator Parameter`で指定した名前の各回転軸の角度に関するfloatパラメーターを作成し、モデルに合わせてアニメーションを設定します。
- 追従タレットを設定する場合は、`Follower Rotators Animator`に追従タレットの旋回制御を設定したアニメーターを指定します。`Reference Rotator Animator`と同じでも構いません。

## 3. 操作席の設定をする

### 3-1. 共通の設定をする

タレットの操作席の`Sacc Vehicle Seat`オブジェクトの`EnableInSeat`へ、以下のオブジェクトを登録します。

- `FSE_TurretControl/Yaw Pivot/Pitch Pivot/Aim Origin`
- `FSE_TurretControl/Sight Display`

![Sacc Vehicle SeatのEnableInSeatを設定](../assets/images/turret-control/installation/2-3_1.png){ width="900" loading=lazy }

### 3-2. `FSE_EXT_Turret`を`ExtensionUdonBehaviours`に登録する

#### 3-2-A. PassengerSeatで操作する場合

- PassengerSeatの`Sacc Vehicle Seat`内`Passenger Functions`が参照する`SAV_PassengerFunctionsController`をクリックし、インスペクターを開きます。
- `PassengerExtensions`に`FSE_TurretControl`オブジェクト（`FSE_EXT_Turret`）を登録します。

![PassengerExtensionsを設定](../assets/images/turret-control/installation/3_1.png){ width="900" loading=lazy }

#### 3-2-B. PilotSeatで操作する場合

- 対象の乗り物の`SaccEntity`のインスペクターを開きます。
- `ExtensionUdonBehaviours`に`FSE_TurretControl`オブジェクト（`FSE_EXT_Turret`）を登録します。
- 単独の砲塔として使用する場合は、`FSE_TurretControl`の子`FSE_DFUNC_TurretControl`を操作席の`Dial_Functions_L`または`Dial_Functions_R`へ登録します。

## 4. 任意機能を設定する

デスクトップモードでHEAD SLAVE、Sight Camera／Zoom機能をDialFunctionで選択できるようにするためには、割り当てた座席に対応する`KeyboardControls`でキーを設定します。`KeyboardControls`がない場合は空のオブジェクトを作成し、`SAV_KeyboardControls`コンポーネントを追加します。

### HEAD SLAVE

照準を頭または視点の向きに追従させる機能です。使用する場合は`FSE_DFUNC_HeadSlave`を操作席の`Dial_Functions_L`または`Dial_Functions_R`に登録します。

### Sight Camera／Zoom

照準映像の拡大縮小、照準による測距を行う機能です。使用する場合は`FSE_DFUNC_SightZoom`を操作席の`Dial_Functions_L`または`Dial_Functions_R`に登録します。

![HEAD SLAVE、Sight Camera／Zoomを設定](../assets/images/turret-control/installation/4_1.png){ width="900" loading=lazy }

![任意機能のキー設定](../assets/images/turret-control/installation/4_2.png){ width="900" loading=lazy }
