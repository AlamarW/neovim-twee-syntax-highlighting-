" Test script to verify syntax groups are properly defined
" Usage: vim -u NONE -N --noplugin -S test_syntax_groups.vim

" Prevent 'more' prompts
set nomore

let s:test_file = expand('<sfile>:p:h') . '/fixtures/sugarcube.twee'
let s:plugin_dir = expand('<sfile>:p:h:h')
let &runtimepath .= ',' . s:plugin_dir

" Track test results
let s:tests_passed = 0
let s:tests_failed = 0
let s:failures = []

" Helper function to check if a syntax group exists
function! s:AssertSyntaxExists(group_name)
  if hlexists(a:group_name)
    let s:tests_passed += 1
    echo "✓ Syntax group '" . a:group_name . "' exists"
    return 1
  else
    let s:tests_failed += 1
    call add(s:failures, "Syntax group '" . a:group_name . "' does not exist")
    echo "✗ Syntax group '" . a:group_name . "' MISSING"
    return 0
  endif
endfunction

" Helper function to check if a syntax item is defined
function! s:AssertSyntaxDefined(item_name)
  redir => syntax_output
  silent! syntax list
  redir END

  if syntax_output =~ a:item_name
    let s:tests_passed += 1
    echo "✓ Syntax item '" . a:item_name . "' is defined"
    return 1
  else
    let s:tests_failed += 1
    call add(s:failures, "Syntax item '" . a:item_name . "' is not defined")
    echo "✗ Syntax item '" . a:item_name . "' NOT DEFINED"
    return 0
  endif
endfunction

echo "========================================"
echo "Testing Syntax Groups"
echo "========================================"
echo "Plugin directory: " . s:plugin_dir
echo "Test file: " . s:test_file
echo ""

" Load the syntax
set filetype=twee
syntax on

" Open test file
execute 'edit ' . s:test_file

echo "Testing Core Syntax Groups..."
echo "----------------------------------------"
call s:AssertSyntaxExists('tweeComment')
call s:AssertSyntaxExists('tweeToDo')
call s:AssertSyntaxExists('tweeEOL')
call s:AssertSyntaxExists('tweePassage')
call s:AssertSyntaxExists('tweePassageTitle')
call s:AssertSyntaxExists('tweeTag')
call s:AssertSyntaxExists('tweeLink')
call s:AssertSyntaxExists('tweeLinkedPassage')

echo ""
echo "Testing SugarCube Syntax Groups..."
echo "----------------------------------------"
call s:AssertSyntaxExists('tweeConditional')
call s:AssertSyntaxExists('tweeRepeat')
call s:AssertSyntaxExists('tweeLabel')
call s:AssertSyntaxExists('tweeOperator')
call s:AssertSyntaxExists('tweeKeyword')
call s:AssertSyntaxExists('tweeBool')
call s:AssertSyntaxExists('tweeVariable')
call s:AssertSyntaxExists('tweeSubVariable')
call s:AssertSyntaxExists('tweeString')
call s:AssertSyntaxExists('tweeNumber')
call s:AssertSyntaxExists('tweeMacro')
call s:AssertSyntaxExists('tweeItalic')
call s:AssertSyntaxExists('tweeBold')
call s:AssertSyntaxExists('tweeUnderline')
call s:AssertSyntaxExists('tweeList')

echo ""
echo "Testing Syntax Items..."
echo "----------------------------------------"
call s:AssertSyntaxDefined('tweeComment')
call s:AssertSyntaxDefined('tweeMacro')
call s:AssertSyntaxDefined('tweeLink')
call s:AssertSyntaxDefined('tweeVariable')

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
