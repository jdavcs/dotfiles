# Load shell dotfiles
DOTFILES=dotfiles
source ~/${DOTFILES}/aliases
source ~/${DOTFILES}/export

#sets terminal title to passed argument 
function set_title {
	x=$1
	PROMPT_COMMAND='echo -ne "\033]0;${x}\007"'
}

# Set terminal title to $PWD
PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'

# Don't overwirte existing files by redirection
set -o noclobber 

# Simple prompt: violet, host only
PS1="\[\e[1;35m\]\h$ \[\e[0m\]" 

# Load local .bashrc
if [[ -f ~/.bashrc-local ]]; then
	source ~/.bashrc-local
fi

# Load git completions
. ~/${DOTFILES}/git-completion.bash

# Load solarized colors for ls
eval $(dircolors ~/.dircolors)
