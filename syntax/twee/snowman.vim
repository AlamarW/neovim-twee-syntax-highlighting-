" Vim syntax file
" Language: Twee 3 + Snowman 2.x
" Maintainer: AlamarW
" Latest Revision: 15 January 2026
"
" This file contains syntax definitions specific to the Snowman 2.x story format.
" It should be loaded in addition to syntax/twee/core.vim
"
" Snowman is an advanced Twine story format designed for people who already
" know JavaScript and CSS. It uses Underscore.js templates instead of macros.

" Note: No guard here - the main syntax/twee.vim file handles preventing duplicate loads

" ---- Define Snowman-Specific Syntax Elements ----

" Snowman Template Tags
" <%= expression %> - Output expression
" <% code %> - Execute JavaScript code
" <%- expression %> - HTML-escaped output
syn region tweeSnowmanTemplate start="<%[-=]\?" end="%>" contains=tweeSnowmanVariable,tweeSnowmanStoryAPI,tweeSnowmanKeyword,tweeSnowmanFunction,tweeSnowmanOperator,tweeSnowmanString,tweeSnowmanNumber,tweeSnowmanBoolean,tweeSnowmanComment

" Snowman Story Variables
" s.variable - story variables (persistent across passages)
" window.story - story API access
syn match tweeSnowmanVariable "\<s\.\w\+" contained
syn match tweeSnowmanStoryAPI "\v<(window\.story|story\.\w+)>" contained

" JavaScript Keywords (within templates)
syn keyword tweeSnowmanKeyword var let const function if else for while do switch case break continue return try catch finally throw new typeof instanceof in of contained
syn keyword tweeSnowmanBoolean true false null undefined contained

" Snowman/Underscore Functions
syn keyword tweeSnowmanFunction print render contained

" JavaScript Operators
syn keyword tweeSnowmanOperator delete void contained

" Strings (within templates)
syn region tweeSnowmanString start=/"/ skip=/\\./ end=/"/ contained
syn region tweeSnowmanString start=/'/ skip=/\\./ end=/'/ contained
syn region tweeSnowmanString start=/`/ skip=/\\./ end=/`/ contained

" Numbers (within templates)
syn match tweeSnowmanNumber "\<\d\+\>" contained
syn match tweeSnowmanNumber "\<0x\x\+\>" contained
syn match tweeSnowmanNumber "\<\d\+\.\d\+\>" contained

" JavaScript Comments (within templates)
syn region tweeSnowmanComment start="//" end="$" contained
syn region tweeSnowmanComment start="/\*" end="\*/" contained

" ---- Set Highlighting for Snowman Elements ----

hi def link tweeSnowmanTemplate		PreProc
hi def link tweeSnowmanVariable		Identifier
hi def link tweeSnowmanStoryAPI		Function
hi def link tweeSnowmanKeyword		Keyword
hi def link tweeSnowmanFunction		Function
hi def link tweeSnowmanOperator		Operator
hi def link tweeSnowmanString		String
hi def link tweeSnowmanNumber		Number
hi def link tweeSnowmanBoolean		Boolean
hi def link tweeSnowmanComment		Comment
