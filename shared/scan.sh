# Discover Git repos by nesting depth (sdepth), not filesystem depth.

# Internal: walk from dir looking for worktree roots.
# remaining_depth: empty string means unlimited; otherwise integer layers left.
# When a worktree root is found it is printed; further descent only continues
# if remaining_depth is unlimited or still > 0 after consuming one layer.
_discover_git_repos_walk() {
  local dir="$1"
  local remaining_depth="$2"
  local child name next_depth

  for child in "$dir"/*; do
    # Unmatched glob stays literal; skip it.
    [[ -d "$child" ]] || continue
    name=$(basename -- "$child")
    [[ "$name" == ".git" ]] && continue

    if is_git_worktree "$child"; then
      printf '%s\n' "$(cd -- "$child" && pwd -P)"
      if [[ -z "$remaining_depth" ]]; then
        _discover_git_repos_walk "$child" ""
      elif (( remaining_depth > 1 )); then
        next_depth=$((remaining_depth - 1))
        _discover_git_repos_walk "$child" "$next_depth"
      fi
      # sdepth layer consumed: do not walk non-repo children inside this repo
      # beyond the remaining budget (already handled above).
      continue
    fi

    # Not a worktree root: keep walking without consuming a git nesting layer.
    _discover_git_repos_walk "$child" "$remaining_depth"
  done
}

# discover_git_repos <root> <sdepth>
# Prints absolute paths of Git worktree roots under root (never root itself).
# sdepth 0 = unlimited nesting; sdepth N = collect up to N nested layers.
# Designed so future N>1 works; callers may still restrict accepted values.
discover_git_repos() {
  local root="${1:?discover_git_repos: root required}"
  local sdepth="${2:?discover_git_repos: sdepth required}"
  local remaining_depth

  if [[ ! -d "$root" ]]; then
    log_error "not a directory: $root"
    return 1
  fi

  if [[ "$sdepth" == "0" ]]; then
    remaining_depth=""
  else
    remaining_depth="$sdepth"
  fi

  _discover_git_repos_walk "$root" "$remaining_depth"
}
