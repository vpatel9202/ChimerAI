# Role Governance

ChimerAI roles are governed so the catalog supports the platform instead of
becoming the platform. A role belongs in the public repo when it advances a
repeatable operator workflow, not merely because an upstream app has a Compose
file.

## Role Tiers

| Tier | Meaning |
| --- | --- |
| `core` | Required foundation roles for the supported ChimerAI lifecycle. These roles carry the highest maintenance expectation. |
| `reference` | Useful examples that prove patterns on top of the foundation. They are maintained as examples, not equal commitments. |
| `community` | Community-owned roles that meet the contract but need an explicit support owner outside the core maintainers. |
| `experimental` | Design probes or early integrations that may change, merge into other roles, or be removed. |

## Support Statuses

| Status | Meaning |
| --- | --- |
| `active` | Supported in current validation and expected to keep working with normal project changes. |
| `best-effort` | Maintained when practical, but not a release blocker unless a maintainer explicitly raises it. |
| `experimental` | Useful for exploration; interfaces and behavior are not stable. |
| `deprecated` | Kept temporarily for migration or historical reasons and scheduled for removal. |

## Inclusion Criteria

New roles should meet these criteria before they are added to `roles/`:

- solve a clear operational problem for self-hosted AI infrastructure;
- add value beyond wrapping an upstream Compose file;
- fit the role contract for configure, start, stop, validate, backup, restore,
  and remove behavior where applicable;
- document state paths, backup scope, and restore expectations;
- keep secrets in encrypted or ignored files, never in tracked examples;
- state ingress, network exposure, and Authentik protection expectations;
- provide a validation path that can run without destructive side effects;
- identify a proposed tier, support status, and owner;
- explain why the role belongs in ChimerAI instead of local private Compose.

## Deprecation Policy

A deprecated role must document:

- the reason for deprecation;
- the recommended replacement, if one exists;
- migration notes for state, config, secrets, ingress, and auth behavior;
- the target removal milestone or release window;
- the validation command or manual check that confirms migration is complete.

Deprecated roles stay in the catalog until removal. Their status must be
`deprecated`, and their catalog notes should point operators to the replacement
or explain that no replacement is planned.
