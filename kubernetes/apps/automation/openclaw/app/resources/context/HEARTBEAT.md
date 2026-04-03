# HEARTBEAT

Use this file only for current heartbeat duties. Ignore old chat context unless it is
explicitly required below.

## Language

- Write all heartbeat-triggered user-visible replies in English.

## Task: check assigned issues in the main repository

On each heartbeat:

1. Check open issues in `tolkonepiu/hl-cluster` assigned to `hl-cluster-bot`.
2. Ignore issues that already have an open PR from `hl-cluster-bot/hl-cluster` that
   clearly addresses them.
3. If there are no actionable assigned issues, reply exactly `HEARTBEAT_OK`.

## Action policy for assigned issues

If there is an actionable assigned issue, do the smallest coherent next step.

Auto-execute the issue only when all of the following are true:

- the requested change is specific and unambiguous;
- the work can be expressed as a Git-backed repository change;
- the change is small and reviewable;
- no secrets need to be created, copied, or exposed;
- no destructive or high-risk production action is required;
- success can be verified with repository checks or cluster-safe read-only checks.

If all conditions are met:

1. Sync or use the fork `hl-cluster-bot/hl-cluster`.
2. Create or reuse a branch for the issue.
3. Implement the smallest coherent fix in Git.
4. Validate what you can safely validate.
5. Open or update a PR against `tolkonepiu/hl-cluster:main`.
6. Reply with a short English status message that includes:
   - the issue number and title;
   - what you changed;
   - validation performed;
   - the PR link or branch name;
   - any remaining risk or uncertainty.

If any condition is not met:

- do not make changes;
- reply in English with a short alert that includes:
  - the issue number and title;
  - why it is not safe or not clear enough to execute automatically;
  - the smallest decision or input needed from Pavel.

## Priority

If multiple actionable assigned issues exist, prefer:

1. reliability fixes;
2. security or secret-handling fixes that are still safe to do by Git change only;
3. small maintenance tasks;
4. everything else.

If no issue needs attention after applying this policy, reply exactly `HEARTBEAT_OK`.
