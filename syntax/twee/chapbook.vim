" Vim syntax file
" Language: Twee 3 + Chapbook 2.x
" Maintainer: AlamarW
" Latest Revision: 15 January 2026
"
" This file contains syntax definitions specific to the Chapbook 2.x story format.
" It should be loaded in addition to syntax/twee/core.vim
"
" Chapbook is a "second-generation" Twine story format that emphasizes readability
" and uses modifiers and inserts instead of macros.

" Note: No guard here - the main syntax/twee.vim file handles preventing duplicate loads

" ---- Define Chapbook-Specific Syntax Elements ----

" Chapbook Variables (no sigil prefix)
" Variables are referenced in inserts like {variableName}
syn match tweeChapbookVariable "\w\+" contained

" Chapbook Vars Section
" Appears at beginning of passage, ends with --
syn region tweeChapbookVarsSection start="^" end="^--$" contains=tweeChapbookVarDecl,tweeChapbookComment
syn match tweeChapbookVarDecl "^\w\+:" contained

" Chapbook Modifiers (start of line, in brackets)
" [if condition], [unless condition], [else], [continued], [append], [after duration]
syn match tweeChapbookModifier "^\[if\s\+[^\]]\+\]" contains=tweeChapbookKeyword,tweeChapbookOperator,tweeChapbookVariable
syn match tweeChapbookModifier "^\[unless\s\+[^\]]\+\]" contains=tweeChapbookKeyword,tweeChapbookOperator,tweeChapbookVariable
syn match tweeChapbookModifier "^\[else\]"
syn match tweeChapbookModifier "^\[continued\]"
syn match tweeChapbookModifier "^\[append\]"
syn match tweeChapbookModifier "^\[after\s\+[^\]]\+\]" contains=tweeChapbookKeyword

" Chapbook Keywords (within modifiers and expressions)
syn keyword tweeChapbookKeyword if unless else append continued after ifalways ifnever contained

" Chapbook Operators (within modifiers)
syn keyword tweeChapbookOperator and or not contained
syn match tweeChapbookOperator "\v(\=\=\=|!\=\=|>\=|<\=|>|<|&&|\|\|)" contained

" Chapbook Boolean Values
syn keyword tweeChapbookBoolean true false contained

" Chapbook Inserts (inline, curly braces)
" {embed passage: 'name'}, {reveal link: 'text', text: 'content'}, {cycling link}, {varName}
syn region tweeChapbookInsert start="{" end="}" contains=tweeChapbookInsertKeyword,tweeChapbookVariable,tweeChapbookString,tweeChapbookNumber,tweeChapbookBoolean

" Chapbook Insert Keywords
syn keyword tweeChapbookInsertKeyword embed reveal link cycling back restart passage text choices for contained

" Strings (within inserts and vars)
syn region tweeChapbookString start=/"/ skip=/\\./ end=/"/ contained
syn region tweeChapbookString start=/'/ skip=/\\./ end=/'/ contained

" Numbers (within inserts and vars)
syn match tweeChapbookNumber "\<\d\+\>" contained
syn match tweeChapbookNumber "\<\d\+\.\d\+\>" contained

" Chapbook-specific Markdown
" Chapbook uses standard CommonMark plus some extras

" Standard Markdown (same as most formats)
" *italic* or _italic_
syn region tweeChapbookItalic start="\*" end="\*"
syn region tweeChapbookItalic start="_" end="_"

" **bold** or __bold__
syn region tweeChapbookBold start="\*\*" end="\*\*"
syn region tweeChapbookBold start="__" end="__"

" `code`
syn region tweeChapbookCode start="`" end="`"

" ~~small caps~~ (Chapbook-specific!)
syn region tweeChapbookSmallCaps start="\~\~" end="\~\~"

" # Headings
syn match tweeChapbookHeading "^#\{1,6\}\s.*$"

" Lists
syn match tweeChapbookList "^[\*\-\+]\s"
syn match tweeChapbookList "^\d\+\.\s"
syn match tweeChapbookList "^#\s"

" ---- Set Highlighting for Chapbook Elements ----

hi def link tweeChapbookVariable		Identifier
hi def link tweeChapbookVarsSection		PreProc
hi def link tweeChapbookVarDecl			Statement
hi def link tweeChapbookModifier		PreProc
hi def link tweeChapbookKeyword			Keyword
hi def link tweeChapbookOperator		Operator
hi def link tweeChapbookBoolean			Boolean
hi def link tweeChapbookInsert			Special
hi def link tweeChapbookInsertKeyword	Keyword
hi def link tweeChapbookString			String
hi def link tweeChapbookNumber			Number
hi def link tweeChapbookHeading			Title
hi def link tweeChapbookList			Special

hi def tweeChapbookItalic				term=italic cterm=italic gui=italic
hi def tweeChapbookBold					term=bold cterm=bold gui=bold
hi def tweeChapbookCode					term=standout cterm=standout gui=standout
hi def tweeChapbookSmallCaps			term=bold cterm=bold gui=bold
