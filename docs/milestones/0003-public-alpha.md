# Milestone 3: Public Alpha

Milestone 3 turns the expanded Milestone 2 stack into a documented public alpha
that a careful operator can evaluate on a clean Linux server in the current
validation environment. Current validation records use Ubuntu Server 24.04; see
the [platform support matrix](../platform-support.md).

## Goals

- Prove a fresh-host install from clone through `chimerai apply`.
- Confirm a second `chimerai apply` has no material changes.
- Validate the enabled Milestone 2 layers together: ingress, auth, agent CLI,
  model runtime/gateway, MCP core, automation, observability, diagnostics, and
  backup.
- Document known limitations clearly enough that users can decide whether to
  test the project.

## Release Gates

- The public alpha checklist passes.
- Generated service config and bind-mounted state locations are documented.
- Authentik automation boundaries are clear.
- Backup and restore have been tested against generated state.
- Security guidance covers secrets, ingress, exposed ports, and key rotation.

## Non-Goals

- Broad MCP catalog beyond the core Milestone 2 MCP set.
- Global model-provider registry beyond the first LiteLLM/provider boundary.
- Dedicated update lifecycle action.
- Full Authentik user, group, policy, or identity-provider automation.
