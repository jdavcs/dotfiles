import os


LINKS = {
    '.bashrc.d': 'bashrc.d',
    '.ipython/profile_default/startup/jk.py': 'ipython/startup/jk.py',
    '.vim': 'vim',
    '.dircolors': 'dircolors',
    '.editrc': 'editrc',
    '.gitconfig': 'gitconfig',
    '.inputrc': 'inputrc',
    '.tmux.conf': 'tmux.conf',
    '.vimrc': 'vimrc',
}

HOME = os.path.expanduser('~')
DOTFILES = os.path.join(HOME, 'dotfiles')

def setup():
    for name, target in LINKS.items():
        name = os.path.join(HOME, name)
        target = os.path.join(DOTFILES, target)
        stm = 'ln -snf {} {}'.format(target, name)
        print(stm)
        os.system(stm)


if __name__ == '__main__':
    setup()
