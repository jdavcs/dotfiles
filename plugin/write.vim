" ----------------------------------------------------------------------
" write         Minimalist writing mode for Vim
" Maintainer:   John Davis <jdavcs@gmail.com>
" File:         plugin/write.vim
" Source:       https://github.com/jdavcs/vim-write
" License:      MIT
" Last Updated: 2025 Dec 30 11:00:53 PM EST
" ----------------------------------------------------------------------

" prevent from loading twice; to disable plugin uncomment next line
"let g:write_loaded = 1
if exists("g:write_loaded")
  finish
endif
let g:write_loaded = 1


" reasonable default values
let s:write_marginwidth = 2
let s:write_textwidth = 80
let s:write_columns = 0
let s:write_background = 'dark'

" check if globals have been defined, reassign if needed
if exists("g:write_marginwidth")
    let s:write_marginwidth = g:write_marginwidth
endif

if exists("g:write_textwidth")
    let s:write_textwidth = g:write_textwidth
endif

if exists("g:write_columns")
    let s:write_columns = g:write_columns
endif

if exists("g:write_background")
    let s:write_background = g:write_background
endif


" initialize writing_mode flag
if !exists("g:write_writingmode")
    let g:write_writingmode = 0
endif


" add shortcuts or mappings to these commands in your .vimrc
if !exists(":WriteToggleWritingMode")
    command WriteToggleWritingMode call write#toggle_writingmode(
        \ s:write_marginwidth, s:write_textwidth, 
        \ s:write_columns, s:write_background)
endif

if !exists(":WriteToggleLineNumbers")
    command WriteToggleLineNumbers call write#toggle_numbers(s:write_marginwidth)
endif
