# TOOLS.md

## Memory

- `honcho_context` — quick user/profile context
- `honcho_search_conclusions` — recall distilled past knowledge
- `honcho_search_messages` — recall message-level history
- `honcho_ask` — synthesis over Honcho memory
- `honcho_session` — current session state

## MCP Services

- `github-mcp-server` — GitHub issues, PRs, comments, repository operations
- `kubernetes-mcp` — Kubernetes state inspection and diagnostics
- `victoria-metrics-mcp` — metrics, alerts, time-series queries
- `flux-mcp` — Flux reconciliation and GitOps state

## Execution

- `sessions_spawn` — use for heavy code/research tasks
- `exec` — shell work, inspection and verification
- `web_search` / `web_fetch` — current docs, releases, specs

## Local Tooling Hints

Available through `exec`:

- `rg` for repository-wide search
- `jq` for structured JSON output
- `gh` for GitHub CLI workflows when MCP is not the best fit
- `uv` for Python tasks
- `pnpm` / `bun` for JavaScript tasks

## Rule

- Prefer the cheapest tool that can answer the question correctly.
- Prefer MCP tools for live platform state.
- Prefer standard CLI tools for local verification and fast inspection.
- Use Honcho before reconstructing prior context manually.
