# Sight Camera／Zoom／距離計

## Sight Camera

`FSE_TurretControl` Prefabでは、Sight Camera、`Rangefinder Origin`、`FSE_SightController`と内部参照が設定済みです。独自構成を作る場合は次の手順で設定します。

1. `AimPitchRotator`の子へCameraを置きます。
2. Cameraの青いZ軸を`AimOrigin`と同じ方向へ向けます。
3. CameraのTarget TextureへRenderTextureを指定します。
4. 表示面のMaterialへ同じRenderTextureを設定します。
5. `FSE_EXT_Turret.SightCamera`へCameraを指定します。
6. `FSE_SightController`を追加し、`TurretController`と`SightCamera`へ対象を指定します。
7. HUDなど照準映像へ映したくないLayerを`SightCameraExcludedLayers`へ指定します。

座席使用中だけ表示する場合は、Cameraと表示面を対象座席の`EnableInSeat`へ登録します。

## Zoom

`FSE_DFUNC_SightZoom`は`FSE_SightController`を通じてSight CameraのFOVを直接操作します。AnimatorやAnimation Clipは設定しません。

1. `FSE_TurretControl` Prefab内の子`FSE_DFUNC_SightZoom`を使用します。独自構成ではDialFunction用GameObjectへ同名Componentを追加します。
2. `SightController`へ`FSE_SightController`を指定します。Prefab内では設定済みです。
3. 子`FSE_DFUNC_SightZoom`を操作席のDialFunctionへ直接登録します。Prefabのルートは登録しません。
4. `MinimumFov`と`MaximumFov`で使用するFOV範囲を決めます。
5. 段階式を使う場合は`ZoomPresetMagnifications`を設定します。連続式を使う場合は`UsePresetSteps`を無効にします。

連続式では`ContinuousZoomRate`で速度を調整します。SACLOS Sampleは連続式（`UsePresetSteps`は無効）で、`ContinuousZoomRate`は`2`です。倍率の変化は操作感が均等になるよう調整されています。

- Desktopの連続式：着席中はZoomをDialFunctionで選択しなくても`Q`／`E`で操作できます。
- Desktopの段階式：ZoomをDialFunctionで選択してから`Q`／`E`で操作します。
- VRの連続式：ZoomをDialFunctionで選び、Triggerを押しながら手を手前／奥へ動かします。`VrHandZForFullSpeed`は全速になる移動量です（SACLOS Sampleは`0.15`）。
- VRの段階式：ZoomをDialFunctionで選び、Triggerを押すたびに次の倍率へ進み、最大倍率の次は1xへ戻ります。

Zoom値はローカル用で、ほかの参加者へ同期しません。

## 距離計

`FSE_SightController`の`RangefinderOrigin`へ距離計の起点を指定します。未設定時は`SightCamera`、それも未設定なら`AimOrigin`を使用します。`RangefinderLayers`で測定対象のLayerを選び、`RangefinderUpdateInterval`で更新間隔を調整します。

操作席の使用中は0.1秒ごとに測定します。表示はメートル単位で丸め、0〜9999 mを表示します。対象がない場合は`RNG ----`です。距離表示は物理的なSight Displayへ重ねる表示であり、RenderTextureそのものには描画されません。

## FOVと照準速度

`ScaleManualAimWithSightFov`を有効にすると、現在のFOVと`ZoomReferenceFov`から手動照準速度を補正します。

`MinManualAimScale`は速度倍率の下限です。0にするとFOV比をそのまま使用できます。Cameraが無効、未設定、またはFOVが不正な場合は通常速度になります。
