# CLI UI language resolver (RFC-DOC-002 §7.14 / research L1).
# Resolves to: en | zh
#
# Priority: --lang / AGB_LANG → messages locale (LC_ALL > LC_MESSAGES > LANG)
# with C/POSIX short-circuit → LANGUAGE list → map tag → en.

AGB_LANG_OVERRIDE="${AGB_LANG_OVERRIDE:-}"
AGB_UI_LANG="${AGB_UI_LANG:-}"

# Strip encoding / modifier: zh_CN.UTF-8 → zh_CN; C.utf8 → C
agb_locale_language_tag() {
  local loc="${1:-}"
  loc="${loc%%.*}"
  loc="${loc%%@*}"
  printf '%s\n' "$loc"
}

# Map a language tag to ui lang. Empty string = unrecognized (not en fallback).
agb_map_tag_to_ui() {
  local tag="${1:-}"
  tag=$(printf '%s' "$tag" | tr '[:upper:]' '[:lower:]')
  case "$tag" in
    "")
      printf ''
      ;;
    c | posix)
      printf 'en'
      ;;
    zh | zh_*)
      printf 'zh'
      ;;
    en | en_*)
      printf 'en'
      ;;
    *)
      printf ''
      ;;
  esac
}

# Normalize explicit override values to en|zh|empty.
agb_normalize_override() {
  local raw="${1:-}"
  raw=$(printf '%s' "$raw" | tr '[:upper:]' '[:lower:]')
  case "$raw" in
    "")
      printf ''
      ;;
    zh | zh_* | chinese)
      printf 'zh'
      ;;
    en | en_* | english)
      printf 'en'
      ;;
    *)
      printf ''
      ;;
  esac
}

# Compute and print en|zh. Does not cache.
agb_compute_ui_lang() {
  local override mapped tag tag_l effective part first
  local -a _agb_lang_parts=()
  override="$(agb_normalize_override "${AGB_LANG_OVERRIDE:-${AGB_LANG:-}}")"
  if [[ -n "$override" ]]; then
    printf '%s\n' "$override"
    return 0
  fi
  if [[ -n "${AGB_LANG_OVERRIDE:-${AGB_LANG:-}}" ]]; then
    log_warn "invalid --lang / AGB_LANG value '${AGB_LANG_OVERRIDE:-${AGB_LANG:-}}'; ignoring"
  fi

  if [[ -n "${LC_ALL:-}" ]]; then
    effective="$LC_ALL"
  elif [[ -n "${LC_MESSAGES:-}" ]]; then
    effective="$LC_MESSAGES"
  else
    effective="${LANG:-}"
  fi

  tag="$(agb_locale_language_tag "$effective")"
  tag_l=$(printf '%s' "$tag" | tr '[:upper:]' '[:lower:]')
  if [[ "$tag_l" == "c" || "$tag_l" == "posix" ]]; then
    printf 'en\n'
    return 0
  fi

  if [[ -n "${LANGUAGE:-}" ]]; then
    _agb_lang_parts=()
    IFS=':' read -r -a _agb_lang_parts <<< "$LANGUAGE"
    for part in "${_agb_lang_parts[@]}"; do
      [[ -z "$part" ]] && continue
      first=$(printf '%s' "$(agb_locale_language_tag "$part")" | tr '[:upper:]' '[:lower:]')
      case "$first" in
        zh | zh_* | en | en_*)
          mapped="$(agb_map_tag_to_ui "$first")"
          if [[ "$mapped" == "zh" || "$mapped" == "en" ]]; then
            printf '%s\n' "$mapped"
            return 0
          fi
          ;;
      esac
    done
  fi

  mapped="$(agb_map_tag_to_ui "$tag")"
  if [[ -n "$mapped" ]]; then
    printf '%s\n' "$mapped"
    return 0
  fi

  printf 'en\n'
}

agb_ui_lang() {
  if [[ -z "${AGB_UI_LANG:-}" ]]; then
    AGB_UI_LANG="$(agb_compute_ui_lang)"
  fi
  printf '%s\n' "$AGB_UI_LANG"
}

# Parse leading global options. Sets AGB_LANG_OVERRIDE; leaves remaining args in AGB_ARGV.
# Usage: agb_parse_global_args "$@"; set -- "${AGB_ARGV[@]}"
AGB_ARGV=()
agb_parse_global_args() {
  AGB_ARGV=()
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --lang)
        if [[ $# -lt 2 ]]; then
          log_error "--lang requires en or zh"
          return 1
        fi
        AGB_LANG_OVERRIDE="$2"
        shift 2
        ;;
      --lang=*)
        AGB_LANG_OVERRIDE="${1#--lang=}"
        shift
        ;;
      --)
        shift
        AGB_ARGV+=("$@")
        break
        ;;
      -*)
        # Unknown global flag: stop and let command parser handle / error.
        AGB_ARGV+=("$@")
        break
        ;;
      *)
        AGB_ARGV+=("$@")
        break
        ;;
    esac
  done
  # Reset cached lang when override may have changed.
  AGB_UI_LANG=""
  return 0
}
