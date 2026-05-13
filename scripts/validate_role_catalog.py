#!/usr/bin/env python3
"""Validate docs/role-catalog.md against roles/* directories."""

from __future__ import annotations

import re
import sys
from collections import Counter
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ROLES_DIR = ROOT / "roles"
CATALOG = ROOT / "docs" / "role-catalog.md"

APPROVED_TIERS = {"core", "reference", "community", "experimental"}
APPROVED_STATUSES = {"active", "best-effort", "experimental", "deprecated"}
ROLE_RE = re.compile(r"^`?roles/([A-Za-z0-9_][A-Za-z0-9_-]*)`?$")
CODE_VALUE_RE = re.compile(r"^`?([A-Za-z0-9_-]+)`?$")


def normalize_cell(value: str) -> str:
    return value.strip()


def normalize_code_value(value: str) -> str:
    match = CODE_VALUE_RE.match(normalize_cell(value))
    return match.group(1) if match else normalize_cell(value)


def parse_catalog_rows(markdown: str) -> tuple[list[tuple[int, str, str, str]], list[str]]:
    rows: list[tuple[int, str, str, str]] = []
    errors: list[str] = []

    for lineno, line in enumerate(markdown.splitlines(), start=1):
        stripped = line.strip()
        if not stripped.startswith("|") or "roles/" not in stripped:
            continue

        cells = [cell.strip() for cell in stripped.strip("|").split("|")]
        if len(cells) < 4:
            errors.append(
                f"line {lineno}: role row must include role, tier, status, "
                "and support owner"
            )
            continue

        role_match = ROLE_RE.match(cells[0])
        if not role_match:
            errors.append(f"line {lineno}: first cell must be `roles/<name>`")
            continue

        rows.append(
            (
                lineno,
                role_match.group(1),
                normalize_code_value(cells[1]),
                normalize_code_value(cells[2]),
            )
        )

    return rows, errors


def main() -> int:
    errors: list[str] = []

    if not ROLES_DIR.is_dir():
        errors.append(f"missing roles directory: {ROLES_DIR.relative_to(ROOT)}")
        role_dirs: list[str] = []
    else:
        role_dirs = sorted(path.name for path in ROLES_DIR.iterdir() if path.is_dir())

    if not CATALOG.is_file():
        errors.append(f"missing catalog: {CATALOG.relative_to(ROOT)}")
        print_errors(errors)
        return 1

    rows, parse_errors = parse_catalog_rows(CATALOG.read_text(encoding="utf-8"))
    errors.extend(parse_errors)

    catalog_roles = [role for _, role, _, _ in rows]
    counts = Counter(catalog_roles)

    missing = sorted(set(role_dirs) - set(catalog_roles))
    extra = sorted(set(catalog_roles) - set(role_dirs))
    duplicates = sorted(role for role, count in counts.items() if count > 1)

    if missing:
        errors.append("missing catalog entries: " + ", ".join(f"roles/{role}" for role in missing))
    if extra:
        errors.append("catalog entries without roles directory: " + ", ".join(f"roles/{role}" for role in extra))
    if duplicates:
        errors.append("duplicate catalog entries: " + ", ".join(f"roles/{role}" for role in duplicates))

    for lineno, role, tier, status in rows:
        if tier not in APPROVED_TIERS:
            errors.append(f"line {lineno}: roles/{role} has invalid tier {tier!r}")
        if status not in APPROVED_STATUSES:
            errors.append(f"line {lineno}: roles/{role} has invalid status {status!r}")

    if errors:
        print_errors(errors)
        return 1

    print(f"role catalog ok: {len(role_dirs)} roles")
    return 0


def print_errors(errors: list[str]) -> None:
    print("role catalog validation failed:", file=sys.stderr)
    for error in errors:
        print(f"- {error}", file=sys.stderr)


if __name__ == "__main__":
    raise SystemExit(main())
