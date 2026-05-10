# Role Contract

This reference defines the first ChimerAI role contract. It is intentionally
small and optimized for the current single-server roles: `common`, `docker`,
`networks`, `traefik`, `authentik`, `backup`, `openclaw`, `diag`, and
`open_webui`, plus the first optional MCP role `mcp_todoist`.

ChimerAI roles should make host state reproducible while keeping Docker Compose
output visible and debuggable where services are involved.

## Role Responsibilities

Every role should have one clear responsibility:

- `common`: base users, directories, packages, timezone, and host assumptions.
- `docker`: Docker engine and Compose availability.
- `networks`: shared Docker networks used by service roles.
- `traefik`: public ingress, ACME storage, and shared routing defaults.
- `authentik`: shared authentication layer for Traefik-routed apps.
- `backup`: Restic repository checks, consistency dumps, backup, and restore.
- `diag`: safe validation and troubleshooting checks.
- `open_webui`: first app proof of concept; local-only self-hosted AI web UI.
- `openclaw`: first agent runtime role and onboarding helper target.
- `mcp_todoist`: first MCP server role; private Todoist HTTP MCP service.
- app roles: app-local state, rendered config, rendered Compose, lifecycle, and
  validation for one service or tightly related service group.
- host tool roles: user-scoped CLI/tool installs, version checks, uninstall or
  rollback guidance, and no long-running service assumptions.

Do not create generic roles that hide app behavior behind excessive variable
indirection. A role should make generated files easier to inspect, not harder.

## Required Role Shape

A production role should use the standard Ansible layout where relevant:

```text
roles/<role_name>/
├── defaults/main.yml
├── tasks/main.yml
├── templates/
├── handlers/main.yml
└── README.md
```

Early roles should expand only as needed for real behavior. Avoid adding
framework machinery before at least two roles need the same abstraction.

## Tags

Roles should use predictable tags so operators can run narrow tasks:

| Tag | Purpose |
| --- | --- |
| `configure` | Render config, directories, env files, and Compose files. |
| `start` | Start or restart services. |
| `stop` | Stop services without removing state. |
| `validate` | Run health checks and diagnostics. |
| `backup` | Include role state in backup workflows. |
| `restore` | Restore role state from a backup. |
| `remove` | Remove services and generated files deliberately. |

Core roles may also use role-specific tags such as `common`, `docker`,
`networks`, and `diag`.

## State, Host Tools, And Compose Expectations

Roles that manage services should:

- keep runtime state in app-local bind mounts;
- avoid opaque named Docker volumes by default;
- render Compose files to predictable deployment paths;
- render secrets only into ignored/private files;
- keep generated Compose readable by a human operator;
- create explicit Docker networks rather than relying on accidental defaults;
- provide a validation path that can run without destructive side effects.

Roles that manage host tools should:

- install into user-scoped paths by default;
- avoid global package-manager state when a supported user install exists;
- expose version and path validation;
- document what host access the tool receives;
- keep secrets in encrypted config or tool-native auth stores, not in the repo.

## Lifecycle Interface

Roles use `chimerai_action` for lifecycle control:

- `validate`: inspect prerequisites and report configuration without mutating
  service state.
- `apply`: create ChimerAI-managed directories, networks, rendered files, and
  services.
- `remove`: stop/remove ChimerAI-managed services and networks.
- `backup`: snapshot ChimerAI-managed state through the backup role.
- `restore`: restore state from the configured backup repository.

Destructive state removal must require an explicit service-specific opt-in.
During alpha, `update` is intentionally out of scope; operators should edit
config or image tags and rerun `chimerai apply`.

## Secrets

Public defaults and examples must never contain real credentials. Role defaults
may define non-secret values, but secret values belong in the ignored
SOPS-encrypted private config file loaded through `chimerai_config_file`.

If a value controls exposure, authentication, provider tokens, OAuth clients, or
remote access, document where it should live and use an obvious placeholder in
examples.

Roles that render app-specific runtime `.env` files should treat those files as
generated artifacts. They must be ignored, derived from the private encrypted
config, and rendered with `no_log: true` when secret values are involved.

## Current Boundary

The current stack proves the service-role contract with core roles, public
ingress, shared auth, a first agent runtime, and a first optional MCP server.
The expanded Milestone 2 roadmap adds host tool roles, model roles, broader MCP
roles, automation, observability, notifications, and runner profiles. It still
does not automate every app's inside-the-UI setup or provide a dedicated update
lifecycle.

The current installer bootstraps local control tooling only. It does not make
host-level changes such as Docker installation or firewall configuration.
