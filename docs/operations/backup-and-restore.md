# Backup and Restore

ChimerAI alpha backup and restore use Restic through the `backup` role. The
workflow snapshots ChimerAI-managed state and can restore it to a chosen target.

## Protected And Unprotected Data

Protected by the alpha backup workflow:

- configured ChimerAI state paths, currently `chimerai_state_root`;
- backup work output under `chimerai_backup_work_dir`;
- an Authentik Postgres logical dump when the Authentik Compose project exists.

Not protected by the alpha backup workflow:

- the git checkout and generated Ansible dependencies;
- external DNS, registrar, cloud, or identity-provider configuration;
- data stored outside ChimerAI-managed state paths;
- local-only secret files referenced by path, such as a Restic `password_file`;
- Docker images, package caches, and other rebuildable host runtime artifacts.

Keep Restic repository credentials outside public docs and validation records.

## Configure Backups

Set backup values in encrypted local config:

```yaml
chimerai_backup:
  enabled: true
  engine: restic
  repository: s3:https://s3.amazonaws.com/example-bucket/chimerai
  password: ENC[AES256_GCM,...]
  tags:
    - chimerai
```

Use `password_file` instead of `password` when the Restic password should live
in a private host-local file. Do not commit repository passwords or cloud
credentials.

For real recovery, prefer an off-host Restic repository. A local repository is
acceptable for first tests and disposable drills, but it does not protect
against host loss.

## Run A Backup

```bash
chimerai backup
```

The backup action:

- validates Restic settings;
- creates backup work directories under `chimerai_deployment_root`;
- writes an Authentik Postgres dump when the Authentik Compose project exists;
- runs `restic backup` for configured ChimerAI state paths.

## Restore Safely

By default, `chimerai_backup.restore_target` is `/`, which matches Restic's
full-path restore behavior. ChimerAI refuses that target unless the operator
explicitly opts in:

```yaml
chimerai_backup:
  restore_target: /tmp/chimerai-restore
```

Only set this opt-in for a disposable host or a deliberately accepted full-host
restore:

```yaml
chimerai_backup:
  restore_target: /
  restore_allow_root_target: true
```

Run restore after the target is set:

```bash
chimerai restore
```

The restore action restores the selected Restic snapshot, then restores the
Authentik Postgres dump when a restored dump and Compose project are present.

## Drill Expectations

A public alpha restore drill should use one of these targets:

- a disposable host;
- a temporary restore directory such as `/tmp/chimerai-restore`;
- a controlled generated-state path used only for the drill.

Record the restore target, snapshot choice, command, result, and limitation in
the [public alpha validation record](../public-alpha-validation-record.md).
Confirm that no secret output was printed.
