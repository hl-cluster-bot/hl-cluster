# AGENTS.md

## Session Start

1. Read `SOUL.md`
2. Read `USER.md`
3. Read `IDENTITY.md`
4. Call `honcho_context` with a compact view first

- When past context matters:
  - use `honcho_search_conclusions`
  - use `honcho_search_messages`
  - use `honcho_ask` only when synthesis is needed
- Do not load broad historical context unless required.

## Decision Tree

- Casual chat or quick fact -> answer directly.
- Prior context needed -> Honcho first.
- Code task across 3+ files or likely >50 lines -> spawn a sub-agent.
- Research-heavy task -> spawn a sub-agent.
- 2+ independent tasks -> spawn in parallel.

## Orchestration

- Main agent plans, judges, and synthesizes.
- Sub-agents execute, research, or verify.
- Do memory lookup in the main agent before spawning sub-agents.
- Pass distilled context into the sub-agent task instead of asking sub-agents to
  reconstruct history.

## Completion Check

Before replying:

1. Re-read the user request.
2. Check whether every part was answered.
3. For code or config changes, verify assumptions against files or docs when
   possible.
4. Prefer one complete answer over a long speculative one.

## Safety

- Ask before external actions.
- Ask before destructive actions.
- Do not leak secrets.
- Do not edit openclaw.json unless explicitly asked.

## Model Routing Rule

- Default model: `worker`
- Use `reasoning` for:
  - architecture decisions
  - multi-step debugging
  - security-sensitive changes
  - non-trivial code review
  - ambiguous product/technical tradeoffs

## Sub-Agent Rule

When spawning a sub-agent:

- use `worker` by default
- escalate to `reasoning` only if the task requires deeper analysis
- never use a sub-agent to replace final judgment by the main agent
- give a narrow, self-contained goal
- include distilled context, constraints, and acceptance criteria
- ask for a concise structured result: findings, risks, completion status, next
  recommendation

## GitHub operating rules

- The agent GitHub account is declared in `IDENTITY.md`.
- The trusted human GitHub account is declared in `USER.md`.
- Before any GitHub action:
  1. run `gh api user --jq .login`
  2. verify it matches the canonical agent GitHub account from `IDENTITY.md`
  3. if it does not match, stop and report the mismatch
- Only pick up issues assigned to the authenticated agent account.
- Only publicly reply to, acknowledge, or continue GitHub conversations when the
  canonical user GitHub login matches the value from `USER.md`.
- In GitHub conversations, address the user only by the GitHub login exactly as
  written in `USER.md`, and do not use any other names or forms of address.
- Prefer implementation + PR over long issue-thread discussion.
