# Public Alpha Evidence Checklist

Use this checklist before tagging a public alpha release. The checklist is an
evidence record, not private deployment notes. Keep results sanitized: no real
domains, credentials, private inventory values, age identities, Restic
passwords, API keys, or `.local/` content.

For a reusable public template, see
[`public-alpha-validation-record.md`](public-alpha-validation-record.md).
The operational gate list lives in [Installation](installation.md#alpha-operational-gates),
and platform claims must match [Platform Support](platform-support.md).

Hard release blocker: do not tag `v0.1.0-alpha` or any public alpha release
while any required validation record field is blank, `TBD`, `Not recorded yet`,
or still a placeholder. A release candidate with incomplete evidence is
explicitly not ready.

## Evidence Format

Record each gate with:

- **Command run**: exact command or manual action.
- **Evidence location**: stable public path or CI run reference where the
  sanitized evidence can be reviewed.
- **Environment**: OS, host shape, execution context, and relevant inventory
  class, using sanitized names.
- **Sanitized result**: short result summary with sensitive values removed.
- **Status**: `PASS`, `FAIL`, or `LIMITATION`.
- **Known limitation**: required for failures and accepted alpha limitations.

## Foundation Gates

| Gate | Required Evidence |
| --- | --- |
| Fresh clone setup | Command run for clone/bootstrap, evidence location, environment, sanitized result, pass/fail, and any host prerequisite limitation. |
| Validate | `chimerai validate` plus syntax/check commands, evidence location, environment, sanitized result, pass/fail, and any validation limitation. |
| First apply | `chimerai apply`, evidence location, environment, sanitized convergence result, pass/fail, and any manual follow-up required. |
| Second apply idempotency | Second `chimerai apply`, evidence location, environment, sanitized changed-task summary, pass/fail, and explanation for any material change. |
| Backup | `chimerai backup` and Restic snapshot listing, evidence location, environment, sanitized snapshot proof, pass/fail, and any backup limitation. Follow [Backup and Restore](operations/backup-and-restore.md). |
| Restore drill | Restore target, restore command or documented action, evidence location, generated state restored, confirmation that no secret output was printed, pass/fail, and any restore limitation. Follow [Backup and Restore](operations/backup-and-restore.md). |
| Diagnostics | Diagnostic command or runbook step, evidence location, environment, sanitized result, pass/fail, and any diagnostic gap. Follow [Diagnostics](operations/diagnostics.md). |
| Known limitations | Public list of accepted alpha limitations with no private host details. |

## Expected Evidence Locations

Public alpha evidence should live in reviewable public paths:

- release-candidate record:
  [`public-alpha-validation-record.md`](public-alpha-validation-record.md);
- demo transcript or sample-output slots:
  [`demo-and-sample-output.md`](demo-and-sample-output.md);
- release notes:
  [`releases/v0.1.0-alpha.md`](releases/v0.1.0-alpha.md);
- CI dry-run or syntax evidence: linked from the validation record by run name
  or commit SHA;
- manual GitHub repository polish: recorded in the checklist or release notes
  after completion.

Do not move private command logs, inventories, screenshots, hostnames, domains,
or `.local/` content into these public locations.

## Manual Repository Polish

Before tagging public alpha, confirm the GitHub repository metadata is accurate:

- description says this is a prototype alpha self-hosted AI homelab stack;
- topics include relevant public discovery terms such as `ansible`,
  `docker-compose`, `homelab`, `self-hosted`, `ai`, `mcp`, and `automation`;
- README, release notes, and roadmap all say the alpha is unstable and not
  production-ready;
- default branch protection and CI status are visible to reviewers.

This polish is a manual release task. It is not complete until the validation
record or release notes link to the checked repository settings.

## Second Apply Definition

The second apply has no material changes when a repeat run does not create,
remove, restart, rewrite, or rotate deployed resources in a way that changes the
running stack or its generated state.

Acceptable non-material differences include:

- timestamps, elapsed time, or log ordering;
- read-only checks that report `ok`;
- idempotent package or collection checks with no resulting change;
- redacted output formatting differences.

Material changes include:

- changed Ansible tasks that rewrite service config, Compose files, secrets, or
  bind-mounted state;
- container recreation or service restarts caused by rendered config drift;
- new files, removed files, or permission changes under ChimerAI-managed state;
- new Restic repository initialization on a host that should already be
  configured;
- any manual command required between first and second apply to keep the stack
  working.

If a second apply reports material changes, record `FAIL` unless the limitation
is explicitly accepted for alpha.

## Backup Proof

Backup evidence must show:

- the backup command that ran;
- the sanitized Restic repository target class;
- a Restic snapshot listed after the backup;
- which generated state path or service state class was included;
- confirmation that no Restic password, repository credential, or private path
  was printed.

## Restore Proof

Restore evidence must show:

- the restore target, such as a disposable host, temporary restore directory, or
  clean generated-state path;
- the restore command or documented manual action;
- which generated state was restored;
- the verification used to confirm restored state exists;
- confirmation that no secret values, private inventory content, or `.local/`
  content was printed.

## Release Boundary

Public alpha does not require a broad MCP/app catalog, multi-server support, or
operations maturity beyond the foundation gates above. It does require the role
catalog to stay internally consistent so the alpha surface is clear. Broader
role governance and operations work belong to later milestones:

- [Milestone 5: Role Catalog Governance](milestones/0005-role-catalog-governance.md)
- [Milestone 6: Operator Experience](milestones/0006-operations-maturity.md)

Public alpha does require a completed validation record with no blank, `TBD`,
`Not recorded yet`, or placeholder evidence fields for required gates.
