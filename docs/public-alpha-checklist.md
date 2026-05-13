# Public Alpha Evidence Checklist

Use this checklist before tagging a public alpha release. The checklist is an
evidence record, not private deployment notes. Keep results sanitized: no real
domains, credentials, private inventory values, age identities, Restic
passwords, API keys, or `.local/` content.

For a reusable public template, see
[`public-alpha-validation-record.md`](public-alpha-validation-record.md).
The operational gate list lives in [Installation](installation.md#alpha-operational-gates),
and platform claims must match [Platform Support](platform-support.md).

Release blocker: do not tag a public alpha release while any required validation
record field is blank, `TBD`, or still a placeholder.

## Evidence Format

Record each gate with:

- **Command run**: exact command or manual action.
- **Environment**: OS, host shape, execution context, and relevant inventory
  class, using sanitized names.
- **Sanitized result**: short result summary with sensitive values removed.
- **Status**: `PASS`, `FAIL`, or `LIMITATION`.
- **Known limitation**: required for failures and accepted alpha limitations.

## Foundation Gates

| Gate | Required Evidence |
| --- | --- |
| Fresh clone setup | Command run for clone/bootstrap, environment, sanitized result, pass/fail, and any host prerequisite limitation. |
| Validate | `chimerai validate` plus syntax/check commands, environment, sanitized result, pass/fail, and any validation limitation. |
| First apply | `chimerai apply`, environment, sanitized convergence result, pass/fail, and any manual follow-up required. |
| Second apply idempotency | Second `chimerai apply`, environment, sanitized changed-task summary, pass/fail, and explanation for any material change. |
| Backup | `chimerai backup` and Restic snapshot listing, environment, sanitized snapshot proof, pass/fail, and any backup limitation. |
| Restore drill | Restore target, restore command or documented action, generated state restored, confirmation that no secret output was printed, pass/fail, and any restore limitation. |
| Diagnostics | Diagnostic command or runbook step, environment, sanitized result, pass/fail, and any diagnostic gap. |
| Known limitations | Public list of accepted alpha limitations with no private host details. |

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
operations maturity beyond the foundation gates above. Those belong to later
milestones:

- [Milestone 4: MCP and Agent Runtime Catalog](milestones/0004-mcp-and-agent-catalog.md)
- [Milestone 5: Operations Maturity](milestones/0005-operations-maturity.md)

Public alpha does require a completed validation record with no blank, `TBD`, or
placeholder evidence fields for required gates.
