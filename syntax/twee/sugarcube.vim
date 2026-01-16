" Vim syntax file
" Language: Twee 3 + SugarCube 2/3
" Maintainer: mcombeau
" Latest Revision: 15 January 2026
"
" This file contains syntax definitions specific to the SugarCube story format.
" It should be loaded in addition to syntax/twee/core.vim

" Note: No guard here - the main syntax/twee.vim file handles preventing duplicate loads

" ---- Define SugarCube-Specific Syntax Elements ----

" SugarCube Keywords
syn	keyword	tweeConditional	if not else elseif contained
syn	keyword	tweeRepeat		for break continue contained
syn	keyword	tweeLabel		switch case default contained
syn	keyword	tweeOperator	to is isnot eq neq gt gte lt lte not and or def ndef contained
syn	keyword	tweeKeyword		capture set unset run script include nobr print silently type button checkbox cycle link linkappend linkprepend linkreplace listbox numberbox radiobutton textarea textbox actions back choice return addclass append copy prepend remove removeclass replace toggleclass audio cacheaudio createplaylist masteraudio playlist removeaudiogroup removeplaylist waitforaudio done goto repeat stop timed widget contained
syn keyword tweeBool		true false contained

" SugarCube Variables
" $storyVariable - persists across passages
" _temporaryVariable - exists only in current passage
syn match tweeVariable	"[$_]\v[a-zA-Z.]*"
syn match tweeSubVariable	"[.]\w*" contained containedin=tweeVariable

" SugarCube Strings and Numbers (within macros and links)
syn match tweeString	"\(["']\)[^"']*\1" contained containedin=tweeLink
syn match tweeNumber	"\d\+" contained

" SugarCube Macros
" Format: <<macroname arguments>>
syn region tweeMacro	start="<<" end=">>" contains=tweeConditional,tweeRepeat,tweeLabel,tweeOperator,tweeKeyword,tweeVariable,tweeString,tweeBool,tweeNumber

" SugarCube Markdown-Style Formatting
" These are SugarCube's custom markup, not universal Twee
syn region	tweeItalic		start="//" end="//"
syn region	tweeBold		start="''" end="''"
syn region	tweeUnderline	start="__" end="__"
syn match	tweeList		'^[*#]'

" ---- Set Highlighting for SugarCube Elements ----

hi def link tweeMacro			Special
hi def link	tweeConditional		Conditional
hi def link	tweeRepeat			Repeat
hi def link	tweeLabel			Label
hi def link	tweeOperator		Operator
hi def link	tweeKeyword			Keyword
hi def link tweeVariable		Identifier
hi def link tweeSubVariable		Structure
hi def link tweeString			String
hi def link tweeBool			Boolean
hi def link tweeNumber			Number

hi def tweeItalic		term=italic cterm=italic gui=italic
hi def tweeUnderline	term=underline cterm=underline gui=underline
hi def tweeBold			term=bold cterm=bold gui=bold
hi def tweeList			term=bold cterm=bold gui=bold
