" Test script to verify configuration options work correctly
" Usage: vim -u NONE -N --noplugin -S test_config.vim

" Prevent 'more' prompts
set nomore

let s:test_file = expand('<sfile>:p:h') . '/fixtures/sugarcube.twee'
let s:plugin_dir = expand('<sfile>:p:h:h')
let &runtimepath .= ',' . s:plugin_dir

" Track test results
let s:tests_passed = 0
let s:tests_failed = 0
let s:failures = []

" Helper function for assertions
function! s:AssertEquals(actual, expected, test_name)
  if a:actual == a:expected
    let s:tests_passed += 1
    echo "✓ " . a:test_name
    return 1
  else
    let s:tests_failed += 1
    call add(s:failures, a:test_name . " - Expected: '" . a:expected . "', Got: '" . a:actual . "'")
    echo "✗ " . a:test_name
    echo "  Expected: '" . a:expected . "'"
    echo "  Got: '" . a:actual . "'"
    return 0
  endif
endfunction

function! s:AssertTrue(condition, test_name)
  if a:condition
    let s:tests_passed += 1
    echo "✓ " . a:test_name
    return 1
  else
    let s:tests_failed += 1
    call add(s:failures, a:test_name . " - Condition was false")
    echo "✗ " . a:test_name
    return 0
  endif
endfunction

echo "========================================"
echo "Testing Configuration Options"
echo "========================================"
echo ""

" Test 1: Default behavior (should use sugarcube)
echo "Test 1: Default behavior..."
echo "----------------------------------------"
syntax clear
unlet! g:twee_story_format
unlet! b:twee_story_format
unlet! b:current_syntax
unlet! b:twee_core_syntax_loaded
unlet! b:twee_sugarcube_syntax_loaded
execute 'edit ' . s:test_file
set filetype=twee
syntax on
call s:AssertTrue(hlexists('tweeMacro'), 'Default loads SugarCube (tweeMacro exists)')
call s:AssertTrue(hlexists('tweeVariable'), 'Default loads SugarCube (tweeVariable exists)')

echo ""

" Test 2: Explicit g:twee_story_format = 'sugarcube'
echo "Test 2: g:twee_story_format = 'sugarcube'..."
echo "----------------------------------------"
syntax clear
unlet! b:current_syntax
unlet! b:twee_core_syntax_loaded
unlet! b:twee_sugarcube_syntax_loaded
let g:twee_story_format = 'sugarcube'
unlet! b:twee_story_format
execute 'edit! ' . s:test_file
set filetype=twee
syntax on
call s:AssertTrue(hlexists('tweeMacro'), 'Explicit sugarcube loads SugarCube syntax')

echo ""

" Test 3: Buffer-local override
echo "Test 3: Buffer-local b:twee_story_format override..."
echo "----------------------------------------"
syntax clear
unlet! b:current_syntax
unlet! b:twee_core_syntax_loaded
unlet! b:twee_sugarcube_syntax_loaded
let g:twee_story_format = 'harlowe'  " Set global to something else
let b:twee_story_format = 'sugarcube'  " Override with buffer-local
execute 'edit! ' . s:test_file
set filetype=twee
syntax on
call s:AssertTrue(hlexists('tweeMacro'), 'Buffer-local override works (SugarCube loaded)')

echo ""

" Test 4: Core syntax always loads
echo "Test 4: Core syntax always loads..."
echo "----------------------------------------"
syntax clear
unlet! b:current_syntax
unlet! b:twee_core_syntax_loaded
unlet! b:twee_sugarcube_syntax_loaded
unlet! g:twee_story_format
unlet! b:twee_story_format
execute 'edit! ' . s:test_file
set filetype=twee
syntax on
call s:AssertTrue(hlexists('tweeComment'), 'Core syntax loads (tweeComment exists)')
call s:AssertTrue(hlexists('tweeLink'), 'Core syntax loads (tweeLink exists)')
call s:AssertTrue(hlexists('tweePassageTitle'), 'Core syntax loads (tweePassageTitle exists)')

echo ""

" Test 5: Unknown format falls back gracefully
echo "Test 5: Unknown format handling..."
echo "----------------------------------------"
syntax clear
unlet! b:current_syntax
unlet! b:twee_core_syntax_loaded
unlet! b:twee_sugarcube_syntax_loaded
let g:twee_story_format = 'nonexistent'
unlet! b:twee_story_format

" Redirect messages to capture warning
redir => messages
execute 'edit! ' . s:test_file
set filetype=twee
syntax on
redir END

" Core should still load even with unknown format
call s:AssertTrue(hlexists('tweeComment'), 'Core syntax loads even with unknown format')
call s:AssertTrue(messages =~ "Unknown story format", 'Warning message shown for unknown format')

echo ""
echo "========================================"
echo "Test Results"
echo "========================================"
echo "Passed: " . s:tests_passed
echo "Failed: " . s:tests_failed
echo ""

if s:tests_failed > 0
  echo "Failures:"
  for failure in s:failures
    echo "  - " . failure
  endfor
  cquit 1
else
  echo "All tests passed!"
  quit
endif
