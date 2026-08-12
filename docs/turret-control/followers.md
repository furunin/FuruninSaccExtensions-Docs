# 追従砲塔

主照準器とは別の砲塔や砲身を同じ照準方向へ向ける任意機能です。

## 配列の規則

`TurretGunYawRotators`と`TurretGunPitchRotators`は、同じ要素数・同じ順序で設定します。同じindexが一つの追従砲塔です。

### 一つのTransformで上下左右へ回転する場合

YawとPitchの同じindexへ同じTransformを指定します。Play開始時と操作中、そのTransformのワールド回転を`AimOrigin`へ合わせます。

### 左右親と上下子が分かれている場合

- Yaw側へ左右軸のTransformを指定します。
- Pitch側へその子にある上下軸のTransformを指定します。

左右軸を照準方向の水平成分へ向けた後、上下軸を最終的な照準方向へ合わせます。

## 注意点

- Primary Aim Rotatorsと同じTransformを追従砲塔へ指定しないでください。
- null、配列長不一致、不正な親子関係の組は動作しません。
- モデルのforward軸がUnityの青いZ軸と異なる場合は、モデルまたはWrapperで軸を修正します。
- 初期方向が照準器と異なっていても、Play開始時に`AimOrigin`へ整列します。
