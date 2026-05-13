## Summary

-

## Validation

- [ ] Ran the most specific validation available, or explained why it could not
      run.
- [ ] For docs-only changes, checked links and reread the changed section for
      clarity.
- [ ] For Ansible changes, ran
      `uv run ansible-playbook chimerai.yml --syntax-check` or explained why
      not.

## Release Honesty

- [ ] Public docs still describe ChimerAI as prototype alpha, unstable, and not
      production-ready where release status is discussed.
- [ ] Planned, incomplete, or unvalidated behavior is not described as
      implemented.
- [ ] Public-alpha validation evidence is complete where claimed, or explicitly
      marked incomplete/not ready.

## Secret And Local Scrub

- [ ] No secrets, credentials, tokens, private inventory values, private
      hostnames, or real domains were added.
- [ ] No `.local/` files or private `.local/` content were committed or copied
      into public docs.
- [ ] Sanitized examples use placeholders instead of private deployment details.
