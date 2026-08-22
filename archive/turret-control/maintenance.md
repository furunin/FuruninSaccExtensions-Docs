# 制限・更新・削除

## 制限事項

- Primary Aim Rotatorsと追従砲塔で同じTransformを共有できません。
- 追従砲塔のモデルforward軸がUnityの青いZ軸と異なる場合は、モデルまたはWrapper側で修正します。
- Target Trackingは対応するSacc車両だけを対象にします。自動発射、見越し、陣営識別、候補の周期的な再取得は行いません。
- Target Tracking、Zoom、距離計の状態はローカル用です。他の参加者へは砲塔姿勢だけが見えます。
- 距離表示は照準映像上のOverlayです。
- HEAD SLAVEはHMDのロールを照準へ反映しません。
