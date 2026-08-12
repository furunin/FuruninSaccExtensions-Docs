# Sight Camera／Zoom

## Sight Camera

1. `AimPitchRotator`の子へCameraを置きます。
2. Cameraの青いZ軸を`AimOrigin`と同じ方向へ向けます。
3. CameraのTarget TextureへRenderTextureを指定します。
4. 表示面のMaterialへ同じRenderTextureを設定します。
5. `FSE_EXT_Turret.SightCamera`へCameraを指定します。
6. HUDなど照準映像へ映したくないLayerを`SightCameraExcludedLayers`へ指定します。

座席使用中だけ表示する場合は、Cameraと表示面を対象座席の`EnableInSeat`へ登録します。

## Zoom

現行構成では、Saccの`DFUNC_SlideAnimation`、Animator Controller、Animation Clipを使用して`SightCamera.fieldOfView`を変更します。

1. Sight CameraへAnimatorを設定します。
2. Animation ClipでCameraの`fieldOfView`を変化させます。
3. `DFUNC_SlideAnimation.VehicleAnimator`へそのAnimatorを指定します。
4. `AnimFloatName`をAnimatorのFloat Parameter名と一致させます。
5. `DFUNC_SlideAnimation`を使用するDialFunctionへ登録します。
6. DesktopでQ／Eを使う場合は、車両のKeyboard Controlsから対応する機能へ入力が届くようにします。

Zoom値はローカル用で、ほかの参加者へ同期しません。

## FOVと照準速度

`ScaleManualAimWithSightFov`を有効にすると、現在のFOVと`ZoomReferenceFov`から手動照準速度を補正します。

```text
scale = tan(current FOV / 2) / tan(reference FOV / 2)
```

`MinManualAimScale`は速度倍率の下限です。0にするとFOV比をそのまま使用できます。Cameraが無効、未設定、またはFOVが不正な場合は通常速度になります。
