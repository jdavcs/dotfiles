" ----------------------------------------------------------------------
" timestamp     Filetype plugin for timestamping .vim files
" Maintainer:   John Davis <jdavcs@gmail.com>
" File:         ftplugin/vim_timestamp.vim
" Source:       https://github.com/jdavcs/vim-timestamp
" License:      MIT
" Last Updated: 2025 Dec 30 10:57:32 PM EST
" ----------------------------------------------------------------------

" prevent from loading twice; to disable plugin uncomment next line
"let g:vimtimestamp_loaded = 1
if exists("g:vimtimestamp_loaded")
  finish
endif
let g:vimtimestamp_loaded = 1


" text that prefixes the timesamp (from start-of-line)
let s:timestamp_prefix = "\" Last Updated: "

" format for strftime()
let s:timestamp_format = "%Y %b %d %X %Z"

" regex to match s:ts_format (changing one requires updating the other)
let s:timestamp_regex = '\d\{4\} \a\{3\} \d\{2\} \d\{2\}:\d\{2\}:\d\{2\} [AP]M \a\+'


" check if globals have been defined, reassign if needed
if exists("g:timestamp_prefix")
    let s:timestamp_prefix = g:timestamp_prefix
endif

if exists("g:timestamp_format")
    let s:timestamp_format = g:timestamp_format
endif

if exists("g:timestamp_regex")
    let s:timestamp_regex = g:timestamp_regex
endif


" if timestamp exists in .vim file, this will update it on :write command
augroup timestamp
    autocmd!
    autocmd BufWritePre *.vim call timestamp#update(
        \ s:timestamp_prefix, s:timestamp_format, s:timestamp_regex)
augroup END


" add shortcuts or mappings to these commands in your .vimrc
if !exists(":TimestampInsert")
    command TimestampInsert call timestamp#insert(
        \ s:timestamp_prefix, s:timestamp_format, s:timestamp_regex)
endif

if !exists(":TimestampUpdate")
    command TimestampUpdate call timestamp#update(
        \ s:timestamp_prefix, s:timestamp_format, s:timestamp_regex)
endif
