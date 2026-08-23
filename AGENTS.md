# Furunin Sacc Extensions documentation policy

- Treat Markdown under `docs/` as the public documentation source.
- Read `coordination/README.md` and `coordination/release-checklist.md` before preparing or publishing a release.
- After applying approved documentation requests, run `scripts/check-docs.ps1`.
- For layout-affecting changes, run `scripts/preview-docs.ps1` and report which viewport widths and themes were actually inspected.
- Keep documentation changes local until the user explicitly requests a formal release or push. Local commits are allowed; do not push or deploy GitHub Pages without that explicit instruction.
- Product chats create documentation requests only. This repository's documentation chat owns public-page edits and release preparation.
- At the beginning of a documentation task, run `scripts/Get-PendingDocumentationRequests.ps1` and apply every unprocessed `ready` request before preparing a release.
- After a successful documentation check, commit the exact documentation and coordination files locally. Do not use `git add .`.
- Do not publish `coordination/`, documentation requests, development history, internal network APIs, or future plans.
- Preserve unrelated and pre-existing worktree changes.

## 公開文書の執筆規則

- 読者はギミックを導入・設定する利用者です。開発者向けの内部情報は掲載しません。
- 編集前に既存ページを検索し、同じField、参照、登録手順の正本がないか確認します。共通手順を先に一か所だけで示し、個別ページには固有の差分だけを書きます。
- 文は、削除すると利用者の作業、判断、確認結果が変わる場合だけ残します。通常の手順で発生しない問題は導入手順に書かず、トラブルシューティングにまとめます。
- 手順は利用者の作業順に並べ、何を開くか、どのGameObjectまたはComponentのFieldへ何を指定するか、どこへ登録するかを明記します。
- Sample固有の構成、数値、内部実装は、利用者が設定を維持または変更する必要がある場合だけ掲載します。
- 禁止操作を記載する必要がある場合は、「〜しないでください」と書きます。仕様の結果は、利用者から見た状態として書きます。
- ユーザーから明示的な依頼がない限り、`FSE_ResupplyTriggerBootstrap`には公開文書で言及しません。
- 文書更新履歴は、バージョンごとに利用者から見える大きな変更を簡潔な箇条書きでまとめます。ページ作成の経緯や細かな編集内容は列挙しません。
- 最終レビューでは、重複、不要な否定文、内部情報、将来計画、通常の導入経路で不要な注意書きがないか確認します。
