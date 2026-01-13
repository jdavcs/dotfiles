Dotfiles.

## Installation

Run `./install.sh`.

Warning: this script is not generic. It handles a bunch of special cases that work for my setup but
may break things in a different context.

### What the script does
- Creates symlinks in `$HOME` to files in `src/`.
- Files in `nested` are linked to only if corresponding directory exists in `$HOME`.
- Existing symlinks are overridden.

### Handling of .bashrc
- Removes existing symlinks to `.bashrc` and `.bashrc.local`.
- If `$HOME/.bashrc` does not exist: creates symlink to `src/.bashrc`.
- If `$HOME/.bashrc` exists:
  - Creates `.bashrc.local` symlink to `src/.bashrc`
  - Appends code to `.bashrc` to source `.bashrc.local`

### Handling of .profile and .bash_profile
- If localhost:
  - Handles `.bash_profile` for a Mac and `.profile` for Linux the same way other dotfiles are
    handled.
- If remote host:
  - If `.profile` does not exist: fails (check manually)
  - If `.profile` exists: 
    - Appends code to `.profile` to attach to an existing tmux session or start a new one.

## License
[MIT](https://github.com/jdavcs/dotfiles/blob/master/LICENSE)
