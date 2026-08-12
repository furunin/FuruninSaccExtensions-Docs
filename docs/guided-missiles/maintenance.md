# 制限・更新・削除

## 制限事項

- 同時に存在できるミサイル数は`ProjectilePool`へ登録した数で決まります。
- 途中参加者は、参加前から飛翔しているミサイルの位置と速度を再構築しません。
- 誘導を終了したミサイルは再誘導できません。
- 指令ワイヤーの垂れは見た目だけで、切断判定は直線です。
- Zoom状態はほかの参加者へ同期しません。
- MCLOS用ComponentはPool内の各ミサイルへ個別に設定します。
- PilotSeatでミサイル選択中は飛行入力を抑止しますが、FSEはAuto Hoverを有効化しません。
- `DFUNC_TakeControl`による実行中の操作席交換には対応しません。
- 利用可能な信管Componentは同梱されていません。`FuzeModule`は対応する別機能を導入した場合だけ設定します。

## 更新

1. 導入先Prefab Variantと現在のFSEフォルダーをバックアップします。
2. 新しいunitypackageを同じフォルダーへインポートします。
3. 配布物内の同名Script、ProgramAsset、Prefab、FBX、Material、Animation、Audioは上書き対象になります。
4. 車両固有の変更が導入先Variantへ保存されていることを確認します。
5. 互換性のない変更が案内されている場合は、Inspector参照を設定し直します。

## 削除

1. 導入先Variantから追加した発射装置、ミサイル、表示物、FSE Componentを削除します。
2. 座席のDialFunction、`EnableInSeat`、補給TriggerからFSE参照を外します。
3. 他のPrefabやSceneから参照されていないことを確認します。
4. `Assets/Furunin/SaccExtensions`を削除します。SaccFlightAndVehicles本体は削除しません。
