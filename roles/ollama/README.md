# Ollama Role

`ollama` runs the local model runtime in Docker Compose and exposes the API on
loopback by default.

The role does not pull models automatically. Operators should choose models
explicitly after the service is running.

```yaml
chimerai_enabled_roles:
  - docker
  - networks
  - ollama

chimerai_services:
  ollama:
    host: 127.0.0.1
    host_port: 11434
    gpu: none
```

Supported `gpu` values are `none`, `nvidia`, and `amd`.
