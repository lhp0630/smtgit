# Path helpers for smtgit.

# Resolve a path (including ".") to an absolute path. Does not require existence.
resolve_path() {
  local input="${1:?resolve_path: path required}"
  local dir base

  if [[ "$input" == "/" ]]; then
    printf '%s\n' "/"
    return 0
  fi

  if [[ "$input" == */ ]]; then
    input="${input%/}"
  fi

  if [[ -d "$input" ]]; then
    (cd -- "$input" && pwd -P)
    return 0
  fi

  dir=$(dirname -- "$input")
  base=$(basename -- "$input")
  if [[ ! -d "$dir" ]]; then
    log_error "path does not exist: $input"
    return 1
  fi
  printf '%s/%s\n' "$(cd -- "$dir" && pwd -P)" "$base"
}

# Ensure the path exists and is a directory; print absolute path on success.
require_dir() {
  local input="${1:?require_dir: path required}"
  local resolved

  if [[ ! -e "$input" ]]; then
    log_error "path does not exist: $input"
    return 1
  fi
  if [[ ! -d "$input" ]]; then
    log_error "not a directory: $input"
    return 1
  fi

  resolved=$(resolve_path "$input") || return 1
  printf '%s\n' "$resolved"
}
