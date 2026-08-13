# トラブルシューティング

| 症状 | 確認項目 |
|---|---|
| 発射できない | `OperatorSeat`、残弾、再装填、`FireCooldown`、再利用用ミサイルの登録、`LaunchPoints`、`MaxLaunchSightAngle`、地上発射設定、速度上限を確認します。PilotSeatなら`SAVControl`、PassengerSeatなら`PassengerFunctionsController`を設定し、ランチャーは左右どちらか一方のDialFunctionへ一度だけ登録します。座席に着席して通常操作を行った後に再試行し、Consoleに`[FSE MissileLauncher] Operator seat, control, or dial registration is invalid.`が出ていないか確認します。複数人でだけ失敗する場合は、発射するプレイヤーが席に座って車両を操作してから再試行します。 |
| PilotSeatから操作できない | `SAVControl`が設定され、ランチャーが`SaccEntity`の左右どちらか一方へ一度だけ登録され、`PassengerFunctionsController`が未設定か確認します。 |
| PassengerSeatから操作できない | 座席の`PassengerFunctionsController`が設定され、ランチャーが左右どちらか一方へ一度だけ登録されているか確認します。 |
| 発射直後に母機へ当たる | `CollisionHostRoot`、`LaunchPoint`の位置と青いZ軸、ミサイルColliderを確認します。 |
| SACLOSが誘導しない | `GuidanceReference`、`FSE_SACLOSGuidance.Missile`、`GuidanceModule`、照準基準の青いZ軸を確認します。 |
| MCLOSが誘導しない、または矢印キーに反応しない | `FSE_MCLOSGuidance.Missile`、`CommandSource`、`GuidanceModule`、入力Componentの参照と選択状態を確認します。ConsoleにUdonSharpのcompile errorがある場合、またはComponentがMissing Scriptの場合のみ、同名の`.cs`と`.asset`が存在するか、Program Source／Program AssetがMissingになっていないかを確認します。個別にAssetを割り当てず、`.meta`を含む正規パッケージを再importしてください。ProgramAssetの手動作成、GUID変更、任意のAsset割り当ては行いません。 |
| ワイヤーが見えない | `CommandWireRenderer`、Material、`EnableCommandWire`を確認します。 |
| ワイヤーがすぐ切れる | `WireCutLayers`へ母機や不要なTriggerのLayerが含まれていないか確認します。 |
| 弾薬表示が合わない | `LaunchPoints`と`AmmoMeshes`の数・順序、`MaxAmmo`、再装填状態を確認します。 |
| 補給されない | Saccの補給通知、補給判定用GameObject、`FSE_ResupplyTriggerBootstrap.ResupplyHost`を確認します。 |
| 見た目がロールしない | `RollVisualRoot`へ物理rootではなくMeshの共通親を指定し、回転速度が0でないことを確認します。 |
