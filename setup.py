import os


LINKS = {
    '.profile': 'bash/profile',
    '.bashrc-local': 'bash/bashrc-local',
    '.dircolors': 'dircolors',
    '.editrc': 'editrc',
    '.inputrc': 'inputrc',
    '.tmux.conf': 'tmux.conf',
    '.vimrc': 'vimrc',
    '.vim': 'vim',
    '.gitconfig': 'git/gitconfig',
    '.gitignmore_global': 'git/gitignore_global',
    '.git-prompt.sh': 'git/git-prompt.sh',
    '.ipython/profile_default/ipython_config.py': 'ipython/ipython_config.py',
    '.ipython/profile_default/startup/jk.py': 'ipython/startup/jk.py',
    }

HOME = os.path.expanduser('~')
DOTFILES = os.path.join(HOME, 'dotfiles')

def setup():
    for name, target in LINKS.items():
        name = os.path.join(HOME, name)
        target = os.path.join(DOTFILES, target)
        stm = f'ln -snf {target} {name}'
        print(stm)
        os.system(stm)


if __name__ == '__main__':
    setup()
