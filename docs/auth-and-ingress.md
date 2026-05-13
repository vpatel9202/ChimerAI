# Auth And Ingress

ChimerAI uses Traefik as the shared public ingress layer and Authentik as the
shared authentication layer for ChimerAI-managed apps. The contract is meant to
stay inspectable: roles render normal Compose files with Traefik labels, and
operators can review the generated files before exposing a host.

## Managed Boundary

ChimerAI-managed auth and ingress includes:

- a public Traefik network for routed services;
- Traefik `web` and `websecure` entrypoints on ports `80` and `443`;
- HTTP-to-HTTPS redirect from `web` to `websecure`;
- Let's Encrypt HTTP-01 ACME with staging enabled by default;
- a shared Authentik forward-auth middleware named `authentik@docker`;
- Authentik outpost routes for protected application hosts;
- Authentik proxy provider, application, and embedded outpost membership
  automation for ChimerAI-managed protected apps.

Operator-owned setup includes:

- public DNS records for each hostname;
- host and cloud firewall rules for SSH, port `80`, and port `443`;
- the switch from ACME staging certificates to production certificates;
- Authentik users, groups, policies, flows, external identity providers, OAuth
  clients, and app-specific authorization rules.

## Traefik Contract

The `traefik` role owns the shared public entrypoint:

- `web` listens on `:80`;
- `websecure` listens on `:443`;
- `web` redirects HTTP requests to HTTPS on `websecure`;
- Docker provider discovery uses `exposedByDefault: false`;
- routed apps must opt in with Traefik labels;
- ACME stores certificates in Traefik state under the ChimerAI app-local state
  root.

The default certificate resolver uses Let's Encrypt HTTP-01. Keep
`chimerai_ingress.tls.staging: true` until DNS, firewall, and routing are
verified, then set it to `false` and apply again when ready for production
certificates.

## Authentik Contract

The `authentik` role deploys Authentik and exposes the Authentik admin host
through Traefik. It also defines the shared middleware:

```text
authentik@docker
```

Protected app routers attach that middleware. Authentik outpost routes are
created on each protected app host for:

```text
/outpost.goauthentik.io/
```

Those outpost routes must not be protected by the forward-auth middleware, or
the authentication check cannot complete.

When `chimerai_services.authentik.automation_enabled` is true and a bootstrap
token is present, ChimerAI creates or updates Authentik proxy providers,
applications, and embedded outpost membership for ChimerAI-managed protected
apps. It does not create human access policy.

## Managed App Fields

App roles that participate in public ingress use this shape:

```yaml
chimerai_services:
  some_app:
    ingress:
      enabled: true
      host: app.example.com
      auth_required: true
```

Roles with one public endpoint may expose the same contract as top-level fields
when that is already the role convention:

```yaml
chimerai_services:
  openclaw:
    host: openclaw.example.com
    auth_required: true
```

`auth_required` defaults to
`chimerai_ingress.auth.protect_apps_by_default` when the role does not set an
explicit value. Public routes that disable `auth_required` need role-specific
documentation explaining why they are safe.

## Shared Identity Example

OpenClaw and Open WebUI show the intended pattern:

```yaml
chimerai_ingress:
  enabled: true
  provider: traefik
  tls:
    enabled: true
    resolver: letsencrypt
    challenge: http-01
    staging: true
  auth:
    provider: authentik
    protect_apps_by_default: true

chimerai_services:
  authentik:
    host: auth.example.com
    automation_enabled: true

  openclaw:
    host: openclaw.example.com
    auth_required: true

  open_webui:
    ingress:
      enabled: true
      host: webui.example.com
      auth_required: true
```

With that shape, ChimerAI renders Traefik routes for both app hosts, attaches
`authentik@docker`, creates Authentik proxy applications for both apps, and
adds both providers to the managed embedded outpost. Operators still configure
who can access those apps inside Authentik.

## Verification

After `chimerai apply`, review the generated Authentik verification note in the
Authentik deployment directory, normally:

```text
/opt/chimerai/authentik/AUTHENTIK_SETUP.md
```

For each protected app, verify:

- DNS points at the host;
- ports `80` and `443` reach Traefik;
- the app router uses TLS and the expected certificate resolver;
- the app router includes `authentik@docker`;
- the corresponding Authentik application and proxy provider exist;
- the provider is attached to the managed embedded outpost;
- unauthenticated access redirects through Authentik;
- the app's own authorization requirements are configured separately.
