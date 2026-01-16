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

" Clear any existing syntax to ensure clean slate
" This MUST come before the guard so we clear even if another syntax was loaded
syntax clear

" Guard: Prevent loading if syntax is already set
" After clearing, check if twee syntax was already loaded
if exists("b:current_syntax") && b:current_syntax == "twee"
    finish
endif

" ---- Determine Story Format ----

" Priority: buffer-local > global > default (sugarcube for backward compatibility)
let s:story_format = get(b:, 'twee_story_format', get(g:, 'twee_story_format', 'sugarcube'))

" ---- Load Core Twee 3 Syntax ----
" This contains universal elements: passages, links, tags, comments, etc.
let b:current_syntax = ''
runtime! syntax/twee/core.vim

" ---- Load Format-Specific Syntax ----
" This contains format-specific elements: macros, variables, markdown, etc.
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
" This ensures highlighting works correctly throughout the entire file
syn sync fromstart
syn sync minlines=100

" ---- Finalize ----

let b:current_syntax = "twee"
