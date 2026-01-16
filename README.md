# vim-twee-syntax

A [Vim](https://github.com/vim/vim) and [Neovim](https://neovim.io/) syntax highlighting plugin for [Twee 3](https://github.com/iftechfoundation/twine-specs/blob/master/twee-3-specification.md) story formats used with [Twine](http://twinery.org/).

Supports multiple story formats through a modular plugin system:
- **SugarCube 2/3, Harlowe, Chapbook, Snowman** (fully supported)
Enables highlighting for story format syntax and HTML in `.tw` and `.twee` files.

## Install

**Manual install:** Copy all of the files to your `~/.vim` directory.

**Install via a vim plugin manager:**

- [Pathogen](https://github.com/tpope/vim-pathogen): `cd ~/.vim/bundle && git clone https://github.com/AlamarW/neovim-twee-syntax-highlighting-.git`
- [Plug](https://github.com/junegunn/vim-plug): `Plug 'AlamarW/neovim-twee-syntax-highlighting-'`
- [Vundle](https://github.com/VundleVim/Vundle.vim): `Plugin 'AlamarW/neovim-twee-syntax-highlighting-'`
- [lazy.nvim](https://github.com/folke/lazy.nvim): `{ 'AlamarW/neovim-twee-syntax-highlighting-' }`

## Configuration

### Story Format Selection

The plugin supports multiple Twee 3 story formats. By default, it uses **SugarCube** for backward compatibility.

**Set a global default format** in your `~/.vimrc` or `~/.config/nvim/init.vim`:

```vim
" Use SugarCube format (default)
let g:twee_story_format = 'sugarcube'

" Or use another format (when support is added)
" let g:twee_story_format = 'harlowe'
" let g:twee_story_format = 'chapbook'
" let g:twee_story_format = 'snowman'
```

**Override per-project** using a buffer-local variable (useful with project-specific vimrc):

```vim
" In a project-specific .vimrc or using autocmds
let b:twee_story_format = 'harlowe'
```

The buffer-local setting (`b:twee_story_format`) takes precedence over the global setting (`g:twee_story_format`).

### Supported Formats

| Format | Status | Variable Value |
|--------|--------|----------------|
| SugarCube 2/3 | ✅ Fully Supported | `'sugarcube'` |
| Harlowe 3.x | ✅ Fully Supported | `'harlowe'` |
| Chapbook 2.x | ✅ Fully Supported | `'chapbook'` |
| Snowman 2.x | ✅ Fully Supported | `'snowman'` |

## Compatibility

This plugin is compatible with both **Vim** (8.0+) and **Neovim** (0.5+). It uses standard Vimscript syntax definitions and does not require any Lua or Neovim-specific features.

### Tested Editors

- ✅ Vim 8.0+
- ✅ Neovim 0.5+

The plugin works with any Vim-compatible plugin manager:
- Traditional Vim managers: Pathogen, Vundle, vim-plug
- Neovim-specific managers: lazy.nvim, packer.nvim

## Testing

This plugin includes a comprehensive test suite to ensure reliability across different editors and configurations.

### Running Tests

```bash
# Run all tests (summary output)
./tests/run_tests.sh

# Run with verbose output
./tests/run_tests.sh --verbose
```

The test suite verifies:
- Syntax highlighting groups are properly defined
- Configuration options work correctly (global and buffer-local)
- Files load without errors in both Vim and Neovim
- Format detection and fallback behavior

See [tests/README.md](tests/README.md) for more details.

## Contribute

Feel free to submit a pull request or open an issue for any unexpected highlighting issues!
