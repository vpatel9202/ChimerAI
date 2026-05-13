# Operator Operations

These docs help ChimerAI operators understand, validate, update, back up, and
recover an alpha deployment.

ChimerAI is still a prototype. Treat these pages as the supported operator path
for the current alpha shape, not as a production SRE manual.

## Operator Tasks

- [Diagnostics](diagnostics.md): check host, network, and post-apply service
  health without guessing which layer failed.
- [Backup and Restore](backup-and-restore.md): configure Restic, run backups,
  and perform restore drills without overwriting a host by accident.
- [Update Lifecycle](update-lifecycle.md): update a checkout and re-apply it in
  a reviewable order.
- [Common Failure Modes](common-failure-modes.md): map frequent failures to the
  first checks and next commands.

## Operational Boundaries

Milestone 6 improves operator experience for the single-host alpha stack. It
does not add remote access profiles, notification routing, audit dashboards,
runner maturity, or sandbox operations. Those areas belong to future milestones.

## Evidence

For public alpha release work, record sanitized outcomes in the
[public alpha validation record](../public-alpha-validation-record.md). Do not
copy private hostnames, tokens, repository passwords, age identities, or local
inventory files into public docs.
