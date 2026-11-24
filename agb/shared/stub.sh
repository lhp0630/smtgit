# Shared stub helpers for architecture-skeleton commands.

# Print a not-implemented notice and exit 2.
# Usage: stub_not_implemented <command> [mvp|phase2|phase4]
stub_not_implemented() {
  local cmd="${1:?command required}"
  local phase="${2:-mvp}"

  log_error "command '${cmd}' is architecture skeleton only (not implemented)."
  case "$phase" in
    mvp)
      log_info "Planned for MVP per RFC-DOC-002 §7.6 / §7.11. See agb/docs/architecture/skeleton.md."
      ;;
    phase2)
      log_info "Planned for Phase 2+ per RFC-DOC-002 §7.6 / §7.11."
      ;;
    phase4)
      log_info "Planned for Phase 4+ per RFC-DOC-002 §7.6 / §7.11."
      ;;
    *)
      log_info "See RFC-DOC-002 for delivery phase."
      ;;
  esac
  return 2
}
