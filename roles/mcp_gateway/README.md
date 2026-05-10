# MCP Gateway Role

`mcp_gateway` renders ChimerAI's local MCP catalog. MCP service roles append
their private Streamable HTTP endpoints to the in-memory catalog, and consumers
such as OpenClaw use the same catalog to register tools.

```yaml
chimerai_enabled_roles:
  - mcp_todoist
  - mcp_gateway
  - openclaw
```

The role is not a public network service. It writes
`/opt/chimerai/mcp-gateway/catalog.json` during `apply`.
