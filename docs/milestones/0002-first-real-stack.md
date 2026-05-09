# Milestone 2: First Real Stack

Milestone 2 introduces the first ChimerAI stack that looks like the intended
public project: Traefik for ingress, Let's Encrypt for certificates, Authentik
for SSO/forward-auth, and OpenClaw as the first agent runtime.

## Decisions

- Traefik is the public HTTPS entrypoint.
- Let's Encrypt HTTP-01 is the default ACME flow.
- Authentik protects routed applications by default.
- Authentik's own admin and outpost paths are not protected by forward-auth.
- OpenClaw uses the prebuilt `ghcr.io/openclaw/openclaw` image.
- OpenClaw onboarding is run through a `chimerai openclaw onboard` helper.
- Persistent Docker data must use bind mounts under `chimerai_state_root`.

## State Layout

Generated service config lives under:

```text
/opt/chimerai/<service>/
```

Persistent app data lives under:

```text
/opt/chimerai/apps/<service>/
```

Examples:

```text
/opt/chimerai/traefik/compose.yml
/opt/chimerai/apps/traefik/acme/acme.json
/opt/chimerai/apps/authentik/postgresql/
/opt/chimerai/apps/authentik/redis/
/opt/chimerai/apps/openclaw/config/
/opt/chimerai/apps/openclaw/workspace/
```

Named Docker volumes are not used for ChimerAI-managed persistence.

## Boundaries

This milestone does not add a global provider registry. Provider secrets stay
app-local until multiple real roles need shared provider inheritance.

Authentik provider/application/outpost automation covers ChimerAI-managed apps
that require ingress auth. User/group/policy setup remains an operator task
until ChimerAI has a clearer authorization model.

## Acceptance Criteria

- `chimerai validate` succeeds with the expanded config shape.
- `chimerai apply` renders and starts Traefik, Authentik, and OpenClaw when
  those roles are enabled.
- Traefik requests Let's Encrypt certificates using HTTP-01.
- OpenClaw is routed through Traefik and uses Authentik forward-auth middleware.
- ChimerAI creates or updates the Authentik OpenClaw application, proxy
  provider, and embedded outpost membership during `chimerai apply`.
- All persistent service data lives under `chimerai_state_root`.
- `chimerai openclaw onboard` runs the documented Docker onboarding flow.
