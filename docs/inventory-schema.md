# Inventory Schema

This reference defines the first public ChimerAI inventory shape. It is a human
schema, not a JSON Schema file. The goal is to make the first single-server
proof of concept clear without freezing the interface too early.

Private deployments should copy the example inventory into `inventories/local/`
or another ignored/private location before adding real domains, secrets, or
host-specific values.

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
          chimerai_deployment_root: /opt/chimerai
          chimerai_state_root: /opt/chimerai/apps
          chimerai_action: validate

          chimerai_enabled_roles:
            - common
            - docker
            - networks
            - diag
            - open_webui

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
```

## Required Fields

| Field | Meaning |
| --- | --- |
| `chimerai_host_name` | Human-readable name for the target host. |
| `chimerai_timezone` | Timezone roles should apply or assume. |
| `chimerai_deployment_root` | Root directory for generated ChimerAI files. |
| `chimerai_state_root` | Root directory for app-local runtime state. |
| `chimerai_action` | Lifecycle action. Milestone 1 supports `validate`, `apply`, and `remove`. |
| `chimerai_enabled_roles` | Roles intended to run for this host. |
| `chimerai_runtime.engine` | Container runtime family. Milestone 0 expects `docker`. |
| `chimerai_runtime.compose_command` | Compose command exposed to operators. |
| `chimerai_networks` | Shared networks roles may create or reference. |
| `chimerai_services` | Service configuration map. Milestone 1 includes `open_webui`. |

## State Policy

Service roles should place app state under `chimerai_state_root` unless a role
explicitly documents another path. The default design preference is:

```text
<chimerai_state_root>/<service-name>/
```

This keeps runtime state discoverable and backup-friendly.

## Lifecycle Actions

Milestone 1 uses `chimerai_action` as the basic lifecycle interface:

- `validate`: check inventory and host prerequisites without deploying.
- `apply`: create ChimerAI-managed directories, networks, config, and services.
- `remove`: remove ChimerAI-managed services and networks.

Roles must not remove persistent app state unless the inventory explicitly opts
into state removal for that service.

## Secrets And Private Values

Do not put real secrets in committed inventories. Private values include:

- API keys and provider tokens;
- OAuth client secrets and refresh tokens;
- real domains, account IDs, and tunnel IDs when sensitive;
- passwords and bootstrap credentials;
- private network policy.

Use `inventories/local/` or another ignored private inventory location for real
deployments.

## Milestone 0 Boundary

The example inventory exists so Ansible can parse the playbook and so future
roles have a starting contract. Milestone 0 does not validate every field
semantically and does not deploy services.
