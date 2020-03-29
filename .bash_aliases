
export EDITOR=vim
export IGNOREEOF=10 #Will only exit after 10 consecutive ctrl-Ds

#load .local_bashrc if possible
if [ -f ~/.local_bashrc ]; then
    . ~/.local_bashrc
fi

#make history work intelligently with multiple terminals
export PROMPT_COMMAND='history -a'


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

#fix xclip for ubuntu
alias xclip='xclip -selection clipboard'
alias xcopy='xclip -in -selection clipboard '
alias xpaste='xclip -out -selection clipboard'
# use like:
#   `foo | xclip -in`
#   `xclip -out | foo`

alias c.="cd .."

alias g="git"
alias gs="git status"
alias gt="git tree"


#setup dircolors
#eval $(dircolors)
