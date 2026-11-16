# トラブルシューティング

| 症状 | 確認項目 |
|---|---|
| 発射できない、またはランチャーを選択できない | `OperatorSeat`、残弾数、再装填状態、`FireCooldown`、`ProjectilePool`、`LaunchStations`と各`LaunchPoint`、`MaxLaunchSightAngle`、地上発射設定、速度上限の設定値を確認します。<br>ランチャーは操作席の左右どちらか一方のDialFunctionへ一度だけ登録してください。ランチャーのみを登録するDialは配列サイズを`1`にし、Element 0へ`FSE_DFUNC_MissileLauncher`を指定します（Element 0を未設定の空欄にしないでください）。<br>PilotSeatでは`SAVControl`を設定し、PassengerSeatでは`OperatorSeat.PassengerFunctions`と同じコントローラーを`PassengerFunctionsController`へ指定します。座席に着席して通常の選択操作を行っても発射できない場合は、Consoleに`[FSE MissileLauncher] Operator seat, control, or dial registration is invalid.`が出力されていないか確認してください。 |
| ランチャーのみを登録したDialで選択表示（ハイライト）が出ない | 配列サイズが`1`のDialでは、選択中であってもDialのハイライターは表示されません。Element 0に`FSE_DFUNC_MissileLauncher`が指定されており、設定した操作席に着席していることを確認してください。 |
| PilotSeatから操作できない | `SAVControl`が設定されているか、ランチャーが`SaccEntity`の左右どちらか一方へ1回だけ登録されているか、および`PassengerFunctionsController`が空欄（未設定）になっているかを確認します。 |
| PassengerSeatから操作できない | `OperatorSeat.PassengerFunctions`と`PassengerFunctionsController`が同一のコントローラーを参照しており、ランチャーがそのコントローラーの左右どちらか一方へ1回だけ登録されているかを確認します。FSE Turret Controlを併用する場合は、`FSE_EXT_Turret`が同じコントローラーの`PassengerExtensions`へ登録されているかも確認してください。 |
| 発射直後に母機へ衝突する | `CollisionHostRoot`の指定階層、`LaunchPoint`の位置およびローカル+Z軸の向き、ミサイル側のCollider設定を確認します。 |
| SACLOSで誘導されない | `GuidanceReference`が`FSE_TurretControl`内の`Aim Origin`を参照しているか、および`ProjectilePool`内の全飛翔弾で`FSE_SACLOSGuidance.Missile`と`GuidanceModule`が相互に正しく割り当てられているかを確認します。 |
| MCLOSで誘導されない、または矢印キーに反応しない | 共通の`FSE_MCLOSInputController.Launcher`、各飛翔弾の`FSE_MCLOSGuidance.Missile`、`CommandSource`、`GuidanceModule`の割り当てを確認します。`ProjectilePool`内の全飛翔弾で同様の設定が必要です。<br>ConsoleにUdonSharpのコンパイルエラーが出ている場合やコンポーネントがMissing Scriptになっている場合は、同名の`.cs`と`.asset`が存在するか、Program Source／Program AssetがMissingになっていないか確認してください。アセットを個別に割り当て直すのではなく、`.meta`ファイルを含めた正規パッケージを再インポートしてください（ProgramAssetの手動作成やGUID変更、任意アセットの手動割り当ては行わないでください）。 |
| ワイヤーが表示されない | `First Command Wire Renderer`（`CommandWireRenderer`）の指定、Material、`EnableCommandWire`のチェックを確認します。2本目を運用する場合は`Second Command Wire Renderer`（`SecondCommandWireRenderer`）の設定も確認してください。 |
| ワイヤーがすぐに切断される | `WireCutLayers`に母機自体のレイヤーや、接触不要なトリガー用レイヤーが含まれていないか確認します。 |
| 弾薬表示が一致しない | `LaunchStations`の登録数・発射順、各ステーションの`VisualRoot`、`MaxAmmo`、および再装填タイマーの状態を確認します。 |
| 装填アニメーションが動かない | `FSE_DFUNC_MissileLauncher.MissileAnimator`とアニメーターコントローラーを確認します。`Reloading Bool Name`はBool、`Reload Progress Float Name`はFloatとして、指定した名前と同じパラメーターをアニメーターに作成してください。アニメーターを配置したオブジェクトが装填中も有効か確認します。 |
| 更新後に既存の装填アニメーションが動かなくなった | 配布Stowedのモデルは`Visual`親の配下にあります。旧階層を参照するAnimation Clipは、現在のモデルの参照パスへ更新してください。既存の独自生成プレハブの階層は自動変換されません。 |
| 補給が行われない | Saccの補給通知、および`InVehicleOnly`直下で`ResupplyTrigger`がアクティブ（有効）になっていることを確認します。`PilotOnly`の配下や、同一の補給領域内に重複する補給トリガーを配置しないでください。 |
| 見た目がロール回転しない | `RollVisualRoot`に物理挙動のルートオブジェクトではなくメッシュの共通親オブジェクトを指定しているか、およびロール回転速度が0以外の値に設定されているかを確認します。 |
