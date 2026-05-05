# Installation

This guide bootstraps a local ChimerAI checkout on the machine that will run
Ansible. It does not deploy services.

Use this guide when starting from a fresh clone. If the repo is already
bootstrapped, the most common commands are:

```bash
chimerai config edit
chimerai validate
chimerai apply
```

## Prerequisites

ChimerAI currently targets Linux hosts, with Ubuntu 24.04 as the primary test
platform. The installer also has basic macOS detection for controller-side
tooling, but the service roles are not yet validated for macOS targets.

Install these before starting:

- `git`
- `curl`
- `tar`
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
    secret_key: replace-me
    postgres_password: replace-me
  openclaw:
    host: openclaw.example.com
```

Keep `staging: true` until DNS and routing are known-good, then switch it to
`false` to request production Let's Encrypt certificates.

## Validate The Host

Run validation before applying anything:

```bash
chimerai validate
```

This loads the encrypted config, validates required variables, checks Docker and
Compose access, and runs safe role diagnostics.

If Docker access fails with a socket permission error, fix Docker access for
your user or run the lower-level Ansible command with the appropriate privilege
model for your host. ChimerAI does not silently escalate privileges.

## Apply When Ready

Only apply once the config is correct:

```bash
chimerai apply
```

After the first apply, finish Authentik setup in the browser at the configured
auth hostname. ChimerAI writes a generated setup checklist under the Authentik
deployment directory, normally:

```text
/opt/chimerai/authentik/AUTHENTIK_SETUP.md
```

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

Pull the latest repo changes, then rerun the installer:

```bash
git pull
./install.sh
chimerai validate
```

Rerunning the installer is safe: it reuses existing tools when possible,
refreshes Python and Ansible dependencies, and keeps the CLI symlink pointed at
this checkout.
