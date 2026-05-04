# Configuration And Secrets

ChimerAI uses a single private YAML file for local deployment configuration.
That file should be encrypted with SOPS and age before it contains real
secrets.

This keeps non-secret structure readable while protecting API keys, passwords,
OAuth secrets, and bot tokens at rest.

## Default Pattern

Use this layout for a private deployment:

```text
inventories/local/chimerai.sops.yaml
```

The file contains normal ChimerAI inventory variables, including service
configuration and secrets:

```yaml
chimerai_host_name: my-server
chimerai_timezone: America/Chicago
chimerai_deployment_root: /opt/chimerai
chimerai_state_root: /opt/chimerai/apps

chimerai_services:
  openclaw:
    enabled: true
    provider:
      anthropic_api_key: ENC[AES256_GCM,...]
    discord:
      enabled: true
      bot_token: ENC[AES256_GCM,...]
```

Only sensitive values should be encrypted. Hostnames, ports, enabled roles,
network names, and other non-secret settings should remain readable.

## Create A Local Config

Install `sops` and `age` using your operating system package manager.

Generate an age key:

```bash
age-keygen -o ~/.config/sops/age/keys.txt
```

Copy the example SOPS config and replace the placeholder recipient with the
public key printed by `age-keygen`:

```bash
cp .sops.yaml.example .sops.yaml
```

Create your private config:

```bash
mkdir -p inventories/local
cp templates/config/chimerai.yaml inventories/local/chimerai.sops.yaml
sops --encrypt --in-place inventories/local/chimerai.sops.yaml
```

Edit it later with:

```bash
sops inventories/local/chimerai.sops.yaml
```

## Run With The Encrypted Config

Use a minimal inventory host and pass the encrypted config path:

```bash
uv run ansible-playbook chimerai.yml \
  -e chimerai_config_file=inventories/local/chimerai.sops.yaml
```

Ansible loads the file with `community.sops.load_vars` before roles run.

## Rules

- Do not commit `.sops.yaml`; it contains local recipient policy.
- Do not commit `inventories/local/`; it contains private deployment config.
- Do not commit age private keys.
- Use obvious placeholders in public examples.
- Keep `no_log: true` on tasks that render or manipulate secrets.

## Ansible Vault Fallback

Ansible Vault remains a reasonable fallback for users who do not want SOPS. It
is Ansible-native and can encrypt entire variable files, but it makes the whole
file unreadable when encrypted and is less pleasant for review-heavy,
agent-assisted configuration.

ChimerAI documentation and examples should prefer SOPS unless there is a strong
reason not to.
