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

- Main agent: `reasoning` by default.
- Sub-agents: `worker` by default.
- Escalate a sub-agent to `reasoning` only for:
  - architecture decisions
  - multi-step debugging
  - security-sensitive changes
  - non-trivial code review
  - ambiguous product/technical tradeoffs

## Rate Limits

- 5 seconds minimum between API calls
- 10 seconds between web searches
- Max 5 searches per batch, then 2-minute break
- Batch similar work (one request for 10 leads, not 10 requests)
- If you hit 429 error: STOP, wait 5 minutes, retry

## Loop Detection

If you edit the same file 5+ times without progress, STOP. Step back, reconsider
your approach entirely. Don't make small variations to the same broken approach
— that's a doom loop.
