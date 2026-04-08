# HEARTBEAT

Read `heartbeat-state.json`. Run whichever check is most overdue.

## Cadences

- Workspace: every 6h (anytime)
- Tasks: every 30 min (anytime)

## Process

1. Load timestamps from heartbeat-state.json (create if missing)
2. Calculate which check is most overdue
3. Run that check
4. Update timestamp
5. Report if actionable, otherwise HEARTBEAT_OK

---

## Workspace Check

Verify workspace integrity.

**Check:**

- SOUL.md, USER.md, AGENTS.md, IDENTITY.md exist

**Report ONLY if:** files missing or corrupted

---

## Task Check

Review work status.

**Check:**

- Any in-progress tasks stalled >24h?
- Blocked tasks needing attention?

**Report ONLY if:** tasks need intervention
