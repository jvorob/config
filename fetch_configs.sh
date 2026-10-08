#!/bin/bash
set -eufo pipefail

# ANSI codes, use with `echo -e`
RED="\e[0;31m"
CLEAR_STYLE="\e[0m"

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
# TO is the in-repo location of the file
# FROM is the actual on-system location of the config file, e.g. ~/.config/foo/foo.conf
# both should be paths relative to either $HOME_DIR or $SCRIPT_DIR
gather() {
    dest="$1"
    source="$2"

    # Allows using . as shorthand. Shouldn't matter for the copy, but output is nicer?
    if [[ "$dest" = "." ]]; then
        dest="$source"
    fi

    if cp "$HOME_DIR/$source" "$SCRIPT_DIR/$dest" ; then
        echo "  $dest <= $HOME_DIR/$source"
    else
        echo -e "  $RED[NOT FOUND] $HOME_DIR/$source$CLEAR_STYLE"
    fi
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
