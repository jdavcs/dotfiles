


###########################################################
# shell options
set -o vi
set -o noclobber
set history-size=1000

###########################################################
# aliases
alias ls='ls --color=auto'
alias ll='ls -l --group-directories-first'
alias llt='ls -lt --group-directories-first'
alias la='ls -la --group-directories-first'
alias l='ls --group-directories-first'
alias h=history
alias c=clear
alias cll='c;ll'
alias grep='grep -E'
alias grep='grep --color=auto'
alias py=python3
alias py2=python2
alias py35=python3.5
alias t='tree --noreport'
alias chrome='google-chrome-stable'
alias jour='vi ~/writing/journals/journal.sjn'


###########################################################
#virtualenv/virtualenvwrapper:
if [ -a /usr/local/bin/virtualenvwrapper.sh ]; 
    then
        export WORKON_HOME=$HOME/.virtualenvs
        source /usr/local/bin/virtualenvwrapper.sh
        alias v='workon'
        alias v.d='deactivate'
        alias v.mk='mkvirtualenv'
        alias v.rm='rmvirtualenv'
        alias v.cd='cdvirtualenv'
        alias v.ls='lsvirtualenv';
fi;


###########################################################
#misc
IGNOREEOF=1

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export LC_COLLATE=POSIX

#simple prompt: violet, host only
PS1="\[\e[1;35m\]\h$ \[\e[0m\]" 
#simple prompt: light grey, host only
#PS1="\[\e[1;32m\]\h$ \[\e[0m\]"

#solarized colors for ls
eval `dircolors ~/.dircolors`

#set terminal title to $PWD
PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'

###########################################################
#load local .bashrc

if [ -f ~/.bashrc-local ]; then
	source ~/.bashrc-local
fi


###########################################################
#launch writing environment
#alias wp='mate-terminal --maximize --hide-menubar &
#gnome-terminal --window-with-profile=writing --geometry=100x75 --hide-menubar'

alias wp='gnome-terminal --window-with-profile=writingbg --maximize --hide-menubar &
gnome-terminal --window-with-profile=writing --geometry=100x75 --hide-menubar & exit'

#sets terminal title to passed argument 
function set_title {
	X=$1
	PROMPT_COMMAND='echo -ne "\033]0;${X}\007"'
}


#load git completions
. ~/git-completion.bash
