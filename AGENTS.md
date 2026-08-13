# Furunin Sacc Extensions documentation policy

- Treat Markdown under `docs/` as the public documentation source.
- Read `coordination/README.md` and `coordination/release-checklist.md` before preparing or publishing a release.
- After applying approved documentation requests, run `scripts/check-docs.ps1`.
- For layout-affecting changes, run `scripts/preview-docs.ps1` and report which viewport widths and themes were actually inspected.
- Keep documentation changes local until the user explicitly requests a formal release or push. Local commits are allowed; do not push or deploy GitHub Pages without that explicit instruction.
- Product chats create documentation requests only. This repository's documentation chat owns public-page edits and release preparation.
- Do not publish `coordination/`, documentation requests, development history, internal network APIs, or future plans.
- Preserve unrelated and pre-existing worktree changes.
