# Community Readiness

ChimerAI is preparing for public alpha, not broad community support.

This page defines the surfaces that should exist before larger community use and
the limits that protect maintainer time while the project is still a prototype.

## Current Scope

Accepted contribution paths:

- reproducible bug reports against documented workflows;
- focused documentation fixes;
- small validation or contract improvements;
- role requests that follow the governance template.

Out of scope for now:

- general homelab support;
- private deployment debugging that depends on unpublished local state;
- broad app-role requests without an owner and validation plan;
- large implementation pull requests without prior design agreement.

## Post-Alpha Surfaces

After the first public alpha, ChimerAI should maintain:

- issue templates for bugs and role requests;
- a concise contributing guide;
- roadmap pages that distinguish current, planned, and rejected work;
- role governance docs with support tiers and lifecycle rules;
- validation output that gives contributors enough evidence to file useful
  reports without exposing secrets.

Additional support surfaces should be added only when maintainers can keep them
accurate and responsive.

## Maintainer Load Limits

Maintainers should prefer fewer, clearer queues over more channels.

- Keep blank issues disabled while the project is small.
- Ask for reproducible steps and sanitized validation output before triage.
- Route role ideas through the role request template.
- Close or redirect reports that require private inventories, secrets, or
  machine-specific context that cannot be sanitized.
- Defer large changes until there is an owner, validation path, and lifecycle
  plan.

## Readiness Checklist

- [ ] Bug reports capture environment, reproduction, validation output, and
      sanitization checks.
- [ ] Role requests capture owner, governance tier, support status, validation,
      lifecycle, state, secrets, ingress, and auth impact.
- [ ] Blank issues are disabled.
- [ ] README routes contributors to the contributing guide and roadmap.
- [ ] Milestone docs describe community-readiness work without promising broad
      support.
