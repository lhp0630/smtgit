#!/usr/bin/env bash
# smtgit — pull Git repos under a path by nesting depth (sdepth).
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

# shellcheck source=shared/log.sh
source "$SCRIPT_DIR/shared/log.sh"
# shellcheck source=shared/path.sh
source "$SCRIPT_DIR/shared/path.sh"
# shellcheck source=shared/git.sh
source "$SCRIPT_DIR/shared/git.sh"
# shellcheck source=shared/scan.sh
source "$SCRIPT_DIR/shared/scan.sh"

usage_root() {
  cat <<'EOF'
Usage: smtgit.sh <command> [options]

Commands:
  pull    Pull Git repositories under a path
  help    Show help for smtgit or a specific command

Run "smtgit.sh help <command>" for details.

Examples:
  bash smtgit.sh pull -p /path/to
  bash smtgit.sh pull -p /path/to --sdepth 1
  bash smtgit.sh pull -p . --sdepth 0
  bash smtgit.sh help
  bash smtgit.sh help pull
EOF
}

usage_pull() {
  cat <<'EOF'
Usage: smtgit.sh pull -p <path> [--sdepth <0|1>]

Pull Git repositories discovered under <path>.

Options:
  -p, --path <path>   Target directory (required). Absolute path, relative
                      path, or ".".
  --sdepth <n>        Git-repo nesting scan depth (default: 1).
                      Not filesystem directory depth.
                        1  First nesting level only (default).
                        0  Recurse into all nested Git repos / submodules.
                      Currently only 0 and 1 are accepted.

Path semantics:
  If <path> is itself a Git worktree root:
    - Always pull <path>.
    - Nested repos are scanned only when --sdepth 0.
  If <path> is not a Git worktree root:
    - Discover child Git repos according to --sdepth and pull each.

Examples:
  # Container of repos: pull first-level Git repos only
  bash smtgit.sh pull -p /path/to

  # Same, explicit default depth
  bash smtgit.sh pull -p /path/to --sdepth 1

  # Current directory is a repo: pull it; with 0 also pull nested repos
  bash smtgit.sh pull -p .
  bash smtgit.sh pull -p . --sdepth 0

Example tree (--sdepth 1 on a container):
  /path/to
    example_repo/          <- has .git → pull
      .git
      submodules/
        nested/            <- has .git → skipped when sdepth is 1
          .git

See docs/pull.md for the full workflow.
EOF
}

cmd_help() {
  local topic="${1:-}"

  case "$topic" in
    "")
      usage_root
      ;;
    pull)
      usage_pull
      ;;
    help)
      cat <<'EOF'
Usage: smtgit.sh help [command]

Show general help, or help for a specific command.

Commands with dedicated help:
  pull

Examples:
  bash smtgit.sh help
  bash smtgit.sh help pull
EOF
      ;;
    *)
      log_error "unknown help topic: $topic"
      usage_root
      return 1
      ;;
  esac
}

# Validate sdepth for the current CLI surface (0 or 1 only).
validate_sdepth() {
  local sdepth="$1"
  case "$sdepth" in
    0 | 1) return 0 ;;
    *)
      log_error "invalid --sdepth '$sdepth' (currently only 0 or 1 are supported)"
      return 1
      ;;
  esac
}

# Pull one repo; increment counters named by ok_var / fail_var.
_pull_one() {
  local dir=$1
  local ok_var=$2
  local fail_var=$3
  local -n _ok_ref=$ok_var
  local -n _fail_ref=$fail_var

  if git_pull "$dir"; then
    _ok_ref=$((_ok_ref + 1))
  else
    _fail_ref=$((_fail_ref + 1))
  fi
}

# Discover repos under root at sdepth and pull each (root itself is never included).
_pull_discovered() {
  local root=$1
  local sdepth=$2
  local ok_var=$3
  local fail_var=$4
  local repo
  local repos=()

  # Collect first so git pull stdout cannot race with discovery.
  mapfile -t repos < <(discover_git_repos "$root" "$sdepth")

  for repo in "${repos[@]}"; do
    [[ -z "$repo" ]] && continue
    _pull_one "$repo" "$ok_var" "$fail_var"
  done
}

cmd_pull() {
  local path_arg=""
  local sdepth=1
  local root
  local ok=0
  local fail=0

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -p | --path)
        if [[ $# -lt 2 ]]; then
          log_error "$1 requires a value"
          return 1
        fi
        path_arg=$2
        shift 2
        ;;
      --sdepth)
        if [[ $# -lt 2 ]]; then
          log_error "--sdepth requires a value"
          return 1
        fi
        sdepth=$2
        shift 2
        ;;
      -h | --help)
        usage_pull
        return 0
        ;;
      *)
        log_error "unknown option for pull: $1"
        usage_pull
        return 1
        ;;
    esac
  done

  if [[ -z "$path_arg" ]]; then
    log_error "missing required option: -p/--path"
    usage_pull
    return 1
  fi

  validate_sdepth "$sdepth" || return 1
  root=$(require_dir "$path_arg") || return 1

  log_info "path=$root sdepth=$sdepth"

  if is_git_worktree "$root"; then
    _pull_one "$root" ok fail
    if [[ "$sdepth" == "0" ]]; then
      _pull_discovered "$root" 0 ok fail
    fi
  else
    _pull_discovered "$root" "$sdepth" ok fail
  fi

  if (( ok == 0 && fail == 0 )); then
    log_warn "no Git repositories found to pull"
  fi
  log_info "done: $ok succeeded, $fail failed"

  if (( fail > 0 )); then
    return 1
  fi
  return 0
}

main() {
  local cmd="${1:-}"

  if [[ -z "$cmd" ]]; then
    usage_root
    return 1
  fi

  shift || true

  case "$cmd" in
    pull)
      cmd_pull "$@"
      ;;
    help | -h | --help)
      cmd_help "$@"
      ;;
    *)
      log_error "unknown command: $cmd"
      usage_root
      return 1
      ;;
  esac
}

main "$@"
