# ChimerAI

> A modular self-hosted AI homelab stack for agents, MCP tools, automation, and secure operations.

[![Project status: design prototype](https://img.shields.io/badge/status-design%20prototype-orange)](#status)
[![Ansible first](https://img.shields.io/badge/Ansible-first-ee0000?logo=ansible&logoColor=white)](#what-it-is)
[![Docker Compose runtime](https://img.shields.io/badge/runtime-Docker%20Compose-2496ed?logo=docker&logoColor=white)](#what-it-is)
[![Target OS: Ubuntu 24.04](https://img.shields.io/badge/target-Ubuntu%2024.04-e95420?logo=ubuntu&logoColor=white)](#roadmap)
[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-blue)](LICENSE)

ChimerAI is an early-stage infrastructure project for people who want their AI
tools to work together instead of living as disconnected Docker examples.

The goal is to make it practical to deploy and operate a private AI stack that
can run agent runtimes, MCP servers, workflow automation, model gateways,
memory systems, document ingestion, secure ingress, backups, and diagnostics
from one reproducible control plane.

ChimerAI is inspired by mature homelab projects like Saltbox, but it is not a
media-server stack and it is not a fork. It targets the AI-era version of the
same problem: many powerful services, many sharp edges, and too much glue code.

## At A Glance

- **One control plane:** Ansible-first lifecycle for setup, deployment,
  validation, backup, and recovery.
- **Compose-native runtime:** service definitions stay visible and debuggable.
- **AI stack focus:** agents, MCP servers, model gateways, automation, memory,
  document pipelines, and operations tooling.
- **Homelab-first:** designed for a VPS or home server, not a cloud-only SaaS
  workflow.
- **Secure by design:** ingress, auth, remote access, and exposure policy are
  first-class concerns.
- **AI-first development:** built so humans can direct coding agents through
  provider-neutral repo instructions.

## Status

ChimerAI is in design/prototype stage.

This repository is being built in public from a real working deployment. The
first milestone is a small Ansible-first proof of concept. Do not use this yet
for production systems unless you are comfortable reading the code and helping
shape the project.

## Why ChimerAI?

Self-hosted AI has a packaging problem.

There are excellent tools for chat, local models, workflow automation, RAG,
browser control, task management, calendars, memory, and MCP. But deploying
them as a coherent system still usually means manually combining:

- Docker Compose files from many projects
- reverse proxy and TLS configuration
- authentication and SSO
- model provider secrets
- local and API model routing
- MCP server wiring
- OAuth flows for calendars, tasks, email, and files
- backup and restore boundaries
- health checks and diagnostics
- safe remote access

ChimerAI aims to make that stack reproducible, inspectable, and operable.

## What It Is

ChimerAI is planned as an Ansible-first deployment framework that keeps Docker
Compose as the service runtime.

Ansible should own:

- host bootstrap
- users, directories, permissions, and packages
- Docker and network setup
- config and secret template rendering
- app lifecycle commands
- firewall and ingress setup
- backups and restore workflows
- diagnostics and validation

Docker Compose should remain visible:

- app services stay understandable
- users can inspect and debug containers directly
- community contributors can adapt existing Compose examples
- advanced users can override service definitions without fighting a black box

## What It Is Not

ChimerAI is not:

- a Kubernetes distribution
- a hosted SaaS platform
- a single monolithic AI app
- another "one huge compose file" demo
- a replacement for every app's native UI
- a promise that all AI tools should be exposed publicly

The goal is operational glue, not hiding the system from the operator.

## Target Users

ChimerAI is for:

- homelab operators who want a private AI stack
- developers running agent tooling on a VPS or home server
- people experimenting with MCP servers and agent runtimes
- users who want secure remote access to AI tools
- operators who care about backup, restore, and diagnostics from day one

It is probably not for someone who only wants to run a single local chat UI.

## Planned Architecture

```text
ChimerAI
  -> host provisioning
  -> Docker and networks
  -> ingress and authentication
  -> agent runtimes
  -> MCP tools
  -> model gateways and local models
  -> workflow automation
  -> memory and document pipelines
  -> backup, restore, and diagnostics
```

The expected repository shape is:

```text
.
├── ansible.cfg
├── chimerai.yml
├── inventories/
│   ├── examples/
│   └── local/
├── roles/
│   ├── common/
│   ├── docker/
│   ├── networks/
│   ├── traefik/
│   ├── authentik/
│   ├── hermes/
│   ├── n8n/
│   ├── mcp_todoist/
│   ├── mcp_google_workspace/
│   ├── backup/
│   └── diag/
├── docs/
└── bin/
    └── chimerai
```

The `chimerai` command is planned as a thin wrapper around Ansible, not a
second orchestration system.

## Initial App Categories

ChimerAI will start small. The public app catalog should grow only after the
core lifecycle is reliable.

Planned categories:

- **Core:** Docker, networks, backup, diagnostics
- **Ingress and Auth:** Traefik, Caddy, Authentik, Authelia
- **Remote Access:** Tailscale, Cloudflare Tunnel, Cloudflare DNS/firewall
- **Agent Runtimes:** Hermes Agent, Open WebUI, OpenClaw-compatible runtimes
- **MCP Servers:** Google Workspace, Todoist, Playwright, GitHub, filesystem
- **Model Layer:** Ollama, LiteLLM, OpenRouter/API-provider configuration
- **Automation:** n8n, Node-RED, Activepieces
- **Memory and Knowledge:** Honcho, vector stores, document ingestion tools
- **Operations:** Dockge, Dozzle, Uptime Kuma, Prometheus/Grafana

## Design Principles

- **Composable:** enable the pieces you want; skip the rest.
- **Inspectable:** generated Compose and env files should be easy to read.
- **Secure by default:** do not expose internal services without a deliberate
  ingress and auth policy.
- **App-local state:** runtime data should live in predictable directories,
  not opaque Docker volumes.
- **One control plane:** prefer Ansible roles and tags over multiple competing
  orchestration systems.
- **Validation matters:** every service role should have a health check or
  diagnostic path.
- **Escape hatches are allowed:** advanced users should be able to override
  Compose, env, routing, and service choices.

## Planned User Experience

The intended install flow is:

```bash
git clone https://github.com/vpatel9202/ChimerAI.git
cd ChimerAI

cp inventories/examples/single-server.yml inventories/local/host_vars/localhost.yml

./bin/chimerai install core
./bin/chimerai install hermes mcp-todoist
./bin/chimerai validate
```

This command set does not exist yet. It describes the target interface for the
first proof of concept.

## AI-First Development

ChimerAI is intended to be built and operated with AI coding agents as a normal
part of the workflow.

The expected pattern is:

1. A human states intent, constraints, and acceptance criteria.
2. A coding agent inspects the repo, proposes or applies a focused change, and
   runs relevant validation.
3. A human reviews the diff, tests the behavior, and decides what ships.

The project is provider-neutral. Codex, Claude, Gemini, local models, and other
capable agents should all work from the same canonical instructions:

- [`AGENTS.md`](AGENTS.md) is the source of truth for agent behavior.
- [`CLAUDE.md`](CLAUDE.md) and [`GEMINI.md`](GEMINI.md) are thin import shims
  that load `AGENTS.md`; they do not define separate policy.
- [`docs/agents/`](docs/agents/) contains deeper topic-specific context that
  agents should read only when relevant.
- [`.local/`](docs/agents/local-workspace.md) is the ignored private workspace
  convention for local handoffs, private context, and operator-specific to-do
  lists.

Do not ask agents to summarize `AGENTS.md` into a separate instruction source.
The goal is for each tool to load the canonical instructions directly whenever
the tool supports it.

## Roadmap

### Milestone 0: Project Definition

- [x] Choose project name
- [x] Create initial README
- [ ] Define role contract
- [ ] Define inventory schema
- [x] Choose initial license
- [x] Add contribution guidelines
- [x] Add provider-neutral agent instructions
- [x] Add local workspace templates

### Milestone 1: Ansible Proof Of Concept

- [ ] Add `common` role
- [ ] Add `docker` role
- [ ] Add `networks` role
- [ ] Add `mcp_todoist` role
- [ ] Add `diag` role
- [ ] Validate a minimal install on Ubuntu 24.04

### Milestone 2: First Real Stack

- [ ] Add ingress profile
- [ ] Add authentication profile
- [ ] Add Hermes Agent role
- [ ] Add Google Workspace MCP role
- [ ] Add backup and restore workflows
- [ ] Document a complete fresh-server install

### Milestone 3: Public Alpha

- [ ] Publish example inventories
- [ ] Add CI validation
- [ ] Add issue templates
- [ ] Add security policy
- [ ] Add comparison guide against existing self-hosted AI stacks

## Comparison To Existing Projects

ChimerAI overlaps with projects such as n8n self-hosted AI starter kits,
local-AI Compose bundles, LLemonStack-style service catalogs, and Saltbox-style
homelab automation.

The intended difference is focus:

- not just AI demos
- not just local model chat
- not just workflow automation
- not just a service catalog

ChimerAI is intended to be an operations framework for self-hosted AI systems:
agents, MCP tools, secure access, memory, automation, backup, and diagnostics.

## Contributing

This project is not ready for broad contribution yet, but early design feedback
is welcome.

Good early contributions:

- propose role structure improvements
- identify existing projects worth integrating with instead of duplicating
- suggest app categories and profiles
- test the first proof of concept when available
- improve documentation clarity

## Name

A chimera is a composite creature. ChimerAI is a composite AI stack: agents,
models, tools, automations, memory, and infrastructure blended into one
operable system.

## License

ChimerAI is licensed under the [Apache License 2.0](LICENSE).
