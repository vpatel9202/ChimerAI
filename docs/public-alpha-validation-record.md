# Public Alpha Validation Record

This is the public release-candidate evidence record and reusable template for
tagging a public alpha release. It is not proof by itself.

Blank fields, `TBD` entries, `Not recorded yet`, or placeholder values mean the
public alpha is not ready. Do not tag `v0.1.0-alpha` or any public alpha release
until every required field is filled with sanitized evidence and the reviewer
sign-off says the release is ready.

Keep only sanitized placeholders and sanitized results here. Do not include real
domains, credentials, private inventory values, age identities, Restic passwords,
API keys, hostnames that identify a private deployment, or `.local/` content. Do
not fill expected or assumed results as evidence.

## Release Candidate

- **Release candidate**: Not recorded yet.
- **Date**: Not recorded yet.
- **Reviewer**: Not recorded yet.
- **Commit or tag**: Not recorded yet.
- **Validation target**: single Linux server, currently Ubuntu Server 24.04.
- **Inventory class**: sanitized example, such as `single-server`.
- **Current readiness**: Not ready - validation evidence incomplete.

## Environment

- **OS**: Not recorded yet.
- **CPU/RAM class**: Not recorded yet.
- **Disk class**: Not recorded yet.
- **Network shape**: Not recorded yet.
- **Execution context**: local shell, SSH session, CI dry run, or disposable
  proof environment. Not recorded yet.
- **Notes**: Not recorded yet.

## Evidence Summary

| Gate | Status | Evidence Location | Known Limitation |
| --- | --- | --- | --- |
| Fresh clone setup | Blocked until recorded | Not recorded yet | Not recorded yet |
| Validate | Blocked until recorded | Not recorded yet | Not recorded yet |
| First apply | Blocked until recorded | Not recorded yet | Not recorded yet |
| Second apply idempotency | Blocked until recorded | Not recorded yet | Not recorded yet |
| Backup | Blocked until recorded | Not recorded yet | Not recorded yet |
| Restore drill | Blocked until recorded | Not recorded yet | Not recorded yet |
| Diagnostics | Blocked until recorded | Not recorded yet | Not recorded yet |
| Known limitations reviewed | Blocked until recorded | Not recorded yet | Limitations must be recorded before release |

## Gate Records

Use the operator docs for repeatable evidence:
[Diagnostics](operations/diagnostics.md),
[Backup and Restore](operations/backup-and-restore.md), and
[Update Lifecycle](operations/update-lifecycle.md).

### Fresh Clone Setup

- **Command run**: Not recorded yet.
- **Evidence location**: Not recorded yet.
- **Environment**: Not recorded yet.
- **Sanitized result**: Not recorded yet.
- **Status**: Blocked until recorded.
- **Known limitation**: Not recorded yet.

### Validate

- **Command run**: Not recorded yet.
- **Evidence location**: Not recorded yet.
- **Environment**: Not recorded yet.
- **Sanitized result**: Not recorded yet.
- **Status**: Blocked until recorded.
- **Known limitation**: Not recorded yet.

### First Apply

- **Command run**: Not recorded yet.
- **Evidence location**: Not recorded yet.
- **Environment**: Not recorded yet.
- **Sanitized result**: Not recorded yet.
- **Status**: Blocked until recorded.
- **Known limitation**: Not recorded yet.

### Second Apply Idempotency

- **Command run**: Not recorded yet.
- **Evidence location**: Not recorded yet.
- **Environment**: Not recorded yet.
- **Sanitized result**: Not recorded yet.
- **Material change review**: Not recorded yet.
- **Status**: Blocked until recorded.
- **Known limitation**: Not recorded yet.

### Backup

- **Command run**: Not recorded yet.
- **Evidence location**: Not recorded yet.
- **Environment**: Not recorded yet.
- **Sanitized result**: Not recorded yet.
- **Restic snapshot listed**: Not recorded yet.
- **Generated state included**: Not recorded yet.
- **No secret output printed**: Not recorded yet.
- **Status**: Blocked until recorded.
- **Known limitation**: Not recorded yet.

### Restore Drill

- **Restore target**: Not recorded yet.
- **Command run**: Not recorded yet.
- **Evidence location**: Not recorded yet.
- **Environment**: Not recorded yet.
- **Generated state restored**: Not recorded yet.
- **Verification**: Not recorded yet.
- **No secret output printed**: Not recorded yet.
- **Status**: Blocked until recorded.
- **Known limitation**: Not recorded yet.

### Diagnostics

- **Command run**: Not recorded yet.
- **Evidence location**: Not recorded yet.
- **Environment**: Not recorded yet.
- **Sanitized result**: Not recorded yet.
- **Status**: Blocked until recorded.
- **Known limitation**: Not recorded yet.

### GitHub Repository Polish

- **Description reviewed**: Not recorded yet.
- **Topics reviewed**: Not recorded yet.
- **Default branch and CI visibility reviewed**: Not recorded yet.
- **Evidence location**: Not recorded yet.
- **Status**: Blocked until recorded.

### Known Limitations

List accepted public alpha limitations. Keep this public-safe and avoid private
deployment details.

- Not recorded yet. Public alpha limitations must be reviewed and recorded
  before release.

## Reviewer Sign-Off

- **Foundation gates complete**: No - validation evidence incomplete.
- **Public docs reviewed for stale promises**: Not recorded yet.
- **Secrets and private host details removed**: Not recorded yet.
- **Ready for public alpha tag**: No - validation evidence incomplete.
