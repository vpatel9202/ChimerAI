# Platform Support

ChimerAI is an alpha project. This page is the canonical support matrix for
deployment and validation claims.

## Status Definitions

- **Validated alpha path**: exercised as the current end-to-end alpha path.
- **Target family**: intended to work in the project direction, but not yet
  validated end to end.
- **Unvalidated**: not tested enough to make a support promise.
- **Unsupported**: outside the current deployment target.
- **CI only**: used for syntax, lint, or dry-run checks; not a deployment
  support claim.

## Deployment Targets

| Platform or path | Status | Notes |
| --- | --- | --- |
| Single-server deployment model | Validated alpha path | First full deployment model for ChimerAI alpha. Current validation records specifically use Ubuntu Server 24.04. |
| Other Linux server distributions | Target family | Intended target family, but unvalidated until fresh-host records exist. |
| Multi-server deployment | Unvalidated | Post-alpha direction. Current roles and examples focus on one server. |
| Desktop operating systems as deployment targets | Unsupported | ChimerAI does not promise support for desktop OS deployment targets. |

## Control and Evaluation Environments

| Platform or path | Status | Notes |
| --- | --- | --- |
| Ubuntu Server 24.04 fresh-host validation environment | Validated alpha path | Current validation records use this environment. This is not an Ubuntu-only support promise. |
| Non-Linux controller or provisioning paths | Unvalidated | The first full path is a Linux server workflow. Non-Linux controller paths need explicit validation before docs can recommend them. |

## CI

| Platform or path | Status | Notes |
| --- | --- | --- |
| GitHub Actions `ubuntu-latest` | CI only | Useful for syntax and dry-run checks. It is not a substitute for a fresh-host deployment validation. |

## Current Alpha Boundary

The first complete ChimerAI path is a single Linux server. Ubuntu Server 24.04
is the current fresh-host validation environment because that is where the
project records alpha checks today. Other Linux server distributions remain in
the target family, but they need their own validation records before the project
can describe them as validated.
