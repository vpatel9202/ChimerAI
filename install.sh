#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="${SCRIPT_DIR}"
readonly LOCAL_BIN="${HOME}/.local/bin"
readonly CHIMERAI_LINK="${LOCAL_BIN}/chimerai"
readonly CHIMERAI_TARGET="${REPO_ROOT}/bin/chimerai"

FORCE_LINK="false"
FORCE_TOOLS="false"
SKIP_TOOLS="false"

usage() {
  cat <<'EOF'
Usage:
  ./install.sh [--force-link] [--force-tools] [--skip-tools]

Bootstraps a local ChimerAI checkout without deploying services.

What this does:
  - checks basic host prerequisites
  - installs uv if it is missing
  - installs sops and age to ~/.local/bin if missing
  - links ~/.local/bin/chimerai to this checkout's bin/chimerai
  - runs uv sync --locked
  - installs Ansible Galaxy collections from requirements.yml

What this does not do:
  - clone the repository
  - edit shell startup files
  - create encrypted ChimerAI config
  - deploy or remove services

Options:
  --force-link    Replace an existing ~/.local/bin/chimerai file or symlink.
  --force-tools   Reinstall sops and age even if commands already exist.
  --skip-tools    Skip sops and age installation.
EOF
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

info() {
  printf '%s\n' "$*"
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "missing required command: $1"
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --force-link)
        FORCE_LINK="true"
        shift
        ;;
      --force-tools)
        FORCE_TOOLS="true"
        shift
        ;;
      --skip-tools)
        SKIP_TOOLS="true"
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "unknown option: $1"
        ;;
    esac
  done
}

detect_os() {
  local os
  os="$(uname -s)"
  case "${os}" in
    Linux)
      printf 'linux\n'
      ;;
    Darwin)
      printf 'darwin\n'
      ;;
    *)
      die "unsupported OS: ${os}"
      ;;
  esac
}

detect_arch() {
  local arch
  arch="$(uname -m)"
  case "${arch}" in
    x86_64|amd64)
      printf 'amd64\n'
      ;;
    arm64|aarch64)
      printf 'arm64\n'
      ;;
    *)
      die "unsupported architecture: ${arch}"
      ;;
  esac
}

latest_tag() {
  local repo="$1"
  local effective_url
  effective_url="$(curl -fsSL -o /dev/null -w '%{url_effective}' "https://github.com/${repo}/releases/latest")"
  printf '%s\n' "${effective_url##*/}"
}

ensure_local_bin() {
  mkdir -p "${LOCAL_BIN}"
}

ensure_path_notice() {
  case ":${PATH}:" in
    *":${LOCAL_BIN}:"*)
      ;;
    *)
      cat <<EOF

Note: ${LOCAL_BIN} is not currently on PATH.
Add this to your shell startup file, then open a new shell:

  export PATH="\$HOME/.local/bin:\$PATH"

EOF
      ;;
  esac
}

install_uv_if_missing() {
  if command -v uv >/dev/null 2>&1; then
    info "Using existing uv: $(command -v uv)"
    return
  fi

  require_cmd curl
  info "Installing uv with the official installer..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="${LOCAL_BIN}:${HOME}/.cargo/bin:${PATH}"
  require_cmd uv
}

install_sops() {
  local os="$1"
  local arch="$2"

  if [[ "${FORCE_TOOLS}" != "true" ]] && command -v sops >/dev/null 2>&1; then
    info "Using existing sops: $(command -v sops)"
    return
  fi

  [[ "${os}" == "linux" || "${os}" == "darwin" ]] || die "sops install unsupported for OS: ${os}"

  local tag
  tag="$(latest_tag getsops/sops)"

  local asset_os="${os}"
  local asset_arch="${arch}"
  if [[ "${os}" == "darwin" ]]; then
    asset_os="darwin"
  fi

  local url="https://github.com/getsops/sops/releases/download/${tag}/sops-${tag}.${asset_os}.${asset_arch}"
  local tmp_file
  tmp_file="$(mktemp)"

  info "Installing sops ${tag} to ${LOCAL_BIN}/sops"
  curl -fsSL -o "${tmp_file}" "${url}"
  install -m 0755 "${tmp_file}" "${LOCAL_BIN}/sops"
  rm -f "${tmp_file}"
}

install_age() {
  local os="$1"
  local arch="$2"

  if [[ "${FORCE_TOOLS}" != "true" ]] && command -v age >/dev/null 2>&1 && command -v age-keygen >/dev/null 2>&1; then
    info "Using existing age: $(command -v age)"
    return
  fi

  local tag
  tag="$(latest_tag FiloSottile/age)"

  local asset_os="${os}"
  case "${os}" in
    linux)
      asset_os="linux"
      ;;
    darwin)
      asset_os="darwin"
      ;;
    *)
      die "age install unsupported for OS: ${os}"
      ;;
  esac

  local archive="age-${tag}-${asset_os}-${arch}.tar.gz"
  local url="https://github.com/FiloSottile/age/releases/download/${tag}/${archive}"
  local tmp_dir
  tmp_dir="$(mktemp -d)"

  info "Installing age ${tag} to ${LOCAL_BIN}"
  curl -fsSL -o "${tmp_dir}/${archive}" "${url}"
  tar -xzf "${tmp_dir}/${archive}" -C "${tmp_dir}"
  install -m 0755 "${tmp_dir}/age/age" "${LOCAL_BIN}/age"
  install -m 0755 "${tmp_dir}/age/age-keygen" "${LOCAL_BIN}/age-keygen"
  if [[ -f "${tmp_dir}/age/age-inspect" ]]; then
    install -m 0755 "${tmp_dir}/age/age-inspect" "${LOCAL_BIN}/age-inspect"
  fi
  if [[ -f "${tmp_dir}/age/age-plugin-batchpass" ]]; then
    install -m 0755 "${tmp_dir}/age/age-plugin-batchpass" "${LOCAL_BIN}/age-plugin-batchpass"
  fi
  rm -rf "${tmp_dir}"
}

install_secret_tools() {
  if [[ "${SKIP_TOOLS}" == "true" ]]; then
    info "Skipping sops and age installation."
    return
  fi

  require_cmd curl
  require_cmd tar

  local os
  local arch
  os="$(detect_os)"
  arch="$(detect_arch)"

  install_sops "${os}" "${arch}"
  install_age "${os}" "${arch}"
}

link_cli() {
  ensure_local_bin

  [[ -x "${CHIMERAI_TARGET}" ]] || die "missing executable: ${CHIMERAI_TARGET}"

  if [[ -e "${CHIMERAI_LINK}" || -L "${CHIMERAI_LINK}" ]]; then
    local current_target
    current_target="$(readlink "${CHIMERAI_LINK}" 2>/dev/null || true)"
    if [[ "${current_target}" == "${CHIMERAI_TARGET}" ]]; then
      info "CLI already linked: ${CHIMERAI_LINK}"
      return
    fi

    if [[ "${FORCE_LINK}" != "true" ]]; then
      die "${CHIMERAI_LINK} already exists; rerun with --force-link to replace it"
    fi

    rm -f "${CHIMERAI_LINK}"
  fi

  ln -s "${CHIMERAI_TARGET}" "${CHIMERAI_LINK}"
  info "Linked CLI: ${CHIMERAI_LINK} -> ${CHIMERAI_TARGET}"
}

install_ansible_dependencies() {
  require_cmd uv

  cd "${REPO_ROOT}"
  info "Installing Python dependencies with uv..."
  uv sync --locked

  info "Installing Ansible collections..."
  uv run ansible-galaxy collection install -r requirements.yml
}

print_next_steps() {
  cat <<EOF

Bootstrap complete.

Next steps:
  1. Run: chimerai config init
  2. Edit config if needed: chimerai config edit
  3. Validate: chimerai validate
  4. Apply only when ready: chimerai apply

EOF
}

main() {
  parse_args "$@"

  require_cmd git
  require_cmd curl
  require_cmd tar

  ensure_local_bin
  export PATH="${LOCAL_BIN}:${PATH}"

  install_uv_if_missing
  install_secret_tools
  link_cli
  install_ansible_dependencies
  ensure_path_notice
  print_next_steps
}

main "$@"
