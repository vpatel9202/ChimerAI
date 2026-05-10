# Agent CLI Role

`agent_cli` installs operator-facing coding agents on the host in a user-scoped
prefix. These tools are not long-running ChimerAI services.

Default install mode is npm with:

```text
~/.local/share/chimerai/agent-cli/npm
```

Executables are linked into:

```text
~/.local/bin
```

## Configuration

```yaml
chimerai_enabled_roles:
  - agent_cli

chimerai_services:
  agent_cli:
    install_method: npm
    install_node: true
    node_repository_enabled: true
    node_major: 22
    install_prefix: "{{ ansible_env.HOME }}/.local/share/chimerai/agent-cli/npm"
    bin_dir: "{{ ansible_env.HOME }}/.local/bin"
    tools:
      codex:
        enabled: true
      claude:
        enabled: false
      gemini:
        enabled: false
```

Real authentication remains tool-native and local to the operator. Do not store
agent login state or provider tokens in the public repo.
