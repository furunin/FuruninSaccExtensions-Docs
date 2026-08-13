# Furunin Sacc Extensions Documentation

Furunin Sacc Extensionsの利用者向けドキュメントです。

- 公開サイト: https://furunin.github.io/FuruninSaccExtensions-Docs/
- ローカルプレビュー: `.\scripts\preview-docs.ps1`
- ローカルビルド確認: `.\scripts\check-docs.ps1`

公開ページの正本は`docs/`以下のMarkdownです。`site/`は生成物のためGitへ含めません。

## ローカルプレビュー

PowerShellでリポジトリルートを開き、次を実行します。

```powershell
.\scripts\preview-docs.ps1
```

初回必要時にだけPython 3.12の`.venv-docs`と固定済み依存関係を準備し、`http://127.0.0.1:8000/`を既定ブラウザで開きます。Markdownの変更は自動反映されます。停止するときは実行中のターミナルで`Ctrl+C`を押します。

リリース候補の警告・リンク・ナビゲーションをブラウザなしで確認する場合は次を使います。

```powershell
.\scripts\check-docs.ps1
```

PowerShellの実行ポリシーによってスクリプトが拒否された場合に限り、実行中のプロセスだけを対象に次を使います。

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass `
  -File .\scripts\preview-docs.ps1
```

どちらのスクリプトもGitのcommit・pushやGitHub Pagesの公開は行いません。
