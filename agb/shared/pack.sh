# Pack path helpers (skeleton). Full fetch/verify/emit later.

agb_pack_root() {
  printf '%s\n' "${AGB_ROOT}/pack"
}

agb_pack_manifest() {
  printf '%s\n' "$(agb_pack_root)/manifest.yaml"
}

# Resolve pack root; fail if manifest missing.
agb_require_pack_manifest() {
  local manifest
  manifest="$(agb_pack_manifest)"
  if [[ ! -f "$manifest" ]]; then
    log_error "pack manifest not found: ${manifest}"
    return 1
  fi
  return 0
}
