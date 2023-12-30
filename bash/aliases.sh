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
	alias l='ls --color=auto --group-directories-first'
	alias ls='ls --color=auto --group-directories-first'
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
alias t="tree --noreport --dirsfirst -I 'node_modules|__pycache__'"
alias grep='grep -E --color=auto'
alias vi=vim

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

# misc.
alias pgadm='nohup pgadmin4 &>/dev/null &'  # don't hog up a terminal w/pgadmin

# be explicit about what python interpreter will run pip (use whatever is the current `python`)
alias pip="python -m pip"

# initialize conda and deactivate base env
alias initconda=". $HOME/dotfiles/bash/condainit.sh ; conda deactivate"
