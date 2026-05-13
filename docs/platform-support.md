# Platform Support

ChimerAI is currently targeting a single-server Linux deployment path for public
alpha proof. Public docs should only describe a path as validated after a
matching completed [public alpha validation record](public-alpha-validation-record.md)
exists.

## Status Definitions

- **Validated alpha path**: exercised as the current end-to-end public alpha path
  and backed by a completed public alpha validation record.
- **Validation target**: intended proof path for the current release candidate,
  but not validated until the record passes.
- **Current proof target**: the specific OS or environment selected for the
  current release-candidate validation record.
- **Target family**: intended to work in the project direction, but not yet
  validated end to end.
- **Proof environment**: useful for disposable validation, but not itself a
  deployment support promise.
- **Unvalidated**: not tested enough to make a support promise.
- **Unsupported**: outside the current deployment target.
- **CI only**: used for syntax, lint, or dry-run checks; not a deployment
  support claim.

## Deployment Targets

| Platform or path | Status | Notes |
| --- | --- | --- |
| Single Linux server | Validation target | Current public alpha proof path until the validation record passes. |
| Ubuntu Server 24.04 | Current proof target | Intended fresh-server validation environment for the single-server path. |
| Other Linux server distributions | Target family | Intended target family, but unvalidated until fresh-server records exist. |
| Multi-server deployment | Unvalidated | Later direction. Current roles and examples focus on one server. |
| Desktop operating systems as deployment targets | Unsupported | ChimerAI does not promise support for desktop OS deployment targets. |

## Control and Proof Environments

| Platform or path | Status | Notes |
| --- | --- | --- |
| Ubuntu Server 24.04 fresh-server environment | Current proof target | Current release-candidate validation target. This is not an Ubuntu-only long-term support promise. |
| Incus Linux container or VM | Proof environment | Useful as a disposable Linux-server proof target. Incus itself is not a ChimerAI deployment support promise. Do not treat Incus-specific setup as required for users. |
| Non-Linux controller or provisioning paths | Unvalidated | The first full path is a Linux server workflow. Non-Linux controller paths need explicit validation before docs can recommend them. |

## CI

CI can validate syntax, formatting, and dry-run behavior, but CI does not prove a
deployment target by itself. Public support claims require a validation record
against a real or disposable Linux server environment.

## Current Alpha Boundary

The first complete ChimerAI path is a single Linux server. Ubuntu Server 24.04
is the current fresh-server proof target for the release candidate. That path is
not a validated alpha path until the public alpha validation record is complete
and passes. Incus may be used to create disposable Linux server proof
environments, but Incus-specific behavior is not part of the public deployment
support contract.
