# Architecture Map

This is the compact public map of ChimerAI. It explains the intended system
shape without replacing the deeper architecture and role docs.

## Control Plane

ChimerAI is Ansible-first. Roles own provisioning, config rendering,
validation, backup, restore, removal, and diagnostics. The `chimerai` command is
the operator wrapper for common lifecycle paths.

## Runtime Plane

Docker Compose remains the visible service runtime. ChimerAI should generate or
manage Compose output that an operator can inspect, debug, and run with normal
Docker tooling.

## Boundary Model

| Boundary | Responsibility | Current direction |
| --- | --- | --- |
| Host provisioning | Packages, users, directories, prerequisites, and base services. | Ansible roles. |
| Service deployment | App containers and Compose projects. | Compose output, not opaque orchestration. |
| Ingress and auth | Public routes, TLS, forward auth, and exposure policy. | Traefik plus Authentik foundation. |
| Secrets and config | Encrypted operator config and generated service config. | SOPS plus age. |
| State and backup | App-local bind mounts, backup scopes, restore checks. | Prefer app-local paths over unnamed Docker volumes. |
| Diagnostics | Validate paths, health checks, common failure reports. | Every role should gain a clear validate path. |

## Operator Flow

1. Bootstrap repo tooling with `./install.sh`.
2. Prepare encrypted config and inventory.
3. Run validation before apply.
4. Apply Ansible-managed roles.
5. Inspect generated Compose/runtime state when troubleshooting.
6. Use diagnostics, backup, restore, and removal paths as role support matures.

## Design Biases

- Reviewable host changes over hidden automation.
- Public docs that state prototype limits plainly.
- Provider-neutral agent workflows.
- Security-sensitive defaults for ingress, auth, secrets, and remote access.
- Reversible changes where possible.

## Deeper References

- [Architecture agent context](agents/architecture.md)
- [Role contract](role-contract.md)
- [Auth and ingress](auth-and-ingress.md)
- [Configuration and secrets](configuration-and-secrets.md)
- [Operations](operations/README.md)
- [Architecture decisions](adr/)
