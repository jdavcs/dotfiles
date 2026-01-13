" ----------------------------------------------------------------------
" timestamp     Filetype plugin for timestamping .vim files
" Maintainer:   John Davis <jdavcs@gmail.com>
" File:         autoload/timestamp.vim
" Source:       https://github.com/jdavcs/vim-timestamp
" License:      MIT
" Last Updated: 2025 Dec 30 10:57:18 PM EST
" ----------------------------------------------------------------------

" private
" returns true if timestamp already exists;
" side effect: if exists, the cursor will be moved to that location
function! s:exists(prefix, regex)
    let l:ts_pattern = "^" . a:prefix . a:regex
    return search(l:ts_pattern, 'w') > 0
endfunction

" private
" inserts new timestamp with current time;
" exact postion depends on argument: ex_cmd
function! s:make_timestamp(prefix, format, ex_cmd)
    let l:ts_new = a:prefix . strftime(a:format)
    exec "normal! " . a:ex_cmd . l:ts_new
endfunction

" public
" attempts to insert new timestamp
function! timestamp#insert(prefix, format, regex)
    if !s:exists(a:prefix, a:regex)
        " insert new timestamp as a new line at cursor position
        call s:make_timestamp(a:prefix, a:format, "O\<ESC>cc")
    endif
endfunction

" public
" attempts to insert new timestamp replacing existing timestamp
function! timestamp#update(prefix, format, regex)
    "set mark 
    normal! mm
    if s:exists(a:prefix, a:regex)
        " replace current line with new timestamp
        call s:make_timestamp(a:prefix, a:format, "cc")
        " move back to mark
        normal! `m
    endif
endfunction
