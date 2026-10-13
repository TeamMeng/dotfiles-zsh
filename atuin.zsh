# atuin — cross-shell command history search (kept from the fish setup)
# Ctrl+R / Up open the interactive history search UI. History is shared
# with fish via the same atuin database.

if (( $+commands[atuin] )) && [[ -o interactive && -t 0 && -t 1 ]]; then
  eval "$(atuin init zsh)"
fi
