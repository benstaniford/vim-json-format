" Enhanced JSON syntax for vim-json-format
" This extends the default JSON syntax with better folding support

if exists("b:current_syntax")
  finish
endif

" Load the default JSON syntax first
runtime! syntax/json.vim

" Enhanced folding regions
syntax region jsonFold start="{" end="}" fold transparent
syntax region jsonFold start="\[" end="\]" fold transparent

" Highlight for folded text
highlight default link jsonFold Folded

let b:current_syntax = "json"
