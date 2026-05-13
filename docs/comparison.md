# Comparison Guide

ChimerAI overlaps with several self-hosting projects, but it is not trying to
replace all of them. This guide uses durable categories instead of popularity
claims or feature-count scorecards.

## Current Direction

ChimerAI direction is evidence-driven. Public alpha feedback should decide
whether the project deepens the full-stack foundation, extracts reusable
Authentik automation, expands MCP wiring, or adds app roles.

ChimerAI is not currently an MCP-only gateway, an app bundle, or an extracted
Authentik collection. It may include MCP services, optional app roles, or
Authentik automation when those pieces serve the validated foundation.

## Summary

| Project or category | Source or basis | Strong fit | ChimerAI difference |
| --- | --- | --- | --- |
| Saltbox | [Saltbox Basics](https://docs.saltbox.dev/saltbox/basics/basics/) | Ansible and Docker based media-server automation with command-line operation. | ChimerAI is AI-operations focused and keeps media stacks out of the core product direction. |
| Umbrel | [Umbrel support](https://umbrel.com/support/getting-started/what-is-umbrel), [Umbrel GitHub](https://github.com/getumbrel) | Browser-managed home server OS with app store and hardware-friendly onboarding. | ChimerAI is not a GUI appliance; it favors reviewable Ansible, Compose output, and operator-controlled config. |
| CasaOS | [CasaOS GitHub](https://github.com/IceWhaleTech/CasaOS) | Simple personal-cloud dashboard and app management. | ChimerAI focuses on infrastructure lifecycle, auth/ingress/secrets contracts, and agent-friendly contribution paths rather than a dashboard-first app launcher. |
| Coolify | [Coolify introduction](https://coolify.io/docs/get-started/introduction), [Coolify API](https://www.coolify.io/docs/api-reference/introduction) | Self-hosted deployment platform for apps, databases, services, Git deploys, SSL, and API automation. | ChimerAI is a homelab foundation for AI services and operations, not a Heroku/Vercel-style app deployment platform. |
| MCP gateways and registries | [Model Context Protocol](https://modelcontextprotocol.io/), [MCP GitHub](https://github.com/modelcontextprotocol) | Standardizing how AI clients connect to tools, data sources, workflows, servers, and registries. | ChimerAI may run or wire MCP services, but its scope is the host foundation around them: auth, ingress, secrets, Compose, state, backup, diagnostics, and role governance. |
| Personal Ansible repos | Category, not a single public project | Maximum local control for one person's servers, secrets, conventions, and app choices. | ChimerAI turns reusable pieces into public contracts, docs, validation, and role governance so they can be reviewed and shared without publishing private host context. |

## Where ChimerAI Fits

Use ChimerAI when you want:

- Ansible-managed lifecycle and validation.
- Docker Compose as an inspectable runtime artifact.
- Explicit handling of ingress, auth, secrets, backup, restore, and diagnostics.
- Provider-neutral docs and workflows for AI coding agents.
- A project that can be reviewed and adapted before it touches a host.

Consider another project when you primarily want:

- A polished browser dashboard and one-click app store.
- A media-server automation stack.
- A general app deployment platform with Git integrations.
- An MCP-only gateway, registry, or protocol implementation.
- A private Ansible repo that can hard-code one host's local conventions.
- A turnkey appliance experience with minimal command-line review.

## Comparison Rules

- Source project-specific claims to official or project-maintained pages.
- Mark category comparisons as categories, not public projects.
- Avoid star counts, install counts, or temporary popularity claims.
- Describe adjacent projects by their strengths before explaining boundaries.
- Do not imply ChimerAI has validated platform support before the validation
  record proves it.
