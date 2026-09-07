#!/data/data/com.termux/files/usr/bin/bash
echo "🧪 UNIT TESTS"
echo "============================"
tests=0
passed=0
failed=0

test_service() {
    local name=$1
    local url=$2
    local expected=$3
    ((tests++))
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
    if [ "$status" = "$expected" ]; then
        echo "  ✅ $name test passed"
        ((passed++))
    else
        echo "  ❌ $name test failed (expected $expected, got $status)"
        ((failed++))
    fi
}

test_service "OmniRoute" "http://localhost:20128" "307"
test_service "PocketStrike" "http://localhost:5000" "200"
test_service "GlowUP" "http://localhost:8008" "200"

echo ""
echo "📊 Results: $passed/$tests passed, $failed failed"
