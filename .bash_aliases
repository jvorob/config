
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

# http://cheat.sh cool website, can curl e.g. cheat.sh/tar
cheat() {
    curl "http://cheat.sh/$@"
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
