# Milestone 5: Role Catalog Governance

Milestone 5 prevents the role catalog from becoming the product. It defines how
roles are accepted, classified, maintained, and removed so ChimerAI stays an
operations foundation instead of a loose app bundle.

## Goals

- Define role tiers and support statuses for every tracked role.
- Keep reference roles useful as examples without making them equal-maintenance
  commitments.
- Require new roles to explain operational value, lifecycle behavior,
  validation, state, secrets, ingress, and auth boundaries.
- Provide a deprecation path with replacement and migration notes.
- Add a light validation check so tracked roles and catalog docs stay in sync.

## Release Gates

- `docs/role-governance.md` defines tier, support, inclusion, and deprecation
  policy.
- `docs/role-catalog.md` lists every `roles/*` directory exactly once with an
  approved tier and support status.
- Contributor and issue-template flows require proposed tier, status owner,
  validation path, and secrets/networking impact.
- CI checks the role catalog for missing roles, duplicate roles, and invalid
  tier or support values.
- Public-facing docs frame the catalog as governed examples, not as a promise to
  absorb every useful Compose service.

## Non-Goals

- Expanding the number of MCP, app, model, or agent runtime roles.
- Promising equal support for all reference or experimental roles.
- Accepting roles that only wrap an upstream Compose file without lifecycle,
  validation, state, secrets, ingress, and auth design.
