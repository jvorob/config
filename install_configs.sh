#!/bin/bash
set -eufo pipefail

# Copies out configs to $1
SCRIPT_DIR="$(dirname "$0")"

if [ "$#" -lt 1 ]; then
    echo "USAGE: $0 HOME_DIR [-f]"
    echo "  Installs config files into correct places under specified home directory"
    echo "  Will prompt before overwriting if file already exists, or use -f to force"
    exit 1
fi

FORCE=""
if [[ "$#" -eq "2" && "$2" == "-f" ]]; then
    FORCE=true
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


# USAGE: push REPO_LOC TGT_LOC
# REPO_LOC is the in-repo location of the file
# TGT_LOC is the actual on-system location of the config file, e.g. ~/.config/foo/foo.conf
# both should be paths relative to either $HOME_DIR or $SCRIPT_DIR
#
# Copies the config file into it's target location, but has extra smarts to label new/changed/unchanged files,
# and can prompt before overwriting, as well as showing a diff automatically
push() {
    repo_name="$1"
    tgt_name="$2"
    # Allows using . as shorthand. Shouldn't matter for the copy, but output is nicer?
    if [[ "$repo_name" = "." ]]; then
        repo_name="$tgt_name"
    fi
    repo_path="$SCRIPT_DIR/$repo_name"
    tgt_path="$HOME_DIR/$tgt_name"

    # New files can just be copied
    if [[ ! -f "$tgt_path" ]] ; then
        echo "  [NEW]   $repo_name => $HOME_DIR/$tgt_name"
        cp "$repo_path" "$tgt_path"

    # Unchanged files can be ignored: notify of that
    elif diff -q >/dev/null "$repo_path" "$tgt_path" ; then
        echo "  [MATCH] $HOME_DIR/$tgt_name"

    # ELSE: Files differ, but we're in force-copy mode
    elif [[ -n "$FORCE" ]] ; then
        echo "  [UPDATED] $repo_name => $HOME_DIR/$tgt_name"
        cp "$repo_path" "$tgt_path"

    else # Files differ, but we're interactive, so prompt user, offer to show a diff
        echo "  [DIFF!]   $repo_name => $HOME_DIR/$tgt_name"

        choice=''
        while [[ ! "$choice" =~ ^[yYnN]$ ]] ; do # Only exit on y/n, d retries
            read -p "Overwrite $tgt_path (y/n) or show diff (d)? " choice

            case "$choice" in
              y|Y )  cp "$repo_path" "$tgt_path" ;;
              n|N )  echo "  [SKIP]  $repo_name => $HOME_DIR/$tgt_name" ;;
              d|D )
                  git diff "$tgt_path" "$repo_path"  || true ;; # will retry after showing diff
              * ) ;; #Continue: should fallthrough and retry
            esac
        done

    fi
}

if [[ -n $FORCE ]] ; then echo "FORCIBLY OVERWRITING" ; fi
echo Pushing all known configs:
#NOTE: Clobbers existing files
push .  .bash_aliases
push .  .bashrc
push .  .gitconfig
push .  .gitignore_global
push .  .tmux.conf
push .  .vimrc
mkdir -p "$HOME_DIR/.config/helix"
push helix/config.toml    .config/helix/config.toml
push helix/languages.toml .config/helix/languages.toml
echo '  [OTHER/SKIPPED] - config.ghostty  =>  ~/.config/ghostty/config.ghostty'
echo "Done!"
