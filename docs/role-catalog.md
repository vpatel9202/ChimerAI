# Role Catalog

This catalog lists every tracked `roles/*` directory exactly once. Role tier and
support status are governance signals, not architecture layers.

Reference roles are examples that prove ChimerAI patterns on top of the
foundation. They are not equal-maintenance commitments.

Deprecated entries must include replacement and removal notes in this catalog.

## Core Roles

| Role | Tier | Status | Support owner | Purpose |
| --- | --- | --- | --- | --- |
| `roles/authentik` | `core` | `active` | Core maintainers | Shared authentication layer for routed apps. |
| `roles/backup` | `core` | `active` | Core maintainers | Restic-backed backup and restore workflow. |
| `roles/common` | `core` | `active` | Core maintainers | Baseline users, directories, packages, and host assumptions. |
| `roles/diag` | `core` | `active` | Core maintainers | Safe diagnostics and validation checks. |
| `roles/docker` | `core` | `active` | Core maintainers | Docker engine and Compose availability. |
| `roles/networks` | `core` | `active` | Core maintainers | Shared Docker networks used by service roles. |
| `roles/traefik` | `core` | `active` | Core maintainers | Public ingress, TLS, ACME state, and routing defaults. |

## Reference Roles

| Role | Tier | Status | Support owner | Purpose |
| --- | --- | --- | --- | --- |
| `roles/agent_cli` | `reference` | `best-effort` | Core maintainers | Host-installed coding-agent CLIs with user-scoped paths. |
| `roles/langfuse` | `reference` | `best-effort` | Core maintainers | LLM observability reference stack. |
| `roles/litellm` | `reference` | `best-effort` | Core maintainers | Model gateway reference stack. |
| `roles/n8n` | `reference` | `best-effort` | Core maintainers | Workflow automation reference stack. |
| `roles/ollama` | `reference` | `best-effort` | Core maintainers | Local model runtime reference stack. |
| `roles/open_webui` | `reference` | `best-effort` | Core maintainers | Self-hosted AI web UI reference app. |
| `roles/openclaw` | `reference` | `best-effort` | Core maintainers | Agent runtime gateway and onboarding reference app. |
| `roles/qdrant` | `reference` | `best-effort` | Core maintainers | Vector database reference stack. |
| `roles/runner` | `reference` | `best-effort` | Core maintainers | Containerized coding-agent runner reference role. |

## Community Roles

No community roles are tracked yet.

## Experimental Roles

| Role | Tier | Status | Support owner | Purpose |
| --- | --- | --- | --- | --- |
| `roles/mcp_browser` | `experimental` | `experimental` | Core maintainers | Browser automation MCP role. |
| `roles/mcp_chrome_devtools` | `experimental` | `experimental` | Core maintainers | Chrome DevTools MCP role. |
| `roles/mcp_filesystem` | `experimental` | `experimental` | Core maintainers | Filesystem MCP role. |
| `roles/mcp_firecrawl` | `experimental` | `experimental` | Core maintainers | Firecrawl MCP role. |
| `roles/mcp_gateway` | `experimental` | `experimental` | Core maintainers | MCP gateway and profile wiring role. |
| `roles/mcp_todoist` | `experimental` | `experimental` | Core maintainers | Todoist MCP service role. |

## Adding Or Changing Roles

Before adding a role, read [`role-governance.md`](role-governance.md) and
[`role-contract.md`](role-contract.md). New roles must include a proposed tier,
support status, owner, validation path, and state/secrets/networking design.
