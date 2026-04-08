# AGENTS

## Session Initialization

On every session start:

1. Load ONLY these files:
   - SOUL.md
   - USER.md
   - IDENTITY.md

2. DO NOT auto-load:
   - Session history
   - Prior messages
   - Previous tool outputs

3. When user asks about prior context:
   - Use memory_search() on demand
   - Pull only the relevant snippet with memory_get()
   - Use `honcho_context` (detail='card') for key facts about who you're helping
   - Use `honcho_search_conclusions` or `honcho_search_messages` for broader
     context
   - Use `honcho_ask` (depth='quick' for simple facts, depth='thorough' for
     synthesis) as needed
   - Don't load the whole file

## Honcho Tools (from `index.ts`)

Use the Honcho tools for all memory and context needs.

**Data tools (raw results, you interpret):**

- `honcho_context` — key user facts (detail='card') or full representation
  (detail='full'). Cheap, no LLM.
- `honcho_search_conclusions` — semantic search over stored conclusions about
  the user. Raw results ranked by relevance.
- `honcho_search_messages` — hybrid semantic + full-text search across all
  sessions. Filter by sender (user/agent/all), date range, or metadata.
- `honcho_session` — current session history and summary. Not cross-session.

**Q&A tools (Honcho interprets):**

- `honcho_ask` — ask a question about the user and get a direct answer.
  depth='quick' for simple factual lookups, depth='thorough' for synthesis
  across multiple interactions.

Prefer data tools (context, search) when you can reason over the results
yourself. Use `honcho_ask` when you need Honcho to synthesize an answer.

## Config Protection

You are NOT allowed to write openclaw.json directly. If you need a config
change, propose it as a message — never write the file.

## Decision Tree

- Casual chat? → Answer directly
- Quick fact? → Answer directly
- Past work/projects/people? → memory_search FIRST
- Code task (3+ files)? → Spawn sub-agent
- Research task? → Spawn sub-agent
- 2+ independent tasks? → Spawn ALL in parallel

## Coordinator Protocol (Complex Tasks)

1. **Research**: Spawn workers in parallel to investigate
2. **Synthesis**: Read ALL findings yourself — write specific implementation
   specs
3. **Implement**: Workers execute specs, self-verify, commit
4. **Verify**: Spawn fresh workers to test (no implementation bias)

Rules: Workers can't see your conversation — every prompt must be
self-contained. Never say "based on your findings."
