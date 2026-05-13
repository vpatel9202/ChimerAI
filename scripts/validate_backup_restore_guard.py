#!/usr/bin/env python3
"""Validate that root restores require an explicit opt-in."""

from __future__ import annotations

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DEFAULTS = ROOT / "roles" / "backup" / "defaults" / "main.yml"
TASKS = ROOT / "roles" / "backup" / "tasks" / "main.yml"


def main() -> int:
    errors: list[str] = []
    defaults = DEFAULTS.read_text(encoding="utf-8")
    tasks = TASKS.read_text(encoding="utf-8")

    if "chimerai_backup_restore_allow_root_target" not in defaults:
        errors.append("backup defaults must define chimerai_backup_restore_allow_root_target")

    if "Refuse root restore target without explicit opt-in" not in tasks:
        errors.append("backup role must include a named root restore guard task")
    elif tasks.index("Refuse root restore target without explicit opt-in") > tasks.index(
        "Check Restic CLI"
    ):
        errors.append("backup root restore guard must run before checking Restic")

    required_fragments = [
        "chimerai_backup_restore_target == '/'",
        "not (chimerai_backup_restore_allow_root_target | bool)",
        "Restoring to / is destructive",
    ]
    for fragment in required_fragments:
        if fragment not in tasks:
            errors.append(f"backup root restore guard missing: {fragment}")

    if errors:
        print("backup restore guard validation failed:", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    print("backup restore guard ok")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
