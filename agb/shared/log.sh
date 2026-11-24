# Logging helpers for agb. Diagnostics go to stderr.

log_info() {
  printf 'agb: %s\n' "$*" >&2
}

log_warn() {
  printf 'agb: warning: %s\n' "$*" >&2
}

log_error() {
  printf 'agb: error: %s\n' "$*" >&2
}
