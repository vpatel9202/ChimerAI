# Langfuse Role

`langfuse` runs Langfuse v3 for LLM traces, prompt visibility, evaluations, and
observability.

The role uses the current self-hosted architecture:

- Langfuse web
- Langfuse worker
- Postgres
- ClickHouse
- Redis
- MinIO for S3-compatible object storage

The web UI binds to loopback by default:

```text
http://127.0.0.1:13000
```

Store all required secrets in the encrypted local config:

```yaml
chimerai_enabled_roles:
  - langfuse

chimerai_services:
  langfuse:
    postgres_password: replace-me
    clickhouse_password: replace-me
    redis_password: replace-me
    minio_secret_key: replace-me
    nextauth_secret: replace-me
    salt: replace-me
    encryption_key: 0000000000000000000000000000000000000000000000000000000000000000
```

`encryption_key` must be 64 hexadecimal characters. Do not rotate it casually;
stored credentials and sensitive settings depend on it.
