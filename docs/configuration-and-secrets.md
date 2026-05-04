# Configuration And Secrets

ChimerAI uses one private YAML file for local deployment configuration:

```text
inventories/local/chimerai.sops.yaml
```

That file is ignored by git and encrypted with SOPS + age. It is where local
host settings, enabled services, ports, and secrets belong.

## Why SOPS + age

ChimerAI is meant to be edited by humans and AI coding agents. A fully opaque
encrypted file would protect secrets, but it would also make reviews and
agent-assisted edits painful.

SOPS lets the YAML structure remain readable while encrypting only sensitive
values:

```yaml
chimerai_timezone: America/Chicago
chimerai_services:
  openclaw:
    enabled: true
    provider:
      anthropic_api_key: ENC[AES256_GCM,...]
```

This gives users one config file without committing plaintext API keys,
passwords, OAuth client secrets, or bot tokens.

## Create A Local Config

Run the repo-local installer first if you have not already:

```bash
./install.sh
```

Then create the encrypted config:

```bash
chimerai config init
```

That command:

- creates an age identity at `~/.config/sops/age/keys.txt` if one does not
  already exist;
- writes `.sops.yaml` with the public age recipient;
- creates `inventories/local/chimerai.sops.yaml` from the template;
- encrypts the private config file;
- verifies that SOPS can decrypt it.

`config init` is safe to rerun. It reuses an existing age key, SOPS rules file,
and encrypted config unless `--force` is provided.

## Edit And Validate Config

Edit the encrypted config:

```bash
chimerai config edit
```

Verify it can decrypt:

```bash
chimerai config validate
```

Run the normal ChimerAI validation flow:

```bash
chimerai validate
```

The wrapper passes `chimerai_config_file` to Ansible. Ansible loads the file
with `community.sops.load_vars` before roles run.

## What Gets Encrypted

The generated `.sops.yaml` encrypts values whose key names look secret-like:

```yaml
api_key: ENC[AES256_GCM,...]
client_secret: ENC[AES256_GCM,...]
secret_key: ENC[AES256_GCM,...]
bot_token: ENC[AES256_GCM,...]
bootstrap_password: ENC[AES256_GCM,...]
```

Non-secret structure remains readable:

```yaml
chimerai_enabled_roles:
  - common
  - docker
  - networks
  - diag
  - open_webui
```

When adding new secret fields, use explicit names such as `api_key`,
`client_secret`, `secret_key`, `password`, or `token` so SOPS encrypts them.

## Manual SOPS Flow

The wrapper above is preferred. If you need to perform the steps manually,
generate an age key:

```bash
age-keygen -o ~/.config/sops/age/keys.txt
```

Copy the example SOPS config and replace the placeholder recipient with the
public key printed by `age-keygen`:

```bash
cp .sops.yaml.example .sops.yaml
```

Create and encrypt your private config:

```bash
mkdir -p inventories/local
cp templates/config/chimerai.yaml inventories/local/chimerai.sops.yaml
sops --config .sops.yaml --encrypt --in-place inventories/local/chimerai.sops.yaml
```

The lower-level Ansible equivalent of `chimerai validate` is:

```bash
uv run ansible-playbook chimerai.yml \
  -e chimerai_config_file=inventories/local/chimerai.sops.yaml \
  -e chimerai_action=validate
```

Use `chimerai_action=apply` or `chimerai_action=remove` for other lifecycle
actions.

## Rules

- Do not commit `.sops.yaml`; it contains local recipient policy.
- Do not commit `inventories/local/`; it contains private deployment config.
- Do not commit age private keys.
- Back up the age identity. If you lose `~/.config/sops/age/keys.txt`, you lose
  the ability to decrypt files encrypted only to that recipient.
- Use obvious placeholders in public examples.
- Keep `no_log: true` on tasks that render or manipulate secrets.

## Ansible Vault Fallback

Ansible Vault remains a reasonable fallback for users who do not want SOPS. It
is Ansible-native and can encrypt entire variable files, but it makes the whole
file unreadable when encrypted and is less pleasant for review-heavy,
agent-assisted configuration.

ChimerAI documentation and examples should prefer SOPS unless there is a strong
reason not to.
