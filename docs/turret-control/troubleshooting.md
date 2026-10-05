# トラブルシューティング

| 症状 | 確認項目 |
|---|---|
| 照準器が動かない | `OperatorSeat`、`ReferenceRotatorHor`、`ReferenceRotatorVert`の指定を確認します。<br>Pilot Seatの場合：`FSE_EXT_Turret`が`SaccEntity`の`ExtensionUdonBehaviours`へ登録されているか確認します。単独砲塔として動かす場合は、子オブジェクトの`FSE_DFUNC_TurretControl`をDialFunctionへ登録し、操縦中に選択してください。<br>PassengerSeatの場合：`FSE_EXT_Turret`が、操作席の`PassengerFunctions`が参照するControllerの`PassengerExtensions`へ登録されているか確認します。 |
| Play開始時に意図しない方向を向く | Pivotの軸方向と親子関係を確認してください。モデル固有の回転オフセットはPivot自体ではなく、子階層のWrapperオブジェクト側で調整します。 |
| VR操作時の旋回方向が逆になる | `InvertVRPitch`および`VJoyRollAsYaw`の設定を確認します。 |
| 機体や車両が旋回しただけで照準が動いてしまう | `ControlsRoot`に機体の回転を表す適切なトランスフォームが指定されているか確認します。 |
| HEAD SLAVEが動作しない | プレハブのルートではなく、子オブジェクトの`FSE_DFUNC_HeadSlave`をDialFunctionへ登録しているか確認します。あわせて`TurretController`の参照、DialFunctionの選択状態、`HeadSlaveVROnly`の設定を確認してください。 |
| 自分だけ動いて見え、他の参加者側で動かない | 操作席の割り当てや、Pilot Seatで連携する武装の設定を確認します。前の操作者が離席した直後の場合は座り直し、HEAD SLAVEを再選択してください（`HeadSlaveVROnly`も確認します）。単独での確認だけでなく他プレイヤーの視点からも確認し、解消しない場合は機体をリスポーンさせます。`OperatorSeat`と`TurretController`の参照先も確認してください。 |
| 追従タレットが動かない | `FollowerRotatorsHor`と`FollowerRotatorsVert`の要素数、同じインデックス同士のペア設定、基準タレットとの重複指定がないか、および各軸構成に応じた親子関係を確認します。 |
| 追従タレットの向きが90度ずれる | モデルの前方方向（forward）をUnityの青いZ軸（+Z）に合わせるWrapperオブジェクトを挟んで調整します。 |
| 照準ディスプレイ画面が真っ黒になる | Sight Cameraの有効化状態（アクティブ状態）、Target Texture、表示先Material、および操作席の`EnableInSeat`の設定を確認します。 |
| HUDの描画線が照準画面に映り込んでしまう | HUD用のレイヤーを`SightCameraExcludedLayers`に追加して除外します。 |
| ズーム操作ができない | プレハブのルートではなく、子オブジェクトの`FSE_DFUNC_SightZoom`をDialFunctionへ登録しているか確認します。あわせて`SightController`の参照、`MinimumFov`と`MaximumFov`の値を確認してください。デスクトップモードでは、DialFunctionでSight Zoomを選択してから`Q`/`E`キーを操作します。 |
| VR連続式ズームの前後操作の向きが合わない | `ControlsRoot`が車両とともに動くトランスフォームを参照しており、かつローカル+Z軸が車両前方を向いていることを確認します。 |
| ズーム時の照準感度が合わない | Sight Cameraの実際のFOV、`Manual Aim Reference FOV`、`MinManualAimScale`の設定値を確認します。 |
| 距離が表示されない、または`RNG ----`のままになる | 操作席に着席中か、`RangefinderOrigin`（またはSight Camera／Aim Origin）の参照設定、`RangefinderLayers`、および測定限界距離内に対象物が存在するかを確認します。 |
