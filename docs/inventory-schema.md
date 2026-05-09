# Inventory Schema

This reference defines the first public ChimerAI inventory shape. It is a human
schema, not a JSON Schema file. The goal is to make the first single-server
proof of concept clear without freezing the interface too early.

Private deployments should keep real host values and secrets in an ignored
SOPS-encrypted config file. The preferred path is
`inventories/local/chimerai.sops.yaml`.

Use `chimerai config init` to create that file and `chimerai config edit` to
modify it. Static public examples stay in `inventories/examples/`.

## Minimal Shape

```yaml
all:
  children:
    chimerai:
      hosts:
        localhost:
          ansible_connection: local

          chimerai_host_name: localhost
          chimerai_timezone: Etc/UTC
          chimerai_domain: example.com
          chimerai_acme_email: admin@example.com
          chimerai_deployment_root: /opt/chimerai
          chimerai_state_root: /opt/chimerai/apps
          chimerai_action: validate

          chimerai_enabled_roles:
            - common
            - docker
            - networks
            - traefik
            - authentik
            - backup
            - openclaw
            - mcp_todoist
            - diag
            - open_webui

          chimerai_ingress:
            tls:
              enabled: true
              resolver: letsencrypt
              challenge: http-01
              staging: true
            auth:
              provider: authentik
              protect_apps_by_default: true

          chimerai_runtime:
            engine: docker
            compose_command: docker compose

          chimerai_networks:
            - name: chimerai-public
              purpose: ingress
            - name: chimerai-internal
              purpose: private-service
            - name: chimerai-mcp
              purpose: mcp

          chimerai_services:
            open_webui:
              image: ghcr.io/open-webui/open-webui:main
              host: 127.0.0.1
              host_port: 13080
              container_port: 8080
              auth_enabled: true
              ingress:
                enabled: true
                host: open-webui.example.com
                auth_required: true
            openclaw:
              image: ghcr.io/openclaw/openclaw:latest
              host: openclaw.example.com
              auth_required: true
              mcp_network: chimerai-mcp
              allow_unconfigured: true
            mcp_todoist:
              enabled: false
              image: node:22-alpine
              package_version: "8.12.1"
              host: 127.0.0.1
              host_port: 13002
              container_port: 3000
              session_timeout_ms: 1800000
              todoist_api_key: replace-me
            authentik:
              image: ghcr.io/goauthentik/server:2025.10
              host: auth.example.com
              bootstrap_email: admin@example.com
              bootstrap_password: replace-me
              bootstrap_token: replace-me
              secret_key: replace-me
              postgres_password: replace-me
              automation_enabled: true
              postgres_max_connections: 300
              web_workers: 2
              web_threads: 2
              worker_processes: 1
              worker_threads: 2

          chimerai_backup:
            enabled: false
            engine: restic
            repository: /opt/chimerai/backups/restic
            password: replace-me
            tags:
              - chimerai
```

## Required Fields

| Field | Meaning |
| --- | --- |
| `chimerai_host_name` | Human-readable name for the target host. |
| `chimerai_timezone` | Timezone roles should apply or assume. |
| `chimerai_domain` | Base DNS domain used by ingress-aware roles. |
| `chimerai_acme_email` | Contact email for Let's Encrypt ACME registration. |
| `chimerai_deployment_root` | Root directory for generated ChimerAI files. |
| `chimerai_state_root` | Root directory for app-local runtime state. |
| `chimerai_action` | Lifecycle action. Current alpha actions are `validate`, `apply`, `remove`, `backup`, and `restore`. |
| `chimerai_enabled_roles` | Roles intended to run for this host. |
| `chimerai_ingress` | Shared ingress, TLS, and auth defaults. |
| `chimerai_runtime.engine` | Container runtime family. Milestone 1 expects `docker`. |
| `chimerai_runtime.compose_command` | Compose command exposed to operators. |
| `chimerai_networks` | Shared networks roles may create or reference. |
| `chimerai_services` | Service configuration map. Current roles include `traefik`, `authentik`, `openclaw`, `mcp_todoist`, and `open_webui`. |
| `chimerai_backup` | Restic backup and restore settings for ChimerAI-managed state. |

## Preferred Private Config File

ChimerAI's preferred private deployment format is a single YAML file encrypted
with SOPS + age:

```text
inventories/local/chimerai.sops.yaml
```

That file can contain both non-secret deployment choices and encrypted secret
values. The playbook loads it before roles run when `chimerai_config_file` is
set:

```bash
chimerai validate
```

Use [`templates/config/chimerai.yaml`](../templates/config/chimerai.yaml) as
the starting shape, then encrypt the private copy. Keep committed inventories
small and generic.

The lower-level equivalent is:

```bash
uv run ansible-playbook chimerai.yml \
  -e chimerai_config_file=inventories/local/chimerai.sops.yaml \
  -e chimerai_action=validate
```

## State Policy

Service roles should place app state under `chimerai_state_root` unless a role
explicitly documents another path. The default design preference is:

```text
<chimerai_state_root>/<service-name>/
```

This keeps runtime state discoverable and backup-friendly.

By default, `chimerai_state_root` is `/opt/chimerai/apps`, so OpenClaw state
would live under `/opt/chimerai/apps/openclaw/`, Authentik state under
`/opt/chimerai/apps/authentik/`, and Traefik ACME state under
`/opt/chimerai/apps/traefik/`.

## Lifecycle Actions

Milestone 1 uses `chimerai_action` as the basic lifecycle interface:

- `validate`: check inventory and host prerequisites without deploying.
- `apply`: create ChimerAI-managed directories, networks, config, and services.
- `remove`: remove ChimerAI-managed services and networks.
- `backup`: snapshot ChimerAI-managed state with Restic.
- `restore`: restore from the configured Restic repository.

Roles must not remove persistent app state unless the inventory explicitly opts
into state removal for that service.

The CLI maps these actions directly:

```bash
chimerai validate
chimerai apply
chimerai remove
chimerai backup
chimerai restore
```

## Secrets And Private Values

Do not put real secrets in committed inventories. Private values include:

- API keys and provider tokens;
- OAuth client secrets and refresh tokens;
- real domains, account IDs, and tunnel IDs when sensitive;
- passwords and bootstrap credentials;
- Restic repository passwords;
- private network policy.

Use `inventories/local/chimerai.sops.yaml` for real deployments. The
repository's `.sops.yaml.example` shows how to encrypt sensitive keys while
leaving non-secret structure readable in diffs.

## Current Boundary

The example inventory exists so Ansible can parse the playbook and roles have a
starting contract. The current public stack configures first-pass ingress,
shared auth, Authentik app/provider/outpost automation for managed apps,
OpenClaw, the first Todoist MCP server role, and Restic-backed state backup. A
dedicated `update` action, additional MCP server roles, and provider-key
inheritance are post-alpha work.
