# HEAD SLAVE

HEAD SLAVEは、VRプレイヤーのHMD方向へ主照準器を追従させる任意機能です。頭のロールは照準へ使用しません。

## 設定

1. DialFunction用GameObjectへ`FSE_DFUNC_HeadSlave`を追加します。
2. `TurretController`へ対象の`FSE_EXT_Turret`を指定します。
3. 選択中だけ表示する物があれば`EnableFunconObjects`へ登録します。不要なら空配列にします。
4. `FSE_DFUNC_HeadSlave`を操作席のDialFunctionへ登録します。

## 操作

DialFunctionでHEAD SLAVEを選択すると、照準器がHMDの左右・上下方向へ追従します。右Grip操作を使うと、追従方向を小さく微調整できます。

## 調整項目

- `HeadSlaveVROnly`：VR以外でHEAD SLAVEを無効にします。
- `HeadSlaveSmoothingHalfLife`：HMD追従の滑らかさです。
- `HeadSlaveDeadZoneDeg`：微小な頭の動きを無視する角度です。
- `HeadSlaveMaxYawSlewRate` / `HeadSlaveMaxPitchSlewRate`：最大追従速度です。
- Offset Limit項目：右Grip微調整の最大範囲です。
- `HeadSlaveTrimRate`：微調整速度です。

`InvertVRPitch`は右Gripによる微調整へ適用されますが、HMD追従そのものの上下方向は変えません。
