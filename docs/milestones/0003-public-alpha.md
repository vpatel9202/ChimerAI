# Milestone 3: Public Alpha

Milestone 3 turns the current prototype into a documented public alpha that a
careful operator can evaluate on a clean Ubuntu 24.04 host.

## Goals

- Prove a fresh-host install from clone through `chimerai apply`.
- Confirm a second `chimerai apply` has no material changes.
- Validate Traefik, Authentik, OpenClaw, Todoist MCP, diagnostics, and backup
  behavior together.
- Document known limitations clearly enough that users can decide whether to
  test the project.

## Release Gates

- The public alpha checklist passes.
- Generated service config and bind-mounted state locations are documented.
- Authentik automation boundaries are clear.
- Backup and restore have been tested against generated state.
- Security guidance covers secrets, ingress, exposed ports, and key rotation.

## Non-Goals

- Broad MCP catalog.
- Global model-provider registry.
- Dedicated update lifecycle action.
- Full Authentik user, group, policy, or identity-provider automation.
