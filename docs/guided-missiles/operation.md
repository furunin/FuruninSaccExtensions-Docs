# 操作方法

操作キーは車両側のDialFunctionとKeyboard Controlsの登録に従います。

| 誘導方式 | Desktop | VR |
|---|---|---|
| 共通 | 武装を選び（デフォルトでは`1`、`2`キー）、`Space`で発射します。 | DialFunctionで武装を選び、対応するTriggerで発射します。 |
| MCLOS | 飛翔中に矢印キーでミサイルの方向を修正します。 | 飛翔中に右手Secondary Thumbstickで方向を修正します。 |
| SACLOS | 照準器を目標へ向け続けます。FSE Turret Controlを使用する場合は`W/A/S/D`で操作します。 | 手動照準またはHEAD SLAVEで照準器を目標へ向け続けます。 |

MCLOSはキーまたはスティックを戻すと、その時点の進行方向を維持します。

SACLOS SampleのSight Zoomは連続式です。Desktopでは着席中に`Q`／`E`で操作でき、VRではZoomをDialFunctionで選んでTriggerを押しながら手を手前／奥へ動かします。距離計は操作席の使用中に照準方向を測定し、照準映像上へ表示します。

## 誘導中の再入力

誘導中ミサイル数が`MaxConcurrentGuidedShots`へ達した状態で再度発射入力すると、最も古い誘導中ミサイルの誘導を終了します。その入力では新しいミサイルを発射しません。次の独立した入力で発射条件を改めて判定します。

誘導を終了したミサイルは飛翔を続けますが、再び誘導することはできません。
