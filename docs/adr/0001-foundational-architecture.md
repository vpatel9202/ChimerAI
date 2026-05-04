# 0001: Foundational Architecture

- Status: Accepted
- Date: 2026-05-04

## Context

ChimerAI is intended to become a reusable self-hosted AI homelab framework, not
a one-off private deployment. It needs to manage host setup, Docker services,
MCP servers, agent runtimes, ingress, auth, backups, diagnostics, and local
operator context without becoming opaque or provider-specific.

## Decision

ChimerAI will use Ansible as the primary control plane and Docker Compose as the
visible service runtime.

The project also adopts these foundational rules:

- app state should default to app-local bind mounts rather than opaque Docker
  named volumes;
- `AGENTS.md` is the canonical provider-neutral instruction file for AI coding
  agents;
- provider-specific agent files may exist only as import shims;
- uv manages the local Python/Ansible validation toolchain;
- early roles should prioritize clarity and inspectability over generic
  abstraction.

## Consequences

Ansible owns lifecycle, provisioning, validation, backup, restore, diagnostics,
and generated configuration. Compose remains directly inspectable so operators
can debug containers with familiar Docker tools.

Private deployments should keep secrets, inventories, runtime state, and local
policy outside the public repo. Public examples must use placeholders and stay
safe for contributors to copy.

This decision intentionally avoids Kubernetes, Nix/NixOS, a pure Compose
catalog, and a custom orchestration CLI as the default path. A future
`chimerai` command may wrap Ansible for convenience, but it should not become a
second orchestration system.
