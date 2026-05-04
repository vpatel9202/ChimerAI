# Installation

This guide bootstraps a local ChimerAI checkout on the machine that will run
Ansible. It does not deploy services.

## Prerequisites

ChimerAI currently targets Linux hosts, with Ubuntu 24.04 as the primary test
platform. The installer also has basic macOS detection for controller-side
tooling, but the service roles are not yet validated for macOS targets.

Install these before starting:

- `git`
- `curl`
- `tar`
- Docker with Compose v2, if you want validation to check the Docker runtime

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

## Validate The Host

Run validation before applying anything:

```bash
chimerai validate
```

This loads the encrypted config, validates required variables, checks Docker and
Compose access, and runs safe role diagnostics.

## Apply When Ready

Only apply once the config is correct:

```bash
chimerai apply
```

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
