" Vim syntax file
" Language: Twee 3 (Format-Agnostic)
" Maintainer: AlamarW
" Original Author: mcombeau
" Latest Revision: 16 January 2026
" Based on: https://github.com/PolyCement/vim-tweego/
" Based on: https://gist.github.com/thricedotted/6590696
"
" This is the main loader for Twee 3 syntax highlighting.
" It loads core Twee syntax plus format-specific syntax based on configuration.
"
" Configuration:
"   let g:twee_story_format = 'sugarcube'  " Global default
"   let b:twee_story_format = 'harlowe'    " Buffer-local override
"
" Supported formats: sugarcube, harlowe, chapbook, snowman
"
" Note: Tree-sitter is automatically disabled for Twee files via plugin/twee.vim
"       to prevent conflicts with traditional Vim syntax highlighting.

" ---- Critical: Clear Before Guard ----
" MUST clear syntax BEFORE checking the guard. If tree-sitter or another plugin
" has already set b:current_syntax (e.g., to "lua"), the guard would exit early
" without clearing, preventing Twee syntax from ever loading.
syntax clear

" ---- Guard: Prevent Duplicate Load ----
" Only exit if Twee syntax is already fully loaded. This allows us to override
" other syntax (like tree-sitter) but prevents double-loading Twee itself.
if exists("b:current_syntax") && b:current_syntax == "twee"
    finish
endif

" ---- Determine Story Format ----
" Priority: buffer-local > global > default (sugarcube for backward compatibility)
let s:story_format = get(b:, 'twee_story_format', get(g:, 'twee_story_format', 'sugarcube'))

" ---- Load Core Twee 3 Syntax ----
" Reset b:current_syntax to allow subfiles to load properly. The subfiles don't
" have their own guards, so they rely on this being cleared.
let b:current_syntax = ''
runtime! syntax/twee/core.vim

" ---- Load Format-Specific Syntax ----
" Validate format file exists before loading to provide helpful error messages
let s:format_file = 'syntax/twee/' . s:story_format . '.vim'

if filereadable(expand('<sfile>:p:h') . '/twee/' . s:story_format . '.vim')
    execute 'runtime! ' . s:format_file
else
    echohl WarningMsg
    echomsg "Twee syntax: Unknown story format '" . s:story_format . "'. Falling back to core syntax only."
    echomsg "Available formats: sugarcube, harlowe, chapbook, snowman"
    echomsg "Set g:twee_story_format or b:twee_story_format to choose a format."
    echohl None
endif

" ---- Syntax Synchronization ----
" fromstart: Always parse from the beginning for accuracy (Twee files are small)
" minlines: Look back at least 100 lines when re-syncing during scrolling
" These settings ensure highlighting works correctly throughout the entire file,
" preventing the "only first line highlighted" issue.
syn sync fromstart
syn sync minlines=100

" ---- Finalize ----
" Mark syntax as fully loaded. This prevents the guard from blocking re-entry.
let b:current_syntax = "twee"

" Debug: Uncomment to verify syntax loaded correctly
" echomsg "Twee syntax loaded successfully. Format: " . s:story_format
