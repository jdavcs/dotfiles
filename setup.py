import os


LINKS = {
    '.config/pgcli/config': 'pgcli-config',
    '.config/Code/User/settings.json': 'vscode-settings.json',
    '.angular-config.json': 'angular-config.json',
    '.bashrc': 'bash/bashrc',
    '.condarc': 'condarc',
    '.dircolors': 'dircolors',
    '.flake8': 'flake8',
    '.gitconfig': 'git/gitconfig',
    '.gitignmore_global': 'git/gitignore_global',
    '.inputrc': 'inputrc',
    '.irbrc': 'irbrc',
    '.myclirc': 'mycli',
    '.pdbrc': 'pdbrc',
    '.pylintrc': 'pylintrc',
    '.tmux.conf': 'tmux.conf',
    '.vim': 'vim',
    '.vimrc': 'vimrc',
    '.ipython/profile_default/ipython_config.py': 'ipython/ipython_config.py',
    '.ipython/profile_default/startup/jk.py': 'ipython/startup/jk.py',
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
