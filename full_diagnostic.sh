#!/data/data/com.termux/files/usr/bin/bash

echo "🔍 FULL SYSTEM DIAGNOSTIC — ULTIMATE JARVIS"
echo "============================================================"
echo ""

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

print_green() { echo -e "${GREEN}$1${NC}"; }
print_yellow() { echo -e "${YELLOW}$1${NC}"; }
print_red() { echo -e "${RED}$1${NC}"; }
print_blue() { echo -e "${BLUE}$1${NC}"; }

PASS=0
FAIL=0
WARN=0

# ============================================================
# 1. SERVICES CHECK
# ============================================================
print_blue "📊 1. CHECKING SERVICES..."
echo ""

check_service() {
    local name=$1
    local url=$2
    local status=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
    if [ "$status" = "200" ] || [ "$status" = "307" ]; then
        print_green "   ✅ $name running"
        ((PASS++))
        return 0
    else
        print_red "   ❌ $name DOWN (status: $status)"
        ((FAIL++))
        return 1
    fi
}

check_service "OmniRoute" "http://localhost:20128"
check_service "PocketStrike-AI" "http://localhost:5000"
check_service "GlowUP AI" "http://localhost:8008"

# ============================================================
# 2. TOOLS CHECK
# ============================================================
print_blue ""
print_blue "🔧 2. CHECKING TOOLS..."
echo ""

check_tool() {
    if command -v $1 &> /dev/null; then
        print_green "   ✅ $1"
        ((PASS++))
        return 0
    else
        print_red "   ❌ $1"
        ((FAIL++))
        return 1
    fi
}

check_tool "qwen"
check_tool "mmx"
check_tool "gga"
check_tool "hermes"
check_tool "supercode"
check_tool "core"
check_tool "ollama"
check_tool "omniroute"
check_tool "python"
check_tool "node"

# ============================================================
# 3. REPOSITORIES CHECK
# ============================================================
print_blue ""
print_blue "📁 3. CHECKING REPOSITORIES..."
echo ""

check_repo() {
    if [ -d ~/$1 ]; then
        print_green "   ✅ $1"
        ((PASS++))
        return 0
    else
        print_red "   ❌ $1"
        ((FAIL++))
        return 1
    fi
}

check_repo "jarvis-mega-repo"
check_repo "my-automator"
check_repo "PocketStrike-AI"
check_repo "jarvis-unified"
check_repo "jarvis-boot"
check_repo "omniroute-config"
check_repo "llama-cpp-config"
check_repo "termux-config"
check_repo "jarvis-scripts"
check_repo "jarvis-roadmap"
check_repo "custom-agents"
check_repo "jarvis-plugins"
check_repo "jarvis-android-app"

# ============================================================
# 4. SCRIPTS CHECK
# ============================================================
print_blue ""
print_blue "📜 4. CHECKING SCRIPTS..."
echo ""

check_script() {
    if [ -f ~/$1 ]; then
        print_green "   ✅ $1"
        ((PASS++))
        return 0
    else
        print_red "   ❌ $1"
        ((FAIL++))
        return 1
    fi
}

check_script "bin/use_agent"
check_script "bin/agent-ref"
check_script "bin/git_sync_all.sh"
check_script "bin/app_launcher_all"
check_script "bin/jarvis-ai"
check_script "jarvis-unified/watchdog.sh"
check_script "jarvis-unified/self_build.sh"
check_script "jarvis-unified/daily_briefing.sh"
check_script "jarvis-unified/test_all.sh"
check_script "jarvis-unified/full_diagnostic.sh"

# ============================================================
# 5. AUTOMATOR CHECK
# ============================================================
print_blue ""
print_blue "⚙️ 5. CHECKING AUTOMATOR..."
echo ""

if [ -f ~/my-automator/automator.sh ]; then
    print_green "   ✅ automator.sh exists"
    ((PASS++))
    options=$(grep -c "echo.*║.*[0-9]" ~/my-automator/modules/advanced.sh 2>/dev/null)
    if [ -n "$options" ]; then
        print_green "   ✅ $options options found"
        ((PASS++))
    else
        print_yellow "   ⚠️ Could not count options"
        ((WARN++))
    fi
else
    print_red "   ❌ automator.sh missing"
    ((FAIL++))
fi

# ============================================================
# 6. API KEY CHECK
# ============================================================
print_blue ""
print_blue "🔑 6. CHECKING API KEYS..."
echo ""

if [ -f ~/PocketStrike-AI/config.json ]; then
    KEY=$(grep -o '"api_key": "[^"]*"' ~/PocketStrike-AI/config.json 2>/dev/null | cut -d'"' -f4)
    if [ -n "$KEY" ]; then
        print_green "   ✅ API key found"
        ((PASS++))
    else
        print_yellow "   ⚠️ No API key in config"
        ((WARN++))
    fi
else
    print_red "   ❌ config.json missing"
    ((FAIL++))
fi

# ============================================================
# 7. GITHUB CHECK
# ============================================================
print_blue ""
print_blue "📦 7. CHECKING GITHUB..."
echo ""

if command -v gh &> /dev/null; then
    print_green "   ✅ gh installed"
    ((PASS++))
else
    print_yellow "   ⚠️ gh not installed"
    ((WARN++))
fi

# ============================================================
# 8. API ENDPOINT CHECK
# ============================================================
print_blue ""
print_blue "🌐 8. CHECKING API ENDPOINTS..."
echo ""

check_endpoint() {
    local name=$1
    local url=$2
    local status=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
    if [ "$status" = "200" ] || [ "$status" = "307" ]; then
        print_green "   ✅ $name ($status)"
        ((PASS++))
        return 0
    else
        print_red "   ❌ $name (status: $status)"
        ((FAIL++))
        return 1
    fi
}

check_endpoint "OmniRoute API" "http://localhost:20128/v1/models"
check_endpoint "PocketStrike API" "http://localhost:5000"
check_endpoint "GlowUP API" "http://localhost:8008"

# ============================================================
# 9. SUMMARY
# ============================================================
echo ""
print_blue "============================================================"
print_blue "📊 DIAGNOSTIC SUMMARY"
echo ""

TOTAL=$((PASS + FAIL + WARN))
print_green "   ✅ Passed: $PASS"
print_red "   ❌ Failed: $FAIL"
print_yellow "   ⚠️ Warnings: $WARN"
echo "   📊 Total: $TOTAL"

PERCENTAGE=$((PASS * 100 / TOTAL))
if [ $PERCENTAGE -ge 90 ]; then
    print_green "   🎉 System Health: $PERCENTAGE% — EXCELLENT"
elif [ $PERCENTAGE -ge 70 ]; then
    print_yellow "   🟡 System Health: $PERCENTAGE% — GOOD"
else
    print_red "   🔴 System Health: $PERCENTAGE% — NEEDS ATTENTION"
fi

echo ""
print_blue "============================================================"

# ============================================================
# 10. RECOMMENDATIONS
# ============================================================
if [ $FAIL -gt 0 ] || [ $WARN -gt 0 ]; then
    echo ""
    print_yellow "📋 RECOMMENDATIONS:"
    echo ""
    if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:20128 2>/dev/null | grep -q "200\|307"; then
        print_yellow "   🔧 Start OmniRoute: omniroute"
    fi
    if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:5000 2>/dev/null | grep -q "200"; then
        print_yellow "   🔧 Start PocketStrike-AI: cd ~/PocketStrike-AI && python server.py &"
    fi
    if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:8008 2>/dev/null | grep -q "200"; then
        print_yellow "   🔧 Start GlowUP AI: cd ~/jarvis-mega-repo/assistants/glowup-ai && python server.py &"
    fi
fi

echo ""
print_green "✅ DIAGNOSTIC COMPLETE!"
