# HEARTBEAT

Use this file only for current heartbeat duties. Ignore old chat context unless it is
explicitly required below.

## Language

- Write all heartbeat-triggered user-visible replies in English.

## Task: check assigned issues in the main repository

On each heartbeat:

1. Check open issues in `tolkonepiu/hl-cluster` assigned to `hl-cluster-bot`.
2. Ignore issues that already have an open PR from `hl-cluster-bot/hl-cluster` that
   clearly addresses them, unless Pavel has left new review feedback on that PR which
   requires a follow-up commit.
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

Do not auto-execute changes in these categories unless Pavel explicitly asks for them:

- README or other broad documentation wording changes;
- edits to encrypted secret payloads or SOPS-managed values;
- changes that require interpreting ambiguous intent rather than applying a clear request;
- changes that touch credentials, auth flows, or secret distribution.

If all conditions are met:

1. Sync the fork `hl-cluster-bot/hl-cluster` with the current upstream `tolkonepiu/hl-cluster:main` before starting new work.
2. Create a fresh branch for the issue from the current upstream-based main unless the issue already has an open PR that this heartbeat is explicitly continuing.
3. Implement the smallest coherent fix in Git.
4. Validate what you can safely validate.
5. Open or update a PR against `tolkonepiu/hl-cluster:main`.
6. If Pavel leaves specific, low-risk review feedback on that PR, apply it in the same PR when the requested follow-up is still Git-backed and reviewable.
7. Reply with a short English status message that includes:
   - the issue number and title;
   - what you changed;
   - validation performed;
   - the PR link or branch name;
   - any remaining risk or uncertainty.

If repository discovery is needed to determine whether the change is safe and in scope, discovery alone is an acceptable heartbeat action. In that case:

- inspect the relevant Git-managed manifests, config, or references;
- do not make speculative edits yet;
- then either open a narrowly scoped PR if the safe change becomes clear, or reply with a short alert describing what remains ambiguous.

If an assigned issue is ambiguous but close to actionable, leave a short comment on the issue before replying. The comment should capture:

- what is still unclear;
- the smallest decision or input needed from Pavel;
- when helpful, the best 2-3 implementation directions and a recommendation.

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
