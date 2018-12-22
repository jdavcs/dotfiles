" .vimrc
" Author  : Sergey Golitsynskiy <sgolitsynskiy@gmail.com>
" License : MIT

execute pathogen#infect()

if !exists("g:syntax_on")
    syntax enable
endif

filetype plugin on
filetype indent on

colorscheme solarized

" tmux sets bg=light
if $TERM == 'screen-256color'
    set background=dark 
endif



" tmux setting to enable Vim CTRL-arrow key sequences under Tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

let mapleader = ","      " set Leader
let maplocalleader = "," " set LocalLeader

let g:netrw_banner = 0  " do not display title banner in file explorer

" use % to switch between opening and closing tags, brackets, etc.
runtime macros/matchit.vim

" Settings {{{1
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
set formatlistpat+=\\\|^\\*\\s*   " prevent reformatting of * bullets
 
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

set ruler "status line

" Set permanent cursor color
" if &term =~ "xterm\\|rxvt"
    " use an orange cursor in insert mode
"    let &t_SI = "\<Esc>]12;orange\x7"
    " use a red cursor otherwise
"    let &t_EI = "\<Esc>]12;red\x7"
"    silent !echo -ne "\033]12;red\007"
    " reset cursor when vim exits
"    autocmd VimLeave * silent !echo -ne "\033]112\007"
    " use \003]12;gray\007 for gnome-terminal
" endif
" }}}

" Mappings {{{1
" switch to N mode
inoremap jk <Esc>

" use single quote (or back tick) to go back to mark
nnoremap ' `

" yank to end of line
nnoremap Y y$

" home + end
nnoremap H ^
nnoremap L $

" move to end of line before joining 
nnoremap J $J

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

"reindent file, then go back to where you were
nnoremap <F7> mqgg=G`q
" }}}1

" Autocommands {{{1
augroup my_filetypedetect 
    autocmd!
    " au BufNewFile,BufRead *.html setf xml  " until I find a better syntax file (but still not sure)
    au BufNewFile,BufRead *.wsgi set filetype=python
    au BufRead,BufNewFile gitconfig set filetype=gitconfig
    au BufNewFile,BufRead *.ejs set filetype=html
augroup END

augroup insert_comment
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType java nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType php nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
augroup END

augroup misc_settings
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType sh setlocal ts=2 sw=2 sts=2 noexpandtab
    autocmd FileType html,markdown,liquid setlocal tw=100
    " autocmd FileType html,xml,css,scss,javascript,json,typescript,pug,yaml,markdown,liquid,ruby setlocal ts=2 sw=2 sts=2 
    " galaxy
    autocmd FileType html,xml,css,scss,javascript,json,typescript,pug,yaml,markdown,liquid,ruby setlocal ts=4 sw=4 sts=4 

    autocmd FileType python setlocal foldmethod=indent | nnoremap <space> zA
    autocmd FileType python normal! zR
augroup END
" }}}1

" My commands {{{1
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

" make MatchParen use more subtle colors (can't make it auto-load with vimrc)
if !exists(":MP")
    command MP hi MatchParen ctermbg=10 ctermfg=LightBlue
endif

" }}}1

" Plugin settings {{{1

" vim-timestamp {{{2
nnoremap <silent><localleader>ti :TimestampInsert<CR>
nnoremap <silent><localleader>tu :TimestampUpdate<CR>
" }}}2

" vim-write {{{2
nnoremap <silent><leader>ww :WriteToggleWritingMode<CR>
nnoremap <silent><leader>nn :WriteToggleLineNumbers<CR>
nnoremap <silent><leader>nf :set foldcolumn=0<CR>

"let g:write_background = 'light'
" }}}2

" vim-journal {{{2

augroup vim_journal
    autocmd!
    " setup mappings
    autocmd FileType journal nnoremap <buffer> <silent> <LocalLeader>jd :JournalInsertDate<CR>zzi
    autocmd FileType journal nnoremap <buffer> <silent> <LocalLeader>jt :JournalInsertTodo<CR>zza
    autocmd FileType journal nnoremap <buffer> <silent> <LocalLeader>jsm :JournalMakeSummaries<CR>

    " add your custom terms; this MUST be inside a filetype autocmd:
    " if called for any file, the vim-journal filetype plugin won't be loaded.
    autocmd FileType journal call journal#addterm("IDEA",        "<LocalLeader>ji", "Identifier")
    autocmd FileType journal call journal#addterm("THOUGHT",     "<LocalLeader>jh", "Constant")
    autocmd FileType journal call journal#addterm("OBSERVATION", "<LocalLeader>jo", "Underlined")
augroup END

" }}}2

" vim-syntastic {{{2
" only show error messages, supress the rest
" let g:syntastic_quiet_messages = { "!level": "errors" }
" }}}2

" }}}1
