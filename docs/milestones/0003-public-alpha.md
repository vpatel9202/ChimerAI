# Milestone 3: Public Alpha Foundation

Milestone 3 defines the proof required before tagging a public alpha. The alpha
is foundation-first: a careful operator should be able to start from a fresh
Linux server, apply the stack, prove repeatability, recover generated state, and
understand the limitations.

## Goals

- Prove the fresh-clone path on the current alpha platform target.
- Prove wrapper-backed validation, first apply, and second apply idempotency.
- Prove backup and restore against generated service state without exposing
  secrets.
- Make diagnostics, release evidence, and known limitations explicit.
- Keep the alpha boundary narrow enough for public users to evaluate honestly.

## Release Gates

Use the [Public Alpha Evidence Checklist](../public-alpha-checklist.md) for gate
definitions, record release-candidate evidence in the
[Public Alpha Validation Record](../public-alpha-validation-record.md), and keep
platform claims aligned with [Platform Support](../platform-support.md).

- **Fresh clone setup**: a new checkout can install local tooling, initialize
  placeholder-safe config, and reach the documented validation commands.
- **Validation**: `chimerai validate` and the documented syntax/check commands
  complete with sanitized evidence.
- **First apply**: `chimerai apply` can converge the single-server alpha stack
  on the Linux server validation target.
- **Second apply idempotency**: a second `chimerai apply` has no material
  changes as defined in the public alpha checklist.
- **Backup**: `chimerai backup` creates a Restic snapshot and the snapshot can
  be listed without printing secrets.
- **Restore drill**: generated state can be restored into a documented restore
  target without exposing credentials or private inventory content.
- **Diagnostics**: documented diagnostics identify common validation, apply,
  service, backup, and restore failures with next inspection steps.
- **Known limitations**: alpha limitations are documented before release, with
  catalog breadth, multi-server deployment, and long-term operations maturity
  kept out of the alpha blocker list.

## Non-Goals

- Broad MCP or app catalog coverage. Catalog expansion belongs to Milestone 5.
- Additional agent runtimes beyond the first validated runtime path.
- Multi-server deployment support.
- Full update lifecycle, service-specific observability, or operations maturity;
  those belong to Milestone 6.
- Full Authentik user, group, policy, or identity-provider automation.
