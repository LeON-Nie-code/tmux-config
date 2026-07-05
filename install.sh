#!/usr/bin/env sh
set -eu

repo_url="${TMUX_CONFIG_REPO_URL:-https://github.com/LeON-Nie-code/tmux-config.git}"
install_dir="${TMUX_CONFIG_DIR:-$HOME/.config/tmux-config}"

if ! command -v git >/dev/null 2>&1; then
  printf 'git is not installed. Install git first, then rerun this command.\n' >&2
  exit 1
fi

if [ -d "$install_dir/.git" ]; then
  git -C "$install_dir" pull --ff-only
elif [ -e "$install_dir" ]; then
  printf '%s exists but is not a git repo. Move it away or set TMUX_CONFIG_DIR.\n' "$install_dir" >&2
  exit 1
else
  mkdir -p "$(dirname "$install_dir")"
  git clone "$repo_url" "$install_dir"
fi

"$install_dir/scripts/install.sh"
