# Twee 3 Format-Agnostic Syntax Highlighting Roadmap

## Overview
Transform vim-twee-sugarcube into a format-agnostic Twee 3 syntax highlighting plugin that supports multiple story formats through a modular plugin system.

## Stage 1: Refactor to Format-Agnostic Architecture ✅ COMPLETE

### Goals
- Extract SugarCube-specific elements from core Twee 3 syntax
- Create modular plugin system for story format support
- Maintain backward compatibility with existing SugarCube users

### Tasks
- [x] Analyze current syntax/twee.vim to identify core vs format-specific elements
- [x] Create `syntax/twee/` directory structure
- [x] Create `syntax/twee/core.vim` - Universal Twee 3 structures
  - Passage headers: `::PassageName [tags]`
  - Wiki-style links: `[[...]]` (all forms)
  - HTML syntax inclusion
  - Comments, TODO keywords, escape characters
- [x] Create `syntax/twee/sugarcube.vim` - SugarCube-specific elements
  - Variables: `$var`, `_tempVar`
  - Macros: `<<...>>`
  - Keywords, operators, booleans
  - SugarCube markdown: `//italic//`, `''bold''`, `__underline__`, lists
- [x] Refactor `syntax/twee.vim` into plugin loader
  - Check `b:twee_story_format` (buffer-local override)
  - Check `g:twee_story_format` (global config)
  - Default to 'sugarcube' for backward compatibility
  - Load core.vim + format-specific file
- [x] Test with SugarCube projects
- [x] Update README.md with new configuration instructions
- [x] Comprehensive test suite with all tests passing

## Stage 2: Add Support for Other Story Formats ✅ COMPLETE

### Snowman Support
- [x] Research Snowman 2.x syntax
  - Template language: Underscore.js templates `<% %>`, `<%= %>`
  - Variable syntax: `s.variable` (story variables)
  - Links: `[[link]]`, `[[display|link]]`
  - JavaScript expressions within templates
- [x] Create `syntax/twee/snowman.vim`
- [x] Create comprehensive test fixture
- [x] Test with Snowman syntax

### Harlowe Support
- [x] Research Harlowe 3.x syntax
  - Macro syntax: `(macro: args)`, hooks `[text]`
  - Variable syntax: `$variable`, `_variable` (different semantics than SugarCube)
  - Links: `[[link]]`, `[[display->link]]`
  - Markdown: `*italic*`, `**bold**`, `~~strikethrough~~`, etc.
  - Changers, commands, and data structures
- [x] Create `syntax/twee/harlowe.vim`
- [x] Create comprehensive test fixture
- [x] Test with Harlowe syntax

### Chapbook Support
- [x] Research Chapbook 2.x syntax
  - Modifiers: `[if expression]`, `[unless expression]`, `[after duration]`
  - Variable syntax: `varName` (no sigils), vars section with `--` separator
  - Links: `[[link]]`, `[[display: link]]`
  - Markdown: CommonMark plus Chapbook extensions
  - Inserts: `{embed passage: 'name'}`, `{reveal link: 'text', text: 'hidden'}`
- [x] Create `syntax/twee/chapbook.vim`
- [x] Create comprehensive test fixture
- [x] Test with Chapbook syntax

## Stage 3: Advanced Features (Future)

### Potential Enhancements
- [ ] Format auto-detection from passage metadata
  - Look for `:: StoryData` passage with `"format"` field
  - Auto-set `b:twee_story_format` if found
- [ ] Validation and linting integration
  - Warn on syntax errors specific to chosen format
  - Check for undefined passages in links
- [ ] Completion support
  - Passage name completion in links
  - Macro/hook completion based on format
  - Variable completion
- [ ] Folding support for passages
- [ ] Integration with Tweego compiler
- [ ] Support for custom story format plugins

## Notes

### Design Principles
1. **Modularity**: Each format is self-contained in its own file
2. **Backward Compatibility**: Default to SugarCube if no config specified
3. **User Control**: Both global and buffer-local configuration options
4. **Extensibility**: Easy to add new formats or custom format definitions

### Configuration Examples
```vim
" Global default in ~/.vimrc
let g:twee_story_format = 'sugarcube'

" Per-project override (use vim-rooter, editorconfig, or local vimrc)
let b:twee_story_format = 'harlowe'
```

### Testing Checklist
For each format implementation:
- [ ] Variables highlight correctly
- [ ] Macros/hooks/commands highlight correctly
- [ ] Links work in all supported syntaxes
- [ ] Format-specific markdown works
- [ ] Passages and tags highlight correctly
- [ ] HTML syntax highlighting works
- [ ] Comments work
- [ ] No conflicts between core and format-specific highlighting
