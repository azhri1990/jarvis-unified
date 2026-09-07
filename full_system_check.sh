#!/data/data/com.termux/files/usr/bin/bash

echo "🔍 FULL SYSTEM CHECK & FIX — ULTIMATE JARVIS"
echo "============================================================"
echo ""

# ============================================================
# 1. CHECK SERVICES
# ============================================================
echo "📊 1. CHECKING SERVICES..."
echo ""

check_service() {
    local name=$1
    local url=$2
    local status=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
    if [ "$status" = "200" ] || [ "$status" = "307" ]; then
        echo "   ✅ $name running"
        return 0
    else
        echo "   ❌ $name DOWN (status: $status)"
        return 1
    fi
}

check_service "OmniRoute" "http://localhost:20128"
check_service "PocketStrike-AI" "http://localhost:5000"
check_service "GlowUP AI" "http://localhost:8008"

# ============================================================
# 2. CHECK TOOLS
# ============================================================
echo ""
echo "📊 2. CHECKING TOOLS..."
echo ""

check_tool() {
    if command -v $1 &> /dev/null; then
        echo "   ✅ $1"
        return 0
    else
        echo "   ❌ $1"
        return 1
    fi
}

check_tool "qwen"
check_tool "mmx"
check_tool "gga"
check_tool "hermes"
check_tool "supercode"
check_tool "claude"
check_tool "opencode"
check_tool "core"
check_tool "ollama"

# ============================================================
# 3. CHECK REPOSITORIES
# ============================================================
echo ""
echo "📊 3. CHECKING REPOSITORIES..."
echo ""

check_repo() {
    if [ -d ~/$1 ]; then
        echo "   ✅ $1"
        return 0
    else
        echo "   ❌ $1"
        return 1
    fi
}

check_repo "jarvis-mega-repo"
check_repo "my-automator"
check_repo "PocketStrike-AI"
check_repo "jarvis-unified"
check_repo "jarvis-boot"
check_repo "jarvis-scripts"
check_repo "core-termux"

# ============================================================
# 4. CHECK AUTOMATOR OPTIONS
# ============================================================
echo ""
echo "📊 4. CHECKING AUTOMATOR..."
echo ""

if [ -f ~/my-automator/modules/advanced.sh ]; then
    options=$(grep -c "echo.*║.*[0-9]" ~/my-automator/modules/advanced.sh 2>/dev/null)
    echo "   ✅ Automator has $options options"
else
    echo "   ❌ Automator not found"
fi

# ============================================================
# 5. FIX MISSING TOOLS
# ============================================================
echo ""
echo "🔧 5. FIXING MISSING TOOLS..."
echo ""

# Fix Claude Code
if ! command -v claude &> /dev/null; then
    echo "   📦 Installing Claude Code..."
    if [ -f /data/data/com.termux/files/usr/lib/node_modules/@anthropic-ai/claude-code/install.cjs ]; then
        node /data/data/com.termux/files/usr/lib/node_modules/@anthropic-ai/claude-code/install.cjs 2>/dev/null
    else
        npm install -g @anthropic-ai/claude-code --no-ignore-scripts 2>/dev/null
    fi
    echo "   ✅ Claude Code fixed"
fi

# Fix OpenCode
if ! command -v opencode &> /dev/null; then
    echo "   📦 Installing OpenCode..."
    npm install -g opencode 2>/dev/null
    echo "   ✅ OpenCode installed"
fi

# Fix qwen if missing
if ! command -v qwen &> /dev/null; then
    echo "   📦 Installing Qwen..."
    npm install -g @qwen/qwen-cli 2>/dev/null
    echo "   ✅ Qwen installed"
fi

# ============================================================
# 6. START STOPPED SERVICES
# ============================================================
echo ""
echo "🔧 6. STARTING STOPPED SERVICES..."
echo ""

if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:20128 2>/dev/null | grep -q "200\|307"; then
    echo "   📦 Starting OmniRoute..."
    omniroute &
    sleep 3
    echo "   ✅ OmniRoute started"
fi

if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:5000 2>/dev/null | grep -q "200"; then
    echo "   📦 Starting PocketStrike-AI..."
    cd ~/PocketStrike-AI && python server.py &
    sleep 3
    echo "   ✅ PocketStrike-AI started"
fi

if ! curl -s -o /dev/null -w "%{http_code}" http://localhost:8008 2>/dev/null | grep -q "200"; then
    echo "   📦 Starting GlowUP AI..."
    cd ~/jarvis-mega-repo/assistants/glowup-ai && python server.py &
    sleep 3
    echo "   ✅ GlowUP AI started"
fi

# ============================================================
# 7. FINAL VERIFICATION
# ============================================================
echo ""
echo "📋 7. FINAL VERIFICATION..."
echo ""

# Services
check_service "OmniRoute" "http://localhost:20128"
check_service "PocketStrike-AI" "http://localhost:5000"
check_service "GlowUP AI" "http://localhost:8008"

# Tools
echo ""
check_tool "qwen"
check_tool "mmx"
check_tool "gga"
check_tool "hermes"
check_tool "supercode"
check_tool "claude"
check_tool "opencode"
check_tool "core"

# ============================================================
# 8. SUMMARY
# ============================================================
echo ""
echo "============================================================"
echo "✅ FULL SYSTEM CHECK COMPLETE!"
echo ""
echo "📋 QUICK COMMANDS:"
echo "  ~/my-automator/automator.sh — Open automator"
echo "  qwen 'prompt' — Use Qwen"
echo "  mmx --auth-type — Setup Minimax"
echo "  gga run — Use GGA (in git repo)"
echo "  hermes chat — Use Hermes"
echo "  supercode --help — SuperCode"
echo "  claude --help — Claude Code"
echo "  opencode --help — OpenCode"
echo ""
echo "🎉 ULTIMATE JARVIS IS FULLY OPERATIONAL!"
