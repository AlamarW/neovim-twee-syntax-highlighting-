" Vim plugin file for Twee
" This ensures proper setup for Twee files
" Maintainer: AlamarW
" Latest Revision: 16 January 2026

if exists('g:loaded_twee_plugin')
  finish
endif
let g:loaded_twee_plugin = 1

" Disable tree-sitter for Twee files in Neovim
" Tree-sitter can interfere with traditional Vim syntax highlighting, causing
" issues like "only first line highlighted". We use pcall for safety in case
" tree-sitter isn't available.
if has('nvim')
  augroup TweeDisableTreesitter
    autocmd!
    " Disable on FileType event (when syntax is set)
    autocmd FileType twee lua pcall(vim.treesitter.stop)
    " Also disable on buffer enter as backup (in case FileType fires before plugin)
    autocmd BufEnter *.twee,*.tw lua pcall(vim.treesitter.stop)
  augroup END
endif

" Optional: Enable verbose debug mode for syntax issues
" Uncomment the following line to debug syntax loading:
" augroup TweeDebug
"   autocmd!
"   autocmd FileType twee echom "Twee syntax loaded. Format: " . get(g:, 'twee_story_format', get(b:, 'twee_story_format', 'sugarcube'))
" augroup END
