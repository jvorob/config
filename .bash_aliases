
export EDITOR=vim
export IGNOREEOF=10 #Will only exit after 10 consecutive ctrl-Ds

#load .local_bashrc if possible
if [ -f ~/.local_bashrc ]; then
    . ~/.local_bashrc
fi

#make history work intelligently with multiple terminals
export PROMPT_COMMAND='history -a'

#Generic stuff
alias c.="cd .."
alias cl='clear'

# some more ls aliases
alias ll='ls --group-directories-first -alF'
alias la='ls --group-directories-first -A'
alias l='ls --group-directories-first -CF'

# grep things
alias grep='grep --color=auto'
alias igrep='grep -i --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git stuff
alias g="git"
alias gs="git status"
alias gt="git tree"
alias gc="git checkout"

# Etc
alias py3="python3"
alias sctl="systemctl"

# if bat is installed, set it up as pager
# NOTE: groff outputs ansi escape codes also, use this to fix it
# see:      https://github.com/sharkdp/bat/issues/3053
if which bat >/dev/null ; then
    export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
fi

# http://cheat.sh cool website, can curl e.g. cheat.sh/tar
cheat() {
    curl "http://cheat.sh/$@"
}

ALT_PROMPT="$ "
pswap() {
    # swap prompts
    TMP="$PS1"
    PS1="$ALT_PROMPT"
    ALT_PROMPT="$TMP"
}

#  function errecho() {
#    echo 1>&2 $@;  }


# Helpers for finding/deleting/etc vim swap-files
vimswap() {
  USAGE="[usage]: vimswap find|show|load"

  if [[ $# -gt 2 ]]; then
    echo 1>&2 "Err: too many arguments to vimswap"
    return -1
  fi

  if [[ $# -eq 0 || $1 == "find" || $1 == "ls" ]]; then
    find . | egrep '.*.swp|.*.swo'
    return 0
  fi

  if [[ $1 == "show" || $1 == "preview" ]]; then
    find . | egrep ".*.swp" | sed -E "s/(.*\/).([^\/]*).swp$/\1\2/"
    return 0
  fi



  if [[ $1 == "load" ]]; then
    vim -p $(find . | egrep ".*.swp" | sed -E "s/(.*\/).([^\/]*).swp$/\1\2/" | xargs echo)
    return
  fi


  if [[ $1 == "--help" ]]; then
    echo "$USAGE"
    return 0
  fi

  #else: got to end
  echo 2>&1 "Error: unrecognized args"
  echo 2>&1 "$USAGE"

}



# #fix xclip for ubuntu
# alias xclip='xclip -selection clipboard'
# alias xcopy='xclip -in -selection clipboard '
# alias xpaste='xclip -out -selection clipboard'
# # use like:
# #   `foo | xclip -in`
# #   `xclip -out | foo`

#setup dircolors
#eval $(dircolors)
