# Common Failure Modes

Use this page to map an error to the first likely layer. Run diagnostics before
changing service config.

## Inventory Or Secret Errors

Symptoms:

- required variable assertion fails;
- SOPS or age cannot decrypt local config;
- a role reports missing backup, domain, or service values.

First checks:

```bash
chimerai validate
sops --decrypt inventories/local/chimerai.sops.yaml
```

Keep decrypted output private. Do not paste real secrets into public issues.

## Docker Runtime Errors

Symptoms:

- Docker CLI is missing;
- Docker Compose v2 is missing;
- the current user cannot reach the Docker daemon.

First checks:

```bash
docker --version
docker compose version
docker info
```

Fix Docker installation or daemon access before re-running ChimerAI.

## Network Or Exposure Warnings

Symptoms:

- UFW is inactive or unavailable;
- unexpected TCP ports are listening;
- configured Docker networks are absent after apply.

First checks:

```bash
chimerai validate
ss -H -tln
docker network ls
```

Public alpha hosts should route app traffic through Traefik on ports `80` and
`443`. App ports should bind to localhost or Docker-only networks unless a role
documents another reason.

## Service Health Failures

Symptoms:

- post-apply HTTP endpoint checks fail;
- containers restart;
- a generated Compose project is missing expected services.

First checks:

```bash
docker compose --project-directory /opt/chimerai/apps/<service> ps
docker compose --project-directory /opt/chimerai/apps/<service> logs --tail=100
```

Check the service's role README and rendered Compose file before changing shared
inventory.

## Backup Or Restore Failures

Symptoms:

- Restic is missing;
- backup configuration assertion fails;
- restore refuses target `/`;
- Restic cannot access the repository.

First checks:

```bash
chimerai validate
chimerai backup
```

For restore drills, set `chimerai_backup.restore_target` to a temporary
directory. Restoring to `/` requires `chimerai_backup.restore_allow_root_target:
true`.
