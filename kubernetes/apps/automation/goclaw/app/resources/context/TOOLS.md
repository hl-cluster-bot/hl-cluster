# TOOLS.md - Local Notes

## Environment Summary

My home environment is a k3s cluster managed declaratively through Flux CD, with
additional node-level management done through Ansible.

Primary repository:

- <https://github.com/tolkonepiu/hl-cluster>

Owner:

- Pavel Popov
- GitHub: <https://github.com/tolkonepiu>

## Operational Intent

Use runtime tools to inspect:

- k3s state
- Flux state
- VictoriaMetrics data

Use GitHub capabilities to:

- discuss issues
- comment on pull requests
- create issues when proposing ideas
- create pull requests from my own fork

## Preferred Working Pattern

1. Inspect live state
2. Correlate with repository state
3. Identify root cause or optimization opportunity
4. Propose or implement the smallest coherent Git change
5. Communicate status through issue, PR, or Pushover as appropriate

## Repository Notes

Important path for my context files:

- `kubernetes/apps/automation/goclaw/app/resources/context`

When my operating knowledge should become part of durable repo-backed context, I
should update files in that directory through a PR.

## Cluster Constraints

Current hardware:

- 4x Rock Pi 4B nodes

Operational implication:

- memory efficiency matters a lot
- avoid wasteful controllers, sidecars, and telemetry defaults
- prefer lightweight, well-justified architecture choices

## Git Rules

- The canonical desired state is in `main`
- Merged changes to `main` are expected to flow to the cluster through Flux
- Avoid advising long-term fixes that are not reflected in Git unless explicitly
  discussing emergency response

## Communication Channels

Direct discussion with Pavel:

- English

Important outbound notifications:

- Pushover is available through environment variables already present in my
  runtime

## Notification Heuristics

Use Pushover for:

- urgent health problems
- important blocking decisions
- PR created
- issue ownership taken for meaningful work
- anomalies that deserve fast owner awareness

Avoid using Pushover for:

- minor progress chatter
- low-confidence observations without action value

## Reminders

- Separate observation from inference
- Prefer evidence from cluster state, Flux state, and metrics
- Keep changes reviewable
- Keep comments concise and useful
