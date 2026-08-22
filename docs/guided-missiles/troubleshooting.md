# トラブルシューティング

| 症状 | 確認項目 |
|---|---|
| 発射できない、またはランチャーを選択できない | `OperatorSeat`、残弾、再装填、`FireCooldown`、`ProjectilePool`、`LaunchPoints`、`MaxLaunchSightAngle`、地上発射設定、速度上限を確認します。ランチャーは操作席の左右どちらか一方のDialFunctionへ一度だけ登録します。ランチャーだけを登録するDialは配列サイズを`1`にし、element 0へ`FSE_DFUNC_MissileLauncher`を指定してください。element 0を未設定にしないでください。PilotSeatでは`SAVControl`を設定し、PassengerSeatでは`OperatorSeat.PassengerFunctions`と同じControllerを`PassengerFunctionsController`へ指定します。座席に着席して通常操作を行った後に再試行し、Consoleに`[FSE MissileLauncher] Operator seat, control, or dial registration is invalid.`が出ていないか確認します。 |
| ランチャーだけを登録したDialで選択表示がない | 配列サイズが`1`のDialでは、選択中でもDialのハイライターは表示されません。element 0に`FSE_DFUNC_MissileLauncher`が指定され、設定した席へ座っていることを確認します。 |
| PilotSeatから操作できない | `SAVControl`が設定され、ランチャーが`SaccEntity`の左右どちらか一方へ一度だけ登録され、`PassengerFunctionsController`が未設定か確認します。 |
| PassengerSeatから操作できない | `OperatorSeat.PassengerFunctions`と`PassengerFunctionsController`が同じControllerを参照し、ランチャーがそのControllerの左右どちらか一方へ一度だけ登録されているか確認します。FSE Turret Controlを併用する場合は、`FSE_EXT_Turret`が同じControllerの`PassengerExtensions`へ登録されているか確認します。 |
| 発射直後に母機へ当たる | `CollisionHostRoot`、`LaunchPoint`の位置と青いZ軸、ミサイルColliderを確認します。 |
| SACLOSが誘導しない | `GuidanceReference`が`FSE_TurretControl`内の`Aim Origin`を参照し、`ProjectilePool`内のすべての飛翔弾で`FSE_SACLOSGuidance.Missile`と`GuidanceModule`が対応しているか確認します。 |
| MCLOSが誘導しない、または矢印キーに反応しない | 共有する`FSE_MCLOSInputController.Launcher`、各飛翔弾の`FSE_MCLOSGuidance.Missile`、`CommandSource`、`GuidanceModule`を確認します。`ProjectilePool`内のすべての飛翔弾で同じ対応が必要です。ConsoleにUdonSharpのcompile errorがある場合、またはComponentがMissing Scriptの場合のみ、同名の`.cs`と`.asset`が存在するか、Program Source／Program AssetがMissingになっていないかを確認します。個別にAssetを割り当てず、`.meta`を含む正規パッケージを再importしてください。ProgramAssetの手動作成、GUID変更、任意のAsset割り当てをしないでください。 |
| ワイヤーが見えない | `CommandWireRenderer`、Material、`EnableCommandWire`を確認します。 |
| ワイヤーがすぐ切れる | `WireCutLayers`へ母機や不要なTriggerのLayerが含まれていないか確認します。 |
| 弾薬表示が合わない | `LaunchPoints`と`AmmoMeshes`の数・順序、`MaxAmmo`、再装填状態を確認します。 |
| 補給されない | Saccの補給通知と、`InVehicleOnly`の下で`ResupplyTrigger`が有効になっていることを確認します。`PilotOnly`の下や、同じ補給範囲へ重複する補給Triggerを配置しないでください。 |
| 見た目がロールしない | `RollVisualRoot`へ物理rootではなくMeshの共通親を指定し、回転速度が0でないことを確認します。 |
