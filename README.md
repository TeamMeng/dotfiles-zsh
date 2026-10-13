# zsh

Powerful and minimal zsh configuration for macOS (Apple Silicon) / Kitty.

## Dependencies

### macOS (current setup)

```sh
brew install zsh neovim eza bat fd fzf zoxide starship ripgrep atuin thefuck yazi lazygit lf mpv zellij
```

### Arch

```sh
paru -S zsh neovim eza bat fd fzf zoxide starship ripgrep
```

### Ubuntu

```sh
sudo apt install zsh neovim eza bat fd-find fzf ripgrep
# install zoxide and starship separately
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
curl -sS https://starship.rs/install.sh | sh
# Ubuntu installs bat and fd under different names — symlink them so everything works
ln -s $(which batcat) ~/.local/bin/bat
ln -s $(which fdfind) ~/.local/bin/fd
```

## Setup

**1. Clone the repo**

```sh
git clone https://github.com/TeamMeng/dotfiles-zsh ~/.config/zsh
```

**2. Point zsh at the config directory**

zsh reads `~/.zshenv` before it knows about `ZDOTDIR`, so the bootstrap has to
live in the home directory:

```sh
cp ~/.config/zsh/bootstrap/zshenv ~/.zshenv
```

**3. Set zsh as your default shell**

```sh
chsh -s $(which zsh)
```

**4. Create required directories**

```sh
mkdir -p ~/.local/state/zsh   # history
mkdir -p ~/.cache/zsh         # completion cache
```

**5. Start a new shell**

Plugins are installed automatically on first launch via the built-in plugin manager.

## Layout

| Path | Purpose |
|------|---------|
| `.zshenv` | Environment for every shell: XDG dirs, editor, pager, `GPG_TTY`, starship, PATH, timezone |
| `.zprofile` | Login shell: Homebrew mirrors, tool paths, OrbStack integration |
| `.zshrc` | Interactive shell: history, completion, keybindings, module loading |
| `aliases.zsh` | eza/bat/rg replacements, navigation, git and video helpers |
| `bindings.zsh` | Keybindings |
| `fzf.zsh` | Fuzzy finder widgets |
| `plugins.zsh` | Plugin manager — clones and sources the three plugins below |
| `prompt.zsh` | starship init |
| `atuin.zsh` | History search integration |
| `local.zsh` | Machine-local personalizations — **gitignored** |
| `starship.toml` | Prompt config |
| `bootstrap/zshenv` | The `~/.zshenv` stub that sets `ZDOTDIR` |

## Plugins

Managed without a third-party plugin manager. Plugins are cloned into
`$ZDOTDIR/plugins/` on first launch.

| Plugin | Purpose |
|--------|---------|
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Syntax highlighting |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-style inline suggestions |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) | Up/down arrow history filtering |

To update all plugins:

```sh
zplugin-update
```

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+R` | Interactive history search — [atuin](https://atuin.sh), overrides fzf's binding |
| `Ctrl+T` | Fuzzy file search including hidden files (fzf + fd) |
| `Ctrl+F` | Fuzzy file search excluding hidden files (fzf + fd) |
| `Ctrl+→` | Move forward one word |
| `Ctrl+←` | Move backward one word |
| `↑` / `↓` | History search by substring |
| `Ctrl+\` | Toggle autosuggestions |

## Starship Config

Included at [`starship.toml`](./starship.toml) and loaded via `STARSHIP_CONFIG`
in `.zshenv`. Requires a [Nerd Font](https://www.nerdfonts.com) in your terminal.

## Features & Integrations

- **Kitty integration** — shell integration and path tracking.
- **atuin** — cross-shell history search, shared with fish setup.
- **OrbStack**, conda (miniconda), nvm (lazy-loaded), zvm.
- **Homebrew Aliyun mirrors** in `.zprofile`.
- **Timezone pinned to `America/New_York`** in `.zshenv` to match network egress; override per shell with `TZ=Asia/Shanghai zsh`.
- `local.zsh` and `plugins/` stay out of git.
