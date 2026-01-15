# Test Suite for vim-twee-syntax

This directory contains comprehensive tests for the Twee 3 syntax highlighting plugin.

## Test Structure

```
tests/
├── run_tests.sh              # Main test runner (run this!)
├── test_syntax_groups.vim    # Tests that syntax groups are properly defined
├── test_config.vim           # Tests configuration options
├── fixtures/                 # Test files
│   ├── sugarcube.twee       # Comprehensive SugarCube syntax test
│   └── core.twee            # Core Twee 3 syntax test
└── README.md                 # This file
```

## Running Tests

### Quick Run (Summary Output)

```bash
./tests/run_tests.sh
```

### Verbose Run (Detailed Output)

```bash
./tests/run_tests.sh --verbose
# or
./tests/run_tests.sh -v
```

### Running Individual Tests

You can run individual test scripts directly:

```bash
# Test syntax groups
vim -u NONE -N --noplugin -S tests/test_syntax_groups.vim

# Test configuration
vim -u NONE -N --noplugin -S tests/test_config.vim

# Or with Neovim
nvim -u NONE -N --noplugin -S tests/test_syntax_groups.vim
```

## What Gets Tested

### 1. Syntax Groups Test (`test_syntax_groups.vim`)

Verifies that all required syntax groups are defined:

**Core Syntax Groups:**
- `tweeComment` - HTML comments
- `tweeToDo` - TODO/FIXME/XXX keywords
- `tweeEOL` - Line continuation character
- `tweePassage` - Passage headers
- `tweePassageTitle` - Passage names
- `tweeTag` - Passage tags
- `tweeLink` - Wiki-style links
- `tweeLinkedPassage` - Linked passage names

**SugarCube Syntax Groups:**
- `tweeConditional` - if/else/elseif
- `tweeRepeat` - for/break/continue
- `tweeLabel` - switch/case/default
- `tweeOperator` - to/is/eq/and/or/etc.
- `tweeKeyword` - set/print/button/etc.
- `tweeBool` - true/false
- `tweeVariable` - $story and _temporary variables
- `tweeSubVariable` - .property access
- `tweeString` - String literals
- `tweeNumber` - Number literals
- `tweeMacro` - <<macro>> blocks
- `tweeItalic` - //italic// text
- `tweeBold` - ''bold'' text
- `tweeUnderline` - __underlined__ text
- `tweeList` - * and # lists

### 2. Configuration Test (`test_config.vim`)

Tests that configuration options work correctly:

- **Default behavior**: Uses SugarCube when no config is set
- **Global config**: `g:twee_story_format` sets the default format
- **Buffer-local override**: `b:twee_story_format` overrides global setting
- **Core always loads**: Core syntax loads regardless of format choice
- **Unknown format handling**: Shows warning and falls back to core syntax only

### 3. File Loading Test

Verifies that test files load without errors in both Vim and Neovim.

## Compatibility Testing

The test suite automatically detects and tests with:
- **Vim** (if installed)
- **Neovim** (if installed)

Tests will be skipped for any editor that is not installed. At least one editor must be available for tests to run.

## Test Fixtures

### `fixtures/sugarcube.twee`

Comprehensive SugarCube test file covering:
- All macro types (if/for/switch/set/print/link/button/etc.)
- Variables ($story, _temporary, .properties)
- All operators and keywords
- SugarCube markdown (italic/bold/underline/lists)
- Comments and TODO keywords
- All link syntaxes
- HTML elements

### `fixtures/core.twee`

Core Twee 3 test file with only universal elements:
- Passage headers with tags and metadata
- All link syntaxes
- Comments
- HTML elements
- Line continuation

## Exit Codes

- `0` - All tests passed
- `1` - One or more tests failed

## CI Integration

The test suite is designed to be CI-ready. Example for GitHub Actions:

```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Vim
        run: sudo apt-get install -y vim
      - name: Install Neovim
        run: sudo apt-get install -y neovim
      - name: Run tests
        run: ./tests/run_tests.sh
```

## Adding New Tests

To add a new test:

1. Create a new test script in `tests/` (e.g., `test_new_feature.vim`)
2. Add the test to `run_tests.sh` in the appropriate section
3. Update this README with what the test covers

### Test Script Template

```vim
" Test script for [feature name]
let s:plugin_dir = expand('<sfile>:p:h:h')
let &runtimepath .= ',' . s:plugin_dir

let s:tests_passed = 0
let s:tests_failed = 0

function! s:AssertTrue(condition, test_name)
  if a:condition
    let s:tests_passed += 1
    echo "✓ " . a:test_name
  else
    let s:tests_failed += 1
    echo "✗ " . a:test_name
  endif
endfunction

" Your tests here...

if s:tests_failed > 0
  cquit 1
else
  quit
endif
```
