# Milestone 6: Operator Experience

Milestone 6 focuses on making ChimerAI understandable and recoverable for
operators running the single-host alpha stack.

## Goals

- Document diagnostics, backup and restore, update lifecycle, and common
  failure modes under `docs/operations/`.
- Group diagnostics output by actionable failure type while keeping validate
  read-only and post-apply checks apply-only.
- Explain the backup and restore workflow, including Restic behavior, Authentik
  dump handling, and restore drill expectations.
- Add an explicit restore safety guard so restoring to `/` requires operator
  opt-in.
- Define current update lifecycle expectations for a repo checkout, local
  tooling, validation, and apply.

## Release Gates

- Operators can update an existing checkout without guessing which commands to
  run.
- Restore documentation has been tested against a clean recovery path.
- Diagnostics explain what failed and what to inspect next.
- Common failure documentation points operators to the first useful check for
  inventory, Docker, network, service, backup, and restore failures.
- Public alpha evidence links to operator diagnostics, backup/restore, and
  update lifecycle docs.

## Non-Goals

- Multi-host orchestration before single-host operations are stable.
- A custom UI or app catalog before role contracts have settled.
- Hidden orchestration that makes generated Compose harder to debug.
- Remote access profile selection.
- Notification routing and alert policy.
- Audit dashboards or full tool-call review surfaces.
- Runner maturity and sandbox operations.
