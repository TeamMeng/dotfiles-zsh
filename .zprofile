# Login shell environment — migrated from ~/.zprofile (previous setup)

# ckbrew: Aliyun mirrors for Homebrew
export HOMEBREW_PIP_INDEX_URL=http://mirrors.aliyun.com/pypi/simple #ckbrew
export HOMEBREW_API_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles/api  #ckbrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles #ckbrew
# Malt speaks the GHCR registry API; keep it on upstream endpoints.
export MALT_API_DOMAIN=https://formulae.brew.sh/api
export MALT_BOTTLE_DOMAIN=https://ghcr.io
[[ -x /opt/homebrew/bin/brew ]] && eval "$(SHELL=/bin/zsh /opt/homebrew/bin/brew shellenv)" #ckbrew

# Custom tool paths ahead of inherited PATH (same priority as fish's fish_add_path)
export PATH="$HOME/.strix/bin:$BUN_INSTALL/bin:$HOME/.pixi/bin:$HOME/.local/bin:$PATH"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
