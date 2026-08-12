# 対応環境とインストール

## 対応環境

- Unity 2022.3.22f1
- VRChat Worlds SDK 3.10.4
- 同SDKに含まれるUdonSharp
- SaccFlightAndVehicles 1.8.1

異なるバージョンではAPIやPrefab構成が変わる可能性があります。

## インストール

1. VRChat Creator Companionで対象のWorld Projectを開きます。
2. 対応するSaccFlightAndVehiclesをProjectへ導入します。
3. Furunin Sacc Extensionsのunitypackageをインポートします。
4. UnityのConsoleにコンパイルエラーがないことを確認します。
5. 使用する製品のセットアップへ進みます。

FSEのScript、ProgramAsset、`.meta`は組として扱ってください。ファイルを個別に移動したり、ProgramAssetを直接編集したりしないでください。

## 製品別セットアップ

- [FSE Guided Missiles](guided-missiles/installation.md)
- [FSE Turret Control](turret-control/installation.md)
