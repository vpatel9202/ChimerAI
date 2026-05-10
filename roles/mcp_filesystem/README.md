# Filesystem MCP Role

`mcp_filesystem` runs the official filesystem MCP server behind a private
Streamable HTTP endpoint. It exposes only explicitly allowlisted directories to
agents.

The default allowlist is a ChimerAI-managed workspace:

```text
/opt/chimerai/apps/mcp-filesystem/workspace
```

Add additional paths deliberately:

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
      - name: repo
        path: /srv/chimerai/repo
        read_only: true
        create: false
```

Allowed path names become container paths under `/projects/<name>`. Use simple
names containing only letters, numbers, `_`, `.`, and `-`.

The role binds the MCP endpoint to loopback for host clients:

```text
http://127.0.0.1:13003/mcp
```

When `mcp_gateway` and a compatible runtime such as OpenClaw are enabled, the
role is also registered in ChimerAI's local MCP catalog as `filesystem`.
