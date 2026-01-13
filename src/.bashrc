#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Enable color support for Mac
if [[ $(uname -s) == 'Darwin' ]]; then
	if command -v tree &> /dev/null; then
		eval $(gdircolors -b ~/.dircolors)
	fi
fi

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't overwirte existing files by redirection
set -o noclobber 

export LC_COLLATE='POSIX'  # sort order: ABab (vs. aAbB)

export EDITOR='vim'  # default editor
export SYSTEMD_EDITOR='/usr/bin/vim'  # for systemctl edit

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr
export PYTHONIOENCODING='UTF-8'

export IGNOREEOF=1  # ignore <C-d> once; next time close terminal

# Set history size (Do not set to -1: breaks older bash (3.2.57) on a mac)
export HISTSIZE=100000  # lines/commands stored in history list: in memory during session
export HISTFILESIZE=1000000  # lines/commands stored in history file: on disk (HISTSIZE * 10)

export HISTTIMEFORMAT='%h %d %H:%M  '
export HISTCONTROL='ignoreboth'  # do not store duplicates and commands that begin with a space
export HISTIGNORE="&:[ ]*:history:h:ls:ll:la:l:clear"  # do not store these commands
shopt -s histappend  # append to the history file, don't overwrite it

export ANSIBLE_NOCOWS=1  # because too many cows.

PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'  # set terminal title to $PWD

# Basic prompt
PS1='${debian_chroot:+($debian_chroot)}\[\e[0;36m\]\u@\h$ \[\e[0m\]'

# Display git branch in prompt
source ~/.git-prompt.sh
PS1='${debian_chroot:+($debian_chroot)}\[\e[0;36m\]\u@\h$(__git_ps1 "(%s)")\$ \[\e[0m\]'

# Load git completions
#source ~/${DOTFILES}/git/git-completion.bash  # TODO: this doesn't seem to matter?

# Uncomment to include current directory
#PS1='${debian_chroot:+($debian_chroot)}\[\033[0;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Prepend .local/bin to path (in case a system binary needs to be overridden)
if [[ -f "$HOME/.local/bin/env" ]]; then
. "$HOME/.local/bin/env" 
fi

# Append miniconda to path if not in path
if [[ ":$PATH:" != *":$HOME/miniconda3/condabin:"* ]]; then
    export PATH="$PATH:$HOME/miniconda3/condabin:$PATH"
fi

export PYENV_ROOT=$HOME/.pyenv
# Append pyenv to path if not in path
if [[ ":$PATH:" != *":$PYENV_ROOT:"* ]]; then
	export PATH="$PATH:$PYENV_ROOT/bin"
fi

export GEM_HOME="$HOME/gems"
# Append Ruby Gems bin to path if not in path
if [[ ":$PATH:" != *":$GEM_HOME:"* ]]; then
	export PATH="$PATH:$GEM_HOME/bin"
fi


# ALIASES ----------

# Up navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'  # escape dash with --

alias mv='mv -v'  # Add verbose

# ls shortcuts
if [[ $(uname -s) == 'Darwin' ]]; then
	alias ls='ls -Gl'
else
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
alias grep='grep -E --color=auto'
alias grepp="grep --include=*py"  # *py only
alias python=python3
alias dir='dir --color=auto'

if [[ $(uname -s) == 'Darwin' ]]; then
	alias chrome='/usr/bin/open -a "/Applications/Google Chrome.app"'
else
	alias chrome='google-chrome-stable'
fi

# python virtualenv
alias deac='deactivate'

# misc.
if command -v tree &> /dev/null; then
    alias t="tree --noreport --dirsfirst -I 'node_modules|__pycache__'"
fi

if command -v pgadm &> /dev/null; then
    alias pgadm='nohup pgadmin4 &>/dev/null &'  # don't hog up a terminal w/pgadmin
fi

# initialize conda and deactivate base env
if command -v conda &> /dev/null; then
    alias initconda=". $HOME/.condainit.sh ; conda deactivate"
fi

# be explicit about what python interpreter will run pip (use whatever is the current `python`)
alias pip="python -m pip"

alias python=python3


# PRIVATE SETTINGS ----------
# Apply private settings if file exists
if [[ -f "$HOME/.bashrc.private" ]]; then
    . "$HOME/.bashrc.private"
fi
