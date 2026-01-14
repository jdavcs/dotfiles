#! /bin/bash

# Change into scripts directory BEFORE doing anything else
cd "$(dirname "$0")" || exit

dotfiles_src="$PWD/src"
bashrc="$HOME/.bashrc"
bashrc_local="$HOME/.bashrc.local"
bashrc_src="${dotfiles_src}/.bashrc"

main() {
	# Loop over all dotfiles
	shopt -s dotglob
	for f in "$dotfiles_src"/*; do
        if [[ ! $(basename "$f") =~ ^(nested|.bashrc|.profile|.bash_profile)$ ]]; then
			process_dotfile "$f"
		fi
	done
	shopt -u dotglob

    # Hanle special cases
    process_bashrc
    process_nested
    process_dotprofile
}

process_bashrc() {
	if [[ -L "$bashrc_local" ]]; then
		rm "$bashrc_local"  # Remove existing symlink .bashrc.local
	fi

	if [[ ! -e "$bashrc" || -L "$bashrc" ]]; then  # .bashrc (file or symlink) does not exist or it is a symlink
		# Add symlink $HOME/.bashrc to dotfiles/.bashrc (override existing symlink)
		ln -sfv "$bashrc_src" "$bashrc"
	
	elif [[ -f "$bashrc" && ! -L "$bashrc" ]]; then  # .bashrc is a file and not a symlink
		# Add symlink $HOME/.bashrc.local to dotfiles/.bashrc (remove existing)
		ln -sfv "$bashrc_src" "$bashrc_local"
	    # Ensure .bashrc sources .bashrc.local
		append_source_local_to_bashrc
	fi
}

process_nested() {
	if [[ -d "$HOME/.ipython" ]]; then
		# Override existing symlinks
		ln -sfv "$dotfiles_src/nested/ipython/ipython_config.py" "$HOME/.ipython/profile_default/ipython_config.py"
		ln -sfv "$dotfiles_src/nested/ipython/jk.py" "$HOME/.ipython/profile_default/startup/jk.py"
	fi

	if [[ -d "$HOME/config/Code/User" ]]; then
		# Override existing symlinks
		ln -sfv "$dotfiles_src/nested/vscode/settings.json" "$HOME/.config/Code/User/sessings.json"
		ln -sfv "$dotfiles_src/nested/vscode/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
	fi
}

process_dotprofile() {
    if [[ -n "$SSH_CLIENT" ]]; then
        # Handle remote host
	    if [[ -f "$HOME/.profile" && ! -L "$HOME/.profile" ]]; then  # .profile is a file and not a symlink
            append_tmux_handling_to_profile
        else
            echo "Abort: $HOME/.profile does not exist on host."
            exit 1  # Needs attention
        fi
    else
        # Handle local host
        if [[ $(uname -s) == 'Darwin' ]]; then
            process_dotfile "${dotfiles_src}/.bash_profile"
        else
            process_dotfile "${dotfiles_src}/.profile"
        fi
    fi
}

append_source_local_to_bashrc() {
	# Append sourcing .bachrc.local to an existing $HOME/.bashrc
	# (Escape $HOME so it's appended verbatim)
    local codeblock
	# shellcheck disable=SC2016
	if ! grep -q '. "$HOME/.bashrc.local"' "$bashrc"; then
		read -r -d '' codeblock <<- EOF
	
		# Source local settings if symlink to .bashrc.local exists
		if [ -L "\$HOME/.bashrc.local" ]; then
		    . "\$HOME/.bashrc.local"
		fi
		EOF
		echo "$codeblock" >> "$bashrc"  # append to .bashrc
	fi
}

append_tmux_handling_to_profile() {
	# Append to an existing $HOME/.profile
	# (Escape $TMUX so it's appended verbatim)
    local codeblock
	if ! grep -q 'tmux attach' "$HOME/.profile"; then
		read -r -d '' codeblock <<- EOF

		# Attach to existing tmux session or create new
		if [ -z "\$TMUX" ]; then
		    tmux attach -t default || tmux new -s default
		fi
		EOF
		echo "$codeblock" >> "$HOME/.profile"  # append to .profile
	fi
}

process_dotfile() {
	local path
	# shellcheck disable=SC2086
	path="$HOME/$(basename $1)"
	if [[ -f "$path" && ! -L "$path" ]]; then  # $path is a file and not a symlink
		# Do not override existing file: command will fail
		# shellcheck disable=SC2086
		ln -snv "$1" "$HOME/$(basename $1)"
	else
		# Create symlink; may override existing symlink
		# shellcheck disable=SC2086
		ln -sfnv "$1" "$HOME/$(basename $1)"
	fi
}

main
