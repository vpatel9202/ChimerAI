# Security And Secrets

ChimerAI will manage infrastructure that can expose private services and
powerful automation tools. Security guidance must be conservative by default.

## Secrets

- Never commit API keys, OAuth tokens, passwords, private inventories, provider
  credentials, `.env` files, or generated runtime state.
- Examples should use placeholders and explain where real values belong.
- Prefer one ignored SOPS-encrypted YAML file for deployment configuration:
  `inventories/local/chimerai.sops.yaml`.
- Use SOPS + age as the default secret workflow. Ansible Vault is acceptable as
  a fallback, but do not introduce a second default path without an ADR.
- Keep role tasks that load or render secrets behind `no_log: true`.
- Do not scatter user-facing secrets across app-specific plaintext `.env`
  files unless the generated runtime file is ignored and derived from the
  encrypted config.
- Keep the age private key outside the repository. If a user needs help setting
  up SOPS, direct them to [`../configuration-and-secrets.md`](../configuration-and-secrets.md).
- Remind users to back up `~/.config/sops/age/keys.txt`; without the age
  identity, encrypted local config cannot be decrypted.
- The installer may install `sops` and `age` into `~/.local/bin`, but it must
  not generate private deployment config or deploy services.

## Ingress And Auth

- Do not expose internal services publicly without a deliberate ingress and
  authentication policy.
- Use `docs/auth-and-ingress.md` as the source of truth for the Traefik and
  Authentik contract before changing routed app behavior.
- Keep Let's Encrypt staging enabled until DNS, firewall, and routing are
  verified.
- Treat `auth_required: false` on a public app route as a security-sensitive
  exception that needs role documentation.
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
