" JSON filetype plugin for vim-json-format
" Sets up JSON-specific settings

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Set local options for JSON files
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
setlocal smartindent

" Enable syntax-based folding
setlocal foldmethod=syntax
setlocal foldlevelstart=1

" Set comment string for JSON (though JSON doesn't support comments)
setlocal commentstring=//%s

" Key mappings for JSON formatting
nnoremap <buffer> <leader>jf :JsonFormat<CR>
nnoremap <buffer> <leader>jt :JsonFormatToggle<CR>

" Automatically format when entering insert mode on empty buffer
autocmd InsertEnter <buffer> if line('$') == 1 && getline(1) == '' | startinsert | endif

let b:undo_ftplugin = "setlocal tabstop< shiftwidth< expandtab< autoindent< smartindent< foldmethod< foldlevelstart< commentstring<"
