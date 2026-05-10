# Browser MCP Role

`mcp_browser` runs Microsoft's Playwright MCP server as a private HTTP MCP
service. It is intended for browser navigation, form interaction, accessibility
tree inspection, and web workflow validation by compatible agents.

The role is not exposed through Traefik. It joins the private `chimerai-mcp`
network and binds a loopback port for host-based clients:

```text
http://127.0.0.1:13004/mcp
```

Example:

```yaml
chimerai_enabled_roles:
  - mcp_browser
  - mcp_gateway

chimerai_services:
  mcp_browser:
    image: mcr.microsoft.com/playwright/mcp:latest
    browser: chromium
    headless: true
    no_sandbox: true
    allowed_hosts: "*"
```

Playwright MCP is not a security boundary. Restrict network access with Docker
networking, host firewall policy, and role-level origin settings when a
deployment needs tighter browser egress control.
