# tmux config

Personal tmux configuration with TPM plugins, mouse-pane selection, clipboard copy on mouse release, Catppuccin theme, and session restore.

## Install

Install tmux first, then run:

```sh
git clone <your-repo-url> ~/.config/tmux-config
~/.config/tmux-config/scripts/install.sh
```

The installer will:

- back up an existing non-symlink `~/.tmux.conf`
- symlink this repo's `tmux.conf` to `~/.tmux.conf`
- install `~/.tmux/bin/tmux-copy`
- install or update TPM
- install tmux plugins declared in `tmux.conf`

## Dependencies

Required:

- `tmux`
- `git`

Recommended:

- `fzf`, used by `sainnhe/tmux-fzf`
- one clipboard command:
  - macOS: `pbcopy`, included by default
  - Wayland Linux: `wl-copy`, from `wl-clipboard`
  - X11 Linux: `xclip` or `xsel`

macOS example:

```sh
brew install tmux fzf
```

Ubuntu/Debian examples:

```sh
sudo apt update
sudo apt install tmux git fzf xclip
```

Wayland Linux:

```sh
sudo apt install wl-clipboard
```

## Update

```sh
cd ~/.config/tmux-config
git pull
scripts/install.sh
```

Inside tmux, reload manually with:

```sh
tmux source-file ~/.tmux.conf
```

## Plugin Shortcuts

TPM defaults:

- `prefix + I`: install plugins
- `prefix + U`: update plugins
- `prefix + alt + u`: remove plugins not listed in `tmux.conf`

The default tmux prefix is `Ctrl-b`.
