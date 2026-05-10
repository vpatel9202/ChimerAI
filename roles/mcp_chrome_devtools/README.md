# Chrome DevTools MCP Role

`mcp_chrome_devtools` runs Chrome DevTools MCP as a private MCP service for
browser inspection, debugging, screenshots, console/network analysis, and
performance tracing.

The role exposes a loopback MCP endpoint by default:

```text
http://127.0.0.1:13006/mcp
```

Enable it with `mcp_gateway` when compatible runtimes should discover it:

```yaml
chimerai_enabled_roles:
  - mcp_chrome_devtools
  - mcp_gateway

chimerai_services:
  mcp_chrome_devtools:
    image: mcr.microsoft.com/playwright:v1.56.1-noble
    server_version: "0.2.7"
    supergateway_version: "3.4.3"
    host: 127.0.0.1
    host_port: 13006
    container_port: 3000
    headless: true
    isolated: true
```

This role starts Chromium with remote debugging inside the container and points
Chrome DevTools MCP at that browser. Browser profile and npm cache state live
under `/opt/chimerai/apps/mcp-chrome-devtools/`.

Treat this role as a mutating browser-debugging tool. It can navigate pages,
inspect page content, run scripts, capture screenshots, and read console and
network data from the managed browser instance.
