# 制限・更新・削除

## 制限事項

- Primary Aim Rotatorsと追従砲塔で同じTransformを共有できません。
- 追従砲塔のモデルforward軸がUnityの青いZ軸と異なる場合は、モデルまたはWrapper側で修正します。
- Zoom値はほかの参加者へ同期しません。
- `FSE_EXT_Turret`はCameraのFOVを直接変更しません。現行のZoom操作には`DFUNC_SlideAnimation`とAnimatorを使用します。
- HEAD SLAVEはHMDのロールを照準へ反映しません。

## 更新

1. 導入先Prefab Variantをバックアップします。
2. 新しいunitypackageをインポートします。
3. 車両固有のPivot、可動範囲、追従砲塔、Camera参照が維持されているか確認します。
4. 互換性のない変更が案内されている場合は、Inspector参照を設定し直します。

## 削除

1. DialFunctionから`FSE_DFUNC_HeadSlave`などのFSE参照を外します。
2. `SaccEntity.ExtensionUdonBehaviours`から`FSE_EXT_Turret`を外します。
3. 座席の`EnableInSeat`からSight Cameraと表示面を外します。
4. 追加したFSE Component、Pivot、表示物を導入先Variantから削除します。
5. 他機能から`AimOrigin`が参照されている場合は、先にその参照を外します。
