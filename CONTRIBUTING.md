# Contributing

ChimerAI is still in design/prototype stage.

At this point, the most useful contributions are design feedback, issue reports,
small documentation improvements, and focused improvements to the initial
Ansible contract.

Before proposing role changes, read:

- [`docs/installation.md`](docs/installation.md)
- [`docs/role-governance.md`](docs/role-governance.md)
- [`docs/role-catalog.md`](docs/role-catalog.md)
- [`docs/role-contract.md`](docs/role-contract.md)
- [`docs/inventory-schema.md`](docs/inventory-schema.md)

## Role Requests And Contributions

Start with the
[role request issue template](.github/ISSUE_TEMPLATE/role_request.md) before
adding a new role. The request should state the operational problem, proposed
tier, support owner, validation path, secrets and networking impact, and why the
work belongs in ChimerAI instead of remaining a local Compose wrapper.

Implementation pull requests for roles must:

- add or update the role entry in [`docs/role-catalog.md`](docs/role-catalog.md);
- follow the inclusion criteria in
  [`docs/role-governance.md`](docs/role-governance.md);
- document lifecycle, validation, state, secrets, ingress, and auth behavior;
- include a removal or deprecation plan when replacing an existing role.

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
