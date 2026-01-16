" Vim plugin file for Twee
" This ensures proper setup for Twee files

" Disable tree-sitter for twee files if nvim-treesitter is available
" Tree-sitter can interfere with traditional Vim syntax highlighting
if has('nvim') && exists('g:loaded_nvim_treesitter')
  augroup TweeDisableTreesitter
    autocmd!
    autocmd FileType twee lua vim.treesitter.stop()
  augroup END
endif
