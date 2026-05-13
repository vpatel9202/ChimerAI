# 0008: Community Readiness

Milestone 8 prepares ChimerAI for limited public-alpha contribution without
creating broad support obligations.

## Goals

- Make contribution paths explicit and realistic for a prototype.
- Improve bug reports so maintainers get environment, reproduction, validation,
  and sanitization detail.
- Keep role requests separate from bug reports and general support.
- Require role requests to name governance tier, support owner, validation,
  lifecycle, state, secrets, ingress, and auth impact.
- Disable blank issues and route users to templates and `CONTRIBUTING.md`.
- Document post-alpha community surfaces and maintainer load limits.

## Non-Goals

- No promise to package every requested application as a ChimerAI role.
- No general support channel commitment.
- No production-readiness claim.
- No change to runtime behavior or Ansible contracts.

## Deliverables

- Updated `CONTRIBUTING.md` with scoped contribution paths.
- Updated bug report and role request templates.
- Issue template config that disables blank issues.
- `docs/community-readiness.md` for post-alpha surfaces and maintainer limits.
- Roadmap entry in `docs/milestones/README.md`.
- Optional README link to the community-readiness plan.

## Completion Criteria

- Public docs stay concise and honest about prototype status.
- Bug reports ask for enough sanitized evidence to reproduce and triage issues.
- Role requests remain a governance gate with owner, validation, and lifecycle
  expectations.
- Community surfaces do not imply maintainer capacity that does not exist yet.
