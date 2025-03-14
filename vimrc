" .vimrc
" Author  : John Davis <jdavcs@gmail.com>
" License : MIT

execute pathogen#infect()

if !exists("g:syntax_on")
    syntax enable
endif

filetype plugin on
filetype indent on

colorscheme solarized

let g:netrw_banner = 0  " do not display title banner in file explorer

set nocompatible    " no need for old Vi
set autoread        " set to auto read when file is changed from the outside
set smartcase       " do not ignore case if pattern contains uppercase letter
set hlsearch        " highlight search matches
set number          " line numbers
set autoindent      " use current indent on new line
set pastetoggle=<F2>    " paste mode on/off
set display+=lastline   " display incomplete last line (not @@@)
set history=1000    "history == good
set listchars=tab:\ \ ,trail:·     " display tabs and trailing spaces
set nolist          " toggle to display: if on, typing is annoying
set nowrap          " do not wrap lines
set scrolloff=3     " more context around cursor
set formatlistpat+=\\\|^\\*\\s*   " prevent reformatting of * bullets

set splitbelow      " on H split open new window below
set splitright      " on V split open new window to the right

set nobackup        " no backup files
set nowritebackup   " no backup files
set noswapfile      " no swap files

" better file/command completion
set wildmenu
set wildmode=list:longest

"helps when maximizing other splits
set winminwidth=0
set winminheight=0

set ruler "status line

inoremap jk <Esc>

" yank to end of line
nnoremap Y y$

" home + end
nnoremap H ^ 
nnoremap L $ 

" move to end of line before joining 
nnoremap J $J

" hit enter to clear last search pattern
nnoremap <silent> <CR> :let @/ = ""<CR>

" split navigation: Use ctrl-[hjkl] to select split
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" split resizing
if stridx(system('uname -a'), 'Darwin') > -1
    nnoremap <silent> <C-S-Right> :vertical res +1<CR>
    nnoremap <silent> <C-S-Left>  :vertical res -1<CR>
    nnoremap <silent> <C-S-Up>    :res +1<CR>
    nnoremap <silent> <C-S-Down>  :res -1<CR>
else
    nnoremap <silent> <C-Right> :vertical res +1<CR>
    nnoremap <silent> <C-Left>  :vertical res -1<CR>
    nnoremap <silent> <C-Up>    :res +1<CR>
    nnoremap <silent> <C-Down>  :res -1<CR>
endif

" faster scrolling up/down (2 lines instead of 1)
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

"reindent file, then go back to where you were
nnoremap <F7> mqgg=G`q

" maximize split
nnoremap <C-W>m <C-W>\|<C-W>_

" visually select line
nnoremap vv 0v$<CR>
