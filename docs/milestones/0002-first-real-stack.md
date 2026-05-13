# Milestone 2: Full Stack Foundation

Milestone 2 is the first ChimerAI foundation milestone. It starts with the
implemented control plane, Traefik, Authentik, backup, and diagnostics work,
then expands into the core layers needed for an AI operations platform.

The milestone is split into sub-milestones so each layer can be designed,
validated, and documented without hiding too much behavior behind one generic
role. App roles such as OpenClaw, Open WebUI, model services, automation
services, and MCP services are reference integrations on top of the foundation.

## 2A: Core Ingress And Identity

Status: available now.

- Traefik is the public HTTPS entrypoint.
- Let's Encrypt HTTP-01 is the default ACME flow.
- Authentik protects routed applications by default.
- Authentik's own admin and outpost paths are not protected by forward-auth.
- OpenClaw is the first agent runtime and uses the prebuilt
  `ghcr.io/openclaw/openclaw` image.
- OpenClaw onboarding runs through `chimerai openclaw onboard`.
- Open WebUI remains the first general chat UI.
- Persistent Docker data uses bind mounts under `chimerai_state_root`.

## 2B: Operator Agent CLI Layer

Status: available now.

The `agent_cli` role installs operator-facing coding agents:

- Codex
- Claude Code
- Gemini CLI
- OpenCode

The default install mode is host-based, user-scoped, and reversible. These CLIs
are operator tools, not long-running services, and they need useful access to
the checkout, shell, Git, and local auth flows.

Containerized variants are optional runner profiles, not the default
interactive path.

## 2C: Model Layer

Status: available now.

- Ollama is implemented as the first local model runtime.
- LiteLLM is implemented as the first model gateway for provider routing and
  OpenAI-style compatibility.
- Model endpoint consumption remains a shared integration boundary for Open
  WebUI, OpenClaw, and future roles.

## 2D: MCP Core Layer

Status: available now.

The MCP core should prioritize broadly useful tools before niche integrations:

- `mcp_gateway`: implemented as a local catalog writer and shared OpenClaw MCP
  registry source.
- `mcp_filesystem`: implemented with explicit workspace/path allowlists.
- `mcp_browser`: implemented with Playwright-based browser automation.
- `mcp_chrome_devtools`: implemented with Chrome DevTools debugging,
  inspection, screenshots, and performance tracing.
- `mcp_firecrawl`: implemented for scraping, crawling, and structured
  extraction, including the current Firecrawl-backed search capability.
- `mcp_todoist`: specialized proof and example role.

There is no separate `mcp_search` role in the current implementation. Todoist
remains valuable as a real MCP proof, but filesystem, browser, Chrome DevTools,
and Firecrawl are higher-priority general-purpose tools.

## 2E: Automation And Observability

Status: available now.

- n8n is implemented for workflow automation.
- Langfuse is implemented for LLM tracing, prompt visibility, and evaluation
  workflows.
- Qdrant is implemented as the first vector storage role.

These roles make ChimerAI useful beyond a chat UI: workflows can run, agent
behavior can be inspected, and retrieval-backed apps have a storage primitive.

## 2F: Safety And Operations Foundation

Status: in progress.

- Define a secrets and credential boundary so roles receive only the keys they
  need.
- Notification wiring is planned for failed validation, backup failures, restore
  drills, and completed agent workflows.
- `runner` profiles are in progress for controlled execution in Docker, Incus,
  and future cloud sandboxes.
- Complete fresh-host validation for the expanded Milestone 2 stack.

## State Layout

Generated service config lives under:

```text
/opt/chimerai/<service>/
```

Persistent app data lives under:

```text
/opt/chimerai/apps/<service>/
```

Examples:

```text
/opt/chimerai/traefik/compose.yml
/opt/chimerai/apps/traefik/acme/acme.json
/opt/chimerai/apps/authentik/postgresql/
/opt/chimerai/apps/authentik/redis/
/opt/chimerai/apps/openclaw/config/
/opt/chimerai/apps/openclaw/workspace/
/opt/chimerai/apps/mcp-todoist/npm-cache/
```

Named Docker volumes are not used for ChimerAI-managed persistence.

## Boundaries

- Service roles are Docker Compose-native by default.
- Operator CLI roles are host-installed by default, user-scoped, and validated.
- Runner profiles provide optional containerized or isolated execution.
- MCP services are private by default and should use explicit profiles,
  allowlists, and secrets.
- Provider secrets stay app-local until multiple real roles need shared
  provider inheritance.
- App roles are optional/reference integrations on top of the foundation, not
  the product identity by themselves.

## Acceptance Criteria

- `chimerai validate` succeeds with the expanded config shape.
- `chimerai apply` renders and starts the enabled service roles.
- OpenClaw can receive managed MCP entries for enabled MCP roles.
- Agent CLIs install in user-scoped host paths and report versions.
- Model endpoints are documented and consumable by Open WebUI and OpenClaw.
- MCP filesystem, browser, Chrome DevTools, and Firecrawl capabilities have
  explicit safety boundaries.
- Backup, diagnostics, notifications, and runner documentation cover the
  expanded stack.
