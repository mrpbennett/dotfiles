sync-dotfiles() {
  cd
  cd .dotfiles

  local dry
  dry=$(stow -n --restow --target="$HOME" --no-folding . 2>&1)

  if echo "$dry" | grep -q "existing target is neither a link nor a directory"; then
    echo "$dry"
    echo "--- conflicts found: real files exist at target, adopting them into the repo ---"
    ad-dotfiles
  else
    re-dotfiles
  fi
}
