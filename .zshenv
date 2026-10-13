# ~/.config/zsh/.zshenv

# ---------- XDG base directories ----------
# Centralizes config/cache/data locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ---------- Editor ----------
# Default editor used by git, crontab, etc.
export EDITOR="nvim"
export VISUAL="nvim"

# ---------- Pager ----------
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="bat -l man -p"
elif command -v batcat >/dev/null 2>&1; then
  export MANPAGER="batcat -l man -p"
fi

# ---------- GPG ----------
# `tty` is unavailable for non-interactive shells (scripts, editors, CI).
if [[ -t 0 ]]; then
  tty_path="$(tty 2>/dev/null)"
  if [[ "$tty_path" == /dev/* ]]; then
    export GPG_TTY="$tty_path"
  else
    unset GPG_TTY
  fi
  unset tty_path
else
  unset GPG_TTY
fi

# ---------- Starship ----------
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# ---------- PATH ----------
# Personal binaries/scripts
export PATH="$HOME/.local/bin:$PATH"

# ---------- Preserved from previous ~/.zshenv ----------
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ---------- Migrated from fish config.fish ----------
# bun (PATH entries moved to .zprofile to stay ahead of brew shellenv)
export BUN_INSTALL="$HOME/.bun"

# ---------- Timezone ----------
# 网络出口在美东（纽约），把 shell 时区钉在出口上，让 git/CLI/Claude Code 的时间戳
# 与出口保持一致。macOS 系统时区也已设成 America/New_York（自动时区关闭），这里再钉
# 一层防止系统时区被改回去。
# 显式传入的 TZ 优先（TZ=Asia/Shanghai zsh）；换节点时改这一行即可。
export TZ="${TZ:-America/New_York}"
