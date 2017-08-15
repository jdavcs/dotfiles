" .vimrc
" Author : Sergey Golitsynskiy <sgolitsynskiy@gmail.com>

execute pathogen#infect()

"=============================================================================
" main settings
"=============================================================================
if !exists("g:syntax_on")
    syntax enable
endif

" tmux sets bg=light
if $TERM == 'screen-256color'
    set background=dark 
endif

filetype plugin on
filetype indent on

colorscheme solarized

set nocompatible    " no need for old Vi
set autoread        " set to auto read when file is changed from the outside
set ignorecase      " search case-insensitive
set smartcase       " do not ignore case if pattern contains uppercase letter
set hlsearch        " highlight search matches
set number          " line numbers
set autoindent      " use current indent on new line
set smartindent
set pastetoggle=<F2>    " paste mode on/off
set display+=lastline 	" display incomplete last line (not @@@)
set history=1000    "history == good
set listchars=tab:\ \ ,trail:·     " display tabs and trailing spaces
set nolist          " toggle to display: if on, typing is annoying
set nowrap          " do not wrap lines
set scrolloff=3     " more context around cursor
 
set expandtab       " use spaces instead of tabs in I mode
set tabstop=4       " spaces in a tab
set shiftwidth=4    " spaces in a tab when autoindenting
set softtabstop=4   " spaces in a tab in I mode

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

let mapleader = ","      " set Leader
let maplocalleader = "," " set LocalLeader
"let maplocalleader = "\<Space>" -comma seems easier, not sure though..

" use % to switch between opening and closing tags, brackets, etc.
runtime macros/matchit.vim

let g:netrw_banner = 0  " do not display title banner in file explorer


"=============================================================================
" mappings
"=============================================================================
" switch to N mode
inoremap jk <Esc>

" use single quote (or back tick) to go back to mark
nnoremap ' `

" hit enter to clear last search pattern
nnoremap <silent> <CR> :let @/ = ""<CR>

" open .vimrc in vsplit
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>

" source .vimrc
noremap <Leader>sv :source $MYVIMRC<CR>

" split navigation: Use ctrl-[hjkl] to select split
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" add semicolumn at end of line without moving cursor
nnoremap <Leader>; mqA;<esc>`q

" faster scrolling up/down (2 lines instead of 1)
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" toggle list option / dispalys trailing space/tabs
nnoremap <silent> <leader>s :set nolist!<CR>

" toggle spell check
nnoremap <leader>ss :setlocal spell!<CR>

" because no self-discipline
nnoremap <Left> :echoe "must use h"<CR>
nnoremap <Right> :echoe "must use l"<CR>
nnoremap <Up> :echoe "must use k"<CR>
nnoremap <Down> :echoe "must use j"<CR>
nnoremap <PageUp> :echoe "must use CTRL-b"<CR>
nnoremap <PageDown> :echoe "must use CTRL-f"<CR>
nnoremap <Home> :echoe "must use 0"<CR>
nnoremap <End> :echoe "must use $"<CR>


"===============================================================================
" autocommands
"===============================================================================
augroup file_types
    autocmd!
    autocmd FileType java nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType php nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType gitcommit setlocal textwidth=72
augroup END


"===============================================================================
" functions
"===============================================================================

" toggle line numbers maintaining left margin width=:
"   if numbers are set, unset numbers + restore foldcolumn width; 
"   otherwise set numbers + reduce foldcolumn  width
"   The combined with of left margin = 10
function! s:ToggleLineNumbersAndMargin()
    "get number of digits needed to display the last line number
    let l:digits = len(line("$") . "")

    " account for Vim's weirdness
    if  l:digits == 2       " 10-99 lines: add 1 space
        let l:digits += 1
    elseif l:digits < 2     " < 10 lines: add 2 spaces
        let l:digits += 2
    endif

    let l:max = 10 " maximum width of fold column
    let l:width = l:max - l:digits - 1 " width with numbers displayed
   
    " toggle numbers and width
    if &nu == 1
        setlocal nonumber
        let &l:foldcolumn = l:max
    else
        setlocal number
        let &l:foldcolumn= l:width
    endif
endfunction


" toggle writing mode (for any file)
if !exists("g:writing_mode")
    let g:writing_mode=0
endif

function! s:ToggleWritingMode()
    " writing mode is global: no reason to have different modes in same window
    if g:writing_mode == 0
        let g:writing_mode = 1

        " save current option values 
        let s:formatoptions = &l:formatoptions
        let s:foldcolumn = &l:foldcolumn
        let s:formatprg = &l:formatprg
        let s:background = &l:background
        let s:number = &l:number
        let s:list = &l:list
        let s:autoindent = &l:autoindent
        let s:smartindent = &l:smartindent

        " set new values
        setlocal formatoptions=nt1
        setlocal foldcolumn=10
        setlocal formatprg=par
        setlocal background=light

        setlocal nonumber
        setlocal nolist
        setlocal noautoindent
        setlocal nosmartindent

        " these options don't need to be reset
        setlocal textwidth=80
        setlocal columns=100
    else
        let g:writing_mode = 0

        " restore previous option values
        let &l:formatoptions = s:formatoptions
        let &l:foldcolumn = s:foldcolumn
        let &l:formatprg = s:formatprg
        let &l:background = s:background
        let &l:number = s:number
        let &l:list = s:list
        let &l:autoindent = s:autoindent
        let &l:smartindent = s:smartindent
    endif
endfunction


"===============================================================================
" commands
"===============================================================================
if !exists(":JJ")
    command JJ call s:ToggleWritingMode()
endif

if !exists(":NN")
    command NN call s:ToggleLineNumbersAndMargin()
endif

" one extra N to remove left margin
if !exists(":NNN")
    command NNN set foldcolumn=0
endif
