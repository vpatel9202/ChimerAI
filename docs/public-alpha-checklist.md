# Public Alpha Checklist

Use this checklist before tagging a public alpha release.

## Core Validation

- `bash -n bin/chimerai`
- `bash -n install.sh`
- `git diff --check`
- `uv run ansible-playbook chimerai.yml --syntax-check`
- `uv run ansible-playbook -i inventories/examples/single-server.yml chimerai.yml --check`

## Fresh Host Validation

- Bootstrap a clean Ubuntu 24.04 host.
- Run `chimerai config init` and back up the age identity.
- Configure real DNS, Authentik secrets, and Let's Encrypt staging.
- Run `chimerai validate`.
- Run `chimerai apply`.
- Run `chimerai apply` again and confirm the second run has no material changes.
- Finish `AUTHENTIK_SETUP.md`.
- Confirm OpenClaw is reachable through Authentik-protected Traefik routing.
- If Todoist MCP is enabled, confirm OpenClaw can show the managed Todoist MCP
  registry entry.
- Run `chimerai backup` and confirm Restic can list the snapshot.

## Release Boundary

- Additional MCP roles beyond Todoist are post-alpha.
- Provider-key inheritance is post-alpha.
- Full Authentik API automation is post-alpha.
- A dedicated `update` lifecycle action is post-alpha.
