# 文書更新履歴

## v1.0.1（2026-11-28）

- 固定ランチャーのサンプル（`FixedLauncher_SACLOS`・`FixedLauncher_MCLOS`）で、照準映像が横に縮んで表示される問題を修正
- 飛翔中のミサイルの迎撃判定（`Intercept Proxy`）が、各ミサイルの最初の発射で効かないことがある問題を修正

## v1.0.0（2026-11-22）

- FSE Guided Missilesに、地上に置いて使う固定式MCLOSランチャーのサンプル（`FixedLauncher_MCLOS`）を追加
- SH-1サンプルのミサイル操作席の右Dialで、ランチャーの前に何もしない項目（NONE）を追加し、搭乗しただけでランチャーが選ばれて不意に発射しないように変更。VRでは右スティックを下へ倒してランチャーを選び、上へ倒すと解除（誘導中は解除不可）。デスクトップでは`1`キーで選択と解除を切り替え
- FSE本体のライセンス文（`LICENSE.md`、MIT License）を同梱

## v0.6.6（2026-11-15）

- FSE Guided Missilesに、Guided Missile Setupで作成した格納状態／飛翔状態ミサイルのプレハブへ配布テンプレートの更新を反映する`Round Template Sync`（`Tools/Furunin Sacc Extensions/Guided Missiles/Round Template Sync`）を追加。`Analyze Selected`で変更内容を確認してから適用でき、`Restore Last Backup`で適用前の状態へ戻せる
- 飛翔状態ミサイルのテンプレートと同梱のサンプル弾に、着弾エフェクト（閃光・火球・煙・破片）を追加。作成済みのプレハブは自動では変わらないため、取り込む場合は`Round Template Sync`を使用
- 各スクリプトとツールのツールチップを短く整理

## v0.6.5（2026-11-11）

- FSE Turret Controlに、砲塔の駆動の最大の速さと最大の加速度を設定する項目（`MaxDriveYawRate`・`MaxDrivePitchRate`・`MaxDriveYawAcceleration`・`MaxDrivePitchAcceleration`）を追加。既定0（無制限）で従来どおり
- Guided Missile Setupの`Update Existing Setup`で、固定ランチャーのように外側のプレハブの中にあるミサイルも誘導方式を変更できるように変更

## v0.6.4（2026-11-08）

- FSE Guided MissilesのMissile Launcherに`AllowDetachOnFireInput`設定を追加。無効にすると、誘導中のミサイル数が上限に達しているときの発射操作で誘導が切れない（既定は有効で従来どおり）
- 固定ランチャーのサンプル（`FixedLauncher_SACLOS`）の座席設定を修正

## v0.6.2（2026-11-07）

- FSE Turret Controlのデスクトップ照準に、押し続けると加速する動きと、`Shift`キーによる微調整、照準キーの設定を追加
- FSE Turret Controlの`SideAngleMax`を180以上にすると、左右に全周を回れるように変更

## v0.6.0（2026-11-03）

- FSE Guided Missilesに、地上に置いて使う固定式SACLOSランチャーのサンプル（`FixedLauncher_SACLOS`）を追加
- FSE Guided MissilesのMissile Launcherに、発射で総弾数が減らない`UnlimitedAmmo`設定を追加
- Take Controlによる役割交代を、操縦席からも開始できるように変更
- Guided Missile Setupのメニューを`Tools/Furunin Sacc Extensions/Guided Missiles/`へ移動

## v0.5.4（2026-10-01）

- FSE Turret ControlがTake Controlによる役割交代に追従し、交代後も担当座席で照準・HEAD SLAVE・ズーム・測距を使用可能に

## v0.5.3（2026-09-30）

- FSE Guided Missilesの発射位置・搭載弾表示・指令ワイヤー始点を発射ステーションごとの設定へ集約
- 指令ワイヤーの発射機側・ミサイル側の接続位置を個別に調整する設定と、操縦・ミサイル操作を交代するTake Controlの導入手順を追加

## v0.5.0（2026-09-27）

- FSE Guided Missilesに4段階の飛翔設定、線形・二乗の空気抵抗、速度・飛距離グラフ、飛翔段階別のエフェクト設定を追加
- FSE Guided Missilesのセットアップ用テンプレートとサンプルを更新し、発射ボタンの長押し設定と発射前エフェクトを追加
- FSE Turret Controlにアニメーターによる旋回と角度出力を追加し、基準タレット・追従タレットの設定を整理

## v0.3.4（2026-09-13）

- FSE Guided Missilesのセットアップ支援、弾頭の作動、残弾表示、重心変化機能の説明を追加
- FSE Turret ControlのFOV設定、ズーム操作、単軸砲塔設定の説明を追加

## v0.1.0（2026-08-23）

- FSE Guided MissilesとFSE Turret Controlの初版を公開
