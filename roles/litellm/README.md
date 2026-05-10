# LiteLLM Role

`litellm` runs the LiteLLM proxy as ChimerAI's model gateway. It exposes an
OpenAI-compatible API on loopback by default and stores proxy state in
Postgres.

The default model list is empty so the gateway can start without provider keys
or pre-pulled local models. Add models in the encrypted config.

```yaml
chimerai_enabled_roles:
  - docker
  - networks
  - litellm

chimerai_services:
  litellm:
    master_key: sk-change-me
    salt_key: change-me
    postgres_password: change-me
    models:
      - model_name: local-llama
        litellm_params:
          model: ollama/llama3.2
          api_base: http://chimerai-ollama:11434
```

Do not put real provider keys or proxy keys in committed inventories.
