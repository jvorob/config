#!/bin/bash

alias cl='clear'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep things
alias grep='grep --color=auto'
alias igrep='grep -i --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#fix xclip for ubuntu
alias xclip='xclip -selection clipboard'
# use like:
#   `foo | xclip -in`
#   `xclip -out | foo`

alias c.="cd .."

alias g="git"



# schedule for school (on desktop machine)
alias sched="eog ~/Dropbox/schedule_spring_17b.png"

# enable the fuck
#eval "$(thefuck --alias)"
