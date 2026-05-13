# Public Alpha Validation Record

This is the public release-candidate evidence record and reusable template for
tagging a public alpha release. It is not proof by itself.

Blank fields, `TBD` entries, or placeholder values mean the public alpha is not
ready. Do not tag a public alpha release until every required field is filled
with sanitized evidence and the reviewer sign-off says the release is ready.

Keep only sanitized placeholders and sanitized results here. Do not include real
domains, credentials, private inventory values, age identities, Restic passwords,
API keys, hostnames that identify a private deployment, or `.local/` content. Do
not fill expected or assumed results as evidence.

## Release Candidate

- **Release candidate**:
- **Date**:
- **Reviewer**:
- **Commit or tag**:
- **Validation target**: single Linux server, currently Ubuntu Server 24.04.
- **Inventory class**: sanitized example, such as `single-server`.

## Environment

- **OS**:
- **CPU/RAM class**:
- **Disk class**:
- **Network shape**:
- **Execution context**: local shell, SSH session, CI dry run, or disposable
  proof environment.
- **Notes**:

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

- **Command run**:
- **Environment**:
- **Sanitized result**:
- **Status**:
- **Known limitation**:

### Validate

- **Command run**:
- **Environment**:
- **Sanitized result**:
- **Status**:
- **Known limitation**:

### First Apply

- **Command run**:
- **Environment**:
- **Sanitized result**:
- **Status**:
- **Known limitation**:

### Second Apply Idempotency

- **Command run**:
- **Environment**:
- **Sanitized result**:
- **Material change review**:
- **Status**:
- **Known limitation**:

### Backup

- **Command run**:
- **Environment**:
- **Sanitized result**:
- **Restic snapshot listed**:
- **Generated state included**:
- **No secret output printed**:
- **Status**:
- **Known limitation**:

### Restore Drill

- **Restore target**:
- **Command run**:
- **Environment**:
- **Generated state restored**:
- **Verification**:
- **No secret output printed**:
- **Status**:
- **Known limitation**:

### Diagnostics

- **Command run**:
- **Environment**:
- **Sanitized result**:
- **Status**:
- **Known limitation**:

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
