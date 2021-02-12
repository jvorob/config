#!/bin/bash
set -eufo pipefail

# Copies out configs to $1
SCRIPT_DIR="$(dirname "$0")"

if [ "$#" -ne 1 ]; then
    echo "Needs 1 arg: home dir to copy configs to"
    exit 1
fi

HOME_DIR="$1"
if [ ! -d "$HOME_DIR" ]; then
    echo "Error: '$HOME_DIR' is not a directory"
    exit 1
fi

if [ ! -w "$HOME_DIR" ]; then
    echo "Error: '$HOME_DIR' is not writable"
    exit 1
fi

#NOTE: wont clobber existing files
echo cp -n "$SCRIPT_DIR"/.bash_aliases "$HOME_DIR/"
echo cp -n "$SCRIPT_DIR"/.bashrc "$HOME_DIR/"
echo cp -n "$SCRIPT_DIR"/.gitconfig "$HOME_DIR/"
echo cp -n "$SCRIPT_DIR"/.gitignore_global "$HOME_DIR/"
echo cp -n "$SCRIPT_DIR"/.tmux.conf "$HOME_DIR/"
echo cp -n "$SCRIPT_DIR"/.vimrc "$HOME_DIR/"
