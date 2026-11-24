#!/usr/bin/env bash
# agb — agent governance bootstrap (architecture skeleton).
#
# Product staging under smtgit/agb/. NOT a smtgit subcommand.
# Help UI language: RFC-DOC-002 §7.14 (research L1). CLI implementation
# language for a future standalone repo remains open (RFC §15).
set -euo pipefail

AGB_VERSION="0.0.0-skeleton"
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
AGB_ROOT="$SCRIPT_DIR"

# shellcheck source=shared/log.sh
source "$AGB_ROOT/shared/log.sh"
# shellcheck source=shared/ui_lang.sh
source "$AGB_ROOT/shared/ui_lang.sh"
# shellcheck source=shared/stub.sh
source "$AGB_ROOT/shared/stub.sh"
# shellcheck source=shared/pack.sh
source "$AGB_ROOT/shared/pack.sh"
# shellcheck source=shared/usage.sh
source "$AGB_ROOT/shared/usage.sh"
# shellcheck source=shared/commands.sh
source "$AGB_ROOT/shared/commands.sh"

cmd_help() {
  local topic="${1:-}"
  case "$topic" in
    "")
      usage_root
      ;;
    init) usage_init ;;
    scan) usage_scan ;;
    plan) usage_plan ;;
    apply) usage_apply ;;
    validate) usage_validate ;;
    update) usage_update ;;
    doctor) usage_doctor ;;
    rollback) usage_rollback ;;
    research) usage_research ;;
    rfc) usage_rfc ;;
    pack) usage_pack ;;
    help)
      usage_root
      ;;
    *)
      log_error "unknown help topic: ${topic}"
      usage_root
      return 1
      ;;
  esac
  return 0
}

main() {
  agb_parse_global_args "$@"
  set -- "${AGB_ARGV[@]}"

  local cmd="${1:-}"
  if [[ $# -gt 0 ]]; then
    shift
  fi

  case "$cmd" in
    "" | -h | --help)
      usage_root
      return 0
      ;;
    help)
      cmd_help "$@"
      ;;
    init) cmd_init "$@" ;;
    scan) cmd_scan "$@" ;;
    plan) cmd_plan "$@" ;;
    apply) cmd_apply "$@" ;;
    validate) cmd_validate "$@" ;;
    update) cmd_update "$@" ;;
    doctor) cmd_doctor "$@" ;;
    rollback) cmd_rollback "$@" ;;
    research) cmd_research "$@" ;;
    rfc) cmd_rfc "$@" ;;
    pack) cmd_pack "$@" ;;
    version | --version)
      printf 'agb %s\n' "$AGB_VERSION"
      return 0
      ;;
    *)
      log_error "unknown command: ${cmd}"
      usage_root
      return 1
      ;;
  esac
}

main "$@"
