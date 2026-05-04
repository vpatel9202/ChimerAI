# Role Contract

This reference defines the first ChimerAI role contract. It is intentionally
small and optimized for the Milestone 1 core roles: `common`, `docker`,
`networks`, and `diag`.

ChimerAI roles should make host state reproducible while keeping Docker Compose
output visible and debuggable.

## Role Responsibilities

Every role should have one clear responsibility:

- `common`: base users, directories, packages, timezone, and host assumptions.
- `docker`: Docker engine and Compose availability.
- `networks`: shared Docker networks used by service roles.
- `diag`: safe validation and troubleshooting checks.
- app roles: app-local state, rendered config, rendered Compose, lifecycle, and
  validation for one service or tightly related service group.

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

Milestone 0 includes task-only placeholders so the project can parse. Milestone
1 should expand roles only as needed for real behavior.

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

## State And Compose Expectations

Roles that manage services should:

- keep runtime state in app-local bind mounts;
- avoid opaque named Docker volumes by default;
- render Compose files to predictable deployment paths;
- render secrets only into ignored/private files;
- keep generated Compose readable by a human operator;
- create explicit Docker networks rather than relying on accidental defaults;
- provide a validation path that can run without destructive side effects.

## Secrets

Public defaults and examples must never contain real credentials. Role defaults
may define non-secret values, but secret values belong in private inventories,
ignored env files, or a documented secret manager.

If a value controls exposure, authentication, provider tokens, OAuth clients, or
remote access, document where it should live and use an obvious placeholder in
examples.

## Milestone 0 Boundary

Milestone 0 proves that the repository has a coherent contract and a parseable
Ansible skeleton. It does not install packages, create Docker networks, render
Compose files, or deploy services.
