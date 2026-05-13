# ChimerAI

> Self-hosted AI operations foundation for agents, MCP tools, automation, and secure operations.

[![Project status: prototype alpha](https://img.shields.io/badge/status-prototype%20alpha-orange)](#current-alpha-status)
[![Ansible first](https://img.shields.io/badge/Ansible-first-ee0000?logo=ansible&logoColor=white)](#architecture-summary)
[![Docker Compose runtime](https://img.shields.io/badge/runtime-Docker%20Compose-2496ed?logo=docker&logoColor=white)](#architecture-summary)
[![Target OS: Ubuntu 24.04](https://img.shields.io/badge/target-Ubuntu%2024.04-e95420?logo=ubuntu&logoColor=white)](#current-alpha-status)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-blue)](LICENSE)

ChimerAI is a self-hosted AI operations foundation: the repeatable control
plane, runtime layout, and operator workflow for running AI services on your
own infrastructure.

It focuses first on the parts every serious self-hosted AI stack needs:

- auth and protected app access;
- public ingress and TLS;
- encrypted secrets and reproducible config;
- lifecycle commands for validate, apply, remove, backup, and restore;
- predictable app-local state;
- diagnostics and health checks;
- backup and restore boundaries;
- visible Docker Compose output instead of opaque orchestration.

Status: ChimerAI is prototype/alpha software. It is useful for careful
operators who are comfortable reviewing Ansible, Docker Compose, generated
config, and host changes. It is not production-ready.

## What ChimerAI Is

ChimerAI is not a generic app bundle. The app roles are examples and
integrations that prove the foundation: Traefik, Authentik, OpenClaw,
Open WebUI, Ollama, LiteLLM, Qdrant, n8n, Langfuse, and MCP services sit on top
of the same operator model.

The project is inspired by mature homelab stacks, but it targets the AI-era
operational problem: agents, MCP servers, model providers, workflow automation,
memory, ingress, auth, backups, diagnostics, and secret handling under one
inspectable control plane.

## What It Gives Operators

ChimerAI gives operators a repo-local way to:

- initialize encrypted local config with SOPS and age;
- validate host and config assumptions before deployment;
- generate and run Docker Compose through Ansible roles;
- expose selected services through Traefik and shared Authentik forward auth;
- keep service state under predictable app-local paths;
- run backup and restore actions for configured state;
- keep AI-coding-agent instructions provider-neutral;
- separate public project defaults from private deployment context.

## Current Alpha Status

Current state: ChimerAI can bootstrap local control tooling, create an
encrypted private config file, validate the host, deploy/remove an early
single-server stack, and run a first Restic-backed backup/restore flow for
bind-mounted state.

The current alpha is best treated as an inspectable foundation for careful
operators, not a turnkey production platform.

## Supported Platforms And Requirements

- Primary tested target: Ubuntu 24.04 on a single Linux server.
- Target family: Linux hosts. Multi-server deployments are not validated yet.
- macOS: controller tooling only; service roles are not validated on macOS.
- Windows: not validated.
- Public ingress: a real domain pointed at the host, with ports `80` and `443`
  reachable for Traefik and Let's Encrypt.

## Quick Start

```bash
git clone https://github.com/vpatel9202/ChimerAI.git
cd ChimerAI
./install.sh
chimerai config init
chimerai validate
```

When you are ready to deploy the configured proof of concept:

```bash
chimerai apply
```

The default public-ingress template expects a real domain pointed at the host,
ports `80` and `443` reachable from the internet, and `chimerai_acme_email`
set for Let's Encrypt. The template starts with Let's Encrypt staging enabled
so first runs do not burn certificate rate limits.

To remove ChimerAI-managed services:

```bash
chimerai remove
```

To back up or restore configured state after you have enabled
`chimerai_backup` in the encrypted config:

```bash
chimerai backup
chimerai restore
```

The installer does not deploy services. It prepares local tooling, links the
`chimerai` command into `~/.local/bin`, installs Python/Ansible dependencies,
and installs `sops`/`age` if they are missing.

See [Installation](docs/installation.md) for details and troubleshooting.

## Current Foundation Capabilities

Available now:

- repo-local bootstrap with [install.sh](install.sh);
- `chimerai` CLI wrapper for config initialization, editing, validation,
  apply, remove, backup, and restore;
- SOPS + age encrypted private config at
  `inventories/local/chimerai.sops.yaml`;
- Ansible-driven lifecycle through `chimerai.yml`;
- Docker Compose as the visible service runtime;
- Traefik public ingress with Let's Encrypt HTTP-01 certificate management;
- Authentik as the shared forward-auth layer for protected apps;
- Authentik app, proxy provider, and embedded outpost automation for managed
  protected apps;
- predictable app-local bind mounts for ChimerAI-managed service state;
- Restic-backed backup and restore actions for configured state;
- diagnostics role and validation paths for the current stack.

## Optional And Reference Integrations

These roles are part of the current alpha surface, but they should be read as
optional/reference integrations on top of the foundation:

- OpenClaw gateway deployment plus `chimerai openclaw onboard` helper;
- Open WebUI chat interface;
- host-installed Codex, Claude Code, Gemini CLI, and OpenCode role with
  user-scoped npm paths;
- containerized runner for Codex, Claude Code, Gemini CLI, and OpenCode with
  an explicit workspace mount;
- Ollama local model runtime with loopback API exposure and bind-mounted model
  state;
- LiteLLM model gateway with Postgres-backed proxy state;
- Qdrant vector storage with loopback HTTP and gRPC exposure;
- n8n workflow automation with Postgres-backed state;
- Langfuse LLM observability stack with Postgres, ClickHouse, Redis, and
  MinIO-backed state;
- MCP roles for Todoist, filesystem, Playwright browser automation,
  Chrome DevTools, Firecrawl, and gateway/profile wiring.

## Architecture Summary

ChimerAI is Ansible-first and Compose-visible.

The foundation layers are:

- **Control plane:** repo-local `chimerai` wrapper plus Ansible playbooks and
  roles.
- **Ingress and auth:** Traefik for public routing, TLS, and Authentik
  forward-auth.
- **Secrets and config:** SOPS + age encrypted local config and explicit
  inventory variables.
- **Service runtime:** generated Docker Compose projects that remain readable
  and debuggable.
- **State and backup:** predictable app-local state directories and Restic
  backup/restore actions.
- **Diagnostics:** validation, health checks, and role-specific diagnostics as
  first-class workflow.

Key project choices:

- **Ansible instead of a custom orchestrator:** Ansible is inspectable and
  already good at host state.
- **Docker Compose instead of Kubernetes:** Compose fits the current
  single-server homelab target and is easy to debug.
- **SOPS + age for secrets:** users get one private YAML config file while
  sensitive values stay encrypted at rest.
- **App-local state instead of opaque Docker volumes:** runtime files should
  be easy to find, inspect, back up, and migrate.
- **Provider-neutral agent instructions:** Codex, Claude, Gemini, local
  models, and other coding agents should all read the same project policy.

See [Architecture Decision Records](docs/adr/) for durable rationale.

## Roadmap

The detailed roadmap lives in [docs/milestones/](docs/milestones/).

Current roadmap pointers:

- [Milestone 2 Stack Plan](docs/milestones/0002-first-real-stack.md): current
  foundation stack and reference integrations.
- [Public Alpha Plan](docs/milestones/0003-public-alpha.md): release-readiness
  gates before a first public alpha tag.
- [MCP and Agent Catalog Plan](docs/milestones/0004-mcp-and-agent-catalog.md):
  planned MCP/runtime expansion.
- [Operations Maturity Plan](docs/milestones/0005-operations-maturity.md):
  planned update, diagnostics, recovery, and operational maturity work.

Core reference docs:

- [Installation](docs/installation.md): bootstrap a fresh local checkout.
- [Configuration and Secrets](docs/configuration-and-secrets.md): encrypted
  config, SOPS, age, and editing secrets.
- [Inventory Schema](docs/inventory-schema.md): current variable shape.
- [Role Contract](docs/role-contract.md): expectations for future roles.
- [Public Alpha Checklist](docs/public-alpha-checklist.md): release gates and
  trust criteria for a public alpha tag.
- [Architecture Decisions](docs/adr/): why major choices were made.
- [Agent Context](docs/agents/): instructions for AI coding agents.

## Contributing

ChimerAI is early. Good contributions are small, reviewable, and honest about
what is implemented versus planned.

Useful first contributions:

- improve docs;
- add validation around existing roles;
- propose narrowly scoped roles;
- test the install flow on a fresh Ubuntu 24.04 host;
- write ADRs for major design changes before implementing them.

See [CONTRIBUTING.md](CONTRIBUTING.md) and [AGENTS.md](AGENTS.md) before
opening a pull request.

Agent-facing project policy is provider-neutral: [AGENTS.md](AGENTS.md) is the
source of truth, and [CLAUDE.md](CLAUDE.md) plus [GEMINI.md](GEMINI.md) are thin
import shims.

## License

ChimerAI is licensed under the [Apache License 2.0](LICENSE).

## Name

The name ChimerAI combines "chimera" with AI: a modular system made from many
specialized parts that should behave as one coherent operator stack.
