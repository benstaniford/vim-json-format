# vim-json-format

A Vim plugin that automatically formats JSON files and applies intelligent folding when you open and save them.

## Features

- **Automatic JSON formatting** on file open and save
- **Intelligent folding** for JSON objects and arrays
- **Configurable indentation** (default: 2 spaces)
- **JSON validation** with error messages
- **Manual formatting commands** for on-demand use
- **Toggle functionality** to enable/disable auto-formatting
- **Buffer-local key mappings** for quick access

## Requirements

- Vim with Python3 support (`has('python3')` must be true)

## Installation

### Using vim-plug
```vim
Plug 'yourusername/vim-json-format'
```

### Using Vundle
```vim
Plugin 'yourusername/vim-json-format'
```

### Using Pathogen
```bash
cd ~/.vim/bundle
git clone https://github.com/yourusername/vim-json-format.git
```

### Manual Installation
Copy the plugin files to your Vim configuration directory.

## Usage

The plugin works automatically on JSON files:

1. **Open a JSON file** - it will be automatically formatted and folded
2. **Save a JSON file** - formatting is applied again
3. **Use manual commands** for on-demand formatting

### Commands

- `:JsonFormat` - Manually format the current buffer
- `:JsonFormatToggle` - Toggle automatic formatting on/off

### Key Mappings (JSON files only)

- `<leader>jf` - Format current JSON buffer
- `<leader>jt` - Toggle automatic formatting

## Configuration

Add these to your `.vimrc` to customize behavior:

```vim
" Enable/disable auto-formatting on file open (default: 1)
let g:json_format_on_open = 1

" Enable/disable auto-formatting on file save (default: 1)
let g:json_format_on_save = 1

" Set indentation spaces (default: 2)
let g:json_format_indent = 2

" Enable/disable automatic folding (default: 1)
let g:json_format_folds = 1
```

## Example

Before formatting:
```json
{"name":"John","age":30,"city":"New York","hobbies":["reading","swimming"],"address":{"street":"123 Main St","zip":"10001"}}
```

After formatting:
```json
{
  "address": {
    "street": "123 Main St",
    "zip": "10001"
  },
  "age": 30,
  "city": "New York",
  "hobbies": [
    "reading",
    "swimming"
  ],
  "name": "John"
}
```

With folding applied, you'll see:
```json
{
  "address": {+-- 3 lines},
  "age": 30,
  "city": "New York",
  "hobbies": [+-- 3 lines],
  "name": "John"
}
```

## Functions

For advanced users, these functions are available:

- `json_format#format_buffer()` - Main formatting function
- `json_format#apply_folds()` - Apply folding to JSON structures
- `json_format#toggle_format()` - Toggle auto-formatting
- `json_format#is_valid_json()` - Check if buffer contains valid JSON

## License

MIT License - see LICENSE file for details.
