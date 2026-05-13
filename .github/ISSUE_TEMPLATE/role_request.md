---
name: Role request
about: Suggest a governed ChimerAI role
title: "[Role]: "
labels: enhancement
assignees: ""
---

## Operational Problem

What operator problem should this role solve?

Role requests are for governed ChimerAI roles only. They are not general app
requests or support requests for private Compose stacks.

Before filing, read:

- [Role governance](../../docs/role-governance.md)
- [Role catalog](../../docs/role-catalog.md)
- [Role contract](../../docs/role-contract.md)

## Upstream Project

Link to the upstream project, documentation, and Compose example if available.

## Proposed Tier

Valid values: `core`, `reference`, `community`, `experimental`.

Explain why this tier fits the current role governance rules.

## Proposed Support Status

Valid values: `active`, `best-effort`, `experimental`, `deprecated`.

State who can respond when upstream releases, image changes, or validation
breakages require maintenance.

## Support Owner

Who will maintain and validate this role?

- GitHub handle or team:
- Expected review capacity:
- Backup maintainer, if any:

## State And Secrets

List expected bind-mounted state paths and secret classes. Do not paste real
secret values.

## Networking, Ingress, And Auth

Should this service be local-only, Traefik-routed, Authentik-protected, or
something else?

Note whether the role introduces public ingress, privileged containers, host
networking, device mounts, or non-HTTP access.

## Validation

How should ChimerAI confirm this role is healthy?

Include the expected `validate` behavior, smoke checks, and any upstream health
endpoint or CLI status command.

## Lifecycle

What configure, start, stop, validate, backup, restore, and remove behavior does
this role need?

Include expected upgrade, deprecation, and removal handling. If the role cannot
be backed up or restored with current project contracts, say so.

## Governance Gate

- [ ] I read the role governance, catalog, and contract docs.
- [ ] I identified a support owner for ongoing validation and lifecycle work.
- [ ] I described state, secrets, ingress, auth, validation, backup, restore,
      and removal behavior.
- [ ] I understand that approval to discuss a role does not guarantee ChimerAI
      will package or maintain it.

## Why Not Local Compose?

Why should this be a ChimerAI role instead of a private Compose file or local
operator note?
