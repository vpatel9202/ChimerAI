# Qdrant Role

`qdrant` runs Qdrant as ChimerAI's first vector storage role. It is intended
for retrieval, embeddings, memory stores, and agent/application data that needs
vector search.

The role binds Qdrant to loopback by default:

```text
http://127.0.0.1:16333
```

Example:

```yaml
chimerai_enabled_roles:
  - qdrant

chimerai_services:
  qdrant:
    image: qdrant/qdrant:latest
    host: 127.0.0.1
    host_port: 16333
    grpc_host_port: 16334
```

Persistent storage lives under `/opt/chimerai/apps/qdrant/` by default.
