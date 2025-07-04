" vim-json-format autoload functions
" Author: Ben

let s:format_enabled = 1

function! json_format#format_buffer()
    " Save cursor position
    let l:cursor_pos = getpos('.')
    
    " Check if buffer is a JSON file
    if &filetype !=# 'json' && expand('%:e') !=# 'json'
        echohl WarningMsg
        echom 'Not a JSON file'
        echohl None
        return
    endif
    
    " Get buffer content
    let l:content = join(getline(1, '$'), "\n")
    
    " Format JSON using Python
    try
        python3 << EOF
import vim
import json
import re

def format_json():
    try:
        # Get the content from vim
        content = vim.eval('l:content')
        
        # Parse and format JSON
        parsed = json.loads(content)
        indent = int(vim.eval('g:json_format_indent'))
        formatted = json.dumps(parsed, indent=indent, ensure_ascii=False, sort_keys=True)
        
        # Split into lines and set buffer content
        lines = formatted.split('\n')
        vim.current.buffer[:] = lines
        
        return True
    except json.JSONDecodeError as e:
        vim.command(f'echohl ErrorMsg | echom "JSON Parse Error: {str(e)}" | echohl None')
        return False
    except Exception as e:
        vim.command(f'echohl ErrorMsg | echom "Error: {str(e)}" | echohl None')
        return False

format_json()
EOF
        
        " Apply folds if enabled
        if g:json_format_folds
            call json_format#apply_folds()
        endif
        
        " Restore cursor position
        call setpos('.', l:cursor_pos)
        
        echom 'JSON formatted successfully'
    catch
        echohl ErrorMsg
        echom 'Failed to format JSON: ' . v:exception
        echohl None
    endtry
endfunction

function! json_format#apply_folds()
    " Set fold method to syntax for JSON
    setlocal foldmethod=syntax
    setlocal foldlevel=1
    
    " Custom fold expressions for JSON
    setlocal foldexpr=json_format#fold_expr(v:lnum)
    setlocal foldmethod=expr
    
    " Fold all arrays and objects initially
    normal! zM
    
    " Open the first level
    normal! zr
endfunction

function! json_format#fold_expr(lnum)
    let l:line = getline(a:lnum)
    let l:prev_line = getline(a:lnum - 1)
    let l:next_line = getline(a:lnum + 1)
    
    " Start fold for objects and arrays
    if l:line =~# '^\s*[{\[]'
        return 'a1'
    endif
    
    " End fold for objects and arrays
    if l:line =~# '^\s*[}\]]'
        return 's1'
    endif
    
    " Continue fold
    return '='
endfunction

function! json_format#on_buffer_read()
    if s:format_enabled
        call json_format#format_buffer()
    endif
endfunction

function! json_format#on_buffer_write()
    if s:format_enabled
        call json_format#format_buffer()
    endif
endfunction

function! json_format#toggle_format()
    let s:format_enabled = !s:format_enabled
    if s:format_enabled
        echom 'JSON auto-formatting enabled'
    else
        echom 'JSON auto-formatting disabled'
    endif
endfunction

function! json_format#is_valid_json()
    let l:content = join(getline(1, '$'), "\n")
    
    try
        python3 << EOF
import vim
import json

try:
    content = vim.eval('l:content')
    json.loads(content)
    vim.command('let l:is_valid = 1')
except:
    vim.command('let l:is_valid = 0')
EOF
        return l:is_valid
    catch
        return 0
    endtry
endfunction
