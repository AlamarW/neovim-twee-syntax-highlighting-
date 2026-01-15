#!/usr/bin/env bash

# Test runner for vim-twee-syntax highlighting plugin
# Tests both Vim and Neovim compatibility

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

# Track overall results
TOTAL_PASSED=0
TOTAL_FAILED=0

# Print functions
print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_test() {
    echo -e "${YELLOW}Running: $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Run a test with a specific editor
run_test() {
    local editor="$1"
    local test_script="$2"
    local test_name="$3"

    print_test "$test_name with $editor"

    if ! command_exists "$editor"; then
        print_info "$editor not found, skipping"
        return 0
    fi

    # Run the test
    if "$editor" -u NONE -N --noplugin -S "$test_script" > /dev/null 2>&1; then
        print_success "$test_name passed with $editor"
        ((TOTAL_PASSED++)) || true
        return 0
    else
        print_error "$test_name FAILED with $editor"
        ((TOTAL_FAILED++)) || true
        return 1
    fi
}

# Run a test with verbose output
run_test_verbose() {
    local editor="$1"
    local test_script="$2"
    local test_name="$3"

    echo ""
    print_test "$test_name with $editor (verbose)"
    echo "----------------------------------------"

    if ! command_exists "$editor"; then
        print_info "$editor not found, skipping"
        echo ""
        return 0
    fi

    # Run the test with output
    if "$editor" -u NONE -N --noplugin -S "$test_script"; then
        echo "----------------------------------------"
        print_success "$test_name passed with $editor"
        ((TOTAL_PASSED++)) || true
        return 0
    else
        echo "----------------------------------------"
        print_error "$test_name FAILED with $editor"
        ((TOTAL_FAILED++)) || true
        return 1
    fi
}

# Check Vim version
check_editor_version() {
    local editor="$1"

    if ! command_exists "$editor"; then
        print_info "$editor not installed"
        return 1
    fi

    local version=$("$editor" --version | head -n 1)
    print_info "$version"
    return 0
}

# Main test execution
main() {
    print_header "Vim/Neovim Twee Syntax Test Suite"

    echo "Plugin directory: $PLUGIN_DIR"
    echo "Test directory: $SCRIPT_DIR"
    echo ""

    # Check which editors are available
    print_header "Checking Available Editors"
    check_editor_version "vim" || true
    check_editor_version "nvim" || true

    # Determine verbosity
    VERBOSE=false
    if [[ "$1" == "-v" ]] || [[ "$1" == "--verbose" ]]; then
        VERBOSE=true
        print_info "Verbose mode enabled"
    fi

    # Run syntax group tests
    print_header "Testing Syntax Groups"
    if [ "$VERBOSE" = true ]; then
        run_test_verbose "vim" "$SCRIPT_DIR/test_syntax_groups.vim" "Syntax Groups Test"
        run_test_verbose "nvim" "$SCRIPT_DIR/test_syntax_groups.vim" "Syntax Groups Test"
    else
        run_test "vim" "$SCRIPT_DIR/test_syntax_groups.vim" "Syntax Groups Test"
        run_test "nvim" "$SCRIPT_DIR/test_syntax_groups.vim" "Syntax Groups Test"
    fi

    # Run configuration tests
    print_header "Testing Configuration Options"
    if [ "$VERBOSE" = true ]; then
        run_test_verbose "vim" "$SCRIPT_DIR/test_config.vim" "Configuration Test"
        run_test_verbose "nvim" "$SCRIPT_DIR/test_config.vim" "Configuration Test"
    else
        run_test "vim" "$SCRIPT_DIR/test_config.vim" "Configuration Test"
        run_test "nvim" "$SCRIPT_DIR/test_config.vim" "Configuration Test"
    fi

    # Test file loading
    print_header "Testing File Loading"

    for editor in vim nvim; do
        if ! command_exists "$editor"; then
            print_info "$editor not found, skipping file load test"
            continue
        fi

        print_test "Loading SugarCube test file with $editor"
        if "$editor" -u NONE -N --cmd "set runtimepath+=$PLUGIN_DIR" \
                    -c "syntax on" -c "set filetype=twee" \
                    -c "quit" "$SCRIPT_DIR/fixtures/sugarcube.twee" > /dev/null 2>&1; then
            print_success "SugarCube file loads without errors in $editor"
            ((TOTAL_PASSED++)) || true
        else
            print_error "SugarCube file load FAILED in $editor"
            ((TOTAL_FAILED++)) || true
        fi

        print_test "Loading core test file with $editor"
        if "$editor" -u NONE -N --cmd "set runtimepath+=$PLUGIN_DIR" \
                    -c "syntax on" -c "set filetype=twee" \
                    -c "quit" "$SCRIPT_DIR/fixtures/core.twee" > /dev/null 2>&1; then
            print_success "Core file loads without errors in $editor"
            ((TOTAL_PASSED++)) || true
        else
            print_error "Core file load FAILED in $editor"
            ((TOTAL_FAILED++)) || true
        fi

        print_test "Loading Snowman test file with $editor"
        if "$editor" -u NONE -N --cmd "set runtimepath+=$PLUGIN_DIR" \
                    --cmd "let g:twee_story_format = 'snowman'" \
                    -c "syntax on" -c "set filetype=twee" \
                    -c "quit" "$SCRIPT_DIR/fixtures/snowman.twee" > /dev/null 2>&1; then
            print_success "Snowman file loads without errors in $editor"
            ((TOTAL_PASSED++)) || true
        else
            print_error "Snowman file load FAILED in $editor"
            ((TOTAL_FAILED++)) || true
        fi

        print_test "Loading Harlowe test file with $editor"
        if "$editor" -u NONE -N --cmd "set runtimepath+=$PLUGIN_DIR" \
                    --cmd "let g:twee_story_format = 'harlowe'" \
                    -c "syntax on" -c "set filetype=twee" \
                    -c "quit" "$SCRIPT_DIR/fixtures/harlowe.twee" > /dev/null 2>&1; then
            print_success "Harlowe file loads without errors in $editor"
            ((TOTAL_PASSED++)) || true
        else
            print_error "Harlowe file load FAILED in $editor"
            ((TOTAL_FAILED++)) || true
        fi

        print_test "Loading Chapbook test file with $editor"
        if "$editor" -u NONE -N --cmd "set runtimepath+=$PLUGIN_DIR" \
                    --cmd "let g:twee_story_format = 'chapbook'" \
                    -c "syntax on" -c "set filetype=twee" \
                    -c "quit" "$SCRIPT_DIR/fixtures/chapbook.twee" > /dev/null 2>&1; then
            print_success "Chapbook file loads without errors in $editor"
            ((TOTAL_PASSED++)) || true
        else
            print_error "Chapbook file load FAILED in $editor"
            ((TOTAL_FAILED++)) || true
        fi
    done

    # Print final results
    print_header "Test Results"

    echo "Total tests passed: $TOTAL_PASSED"
    echo "Total tests failed: $TOTAL_FAILED"
    echo ""

    if [ $TOTAL_FAILED -eq 0 ]; then
        print_success "All tests passed!"
        exit 0
    else
        print_error "Some tests failed!"
        echo ""
        echo "Run with -v or --verbose for detailed output"
        exit 1
    fi
}

# Run main
main "$@"
