# 0009: Public Alpha Release Readiness

Milestone 9 prepares the repository for a future `v0.1.0-alpha` release without
tagging before evidence exists.

## Goals

- Make the public alpha release checklist actionable.
- Keep the validation record as the hard pre-tag blocker.
- Draft release notes that explain who should try the alpha and who should
  wait.
- Document demo evidence slots without inventing output.
- Capture GitHub repository polish tasks that must be checked before release.
- Add pull request checks for validation, release honesty, and secret scrubbing.

## Non-Goals

- No `v0.1.0-alpha` tag.
- No claim that public alpha validation has passed.
- No fake demo output, screenshots, or release evidence.
- No production-readiness or stability claim.

## Deliverables

- Updated [public alpha evidence checklist](../public-alpha-checklist.md).
- Updated [public alpha validation record](../public-alpha-validation-record.md).
- Updated [demo and sample output plan](../demo-and-sample-output.md).
- Draft [v0.1.0-alpha release notes](../releases/v0.1.0-alpha.md).
- Updated [changelog](../../CHANGELOG.md).
- Pull request template with release-honesty and secret-scrub checks.

## Completion Criteria

- Public docs clearly block release while validation evidence is incomplete.
- Release notes explain the intended alpha audience and wait-list audience.
- Manual GitHub polish is recorded as a release task.
- No public document implies the alpha is stable or ready to tag.
