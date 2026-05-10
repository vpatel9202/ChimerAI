# Milestone 2: Full Stack Foundation

Milestone 2 is the first ChimerAI "full stack" milestone. It starts with the
implemented Traefik, Authentik, OpenClaw, Open WebUI, Todoist MCP, backup, and
diagnostics work, then expands into the core layers needed for an AI homelab
stack.

The milestone is split into sub-milestones so each layer can be designed,
validated, and documented without hiding too much behavior behind one generic
role.

## 2A: Core Ingress And Identity

Status: in progress.

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

Status: planned.

Add an `agent_cli` role for operator-facing coding agents:

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

Status: planned.

- Add Ollama as the first local model runtime.
- Add LiteLLM as the first model gateway for provider routing and OpenAI-style
  compatibility.
- Document how Open WebUI, OpenClaw, and future roles consume local and remote
  model endpoints.

## 2D: MCP Core Layer

Status: partially implemented.

The MCP core should prioritize broadly useful tools before niche integrations:

- `mcp_gateway`: implemented as a local catalog writer and shared OpenClaw MCP
  registry source.
- `mcp_filesystem`: implemented with explicit workspace/path allowlists.
- `mcp_browser`: implemented with Playwright-based browser automation.
- `mcp_search`: implemented through Firecrawl's search-capable MCP tools.
- `mcp_firecrawl`: implemented for scraping, crawling, and structured
  extraction.
- `mcp_todoist`: specialized proof and example role.

Todoist remains valuable as a real MCP proof, but filesystem, browser/search,
and Firecrawl are higher-priority general-purpose tools.

## 2E: Automation And Observability

Status: planned.

- Add n8n for workflow automation.
- Add Langfuse for LLM tracing, prompt visibility, and evaluation workflows.
- Add Qdrant as the first vector storage role. Implemented.

These roles make ChimerAI useful beyond a chat UI: workflows can run, agent
behavior can be inspected, and retrieval-backed apps have a storage primitive.

## 2F: Safety And Operations Foundation

Status: planned.

- Define a secrets and credential boundary so roles receive only the keys they
  need.
- Add notifications for failed validation, backup failures, restore drills, and
  completed agent workflows.
- Add `runner` profiles for controlled execution in Docker, Incus, and future
  cloud sandboxes.
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

## Acceptance Criteria

- `chimerai validate` succeeds with the expanded config shape.
- `chimerai apply` renders and starts the enabled service roles.
- OpenClaw can receive managed MCP entries for enabled MCP roles.
- Agent CLIs install in user-scoped host paths and report versions.
- Model endpoints are documented and consumable by Open WebUI and OpenClaw.
- MCP filesystem, browser, search, and Firecrawl roles have explicit safety
  boundaries.
- Backup, diagnostics, notifications, and runner documentation cover the
  expanded stack.
