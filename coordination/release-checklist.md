# Documentation release checklist

- [ ] Every documentation request in the selected `release_group` has `status: approved`.
- [ ] `scripts/Get-PendingDocumentationRequests.ps1` reports no pending `ready` requests.
- [ ] `scripts/check-docs.ps1` succeeds against the release-candidate HEAD.
- [ ] Local preview navigation, tables, code blocks, and internal links were inspected.
- [ ] Desktop and narrow/mobile-equivalent widths were inspected.
- [ ] Light and dark themes were inspected.
- [ ] `coordination/`, documentation requests, and other non-public files are absent from `site/`.
- [ ] The user approved the content and visual result.
- [ ] Only after approval: commit, push, verify GitHub Actions, and verify GitHub Pages.
