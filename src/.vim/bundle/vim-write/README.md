# Vim Write
Plugin for switching to minimalist writing mode. 

## Installation
[Pathogen](https://github.com/tpope/vim-pathogen)
```bash
cd ~/.vim/bundle
git clone https://github.com/jdavcs/vim-write.git
```

## Usage
To switch between current and writing mode, execute the `:WriteToggleWritingMode` command.
To turn line numbers on and off (maintaning the left margin), execute the `:WriteToggleLineNumbers` command.

## Optional Configuration
Suggested sample mappings to add to your .vimrc:
```vim
nnoremap <leader>ww :WriteToggleWritingMode<CR>
nnoremap <leader>nn :WriteToggleLineNumbers<CR>
nnoremap <leader>nf :set foldcolumn=0
```
The third mapping helps when `nn` was executed outside of writing mode (which would create a fold column).

You may also override the defaults by specifyiing these global variables, like so:
```vim
let g:write_marginwidth = 12
let g:write_textwidth = 60 
let g:write_columns = 80
```

## Limitations
1. This plugin uses hard wrap *
2. The writing mode isn't as pleasing when the terminal window is maximized, or when used within a terminal multiplexer
4. Minimalist (no invisible buffers, no true "distraction-free writing"), but lightweight, simple, and not intrusive

\* Here's a [good discussion of hard wrap vs. soft wrap](http://www.terminally-incoherent.com/blog/2013/06/17/using-vim-for-writing-prose/) 


## Contributions
Suggestions and feedback are [welcome](https://github.com/jdavcs/vim-write/issues).

## License
[MIT](https://github.com/jdavcs/vim-write/blob/master/LICENSE)
