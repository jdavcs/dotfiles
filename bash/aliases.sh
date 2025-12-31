#!/usr/bin/env bash

# Up navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'  # escape dash with --

alias mv='mv -v'  # Add verbose

# ls shortcuts
alias l='ls -Gl'
if [ $(uname -s) == 'Darwin' ]; then
	alias ls='l'
else
	alias l='ls --color=auto --group-directories-first'
	alias ls='ls --color=auto --group-directories-first'
fi

alias ll='ls -l'
alias la='ls -la'
alias ldot='ls -dl .??*' #list dot-files and dirs
alias llx='ls -lX' #sort by extention
alias llt='ls -lt' #sort by modification date

# Misc shortcuts
alias h=history
alias c=clear
alias cl='c;ll'
alias t="tree --noreport --dirsfirst -I 'node_modules|__pycache__'"
alias grep='grep -E --color=auto'
alias grepp="grep --include=*py"  # *py only
alias python=python3
alias dir='dir --color=auto'

# virtualenv
alias deac='deactivate'

# be explicit about what python interpreter will run pip (use whatever is the current `python`)
alias pip="python -m pip"
