#!/usr/bin/env sh
set -eu

repo_dir="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
tmux_conf_src="$repo_dir/tmux.conf"
tmux_conf_dst="$HOME/.tmux.conf"
tmux_dir="$HOME/.tmux"
plugins_dir="$tmux_dir/plugins"
bin_dir="$tmux_dir/bin"

backup_existing_tmux_conf() {
  if [ -e "$tmux_conf_dst" ] && [ ! -L "$tmux_conf_dst" ]; then
    backup="$tmux_conf_dst.backup.$(date +%Y%m%d%H%M%S)"
    mv "$tmux_conf_dst" "$backup"
    printf 'Backed up existing %s to %s\n' "$tmux_conf_dst" "$backup"
  fi
}

install_clipboard_script() {
  mkdir -p "$bin_dir"
  cp "$repo_dir/scripts/tmux-copy" "$bin_dir/tmux-copy"
  chmod +x "$bin_dir/tmux-copy"
}

link_tmux_conf() {
  ln -sfn "$tmux_conf_src" "$tmux_conf_dst"
}

install_tpm() {
  mkdir -p "$plugins_dir"
  if [ ! -d "$plugins_dir/tpm/.git" ]; then
    git clone https://github.com/tmux-plugins/tpm "$plugins_dir/tpm"
  else
    git -C "$plugins_dir/tpm" pull --ff-only
  fi
}

install_plugins() {
  tmux start-server \; source-file "$tmux_conf_dst" \; show-environment -g TMUX_PLUGIN_MANAGER_PATH >/dev/null
  "$plugins_dir/tpm/bin/install_plugins"
}

main() {
  if ! command -v tmux >/dev/null 2>&1; then
    printf 'tmux is not installed. Install tmux first, then rerun this script.\n' >&2
    exit 1
  fi

  if ! command -v git >/dev/null 2>&1; then
    printf 'git is not installed. Install git first, then rerun this script.\n' >&2
    exit 1
  fi

  backup_existing_tmux_conf
  install_clipboard_script
  link_tmux_conf
  install_tpm
  install_plugins

  printf '\nDone. tmux config installed from %s\n' "$repo_dir"
  printf 'Open a new tmux session or run: tmux source-file ~/.tmux.conf\n'
}

main "$@"
