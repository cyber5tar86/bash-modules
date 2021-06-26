#!/bin/bash
APP_DIR="$(dirname "$0")"
export __IMPORT__BASE_PATH="$APP_DIR/../src/bash-modules"
export PATH="$APP_DIR/../src:$PATH"
. import.sh strict log unit

###############################################
# Test cases

test_info() {
  unit::assertEqual "$( info Test 2>/dev/null )" "[test_log.sh] INFO: Test"
}

test_warn() {
  unit::assertEqual "$( warn Test 2>&1 1>/dev/null )" "[test_log.sh] WARN: Test"
}

test_error() {
  unit::assertEqual "$( error Test 2>&1 1>/dev/null )" "[test_log.sh] ERROR: Test"
}

test_log_info() {
  unit::assertEqual "$( log::info foo Test 2>/dev/null )" "[test_log.sh] foo: Test"
}

test_log_warn() {
  unit::assertEqual "$( log::warn foo Test 2>&1 1>/dev/null )" "[test_log.sh] foo: Test"
}

test_log_error() {
  unit::assertEqual "$( log::error foo Test 2>&1 1>/dev/null )" "[test_log.sh] foo: Test"
}

test_log_panic() {
  unit::assertEqual "$( log::panic foo 42 Test 2>&1 1>/dev/null | head -n 1)" "[test_log.sh] foo: Test"
}

test_panic() {
  unit::assertEqual "$( panic Test 2>&1 1>/dev/null | head -n 1)" "[test_log.sh] PANIC: Test"
}

test_unimplemented() {
  unit::assertEqual "$( unimplemented Test 2>&1 1>/dev/null | head -n 1)" "[test_log.sh] UNIMPLEMENTED: Test"
}

test_todo() {
  unit::assertEqual "$( todo Test 2>&1 1>/dev/null | head -n 1)" "[test_log.sh] TODO: Test"
}

test_dbg() {
  local foo="bar"
  unit::assertEqual "$( dbg foo 2>&1 )" '[test_log.sh] DBG: foo="bar"'
}


unit::run_test_cases "$@"
