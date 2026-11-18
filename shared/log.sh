# Logging helpers for smtgit. All diagnostics go to stderr.

log_info() {
  printf 'smtgit: %s\n' "$*" >&2
}

log_warn() {
  printf 'smtgit: warning: %s\n' "$*" >&2
}

log_error() {
  printf 'smtgit: error: %s\n' "$*" >&2
}
