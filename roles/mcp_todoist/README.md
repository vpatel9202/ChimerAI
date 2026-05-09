# Todoist MCP Role

`mcp_todoist` runs Doist's official Todoist AI MCP server as a private
streamable HTTP service.

The role is intentionally not exposed through Traefik. It joins the
`chimerai-mcp` Docker network for agent runtimes and binds a host loopback port
for host-based MCP clients.

## Configuration

```yaml
chimerai_enabled_roles:
  - mcp_todoist

chimerai_services:
  mcp_todoist:
    todoist_api_key: replace-me
    host: 127.0.0.1
    host_port: 13002
```

Store the real `todoist_api_key` in the encrypted local config. The generated
service endpoint is:

```text
http://127.0.0.1:13002/mcp
```

The health endpoint is:

```text
http://127.0.0.1:13002/health
```
