# ChimerAI

> A modular self-hosted AI homelab stack for agents, MCP tools, automation, and secure operations.

[![Project status: design prototype](https://img.shields.io/badge/status-design%20prototype-orange)](#status)
[![Ansible first](https://img.shields.io/badge/Ansible-first-ee0000?logo=ansible&logoColor=white)](#architecture)
[![Docker Compose runtime](https://img.shields.io/badge/runtime-Docker%20Compose-2496ed?logo=docker&logoColor=white)](#architecture)
[![Target OS: Ubuntu 24.04](https://img.shields.io/badge/target-Ubuntu%2024.04-e95420?logo=ubuntu&logoColor=white)](#status)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-blue)](LICENSE)

ChimerAI is an early-stage infrastructure project for people who want their AI
tools to work together instead of living as disconnected Docker examples.

It is inspired by mature homelab projects like Saltbox, but it targets the
AI-era version of that problem: agents, MCP servers, model providers, workflow
automation, memory, ingress, auth, backups, and diagnostics under one
reproducible control plane.

## Quick Start

Current state: ChimerAI can bootstrap local control tooling, create an
encrypted private config file, validate the host, deploy/remove an early
single-server stack with Traefik, Authentik, OpenClaw, and Open WebUI, and run
a first Restic-backed backup/restore flow for bind-mounted state.

```bash
git clone https://github.com/vpatel9202/ChimerAI.git
cd ChimerAI
./install.sh
chimerai config init
chimerai validate
```

When you are ready to deploy the current proof of concept:

```bash
chimerai apply
```

The default public-ingress template expects a real domain pointed at the host,
ports `80` and `443` reachable from the internet, and `chimerai_acme_email`
set for Let's Encrypt. The template starts with Let's Encrypt staging enabled
so first runs do not burn production certificate rate limits.

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

The installer does not deploy services. It only prepares local tooling, links
the `chimerai` command into `~/.local/bin`, installs Python/Ansible
dependencies, and installs `sops`/`age` if they are missing.

See [Installation](docs/installation.md) for details and troubleshooting.

## Current Capabilities

Available now:

- repo-local bootstrap with [install.sh](install.sh);
- `chimerai` CLI wrapper for config initialization, editing, validation,
  apply, remove, backup, and restore;
- SOPS + age encrypted private config at
  `inventories/local/chimerai.sops.yaml`;
- Ansible roles for `common`, `docker`, `networks`, `traefik`, `authentik`,
  `backup`, `openclaw`, `mcp_todoist`, `diag`, and `open_webui`;
- Traefik public ingress with Let's Encrypt HTTP-01 certificate management;
- Authentik as the shared forward-auth layer for Traefik-routed apps;
- Authentik app, proxy provider, and embedded outpost automation for managed
  protected apps;
- OpenClaw gateway deployment plus `chimerai openclaw onboard` helper;
- optional Todoist MCP server role on a private MCP network with loopback host
  access for local agents;
- automatic OpenClaw MCP registry wiring for the Todoist MCP server when both
  roles are enabled;
- Docker Compose output for Open WebUI in a predictable deployment directory;
- app-local bind-mounted state under the configured state root;
- Restic-backed backup and restore actions for alpha operators;
- GitHub Actions validation for shell syntax, Ansible syntax, and safe dry-run.

Still rough or intentionally incomplete:

- additional MCP server roles beyond Todoist;
- model provider abstraction or inherited API key configuration;
- fully automated OpenClaw provider onboarding;
- automated users, groups, policies, and external identity providers in
  Authentik;
- fully automated update lifecycle; rerun `chimerai apply` after changing
  config or image tags during alpha.

## Status

ChimerAI is in design/prototype stage. It is being built in public from lessons
learned on a real private homelab deployment, but the public repo is not yet a
complete turnkey AI stack.

Primary test target:

- Ubuntu 24.04
- Docker with Compose v2
- single-server homelab or VPS

Use it now if you are comfortable reading the code, reviewing generated
configuration, and helping shape the project. If you want a supported appliance,
wait for a later release.

## Why ChimerAI?

Self-hosted AI has a packaging problem.

There are excellent tools for chat, local models, workflow automation, RAG,
browser control, task management, calendars, memory, and MCP. But deploying
them as a coherent system still usually means manually combining:

- Docker Compose files from many projects;
- reverse proxy and TLS configuration;
- authentication and SSO;
- model provider secrets;
- local and API model routing;
- MCP server wiring;
- OAuth flows for calendars, tasks, email, and files;
- backup and restore boundaries;
- health checks and diagnostics;
- safe remote access.

ChimerAI aims to make that stack reproducible, inspectable, and operable.

## Architecture

ChimerAI is Ansible-first and Docker Compose-native.

Ansible owns lifecycle work:

- host bootstrap;
- users, directories, permissions, and packages;
- Docker and network setup;
- config and secret template rendering;
- app lifecycle commands;
- firewall and ingress setup;
- backups and restore workflows;
- diagnostics and validation.

Docker Compose stays visible because homelab operators need to debug real
containers with familiar tools. ChimerAI should generate understandable Compose,
not hide services behind an opaque abstraction.

The current shape is:

```text
.
├── install.sh
├── bin/
│   └── chimerai
├── ansible.cfg
├── chimerai.yml
├── inventories/
│   └── examples/
├── roles/
│   ├── common/
│   ├── docker/
│   ├── networks/
│   ├── traefik/
│   ├── authentik/
│   ├── backup/
│   ├── openclaw/
│   ├── mcp_todoist/
│   ├── diag/
│   └── open_webui/
├── templates/
│   └── config/
└── docs/
```

Planned role categories include ingress/auth, remote access, agent runtimes,
MCP servers, model gateways, local models, automation, memory, document
ingestion, backups, and operations tooling.

## Key Decisions

ChimerAI makes a few opinionated choices.

- **Ansible instead of a custom orchestrator:** Ansible is boring, inspectable,
  and already good at host state. The `chimerai` CLI is only a wrapper around
  common workflows.
- **Docker Compose instead of Kubernetes:** most homelab AI services already
  publish Compose examples, and Compose is easier for single-server operators
  to debug.
- **SOPS + age for secrets:** users get one private YAML config file while
  sensitive values stay encrypted at rest.
- **App-local state instead of opaque Docker volumes:** runtime files should
  be easy to find, inspect, back up, and migrate.
- **Provider-neutral agent instructions:** Codex, Claude, Gemini, local models,
  and other coding agents should all read the same project policy.

See [Architecture Decision Records](docs/adr/) for the durable rationale.

## Common Commands

Bootstrap local tooling:

```bash
./install.sh
```

Create encrypted local config:

```bash
chimerai config init
```

Edit encrypted config:

```bash
chimerai config edit
```

Validate the host and config:

```bash
chimerai validate
```

Apply the configured stack:

```bash
chimerai apply
```

Remove ChimerAI-managed services:

```bash
chimerai remove
```

Back up and restore ChimerAI-managed state:

```bash
chimerai backup
chimerai restore
```

Run the lower-level Ansible validation directly:

```bash
uv run ansible-playbook chimerai.yml --check
```

Run the generated OpenClaw tools container for first-time onboarding:

```bash
chimerai openclaw onboard
```

## Documentation

Start here:

- [Installation](docs/installation.md): bootstrap a fresh local checkout.
- [Configuration and Secrets](docs/configuration-and-secrets.md): encrypted
  config, SOPS, age, and editing secrets.
- [Inventory Schema](docs/inventory-schema.md): current variable shape.
- [Role Contract](docs/role-contract.md): expectations for future roles.
- [Milestones](docs/milestones/): current and planned roadmap documents.
- [Milestone 2 Stack Plan](docs/milestones/0002-first-real-stack.md): current
  Traefik + Authentik + OpenClaw stack rationale.
- [Public Alpha Plan](docs/milestones/0003-public-alpha.md): release-readiness
  work before a first public alpha tag.
- [MCP and Agent Catalog Plan](docs/milestones/0004-mcp-and-agent-catalog.md):
  planned MCP/runtime expansion.
- [Operations Maturity Plan](docs/milestones/0005-operations-maturity.md):
  planned update, diagnostics, and recovery work.
- [Architecture Decisions](docs/adr/): why major choices were made.
- [Agent Context](docs/agents/): instructions for AI coding agents.

## AI-First Development

ChimerAI is intended to be built and operated with AI coding agents as a normal
part of the workflow.

The expected pattern is:

1. A human states intent, constraints, and acceptance criteria.
2. A coding agent inspects the repo, proposes or applies a focused change, and
   runs relevant validation.
3. A human reviews the diff, tests the behavior, and decides what ships.

The project is provider-neutral:

- [AGENTS.md](AGENTS.md) is the source of truth for agent behavior.
- [CLAUDE.md](CLAUDE.md) and [GEMINI.md](GEMINI.md) are thin import shims that
  load `AGENTS.md`; they do not define separate policy.
- [docs/agents/](docs/agents/) contains deeper topic-specific context.
- `.local/` is the ignored private workspace convention for local handoffs,
  private context, and operator-specific to-do lists.

## Roadmap

### Milestone 0: Project Definition

- [x] Choose project name
- [x] Create initial README
- [x] Define role contract
- [x] Define inventory schema
- [x] Choose initial license
- [x] Add contribution guidelines
- [x] Add provider-neutral agent instructions
- [x] Add local workspace templates
- [x] Add parseable Ansible dry-run skeleton
- [x] Add CI validation for the dry-run skeleton
- [x] Add foundational architecture decision record

### Milestone 1: Ansible Proof Of Concept

- [x] Add `common` role
- [x] Add `docker` role
- [x] Add `networks` role
- [x] Add `open_webui` role
- [x] Add `diag` role
- [x] Validate a minimal install on Ubuntu 24.04
- [x] Define encrypted single-file configuration with SOPS + age
- [x] Add `bin/chimerai` wrapper for config init/edit/validate
- [x] Add repo-local bootstrap installer

### Milestone 2: Full Stack Foundation

Milestone 2 is split into sub-milestones so the "full stack" grows in layers
instead of one oversized role push.

#### 2A: Core Ingress And Identity

- [x] Add Traefik public ingress
- [x] Add Authentik shared auth
- [x] Add OpenClaw as the first agent runtime
- [x] Add Open WebUI as the first chat UI
- [x] Add backup, restore, and diagnostics foundations

#### 2B: Operator Agent CLI Layer

- [ ] Add `agent_cli` for Codex, Claude Code, Gemini CLI, and OpenCode
- [ ] Install agent CLIs on the host by default with user-scoped paths
- [ ] Document optional containerized runner mode for later sandbox use

#### 2C: Model Layer

- [ ] Add Ollama for local model runtime
- [ ] Add LiteLLM for model gateway, routing, and provider abstraction
- [ ] Document how Open WebUI and OpenClaw consume model endpoints

#### 2D: MCP Core Layer

- [ ] Add `mcp_gateway` for curated MCP profiles and runtime wiring
- [ ] Add `mcp_filesystem` with explicit workspace/path allowlists
- [ ] Add `mcp_browser` with Playwright-based browser automation
- [ ] Add `mcp_search` for general web search
- [ ] Add `mcp_firecrawl` for scraping, crawling, and extraction
- [x] Keep `mcp_todoist` as a specialized proof and example role

#### 2E: Automation And Observability

- [ ] Add n8n for workflow automation
- [ ] Add Langfuse for LLM traces, prompt visibility, and evaluations
- [ ] Add Qdrant as the first vector storage role

#### 2F: Safety And Operations Foundation

- [ ] Define the secrets and credential boundary across roles
- [ ] Add notifications for validation, backup, and agent workflow events
- [ ] Add `runner` profiles for Docker, Incus, and future cloud sandboxes
- [ ] Document and test a complete fresh-host install

### Milestone 3: Public Alpha

- [ ] Complete clean Ubuntu 24.04 install validation for the Milestone 2 stack
- [ ] Prove idempotent `apply` for the enabled alpha role set
- [ ] Prove backup and restore on generated bind-mounted state
- [ ] Finish public install, security, and troubleshooting docs
- [ ] Publish a comparison guide against adjacent self-hosted AI stacks
- [ ] Tag the first public alpha only after the checklist passes

### Milestone 4: MCP And Agent Runtime Catalog

- [ ] Expand beyond the Milestone 2 MCP core set
- [ ] Add more specialized MCP integrations with private-by-default exposure
- [ ] Add additional agent runtimes only after OpenClaw patterns are stable
- [ ] Improve MCP discovery, profiles, and tool permission policy
- [ ] Document safe read-only and mutating validation prompts per tool class

### Milestone 5: Operations Maturity

- [ ] Add an explicit update strategy for image tags and rendered config
- [ ] Expand diagnostics into actionable service-specific checks
- [ ] Add restore drills and operator runbooks
- [ ] Improve observability guidance for logs, health checks, and exposed ports
- [ ] Define remote access profiles after ingress/auth behavior is stable
- [ ] Mature notifications, audit, and runner/sandbox operations

### Later Milestones

- app catalog and role selection UX;
- memory and document-ingestion roles;
- multi-host or split-controller deployments;
- private deployment migration and dogfooding guides.

## Contributing

ChimerAI is not ready for broad contribution yet, but early design feedback is
welcome.

Good early contributions:

- propose role structure improvements;
- identify existing projects worth integrating instead of duplicating;
- suggest app categories and profiles;
- test the current proof of concept;
- improve documentation clarity.

Before proposing role changes, read [Role Contract](docs/role-contract.md) and
[Inventory Schema](docs/inventory-schema.md).

## Name

A chimera is a composite creature. ChimerAI is a composite AI stack: agents,
models, tools, automations, memory, and infrastructure blended into one
operable system.

## License

ChimerAI is licensed under the [Apache License 2.0](LICENSE).
