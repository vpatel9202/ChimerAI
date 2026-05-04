# Contributing

ChimerAI is still in design/prototype stage.

At this point, the most useful contributions are design feedback, issue reports,
small documentation improvements, and focused improvements to the initial
Ansible contract.

Before proposing role changes, read:

- [`docs/installation.md`](docs/installation.md)
- [`docs/role-contract.md`](docs/role-contract.md)
- [`docs/inventory-schema.md`](docs/inventory-schema.md)

Before submitting implementation changes, run the relevant local validation:

```bash
bash -n install.sh
bash -n bin/chimerai
uv run ansible-playbook chimerai.yml --syntax-check
uv run ansible-playbook chimerai.yml --check
```

If you have initialized local encrypted config, `chimerai validate` is the
preferred end-to-end validation wrapper.

Before opening large implementation pull requests, please start with an issue or
discussion so the design can be agreed on first.
