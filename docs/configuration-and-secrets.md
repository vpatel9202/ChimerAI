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
chimerai_domain: example.com
chimerai_acme_email: admin@example.com
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
bootstrap_token: ENC[AES256_GCM,...]
```

Non-secret structure remains readable:

```yaml
chimerai_enabled_roles:
  - common
  - docker
  - networks
  - traefik
  - authentik
  - backup
  - openclaw
  - mcp_todoist
  - mcp_filesystem
  - mcp_browser
  - mcp_chrome_devtools
  - mcp_firecrawl
  - mcp_gateway
  - n8n
  - langfuse
```

When adding new secret fields, use explicit names such as `api_key`,
`client_secret`, `secret_key`, `password`, or `token` so SOPS encrypts them.

## Public Ingress Settings

The first real stack uses Traefik, Authentik, and Let's Encrypt HTTP-01. These
values are not secrets, but they are deployment-specific and control the shared
[auth and ingress contract](auth-and-ingress.md):

```yaml
chimerai_domain: example.com
chimerai_acme_email: admin@example.com
chimerai_ingress:
  enabled: true
  provider: traefik
  tls:
    enabled: true
    ca: letsencrypt
    resolver: letsencrypt
    challenge: http-01
    staging: true
  auth:
    provider: authentik
    protect_apps_by_default: true
```

Set `staging: true` for first tests. After DNS, firewall, and routing are
confirmed, switch to `staging: false` and run `chimerai apply` again to request
production certificates.

HTTP-01 requires public inbound access to ports `80` and `443`. If another
service already owns those ports, Traefik will not start.

`chimerai_ingress.auth.protect_apps_by_default` is the default for managed app
`auth_required` fields. Leave it `true` for public deployments unless a role
explicitly documents why a route is safe without Authentik forward auth.

## Authentik Automation Settings

ChimerAI can automate Authentik proxy providers, applications, and embedded
outpost membership for ChimerAI-managed apps that require ingress auth. Set a
bootstrap token in the encrypted config before the first `chimerai apply`:

```yaml
chimerai_services:
  authentik:
    bootstrap_token: ENC[AES256_GCM,...]
    automation_enabled: true
```

The token is rendered as `AUTHENTIK_BOOTSTRAP_TOKEN`, which Authentik uses to
create a bootstrap API token. If an existing Authentik deployment was started
without a bootstrap token, create an API token in Authentik, store it as
`bootstrap_token`, and rerun `chimerai apply`.

Automation only wires ChimerAI-managed protected apps into Authentik. Operators
still own Authentik users, groups, policies, external identity providers, OAuth
client setup, and app-specific authorization.

## Todoist MCP Settings

The Todoist MCP role is optional and private by default. Enable it only after
adding a real Todoist API key to the encrypted config:

```yaml
chimerai_enabled_roles:
  - mcp_todoist
chimerai_services:
  mcp_todoist:
    todoist_api_key: ENC[AES256_GCM,...]
```

The role exposes the MCP endpoint on loopback, normally
`http://127.0.0.1:13002/mcp`, and joins the private `chimerai-mcp` Docker
network for agent runtimes.

When `mcp_gateway` is enabled after MCP service roles, ChimerAI writes a local
MCP catalog. When `openclaw` is also enabled, ChimerAI attaches OpenClaw to the
MCP network and registers catalog entries in OpenClaw's MCP registry:

```yaml
chimerai_enabled_roles:
  - mcp_todoist
  - mcp_gateway
  - openclaw
```

Real OpenClaw LLM validation additionally requires a provider key under
`chimerai_services.openclaw.provider`.

OpenClaw registry reconciliation is timeout-bound so a wedged OpenClaw CLI does
not hang `chimerai apply` indefinitely. If OpenClaw's `mcp` command hangs on a
specific image version, temporarily keep the MCP catalog and network wiring but
skip the OpenClaw registry step:

```yaml
chimerai_services:
  openclaw:
    mcp_registry_enabled: false
    mcp_cli_timeout: 20
```

## Filesystem MCP Settings

The filesystem MCP role is optional and private by default. It exposes only the
directories listed in `allowed_paths`. The default path is a ChimerAI-managed
workspace under `chimerai_state_root`.

```yaml
chimerai_enabled_roles:
  - mcp_filesystem
  - mcp_gateway
chimerai_services:
  mcp_filesystem:
    allowed_paths:
      - name: workspace
        path: /opt/chimerai/apps/mcp-filesystem/workspace
        create: true
      - name: repo-readonly
        path: /srv/chimerai/repo
        read_only: true
        create: false
```

Do not allowlist broad host paths such as `/`, `/home`, or `/var` unless the
deployment intentionally gives agents that scope.

## Browser MCP Settings

The browser MCP role runs Playwright MCP as a private service. Enable it with
`mcp_gateway` when compatible agent runtimes should discover it automatically:

```yaml
chimerai_enabled_roles:
  - mcp_browser
  - mcp_gateway
chimerai_services:
  mcp_browser:
    browser: chromium
    headless: true
    allowed_hosts: "*"
```

The role persists browser profile and output data under
`/opt/chimerai/apps/mcp-browser/`. Treat browser state as sensitive when agents
log into websites during validation or automation.

## Chrome DevTools MCP Settings

The Chrome DevTools MCP role runs Chrome DevTools MCP as a private service for
debugging, screenshots, console and network inspection, and performance
tracing:

```yaml
chimerai_enabled_roles:
  - mcp_chrome_devtools
  - mcp_gateway
chimerai_services:
  mcp_chrome_devtools:
    headless: true
    isolated: true
```

The role starts a managed Chromium instance inside the container. Treat it as a
mutating browser-debugging tool: agents can navigate pages, inspect page
content, run scripts, and read console or network data from the managed
browser.

## Firecrawl MCP Settings

The Firecrawl MCP role provides web search, scraping, crawling, mapping, and
structured extraction tools. It requires a Firecrawl API key:

```yaml
chimerai_enabled_roles:
  - mcp_firecrawl
  - mcp_gateway
chimerai_services:
  mcp_firecrawl:
    api_key: ENC[AES256_GCM,...]
```

Firecrawl-backed tools can spend API credits. Keep validation prompts narrow,
use small limits, and avoid broad crawls unless the operator intends that cost.

## n8n Settings

n8n requires stable encryption and database secrets. Store both in the encrypted
local config:

```yaml
chimerai_enabled_roles:
  - n8n
chimerai_services:
  n8n:
    postgres_password: ENC[AES256_GCM,...]
    encryption_key: ENC[AES256_GCM,...]
```

Do not rotate `encryption_key` casually. Existing n8n credentials and workflow
secrets depend on it.

## Langfuse Settings

Langfuse requires stable database, object storage, auth, and encryption
secrets. Store them in the encrypted local config:

```yaml
chimerai_enabled_roles:
  - langfuse
chimerai_services:
  langfuse:
    postgres_password: ENC[AES256_GCM,...]
    clickhouse_password: ENC[AES256_GCM,...]
    redis_password: ENC[AES256_GCM,...]
    minio_secret_key: ENC[AES256_GCM,...]
    nextauth_secret: ENC[AES256_GCM,...]
    salt: ENC[AES256_GCM,...]
    encryption_key: ENC[AES256_GCM,...]
```

`encryption_key` must be 64 hexadecimal characters. Do not rotate it casually;
stored Langfuse secrets and credentials depend on it.

## Backup Settings

The alpha backup workflow uses Restic. Keep the repository password in the
encrypted config or point `password_file` at a private host-local file:

```yaml
chimerai_backup:
  enabled: true
  engine: restic
  repository: s3:https://s3.amazonaws.com/example-bucket/chimerai
  password: ENC[AES256_GCM,...]
```

Local filesystem repositories are useful for first tests, but public alpha
operators should use an off-host repository for real recovery.

Restore defaults to target `/` for Restic path compatibility, but the backup
role refuses that target unless `chimerai_backup.restore_allow_root_target` is
set to `true` explicitly. Prefer setting `chimerai_backup.restore_target` to a
temporary directory for restore drills.

See [Backup and Restore](operations/backup-and-restore.md) for the operator
workflow.

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

Use `chimerai_action=apply`, `remove`, `backup`, or `restore` for other
lifecycle actions.

See [Update Lifecycle](operations/update-lifecycle.md) and
[Diagnostics](operations/diagnostics.md) for the operator sequence around these
actions.

## Rules

- Do not commit `.sops.yaml`; it contains local recipient policy.
- Do not commit `inventories/local/`; it contains private deployment config.
- Do not commit age private keys.
- Do not commit Restic passwords or repository credentials.
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
