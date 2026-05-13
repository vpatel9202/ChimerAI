---
name: Role request
about: Suggest a governed ChimerAI role
title: "[Role]: "
labels: enhancement
assignees: ""
---

## Operational Problem

What operator problem should this role solve?

Before filing, read:

- [Role governance](../../docs/role-governance.md)
- [Role catalog](../../docs/role-catalog.md)
- [Role contract](../../docs/role-contract.md)

## Upstream Project

Link to the upstream project, documentation, and Compose example if available.

## Proposed Tier

Valid values: `core`, `reference`, `community`, `experimental`.

## Proposed Support Status

Valid values: `active`, `best-effort`, `experimental`, `deprecated`.

## Support Owner

Who will maintain and validate this role?

## State And Secrets

List expected bind-mounted state paths and secret values.

## Networking, Ingress, And Auth

Should this service be local-only, Traefik-routed, Authentik-protected, or
something else?

## Validation

How should ChimerAI confirm this role is healthy?

## Lifecycle

What configure, start, stop, validate, backup, restore, and remove behavior does
this role need?

## Why Not Local Compose?

Why should this be a ChimerAI role instead of a private Compose file or local
operator note?
