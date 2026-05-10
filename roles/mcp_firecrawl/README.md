# Firecrawl MCP Role

`mcp_firecrawl` runs Firecrawl's official MCP server as a private Streamable
HTTP endpoint. It provides web search, scraping, crawling, mapping, extraction,
and related web-data tools through a Firecrawl API key.

The role is not exposed through Traefik. It joins the private `chimerai-mcp`
network and binds a loopback port for host-based clients:

```text
http://127.0.0.1:13005/mcp
```

Example:

```yaml
chimerai_enabled_roles:
  - mcp_firecrawl
  - mcp_gateway

chimerai_services:
  mcp_firecrawl:
    api_key: replace-me
```

Store the real `api_key` in the encrypted local config. Firecrawl tools can
consume API credits, so use narrow validation prompts and small result limits.
