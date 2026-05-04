# 0002: Secret Configuration

- Status: Accepted
- Date: 2026-05-04

## Context

Milestone 2 introduces services that need real secrets: Authentik bootstrap
values, provider API keys, Discord bot tokens, Let’s Encrypt contact details,
and backup/restore credentials. ChimerAI also aims to be operated with coding
agents, so configuration should remain inspectable without exposing secrets.

## Decision

ChimerAI will use a single SOPS-encrypted YAML file as the preferred private
deployment configuration format.

The default private config path is:

```text
inventories/local/chimerai.sops.yaml
```

SOPS should encrypt only sensitive values. Non-secret structure such as service
selection, ports, domains, paths, and network names should remain readable.
age is the default local key mechanism.

Ansible loads the file through `community.sops.load_vars` when
`chimerai_config_file` is provided.

The `chimerai` CLI is the preferred user interface for this workflow:

```bash
chimerai config init
chimerai config edit
chimerai config validate
```

## Consequences

Users get one local configuration file for both normal settings and secrets,
without storing plaintext credentials. Diffs remain useful because most of the
YAML structure is readable.

This adds external tooling: users need `sops` and `age` on the controller. The
repo-local installer can install both to `~/.local/bin` when they are missing.
Ansible Vault remains documented as a fallback, but it is not the preferred
public ChimerAI workflow.
