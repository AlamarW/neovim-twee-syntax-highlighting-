" Vim syntax file
" Language: Twee 3 + Harlowe 3.x
" Maintainer: AlamarW
" Latest Revision: 15 January 2026
"
" This file contains syntax definitions specific to the Harlowe 3.x story format.
" It should be loaded in addition to syntax/twee/core.vim
"
" Harlowe is a macro-based story format that uses hooks and changers
" for displaying dynamic content and controlling game flow.

" Note: No guard here - the main syntax/twee.vim file handles preventing duplicate loads

" ---- Define Harlowe-Specific Syntax Elements ----

" Harlowe Variables
" $storyVariable - persistent across passages
" _temporaryVariable - scoped to current passage/hook/lambda
syn match tweeHarloweVariable "[$_]\w\+"
syn match tweeHarloweProperty "\.\w\+" contained containedin=tweeHarloweVariable

" Harlowe Macros
" Format: (macro: arguments)
" Matches (word:), (word-word:), etc.
syn region tweeHarloweMacro start="(" end=")" contains=tweeHarloweKeyword,tweeHarloweCommand,tweeHarloweVariable,tweeHarloweString,tweeHarloweNumber,tweeHarloweOperator,tweeHarloweBoolean

" Harlowe Hooks
" [text] - basic hook
" [text]<name| or |name>[text] - named hooks
syn region tweeHarloweHook start="\[" end="\]" contains=ALL
syn match tweeHarloweHookName "<\w\+|" contained containedin=tweeHarloweHook
syn match tweeHarloweHookName "|\w\+>" contained containedin=tweeHarloweHook

" Common Harlowe Commands (execute actions)
syn keyword tweeHarloweCommand set put move print display goto show hide replace append prepend rerun reload loadgame savegame contained
syn match tweeHarloweCommand "\v<(go-to)>" contained

" Common Harlowe Changers (modify hooks)
syn keyword tweeHarloweKeyword if unless else for loop while each live stop cycling contained
syn match tweeHarloweKeyword "\v<(else-if)>" contained

" Data Structure Macros
syn keyword tweeHarloweKeyword a dm ds range repeated reversed sorted shuffled contained

" Link Macros
syn keyword tweeHarloweKeyword link click mouseover mouseout contained
syn match tweeHarloweKeyword "\v<(link-goto|link-reveal|link-repeat|link-undo|link-fullscreen|mouseover-replace|mouseout-replace)>" contained

" Text Style Macros
syn keyword tweeHarloweKeyword bg background font align transition contained
syn match tweeHarloweKeyword "\v<(text-style|text-colour|text-color|text-rotate)>" contained

" State/History Macros
syn keyword tweeHarloweKeyword visited history passages contained
syn match tweeHarloweKeyword "\v<(saved-games)>" contained

" Data Inspection Macros
syn keyword tweeHarloweKeyword either nth contained

" Logic/Control Macros
syn keyword tweeHarloweKeyword continue break cond contained

" Enchantment Macros
syn keyword tweeHarloweKeyword enchant change contained
syn match tweeHarloweKeyword "\v<(enchant-in)>" contained

" Harlowe Operators (used in macro arguments)
" Word operators (using match to avoid conflicts with Vim keywords)
syn match tweeHarloweOperator "\v<(is|isnot|contains|matches|and|or|not|to|into|of)>" contained
" Hyphenated operators
syn match tweeHarloweOperator "\v<(does-not-contain|is-not|does-not-match|is-in|is-not-in)>" contained
" Symbol operators
syn match tweeHarloweOperator "\v(\+|-|\*|/|\%|>|<|>\=|<\=|\=\=|!\=)" contained

" Harlowe Boolean Values
syn keyword tweeHarloweBoolean true false contained

" Strings (within macros)
syn region tweeHarloweString start=/"/ skip=/\\./ end=/"/ contained
syn region tweeHarloweString start=/'/ skip=/\\./ end=/'/ contained

" Numbers (within macros)
syn match tweeHarloweNumber "\<\d\+\>" contained
syn match tweeHarloweNumber "\<\d\+\.\d\+\>" contained

" Harlowe Markdown-style Formatting
" //italic//
syn region tweeHarloweItalic start="//" end="//"
" ''bold''
syn region tweeHarloweBold start="''" end="''"
" ~~strikethrough~~
syn region tweeHarloweStrike start="\~\~" end="\~\~"
" ^^superscript^^
syn region tweeHarloweSuperscript start="\^\^" end="\^\^"
" ==heading==
syn match tweeHarloweHeading "^==.*==$"
syn match tweeHarloweHeading2 "^===.*===$"
syn match tweeHarloweHeading3 "^====.*====$"

" ---- Set Highlighting for Harlowe Elements ----

hi def link tweeHarloweVariable		Identifier
hi def link tweeHarloweProperty		Structure
hi def link tweeHarloweMacro		PreProc
hi def link tweeHarloweHook			Special
hi def link tweeHarloweHookName		Function
hi def link tweeHarloweCommand		Statement
hi def link tweeHarloweKeyword		Keyword
hi def link tweeHarloweOperator		Operator
hi def link tweeHarloweBoolean		Boolean
hi def link tweeHarloweString		String
hi def link tweeHarloweNumber		Number

hi def tweeHarloweItalic			term=italic cterm=italic gui=italic
hi def tweeHarloweBold				term=bold cterm=bold gui=bold
hi def tweeHarloweStrike			term=strikethrough cterm=strikethrough gui=strikethrough
hi def tweeHarloweSuperscript		term=bold cterm=bold gui=bold
hi def link tweeHarloweHeading		Title
hi def link tweeHarloweHeading2		Title
hi def link tweeHarloweHeading3		Title
