#!/usr/bin/env bash

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'  # escape dash with --

# Enable aliases to be sudo’ed
alias sudu='sudo '

# Add verbose to all; prompt once for rm
alias mv='mv -v'
# alias rm='rm -I -v'
# alias cp='cp -v'

# ls shortcuts
# TODO improve this
alias l='ls -Gl'
if [[ "$OSTYPE" == "darwin"* ]]; then
	alias l='gls --color=always --group-directories-first'
	alias ls='l'
else
	alias l='ls --color=always --group-directories-first'
	alias ls='ls --color=always --group-directories-first'
fi

alias ll='ls -l'
alias la='ls -la'
alias ldot='ls -d .??*' #list dot-files and dirs
alias llx='ls -lX' #sort by extention
alias llt='ls -lt' #sort by modification date

# Misc shortcuts
alias h=history
alias c=clear
alias cll='c;ll'
alias cl='c;ll' #even better!
alias ipy=ipython
alias t='tree --noreport --dirsfirst'
alias grep='grep -E --color=auto'

if [ $(uname -s) == 'Darwin' ]; then
	alias chrome='/usr/bin/open -a "/Applications/Google Chrome.app"'
else
	alias chrome='google-chrome-stable'
fi

# virtualenv/virtualenvwrapper:
if [[ -a /usr/local/bin/virtualenvwrapper.sh ]]; then
		alias v='workon'
		alias v.d='deactivate'
		alias v.mk='mkvirtualenv'
		alias v.rm='rmvirtualenv'
		alias v.cd='cdvirtualenv'
		alias v.ls='lsvirtualenv'
		alias v.sp='setvirtualenvproject'
fi
# virtualenv
alias deac='deactivate'

# k8s
alias k=kubectl
# get pod name
alias k-pod='kubectl get pods --no-headers -o custom-columns=":metadata.name"'
# create/delete k8s dashboard
alias kd-create='~/code/bin/k8s/dashboard-create.sh'
alias kd-delete='~/code/bin/k8s/dashboard-delete.sh'
