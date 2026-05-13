# Post-Alpha Strategic Decision Framework

ChimerAI is not choosing its post-alpha shape by assertion. After public alpha,
the project should use operator evidence, contributor capacity, and validation
quality to decide whether to deepen the foundation, extract a reusable
component, expand MCP wiring, or add app roles.

This framework is a planning tool. It does not promise that any path will be
implemented, extracted, or stabilized.

## Feedback Inputs

Post-alpha direction should be based on several inputs, not one loud signal:

- public alpha validation records and failed checks;
- operator install notes from real hosts;
- role request issues and support questions;
- maintainer time required to review, validate, and support changes;
- repeated local lessons that can be sanitized into public contracts;
- security, backup, restore, and update gaps found during use;
- contribution patterns from people other than the original author.

Inputs should distinguish curiosity from adoption. A request is useful signal,
but a working deployment, reproducible failure, or maintained contribution is
stronger evidence.

## Decision Paths

### Full-Stack Foundation

Choose this path when evidence shows that users primarily need a coherent
Ansible-first homelab foundation: ingress, Authentik integration, secrets,
Compose output, state paths, backup, restore, validation, diagnostics, and
operator workflow.

Use this path to improve the shared lifecycle before adding more optional
surface area.

Evidence threshold:

- at least two independent installs or dry runs report foundation friction;
- validation gaps affect more than one role or workflow;
- fixes improve backup, restore, update, diagnostics, or security contracts;
- the work can be tested without private host context.

### Authentik Automation Extraction

Choose this path only if Authentik automation becomes useful outside ChimerAI
and has a clear contract that does not depend on private inventory shape.

This path could produce an extracted role, collection, or library later. It is
not the current project direction by default.

Evidence threshold:

- repeated demand for Authentik automation independent of the full ChimerAI
  stack;
- stable inputs, outputs, and error behavior for provider, application, group,
  policy, and outpost wiring;
- validation that can run against a test Authentik instance;
- documented upgrade, backup, restore, and rollback expectations;
- a named owner willing to maintain the extracted surface.

### MCP Wiring

Choose this path when operators need reliable ways to run, expose, secure, and
validate MCP servers as part of the ChimerAI foundation.

This path should focus on host contracts around MCP services. It should not
turn ChimerAI into an MCP-only gateway, registry, or protocol implementation.

Evidence threshold:

- multiple operators need similar MCP service wiring;
- ingress, auth, network exposure, secrets, logging, and update behavior are
  clear enough to validate;
- failure modes can be diagnosed through `chimerai validate` or a documented
  manual check;
- the work benefits more than one MCP server or client.

### App Roles

Choose this path when an app role proves a reusable infrastructure contract,
not merely because an upstream app has a Compose file.

App roles should remain optional unless they are required for the supported
foundation lifecycle.

Evidence threshold:

- real adoption evidence from at least two operators or a maintained community
  owner;
- the role contract covers configure, start, stop, validate, backup, restore,
  update, and remove behavior where applicable;
- state paths, secrets, ingress, Authentik protection, and network exposure are
  documented;
- validation is non-destructive and can be run by contributors;
- support tier, support status, and owner are explicit.

## Beta And Stable Meanings

`beta` should mean the alpha evidence loop has produced repeatable installs,
validation coverage for the supported lifecycle, documented upgrade and
rollback expectations, and clear owner expectations for included roles.

`stable` should mean the project has a defined support policy, release process,
compatibility expectations, security handling, and enough real usage evidence
to treat regressions in supported contracts as release blockers.

Neither term should be used only because the docs are polished or the happy
path works on one host.

## Pivot Guardrails

- Do not pivot the project around one private deployment.
- Do not extract a component before its public contract is mature.
- Do not add app roles that bypass backup, restore, update, validation, owner,
  and support-status expectations.
- Do not describe ChimerAI as an MCP-only gateway, app bundle, or extracted
  Authentik collection unless the implemented and validated project has become
  that.
- Do not use one domain's assumptions to steer the public roadmap.
- Do not claim beta, stable, production-ready, or broad compatibility before
  evidence and policy support those claims.
- Prefer reversible decisions: document the evidence, choose the smallest path
  that answers it, and keep private host details out of public docs.
