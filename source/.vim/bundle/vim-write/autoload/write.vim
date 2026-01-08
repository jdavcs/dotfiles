" ----------------------------------------------------------------------
" write         Minimalist writing mode for Vim
" Maintainer:   John Davis <jdavcs@gmail.com>
" File:         autoload/write.vim
" Source:       https://github.com/jdavcs/vim-write
" License:      MIT
" Last Updated: 2025 Dec 30 11:00:48 PM EST
" ----------------------------------------------------------------------

" public
" toggle line numbers maintaining maximum left margin width:
"   if numbers are set, unset numbers + increase foldcolumn width; 
"   otherwise set numbers + reduce foldcolumn width
function! write#toggle_numbers(margin_width)
    "get number of digits needed to display the last line number
    let l:digits = len(line("$") . "")

    " account for Vim's handling of width of 1- and 2-digit line numbers
    if  l:digits == 2       " 10-99 lines: add 1 space to digits
        let l:digits += 1
    elseif l:digits < 2     " < 10 lines: add 2 spaces to digits
        let l:digits += 2
    endif

   " let l:width = a:margin_width - l:digits - 1 " width with numbers displayed   (this causes an error)
    let l:width = 0
   
    " toggle numbers and width
    if &number == 1
        setlocal nonumber
        let &l:foldcolumn = a:margin_width
    else
        setlocal number
        let &l:foldcolumn= l:width
    endif
endfunction


" public
" toggle set of options for optimal writing experience
function! write#toggle_writingmode(margin_width, textwidth, columns, background)
    if g:write_writingmode == 0
        let g:write_writingmode = 1

        " save current option values 
        let s:foldcolumn = &l:foldcolumn
        let s:textwidth = &l:textwidth
        let s:columns = &l:columns
        let s:formatoptions = &l:formatoptions
        let s:formatprg = &l:formatprg
        let s:background = &l:background
        let s:number = &l:number
        let s:list = &l:list
        let s:autoindent = &l:autoindent
        let s:smartindent = &l:smartindent

        " set new values
        "let &foldcolumn = a:margin_width
        let &textwidth = a:textwidth
        "let &columns = a:columns
        let &background = a:background
        setlocal formatoptions=nt1
        setlocal formatprg=par

        setlocal nonumber
        setlocal nolist
        setlocal noautoindent
        setlocal nosmartindent
    else
        let g:write_writingmode = 0

        " restore previous option values
        "let &l:foldcolumn = s:foldcolumn
        let &l:formatoptions = s:formatoptions
        let &l:formatprg = s:formatprg
        let &l:background = s:background
        let &l:number = s:number
        let &l:list = s:list
        let &l:autoindent = s:autoindent
        let &l:smartindent = s:smartindent

        " resetting these 2 options back to original values could be annoying;
        " maybe better keep their writing mode values?
        let &l:textwidth = s:textwidth
        "let &l:columns = s:columns
    endif
endfunction
