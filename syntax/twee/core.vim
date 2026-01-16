" Vim syntax file
" Language: Twee 3 (Core/Universal Elements)
" Maintainer: mcombeau
" Latest Revision: 15 January 2026
"
" This file contains syntax definitions for universal Twee 3 structures
" that are common across all story formats (SugarCube, Harlowe, Chapbook, etc.)

" Note: No guard here - the main syntax/twee.vim file handles preventing duplicate loads

" Include HTML syntax highlighting for .tw and .twee files
runtime! syntax/html.vim
unlet! b:current_syntax

" ---- Define Core Twee 3 Syntax Elements ----

" Twee Comments and TODO Keywords
syn region	tweeComment	start="<!--" end="-->"
syn keyword	tweeToDo	TODO XXX FIXME contained containedin=tweeComment

" Escape Character (line continuation)
syn match	tweeEOL		'\\$'

" Twee Passages - Format: ::PassageName [tag1 tag2] {"metadata":"json"}
" The passage header itself
syn match tweePassage	"^::.*$" contains=tweePassageTitle,tweeTag

" Matching Passage Names in Titles
" ::PassageName
syn match tweePassageTitle	"::\zs[^|<>:\[\]]*" contained

" Passage Tags [tag1 tag2]
syn match tweeTag	"\[\zs[^\]]*\ze\]" contained

" Twee Wiki-Style Links - Universal across all formats
" These work in all Twee 3 story formats
syn region tweeLink		start="\[\[" end="\]\]" contains=tweeLinkedPassage keepend

" Matching Passage Names in Links
" [[PassageName]]
syn match tweeLinkedPassage	"\[\[\zs[^|<>]*\ze\]\]" contained
" [[Display Text|PassageName]]
syn match tweeLinkedPassage	"\v\|\zs([^]]*)" contained containedin=tweeLink
" [[Display Text->PassageName]]
syn match tweeLinkedPassage	"\v\-\>\zs([^]]*)" contained containedin=tweeLink
" [[PassageName<-Display Text]]
syn match tweeLinkedPassage	"\v\<-\zs([^]]*)" contained containedin=tweeLink

" ---- Set Highlighting for Core Elements ----

hi def link tweePassage			Special
hi def link tweePassageTitle	StorageClass
hi def link tweeLink			Special
hi def link tweeLinkedPassage	StorageClass
hi def link tweeComment			Comment
hi def link tweeEOL				Comment
hi def link tweeToDo			Todo
hi def link tweeTag				Function
