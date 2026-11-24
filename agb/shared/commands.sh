# Command stubs for RFC-DOC-002 §7.6. No mutating governance logic yet.

cmd_init() {
  stub_not_implemented "init" mvp
}

cmd_scan() {
  stub_not_implemented "scan" mvp
}

cmd_plan() {
  local sub="${1:-}"
  shift || true
  case "$sub" in
    migrate)
      stub_not_implemented "plan migrate" mvp
      ;;
    approve)
      stub_not_implemented "plan approve" phase2
      ;;
    "" | help | -h | --help)
      usage_plan
      return 0
      ;;
    *)
      log_error "unknown plan subcommand: ${sub}"
      usage_plan
      return 1
      ;;
  esac
}

cmd_apply() {
  stub_not_implemented "apply" phase2
}

cmd_validate() {
  stub_not_implemented "validate" mvp
}

cmd_update() {
  stub_not_implemented "update" phase4
}

cmd_doctor() {
  stub_not_implemented "doctor" phase4
}

cmd_rollback() {
  stub_not_implemented "rollback" phase2
}

cmd_research() {
  stub_not_implemented "research" mvp
}

cmd_rfc() {
  stub_not_implemented "rfc" mvp
}

cmd_pack() {
  local sub="${1:-}"
  shift || true
  case "$sub" in
    fetch)
      stub_not_implemented "pack fetch" mvp
      ;;
    emit)
      # Expect --prompt-only in full impl; skeleton only checks presence later.
      stub_not_implemented "pack emit" mvp
      ;;
    "" | help | -h | --help)
      usage_pack
      return 0
      ;;
    *)
      log_error "unknown pack subcommand: ${sub}"
      usage_pack
      return 1
      ;;
  esac
}
