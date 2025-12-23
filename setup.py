import os


LINKS = {
    '.bash_profile': 'bash/bashrc',
    '.bashrc': 'bash/bashrc',
    '.editrc': 'editrc',
    '.dircolors': 'dircolors',
    '.inputrc': 'inputrc',
    '.vim': 'vim',
    '.vimrc': 'vimrc',
    '.tmux.conf': 'tmux.conf',
    '.gitconfig': 'git/gitconfig',
    '.gitignmore_global': 'git/gitignore_global',
    '.ipython/profile_default/ipython_config.py': 'ipython/ipython_config.py',
    '.ipython/profile_default/startup/jk.py': 'ipython/startup/jk.py',
    '.pdbrc': 'pdbrc',
    '.pylintrc': 'pylintrc',
    '.flake8': 'flake8',
    '.condarc': 'condarc',
    '.config/Code/User/settings.json': 'vscode-settings.json',
    '.irbrc': 'irbrc',
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
