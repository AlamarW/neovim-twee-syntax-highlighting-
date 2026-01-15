# Twee 3 Format-Agnostic Syntax Highlighting Roadmap

## Overview
Transform vim-twee-sugarcube into a format-agnostic Twee 3 syntax highlighting plugin that supports multiple story formats through a modular plugin system.

## Stage 1: Refactor to Format-Agnostic Architecture ✓ (In Progress)

### Goals
- Extract SugarCube-specific elements from core Twee 3 syntax
- Create modular plugin system for story format support
- Maintain backward compatibility with existing SugarCube users

### Tasks
- [x] Analyze current syntax/twee.vim to identify core vs format-specific elements
- [ ] Create `syntax/twee/` directory structure
- [ ] Create `syntax/twee/core.vim` - Universal Twee 3 structures
  - Passage headers: `::PassageName [tags]`
  - Wiki-style links: `[[...]]` (all forms)
  - HTML syntax inclusion
  - Comments, TODO keywords, escape characters
- [ ] Create `syntax/twee/sugarcube.vim` - SugarCube-specific elements
  - Variables: `$var`, `_tempVar`
  - Macros: `<<...>>`
  - Keywords, operators, booleans
  - SugarCube markdown: `//italic//`, `''bold''`, `__underline__`, lists
- [ ] Refactor `syntax/twee.vim` into plugin loader
  - Check `b:twee_story_format` (buffer-local override)
  - Check `g:twee_story_format` (global config)
  - Default to 'sugarcube' for backward compatibility
  - Load core.vim + format-specific file
- [ ] Test with SugarCube projects
- [ ] Update README.md with new configuration instructions

## Stage 2: Add Support for Other Story Formats (Future)

### Harlowe Support
- [ ] Research Harlowe 3.x syntax
  - Hook syntax: `(hook:)`, `(if:)`, `(set:)`, etc.
  - Variable syntax: `$variable`, `_variable` (different semantics than SugarCube)
  - Links: `[[link]]`, `[[display->link]]`
  - Markdown: `*italic*`, `**bold**`, `~~strikethrough~~`, etc.
  - Changers, commands, and macros
- [ ] Create `syntax/twee/harlowe.vim`
- [ ] Test with Harlowe projects

### Chapbook Support
- [ ] Research Chapbook 2.x syntax
  - Modifiers: `[if expression]`, `[unless expression]`, `[after duration]`
  - Variable syntax: `varName` (no sigils)
  - Links: `[[link]]`, `[[display: link]]`
  - Markdown: standard CommonMark
  - Inserts: `{embed passage: 'name'}`, `{reveal link: 'text', text: 'hidden'}`
- [ ] Create `syntax/twee/chapbook.vim`
- [ ] Test with Chapbook projects

### Snowman Support
- [ ] Research Snowman 2.x syntax
  - Template language: Underscore.js templates `<% %>`, `<%= %>`
  - Variable syntax: `s.variable` (story), `t.variable` (temporary)
  - Links: `[[link]]`, `[[display|link]]`
  - JavaScript expressions within templates
- [ ] Create `syntax/twee/snowman.vim`
- [ ] Test with Snowman projects

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
