# Installation

This guide bootstraps a local ChimerAI checkout on the machine that will run
Ansible. It does not deploy services.

Use this guide when starting from a fresh clone. If the repo is already
bootstrapped, the most common commands are:

```bash
chimerai config edit
chimerai validate
chimerai apply
chimerai backup
```

## Prerequisites

ChimerAI's first full path is a single Linux server deployment. Ubuntu Server
24.04 is the current fresh-host validation environment, but the project does not
make an Ubuntu-only support promise. See
[Platform Support](platform-support.md) for the canonical support matrix.

### Control And Evaluation Environment

Use a Linux environment for the current evaluated path. Non-Linux controller
and provisioning paths are unvalidated and should not be treated as supported
ways to provision a Linux host yet.

Install these before starting:

- `git`
- `curl`
- `tar`

### Deployment Target

The deployment target must be a Linux server. Install or provide:

- Docker with Compose v2, if you want validation to check the Docker runtime
- a DNS zone you control, if you want public Traefik ingress and Let's Encrypt
- public inbound access to ports `80` and `443`, if you use HTTP-01

Why Docker is not installed here: the current installer bootstraps the local
ChimerAI control environment. Docker installation and hardening belong in the
Ansible role path, where host changes can be validated and made repeatable.

## Clone The Repository

```bash
git clone https://github.com/vpatel9202/ChimerAI.git
cd ChimerAI
```

## Run The Bootstrap Script

```bash
./install.sh
```

The script performs local setup only:

- installs `uv` if it is missing;
- installs `sops` and `age` to `~/.local/bin` if they are missing;
- links `~/.local/bin/chimerai` to this checkout's `bin/chimerai`;
- runs `uv sync --locked`;
- installs Ansible Galaxy collections from `requirements.yml`.

The script does not:

- clone the repository;
- edit shell startup files;
- create encrypted ChimerAI config;
- deploy or remove services.

If `~/.local/bin` is not on your `PATH`, the installer prints the shell export
line you need to add manually.

Why the installer links instead of copying: a symlink keeps `chimerai` pointed
at the current checkout, so updates to `bin/chimerai` take effect without
reinstalling the command.

## Initialize Local Config

After bootstrap, create the ignored encrypted config file:

```bash
chimerai config init
```

Edit it with:

```bash
chimerai config edit
```

Verify it can decrypt:

```bash
chimerai config validate
```

For the first public stack, edit at least these values before applying:

```yaml
chimerai_domain: example.com
chimerai_acme_email: admin@example.com
chimerai_ingress:
  tls:
    staging: true
chimerai_services:
  authentik:
    host: auth.example.com
    bootstrap_email: admin@example.com
    bootstrap_password: replace-me
    bootstrap_token: replace-me
    secret_key: replace-me
    postgres_password: replace-me
  openclaw:
    host: openclaw.example.com
```

Keep `staging: true` until DNS and routing are known-good, then switch it to
`false` to request production Let's Encrypt certificates.

Back up the age identity printed by `chimerai config init`, normally
`~/.config/sops/age/keys.txt`. If that key is lost and the config was not
encrypted to another recipient, the local ChimerAI config cannot be decrypted.

## Validate The Host

Run validation before applying anything:

```bash
chimerai validate
```

This loads the encrypted config, validates required variables, checks Docker and
Compose access, and runs safe role diagnostics. Public deployments should route
app traffic through Traefik on ports `80` and `443`; validation reports a
warning when UFW is inactive or port exposure needs review.

Before applying a public ingress configuration, review the shared
[auth and ingress contract](auth-and-ingress.md) and confirm the non-secret
values are intentional: base domain, ACME email, Traefik/Auth enabled roles,
staging certificate mode, and each managed app hostname.

If Docker access fails with a socket permission error, fix Docker access for
your user or run the lower-level Ansible command with the appropriate privilege
model for your host. ChimerAI does not silently escalate privileges.

## Apply When Ready

Only apply once the config is correct:

```bash
chimerai apply
```

During apply, ChimerAI uses the encrypted Authentik bootstrap token to create
or update proxy providers, applications, and embedded outpost membership for
ChimerAI-managed apps that require ingress auth. It also writes a generated
verification note under the Authentik deployment directory, normally:

```text
/opt/chimerai/authentik/AUTHENTIK_SETUP.md
```

If Authentik was first started without `bootstrap_token`, create an API token
manually in Authentik, add it to the encrypted config as
`chimerai_services.authentik.bootstrap_token`, and rerun `chimerai apply`.

After apply, use the generated verification note and
[auth and ingress contract](auth-and-ingress.md) to confirm Traefik routes,
Authentik applications, provider membership, and app redirect behavior. Keep
DNS, firewall, production certificate cutover, external identity providers,
users, groups, and access policies outside this install flow.

To enable the optional Todoist MCP role, add `mcp_todoist` and `mcp_gateway` to
`chimerai_enabled_roles`, then store a real Todoist API key in the encrypted
config. The service is private by default and exposes
`http://127.0.0.1:13002/mcp` for host-based MCP clients.

When `openclaw` is enabled with MCP service roles and `mcp_gateway`, ChimerAI
attaches OpenClaw to the private MCP network and registers catalog entries such
as Todoist at their Docker-internal MCP endpoints. To validate an LLM actually
using Todoist, configure both a real Todoist API key and a real OpenClaw
provider key, then run a read-only OpenClaw agent prompt.

If OpenClaw's `mcp` CLI hangs on a specific image version, set
`chimerai_services.openclaw.mcp_registry_enabled: false` to keep the MCP
gateway catalog and private network wiring while skipping OpenClaw registry
reconciliation. The registry command is timeout-bound by
`chimerai_services.openclaw.mcp_cli_timeout`, default `20` seconds.

Run OpenClaw's first-time onboarding in the generated gateway container:

```bash
chimerai openclaw onboard
```

That helper runs OpenClaw's pre-start onboarding path through the generated
`openclaw-gateway` service, then starts the gateway service again so it can use
the generated config.

Remove ChimerAI-managed services with:

```bash
chimerai remove
```

Persistent app state should not be deleted unless a role explicitly documents
and requires an opt-in for state removal.

## Backup and Restore

ChimerAI alpha backups use Restic. Enable backups in the encrypted config before
running them:

```yaml
chimerai_backup:
  enabled: true
  engine: restic
  repository: /opt/chimerai/backups/restic
  password: replace-me
```

Use a real Restic password in the encrypted config, or set `password_file` to an
absolute path that exists on the host. For production-like use, prefer a remote
Restic repository such as S3 or B2 instead of a local path.

Run:

```bash
chimerai backup
```

The backup action snapshots the configured state root and writes a pre-backup
Authentik Postgres dump when the Authentik Compose project exists. Restore with:

```bash
chimerai restore
```

Restore uses the configured repository and the configured
`chimerai_backup.restore_target`. The default target is `/`, but ChimerAI
refuses that target unless `chimerai_backup.restore_allow_root_target: true` is
set explicitly. For public alpha drills, prefer a disposable host, temporary
restore directory, or controlled generated-state path, and record the restore
target in the validation record.

See [Backup and Restore](operations/backup-and-restore.md) for restore safety
details and drill expectations.

## Alpha Operational Gates

Before treating a host as alpha-ready, and before tagging a public alpha release,
complete these gates and record sanitized results in the
[public alpha validation record](public-alpha-validation-record.md):

- run `chimerai apply` twice and confirm the second run has no material changes;
- confirm the generated Authentik automation verification note matches the
  protected apps you expect;
- confirm each protected app follows the shared
  [auth and ingress contract](auth-and-ingress.md);
- verify OpenClaw is reachable only through the Authentik-protected Traefik
  route;
- if Todoist MCP is enabled, verify OpenClaw's MCP registry contains the
  Todoist server, or confirm the registry step was intentionally disabled with
  `openclaw.mcp_registry_enabled: false`, and run a read-only OpenClaw agent
  prompt with a real provider key;
- run `chimerai backup` and confirm Restic can list the snapshot;
- run a restore drill against a disposable host, temporary restore directory, or
  controlled generated-state path;
- capture diagnostics proof for validation, apply, service, backup, and restore
  failure inspection paths;
- review the [operator operations docs](operations/README.md) for diagnostics,
  update, backup/restore, and common failure expectations;
- review and record known public alpha limitations without private host details;
- keep Let's Encrypt staging enabled until DNS, firewall, and routing are
  confirmed, then switch to production certificates.

## Installer Options

```bash
./install.sh --force-link
```

Replace an existing `~/.local/bin/chimerai` link or file.

```bash
./install.sh --force-tools
```

Reinstall `sops` and `age` even if existing commands are found.

```bash
./install.sh --skip-tools
```

Skip `sops` and `age` installation. Use this if you manage those tools through
your operating system package manager.

## Update An Existing Checkout

Use the supported operator sequence from
[Update Lifecycle](operations/update-lifecycle.md): pull the checkout, refresh
tooling with `./install.sh`, run `chimerai validate`, then run `chimerai apply`.

Pull the latest repo changes, then rerun the installer:

```bash
git pull
./install.sh
chimerai validate
chimerai apply
```

Rerunning the installer is safe: it reuses existing tools when possible,
refreshes Python and Ansible dependencies, and keeps the CLI symlink pointed at
this checkout. During alpha, `chimerai apply` is the supported way to re-render
config and restart managed services after changing image tags or settings; a
separate `update` action is intentionally not part of the alpha lifecycle.
