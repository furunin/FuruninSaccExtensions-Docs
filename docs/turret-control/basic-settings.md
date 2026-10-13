# 基本的な設定

## 手動照準

### `FSE_EXT_Turret`

- `TurnSpeedMultiX`と`TurnSpeedMultiY`で、それぞれ上下・左右方向の手動旋回速度を設定します。
- `UpAngleMax`、`DownAngleMax`、`SideAngleMax`を調整し、車体や機体モデルに干渉しない可動範囲を指定します。
- `VJoyRollAsYaw`を有効にすると、コントローラーのロール操作を左右照準の入力として扱います。
- `InvertVRPitch`を有効にすると、VRモード時の手動照準の上下操作を反転します。
- `ScaleManualAimWithSightFov`を有効にすると、現在のFOVと`Manual Aim Reference FOV`に基づいて、高倍率ズーム時に手動照準速度を下げる補正を行います。無効にした場合、`Manual Aim Reference FOV`は使用されません。
- `MinManualAimScale`は速度補正倍率の下限です。0に設定すると制限を設けず、FOV比に応じた速度補正をそのまま適用します。

## HEAD SLAVE

### `FSE_EXT_Turret`

- `HeadSlaveVROnly`を有効にするとVRモード限定、無効にするとデスクトップモードとVRモードの双方でHEAD SLAVEを使用できます。
- `HeadSlaveSmoothingHalfLife`で頭または視点への追従の滑らかさを調整します。
- `HeadSlaveDeadZoneDeg`で微小な動きを無視する不感帯角度を設定します。
- `HeadSlaveMaxYawSlewRate`と`HeadSlaveMaxPitchSlewRate`で最大追従速度を設定します。

VRでHEAD SLAVEを使用中に右手コントローラーのグリップ（中指）を押しながらコントローラーを傾けると、HMDの追従方向に対して照準方向を上下左右へ補正できます。

- `HeadSlaveYawOffsetLimit`と`HeadSlavePitchOffsetLimit`で、左右・上下へ追加できる照準補正角の上限を設定します。
- `HeadSlaveTrimRate`で、右グリップ操作による照準補正が反映される速度を設定します。
- `InvertVRPitch`は右グリップによる照準補正にも適用されます（HMD追従そのものの上下方向は変わりません）。

## Sight Camera／Zoom

### `FSE_DFUNC_SightZoom`

`FSE_DFUNC_SightZoom`では、照準映像の倍率を「連続式」と「切替式」の2つの方式から選んで制御できます。連続式では操作に応じて映像のFOVが滑らかに変化し、切替式では設定済みのプリセット倍率へ瞬時に切り替わります。

- `UsePresetSteps`を有効にすると切替式、無効にすると連続式で倍率を制御します。
- `ContinuousZoomRate`で、連続式選択時の倍率変化速度を調整します。

### `FSE_SightController`

- `MaximumFov`で連続式選択時に使用するFOV範囲（広角側）を決めます。切替式の場合は基準倍率（1倍時）のFOVとして使用します。
- `MinimumFov`で連続式選択時に使用するFOV範囲（望遠側）を決めます。
- `ZoomPresetMagnifications`で、切替式選択時に使用する倍率一覧を設定します。

!!! note "倍率制御方式ごとのFOV（倍率）設定箇所"

    - 連続式：`MaximumFov`で最大FOV（最も広い視野）、`MinimumFov`で最小FOV（最も狭い視野）を設定します。
    - 切替式：`MaximumFov`で1倍時の基準FOVを設定し、`ZoomPresetMagnifications`でズーム時の倍率一覧を設定します。

!!! note "基準FOVと設定したい倍率からFOVを求める方法"

    連続式で最大倍率を指定する場合は、基準FOVと設定したい倍率から、`MinimumFov`へ指定するFOVを次の計算機または式で求めます。

    <span data-fov-calculator></span>

    \[
    \mathrm{FOV}_{\mathrm{target}}
    =
    \frac{360}{\pi}
    \arctan\left(
    \frac{
    \tan\left(\dfrac{\pi\,\mathrm{FOV}_{\mathrm{reference}}}{360}\right)
    }{\max(1,M)}
    \right)
    \]

    - \(\mathrm{FOV}_{\mathrm{reference}}\)：`MaximumFov`へ指定する基準FOV（度）
    - \(M\)：設定したい倍率（1以上）
    - \(\mathrm{FOV}_{\mathrm{target}}\)：`MinimumFov`へ指定するFOV（度）

## 独自UIの測距・姿勢表示 { #custom-ui }

測距結果は[取得メソッド](components.md#rangefinder-data)で読み取ります。先に`HasRangefinderHit()`で有効状態を確認し、有効な場合だけ距離などを表示してください。結果は操作者のローカル情報で、他の参加者の測距結果は取得できません。これらのメソッドは保存済みの結果を読み、追加の測距は行いません。

姿勢表示には、`LateUpdate`で`SightCamera.transform.rotation`を読み取ります。機体固定のトランスフォームの世界回転を`V`、カメラの世界回転を`C`として、次のように計算します。

| 表示する情報 | 計算 |
|---|---|
| 機体に対するカメラの相対回転 | `Quaternion.Inverse(V) * C` |
| カメラに対する機体の相対回転 | `Quaternion.Inverse(C) * V` |
| カメラ座標での機首方向 | `Quaternion.Inverse(C) * V * Vector3.forward`。機体固定の参照の+Z軸を機首方向へ合わせます。 |

Yaw／Pitch／Rollへの換算、角度の符号、目盛り、画面上の配置は自作UIで決めます。Animatorへ出力する0～1の角度値は、カメラの実際の回転としては使用しないでください。
