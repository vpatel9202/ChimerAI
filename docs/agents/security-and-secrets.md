# Security And Secrets

ChimerAI will manage infrastructure that can expose private services and
powerful automation tools. Security guidance must be conservative by default.

## Secrets

- Never commit API keys, OAuth tokens, passwords, private inventories, provider
  credentials, `.env` files, or generated runtime state.
- Examples should use placeholders and explain where real values belong.
- Prefer local ignored files, environment variables, or documented secret
  managers for real deployments.

## Ingress And Auth

- Do not expose internal services publicly without a deliberate ingress and
  authentication policy.
- Treat Authentik, Authelia, Cloudflare, Tailscale, firewall, and reverse proxy
  changes as security-sensitive.
- Document exposure assumptions clearly.

## Agent Safety

- Agents should not run destructive commands unless the user explicitly asks.
- Agents should not broaden permissions or public access as a convenience.
- Agents should report uncertainty around auth, networking, DNS, TLS, and
  firewall behavior rather than guessing.

## Public Project Hygiene

- Keep private deployment details out of public examples.
- Avoid using real domains, keys, account IDs, or personal data in committed
  examples.
- If a sample value looks real, replace it with an obvious placeholder.
