readonly BASEDIR="$PWD"
readonly VIMDIR='vim'

# Make a symlink from home directory to dotfiles repo
#   if 2 args supplied: use 2nd for target
function make_homedir_link {
    local target
    if [[ $# -eq 2 ]]; then
        target="$2"
    else
        target="$1"
    fi
    make_link ~/"$1" "${BASEDIR}"/"$target"
}

# link helper
function make_link {
    echo ln -s "$2" "$1"
    if [[ ! -L "$1" ]]; then
        echo "linking " "$1"
        ln -s "$2" "$1"
    else 
        echo "link to $1 already exists"
    fi
}

make_homedir_link .bashrc bashrc
make_homedir_link .dircolors dircolors
make_homedir_link .gitconfig gitconfig
make_homedir_link .inputrc inputrc
make_homedir_link .vimrc vimrc
make_homedir_link .vim "${VIMDIR}"
make_homedir_link .tmux.conf tmux.conf
make_homedir_link .pylintrc pylintrc
make_homedir_link .irbrc irbrc
