# ChimerAI

> Ansible-first, Compose-visible homelab foundation for AI services, agents,
> MCP tools, automation, and secure operations.

[![Project status: prototype alpha](https://img.shields.io/badge/status-prototype%20alpha-orange)](docs/milestones/README.md)
[![Ansible first](https://img.shields.io/badge/Ansible-first-ee0000?logo=ansible&logoColor=white)](docs/architecture-map.md)
[![Docker Compose runtime](https://img.shields.io/badge/runtime-Docker%20Compose-2496ed?logo=docker&logoColor=white)](docs/architecture-map.md)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-blue)](LICENSE)

ChimerAI is for operators who want a reviewable, self-hosted control plane for
AI-adjacent infrastructure instead of a black-box appliance. It uses Ansible for
provisioning and lifecycle, keeps Docker Compose output inspectable, and treats
ingress, authentication, secrets, backup, restore, and diagnostics as foundation
work.

Status: prototype alpha. Use it only if you are comfortable reviewing Ansible,
Compose files, generated config, and host changes before applying them.
The first public alpha is not ready to tag until the release-readiness evidence
is complete.

## First 60 Seconds

| If you want to... | Start here |
| --- | --- |
| See what ChimerAI is | [Architecture map](docs/architecture-map.md) |
| Install the local tooling | [Quick start](#quick-start) |
| Understand current status | [Roadmap and milestones](docs/milestones/README.md) |
| Compare it with nearby projects | [Comparison guide](docs/comparison.md) |
| See planned demo evidence | [Demo and sample output](docs/demo-and-sample-output.md) |
| Check public-alpha readiness | [Alpha checklist](docs/public-alpha-checklist.md), [validation record](docs/public-alpha-validation-record.md), and [release notes draft](docs/releases/v0.1.0-alpha.md) |
| Contribute safely | [Contributing](CONTRIBUTING.md) and [agent context](docs/agents/) |
| Understand community scope | [Community readiness](docs/community-readiness.md) |

## What It Does Now

- Bootstraps repo-local tooling with `./install.sh`.
- Provides a `chimerai` CLI wrapper for validation and lifecycle tasks.
- Defines an Ansible-first foundation with visible Docker Compose runtime
  output.
- Documents current contracts for config, secrets, ingress, auth, role support,
  operations, and public alpha evidence.

## What It Is Not Yet

- Not production-ready.
- Not a broad app store.
- Not a GUI homelab OS.
- Not a managed cloud platform.
- Not a promise that every planned role or workflow is implemented.

## Quick Start

From a fresh checkout:

```bash
./install.sh
chimerai validate
```

`./install.sh` bootstraps local development tools and links the repo-local
`chimerai` command. It does not deploy services, create encrypted config, or
edit shell startup files.

Before applying anything to a host, read:

- [Installation](docs/installation.md)
- [Configuration and secrets](docs/configuration-and-secrets.md)
- [Auth and ingress](docs/auth-and-ingress.md)
- [Platform support](docs/platform-support.md)

## System Shape

ChimerAI separates four concerns:

- Host provisioning and prerequisites.
- Service deployment through generated, inspectable Docker Compose.
- Integration wiring for ingress, authentication, secrets, state, and backup.
- Diagnostics and validation paths for operators and contributors.

See [Architecture map](docs/architecture-map.md) for the compact system view.

## Roadmap

The public roadmap source of truth is [docs/milestones/README.md](docs/milestones/README.md).
The README intentionally does not duplicate that list.

Release-readiness docs:

- [Public alpha evidence checklist](docs/public-alpha-checklist.md)
- [Public alpha validation record](docs/public-alpha-validation-record.md)
- [v0.1.0-alpha release notes draft](docs/releases/v0.1.0-alpha.md)

## Project Docs

- [Architecture map](docs/architecture-map.md)
- [Comparison guide](docs/comparison.md)
- [Demo and sample output](docs/demo-and-sample-output.md)
- [Public alpha evidence checklist](docs/public-alpha-checklist.md)
- [Operations](docs/operations/README.md)
- [Role catalog](docs/role-catalog.md)
- [Community readiness](docs/community-readiness.md)
- [Architecture decisions](docs/adr/)
- [Agent context](docs/agents/)

## License

Apache License 2.0. See [LICENSE](LICENSE).
