# Security Policy

ChimerAI is currently a design/prototype project moving toward public alpha.
Do not treat it as a supported appliance.

## Supported Versions

Security fixes are handled on `main` until versioned alpha releases exist.

## Reporting A Vulnerability

Open a private GitHub security advisory when available. If that is not possible,
open a public issue with only a high-level description and no secrets,
credentials, tokens, private hostnames, or exploit details.

## Security Expectations

- Never commit private inventories, SOPS files, age keys, `.env` files, API
  keys, OAuth tokens, passwords, or runtime state.
- Public deployments should expose only SSH and Traefik ports `80` and `443`.
- App ports should bind to localhost or Docker-only networks unless a role
  explicitly documents a public exposure model.
- Public app routes should use the shared Traefik and Authentik contract in
  `docs/auth-and-ingress.md`; unauthenticated routes must be explicit.
- Keep Let's Encrypt staging enabled until DNS, firewall, and routing are
  verified.
- Authentik automation wires applications, proxy providers, and outpost
  membership only. Operators remain responsible for users, groups, policies,
  external IdPs, OAuth clients, and app-local authorization.
- Back up the SOPS age identity and Restic credentials before relying on a
  deployment.
- Rotate API keys and tokens after testing if they were pasted into chat,
  terminal history, issue trackers, or other shared logs.
