" vim-json-format: A vim plugin that formats json files and applies folds
" Author: Ben Staniford
" License: MIT

if exists('g:loaded_json_format')
    finish
endif
let g:loaded_json_format = 1

" Check if Python3 is available
if !has('python3')
    echohl ErrorMsg
    echom 'vim-json-format requires Python3 support'
    echohl None
    finish
endif

" Default settings
if !exists('g:json_format_on_open')
    let g:json_format_on_open = 1
endif

if !exists('g:json_format_on_save')
    let g:json_format_on_save = 1
endif

if !exists('g:json_format_indent')
    let g:json_format_indent = 2
endif

if !exists('g:json_format_folds')
    let g:json_format_folds = 1
endif

" Commands
command! JsonFormat call json_format#format_buffer()
command! JsonFormatToggle call json_format#toggle_format()

" Auto commands for JSON files
augroup JsonFormat
    autocmd!
    if g:json_format_on_open
        autocmd BufReadPost *.json call json_format#on_buffer_read()
    endif
    if g:json_format_on_save
        autocmd BufWritePre *.json call json_format#on_buffer_write()
    endif
augroup END
