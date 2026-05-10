# n8n Role

`n8n` runs n8n with a colocated Postgres database for workflow automation.
Use it for operator workflows, scheduled jobs, webhooks, and integrations that
do not need to live inside an agent runtime.

The role binds n8n to loopback by default:

```text
http://127.0.0.1:15678
```

Example:

```yaml
chimerai_enabled_roles:
  - n8n

chimerai_services:
  n8n:
    postgres_password: replace-me
    encryption_key: replace-me
```

Store `postgres_password` and `encryption_key` in the encrypted local config.
Persistent n8n and Postgres state lives under `/opt/chimerai/apps/n8n/` by
default.
