#!/bin/bash
set -eufo pipefail

# Copies out configs to $1
SCRIPT_DIR="$(dirname "$0")"

if [ "$#" -lt 1 ]; then
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

if [[ "$#" -eq "2" && "$2" == "-f" ]]; then
    #NOTE: wont clobber existing files
    echo OVERWRITING EXISTING CONFIGS
    cp -f "$SCRIPT_DIR"/.bash_aliases "$HOME_DIR/"
    cp -f "$SCRIPT_DIR"/.bashrc "$HOME_DIR/"
    cp -f "$SCRIPT_DIR"/.gitconfig "$HOME_DIR/"
    cp -f "$SCRIPT_DIR"/.gitignore_global "$HOME_DIR/"
    cp -f "$SCRIPT_DIR"/.tmux.conf "$HOME_DIR/"
    cp -f "$SCRIPT_DIR"/.vimrc "$HOME_DIR/"
else
    #NOTE: wont clobber existing files
    echo Copying configs without clobbering
    cp -n "$SCRIPT_DIR"/.bash_aliases "$HOME_DIR/"
    cp -n "$SCRIPT_DIR"/.bashrc "$HOME_DIR/"
    cp -n "$SCRIPT_DIR"/.gitconfig "$HOME_DIR/"
    cp -n "$SCRIPT_DIR"/.gitignore_global "$HOME_DIR/"
    cp -n "$SCRIPT_DIR"/.tmux.conf "$HOME_DIR/"
    cp -n "$SCRIPT_DIR"/.vimrc "$HOME_DIR/"
fi

