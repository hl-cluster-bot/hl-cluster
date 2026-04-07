# Repository Guide

This repository is the canonical desired state for the homelab cluster.
Changes merged into `main` are reconciled into the cluster by Flux.

## Top-level layout

- `kubernetes/` - GitOps-managed Kubernetes manifests and Flux entrypoints
- `ansible/` - node inventory, roles, and playbooks for host and k3s lifecycle work
- `bootstrap/` - bootstrap resources used to establish initial cluster access and dependencies
- `scripts/` - helper scripts, including bootstrap helpers
- `.taskfiles/` and `Taskfile.yaml` - local operator workflows and common commands
- `devenv.*` - reproducible local development environment configuration

## GitOps flow

The main Flux entrypoint is:

- `kubernetes/flux/cluster`

Flux watches this repository and applies manifests rooted at that path. In practice, the flow is:

1. change Git
2. merge into `main`
3. Flux detects the new revision
4. Flux reconciles manifests into the cluster

For manual reconciliation from a prepared operator environment, the default task is:

```sh
task reconcile
```

## Kubernetes layout

The `kubernetes/` directory is organized into three main areas:

- `kubernetes/flux/` - Flux bootstrap and cluster entrypoints
- `kubernetes/apps/` - app and infrastructure stacks grouped mostly by namespace/domain
- `kubernetes/components/` - reusable shared components

### Apps layout

`kubernetes/apps/` is grouped by operational domain or namespace, including:

- `automation/`
- `cert-manager/`
- `database/`
- `default/`
- `flux-system/`
- `hardware/`
- `kube-system/`
- `network/`
- `observability/`
- `openebs-system/`
- `system-upgrade/`
- `tailscale/`

Each app usually follows the same rough pattern:

- `ks.yaml` - Flux `Kustomization` for that app
- `app/` - manifests, HelmRelease, or supporting resources for the workload

### Components layout

`kubernetes/components/common/` contains reusable shared resources, including:

- alerting fragments
- shared repositories
- SOPS-related resources
- common namespace helpers

## Secrets

Secrets are expected to stay encrypted in Git.

Relevant indicators in this repository:

- `.sops.yaml`
- encrypted secret manifests such as `*.sops.yaml`

Do not commit plaintext credentials, tokens, keys, or kubeconfigs.

## How to make a safe change

Prefer small, reviewable Git-backed changes.

Typical workflow:

1. identify the owning path in `kubernetes/` or `ansible/`
2. make the smallest coherent change
3. validate locally where possible
4. open a PR
5. merge to `main`
6. verify Flux reconciliation and runtime health

Prefer changing desired state in Git over making ad hoc in-cluster changes.

## Operations notes

Useful operator entrypoints:

- `README.md` - high-level cluster overview
- `Taskfile.yaml` - common local workflows
- `kubernetes/flux/cluster/` - Flux root
- `kubernetes/apps/<domain>/<app>/` - workload ownership paths
- `ansible/playbooks/` - host and k3s lifecycle operations

When something is unhealthy:

1. check Flux reconciliation state first
2. map the runtime object back to its path in Git
3. inspect app manifests, HelmRelease, or Kustomization under that path
4. only then decide whether the fix belongs in Git, bootstrap, or Ansible
