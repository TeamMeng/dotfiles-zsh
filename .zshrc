# Powerful but minimal zsh configuration
# Author: Radley E. Sidwell-Lewis
# GitHub: https://www.github.com/radleylewis/zsh
#
# Uses:
#   Plugins:      fast-syntax-highlighting, zsh-autosuggestions,
#                 zsh-history-substring-search
#   Prompt:       starship
#   Navigation:   zoxide, fzf, fd
#   CLI tools:    eza, bat, nvim, ripgrep
#   Node:         nvm

# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# =========================================================
# Shell behaviour
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# =========================================================
# Smart directory navigation & lf
# =========================================================

if [[ -r "$HOME/.config/lf/icons" ]]; then
  LF_ICONS=$(tr '\n' ':' < "$HOME/.config/lf/icons")
  export LF_ICONS
fi

# Initialize zoxide
path=(
  "$HOME/.strix/bin"
  "$HOME/.bun/bin"
  "$HOME/.pixi/bin"
  "$HOME/.local/bin"
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  "/Applications/Postgres.app/Contents/Versions/latest/bin"
  "$HOME/development/flutter/bin"
  "/opt/homebrew/opt/postgresql@15/bin"
  /opt/homebrew/bin
  /opt/malt/bin
  /opt/malt/sbin
  /usr/local/bin
  "$HOME/go/bin"
  $path
)
typeset -U path PATH

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# =========================================================
# Completion
# =========================================================

# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# =========================================================
# Fuzzy finder
# =========================================================

# macOS / Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# macOS / Homebrew (Intel)
if [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# Arch
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Ubuntu
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# =========================================================
# Modular Config Files
# =========================================================

# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"

# atuin (history search, from fish setup)
source "$ZDOTDIR/atuin.zsh"

# Local personalizations (thefuck, etc.)
source "$ZDOTDIR/local.zsh"


# =========================================================
# Node / NVM (lazy: loading nvm.sh and selecting a version is expensive)
# =========================================================

export NVM_DIR="$HOME/.nvm"
if [[ -d "$NVM_DIR" ]]; then
  _nvm_load() {
    unset -f nvm node npm npx _nvm_load
    [[ -r "$NVM_DIR/nvm.sh" ]] || return 127
    source "$NVM_DIR/nvm.sh" --no-use
    [[ -r "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
    nvm use default --silent >/dev/null 2>&1
  }

  nvm()  { _nvm_load && nvm "$@"; }
  node() { _nvm_load && command node "$@"; }
  npm()  { _nvm_load && command npm "$@"; }
  npx()  { _nvm_load && command npx "$@"; }
fi

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# Kitty Shell Integration (稳定启用路径同步与命令跟踪)
if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
  export KITTY_SHELL_INTEGRATION="enabled"
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
