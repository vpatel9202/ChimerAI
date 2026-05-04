# Architecture

ChimerAI is planned as an Ansible-first framework with Docker Compose as the
service runtime.

## Layer Model

- Host provisioning: packages, users, Docker, systemd, firewall, and base
  directories.
- Service deployment: app roles render configuration and Compose files.
- Integration wiring: ingress, auth, networks, MCP registration, and provider
  configuration.
- Operations: validation, diagnostics, backup, restore, update, and removal.

## Role Shape

Future app roles should follow a consistent contract:

- defaults for public, non-secret configuration
- templates for `.env` and Compose output
- tasks for configure, start, stop, validate, backup, restore, and remove
- concise role documentation

The current public contract is defined in
[`../role-contract.md`](../role-contract.md). The first inventory shape is
defined in [`../inventory-schema.md`](../inventory-schema.md).

Do not over-abstract early. A simple role that renders understandable Compose is
better than a generic framework that hides app behavior.

## Runtime Model

- Keep generated Compose visible and debuggable.
- Prefer bind mounts in predictable app-local directories.
- Keep networks explicit.
- Treat health checks and validation as part of the role, not an afterthought.

## Private Deployments

Public ChimerAI should contain reusable roles, defaults, and examples. Private
deployments should contain inventories, secrets, local app selections, local
policy, and private runtime data.
