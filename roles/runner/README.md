# Runner Role

`runner` provides the optional containerized variant for agent CLIs. It is for
operators who want Codex, Claude Code, Gemini CLI, and OpenCode available
inside a Docker container with an explicit mounted workspace.

The role does not mount the Docker socket and does not mount the host
filesystem by default. Configure `workspace_dir` to the host path that should
be visible at `/workspace` inside the container.

```yaml
chimerai_enabled_roles:
  - docker
  - networks
  - runner

chimerai_services:
  runner:
    workspace_dir: /opt/chimerai/apps/runner/workspace
    tools:
      codex:
        enabled: true
      claude:
        enabled: true
      gemini:
        enabled: true
      opencode:
        enabled: true
```

Authentication remains tool-native. Do not store provider tokens in committed
inventories.
