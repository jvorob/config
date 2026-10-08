#!/bin/bash
set -eufo pipefail

# Copies out configs to $1
SCRIPT_DIR="$(dirname "$0")"

if [ "$#" -lt 1 ]; then
    echo "Using homedir: '$HOME'"
    HOME_DIR="$HOME"
else
    HOME_DIR="$1"
fi

if [ ! -d "$HOME_DIR" ]; then
    echo "Error: '$HOME_DIR' is not a directory"
    exit 1
fi

# USAGE: gather TO FROM
gather() {
    dest="$1"
    source="$2"

    # Allows using . as shorthand. Shouldn't matter for the copy, but output is nicer?
    if [[ "$dest" = "." ]]; then
        dest="$source"
    fi

    echo "  $dest <= $HOME_DIR/$source"
    cp "$HOME_DIR/$source" "$SCRIPT_DIR/$dest"
}

echo Gathering all known configs from this system:
gather .  .bash_aliases
gather .  .bashrc
gather .  .gitconfig
gather .  .gitignore_global
gather .  .tmux.conf
gather .  .vimrc
gather config.ghostty       .config/ghostty/config.ghostty
gather helix/config.toml    .config/helix/config.toml
gather helix/languages.toml .config/helix/languages.toml
echo 'Done! (use "git status" or "git diff HEAD" to view changes)'
