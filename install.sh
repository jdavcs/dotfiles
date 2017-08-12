BASEDIR=dotfiles
VIMDIR=vim
VIMBLINK=${VIMDIR}/bundle

#change this when your dev directory changes
VIMBTARGET=~/0dev/vim-bundle

# Make a symlink from home directory to dotfiles repo
#   if 2 args supplied: use 2nd for target
function make_homedir_link {
    if [ $# -eq 2 ]; then
        TARGET=$2
    else
        TARGET=$1
    fi

    make_link ~/$1 ${BASEDIR}/$TARGET
}

# Make a synlink to a vim plugin
function make_vimplugin_link {
    make_link ${VIMBLINK}/$1 ${VIMBTARGET}/$1
}

# link helper
function make_link {
    echo ln -s $2 $1
    if [ ! -L "$1" ] 
    then
        echo "linking " $1
        ln -s $2 $1
    else 
        echo "link to $1 already exists"
    fi
}


make_homedir_link .bashrc bashrc
make_homedir_link .dircolors dircolors
make_homedir_link .gitconfig gitconfig
make_homedir_link .inputrc inputrc
make_homedir_link .vimrc vimrc
make_homedir_link .vim $VIMDIR
make_homedir_link git-completion.bash
make_homedir_link git-prompt.sh

#make_vimplugin_link vim-write
#make_vimplugin_link vim-journal
