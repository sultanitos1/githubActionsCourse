#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
errors=0

run_test() {
    local desc="$1" expected="$2" actual="$3"
    if [ "$actual" != "$expected" ]; then
        echo "FAIL: $desc — expected '$expected', got '$actual'"
        return 1
    fi
    echo "PASS: $desc"
}

echo "=== greet() function ==="

result=$(node -e "const g = require('./app.js'); console.log(g('World'));")
run_test "greet('World')" "Hello, World!" "$result" || ((errors++))

result=$(node -e "const g = require('./app.js'); console.log(g('Mohamed'));")
run_test "greet('Mohamed')" "Hello, Mohamed!" "$result" || ((errors++))

echo "=== CLI mode ==="

result=$(node app.js)
run_test "node app.js (no args)" "Hello, World!" "$result" || ((errors++))

result=$(node app.js Ahmed)
run_test "node app.js Ahmed" "Hello, Ahmed!" "$result" || ((errors++))

echo ""
if [ $errors -eq 0 ]; then
    echo "All tests passed!"
    exit 0
else
    echo "$errors test(s) failed!"
    exit 1
fi
