# Git domain primitives for smtgit.

# Return 0 if dir is the root of a Git worktree (not merely inside one).
# Compatible with .git as a directory or a file (submodules).
is_git_worktree() {
  local dir="${1:?is_git_worktree: dir required}"
  local toplevel normalized

  if [[ ! -d "$dir" ]]; then
    return 1
  fi

  if ! git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    return 1
  fi

  toplevel=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null) || return 1
  normalized=$(cd -- "$dir" && pwd -P) || return 1

  [[ "$toplevel" == "$normalized" ]]
}

# Run git pull in dir. Prints progress. Returns git's exit status.
# Caller decides whether to abort the batch on failure.
git_pull() {
  local dir="${1:?git_pull: dir required}"

  log_info "pulling $dir"
  if git -C "$dir" pull; then
    log_info "ok: $dir"
    return 0
  fi

  log_error "pull failed: $dir"
  return 1
}
