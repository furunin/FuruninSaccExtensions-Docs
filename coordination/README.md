# Documentation coordination

This directory contains release coordination records and is outside `docs/`, so MkDocs does not publish it.

## Documentation chat policy

- After applying an approved documentation request, run `scripts/check-docs.ps1`.
- For layout-affecting changes, run `scripts/preview-docs.ps1` and inspect desktop width, narrow/mobile-equivalent width, light theme, and dark theme.
- Record the locally previewed documentation revision in `applied-requests.yml`.
- Before release, rerun `scripts/check-docs.ps1` against the exact HEAD that will be published.
- Until the user explicitly requests a release, keep work local. Local commits are permitted; `git push` and GitHub Pages deployment are not.
- Product chats create documentation requests only. They do not edit this documentation repository, run its preview server, or publish the site.
- Do not mix release groups. Only approved requests belonging to the selected release group may enter a release candidate.

The preview and check scripts never commit, push, call the GitHub API, or deploy GitHub Pages.
