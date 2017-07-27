#!/bin/bash

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


#lets npm run modules without bleh
function npm-do { (PATH=$(npm bin):$PATH; eval $@;) }

# schedule for school (on desktop machine)
alias sched="eog ~/Dropbox/schedule_spring_17b.png"

# enable the fuck
eval "$(thefuck --alias)"
