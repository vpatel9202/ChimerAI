# Milestone 4: Authentik And Traefik Differentiation

Milestone 4 makes shared ingress and identity the clearest ChimerAI
differentiator. The goal is not just to deploy apps, but to give operators one
inspectable pattern for exposing multiple self-hosted AI services through
Traefik and protecting them with one Authentik identity layer.

## Goals

- Document the public auth and ingress contract for ChimerAI-managed apps.
- Keep Traefik entrypoints, HTTP-to-HTTPS redirect, ACME staging, and
  forward-auth behavior explicit and inspectable.
- Use Authentik automation for ChimerAI-managed proxy providers, applications,
  and embedded outpost membership.
- Show multiple protected apps using one shared identity layer, with OpenClaw
  and Open WebUI as the primary example.
- Make the manual boundary clear: DNS, public firewall rules, production
  certificate cutover, users, groups, policies, external IdPs, and app-local
  authorization remain operator-owned.

## Release Gates

- `docs/auth-and-ingress.md` is the canonical public contract for shared
  Traefik and Authentik behavior.
- README, installation, configuration, inventory, role, security, and agent
  docs point to that contract instead of describing separate conflicting auth
  models.
- Managed app role docs and templates agree on the same fields:
  `ingress.enabled`, `host`, and `auth_required`, with
  `chimerai_ingress.auth.protect_apps_by_default` as the default auth policy.
- Generated Authentik setup notes tell operators what ChimerAI automated and
  what they still need to verify manually.

## Non-Goals

- Automating public DNS records or host firewall policy.
- Switching from Let's Encrypt staging to production certificates without an
  explicit operator config change.
- Creating Authentik users, groups, policies, external IdPs, OAuth clients, or
  app-specific authorization rules.
- Replacing app-native authentication or authorization where an app requires
  its own setup.
- Adding a new ingress provider abstraction before the Traefik/Auth pattern is
  stable.
