# Diagnostics

Use diagnostics to separate configuration, host prerequisite, network, and
post-apply service failures.

## Run Diagnostics

From a configured checkout:

```bash
chimerai validate
```

The validate path is read-only. It checks inventory shape, host assumptions,
runtime settings, firewall exposure, and listening ports. It must not deploy
services or change app state.

After applying services:

```bash
chimerai apply
```

Post-apply diagnostics run only during `apply`. They check generated service
endpoints and registry wiring after containers should already exist.

## Output Groups

Diagnostics are grouped by failure type:

- **Runtime prerequisites**: Docker runtime and Compose configuration.
- **Host exposure**: firewall state and listening TCP ports.
- **Docker network state**: configured ChimerAI networks.
- **Service health**: app endpoints that should respond after apply.
- **MCP registry**: OpenClaw registry entries for configured MCP servers.

Use the group header to decide where to inspect next. For example, a service
health failure usually means checking the rendered Compose project and container
logs, while a host exposure warning usually means checking firewall and bind
addresses.

## Useful Follow-Up Commands

```bash
chimerai validate
docker compose --project-directory /opt/chimerai/apps/<service> ps
docker compose --project-directory /opt/chimerai/apps/<service> logs --tail=100
docker network ls
ss -H -tln
```

Replace service paths with the configured `chimerai_deployment_root` layout.

## Evidence Rules

When recording diagnostics for public alpha evidence, keep output sanitized:

- include command, environment class, pass/fail status, and known limitation;
- remove private hostnames, domains when sensitive, tokens, passwords, and
  provider account IDs;
- summarize long logs instead of pasting full container output.
