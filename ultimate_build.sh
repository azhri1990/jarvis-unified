#!/data/data/com.termux/files/usr/bin/bash

echo "🦾 ULTIMATE JARVIS — SELF-BUILD, SELF-TEST, SELF-HEAL"
echo "============================================================"
echo ""

# Create directories
mkdir -p ~/jarvis-unified/logs
mkdir -p ~/bin
mkdir -p ~/.aider/agents
mkdir -p ~/PocketStrike-AI/templates
mkdir -p ~/jarvis-scripts

# Create use_agent script
cat > ~/bin/use_agent << 'AGENT_EOF'
#!/data/data/com.termux/files/usr/bin/bash
AGENT_FILE="$HOME/.aider/agents/$1/$2.md"
if [ ! -f "$AGENT_FILE" ]; then
    echo "❌ Agent not found: $1/$2"
    ls "$HOME/.aider/agents/$1/" 2>/dev/null | grep .md | sed 's/\.md//'
    exit 1
fi
AGENT_CONTENT=$(cat "$AGENT_FILE")
TASK="${@:3}"
curl -s -X POST http://localhost:20128/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer sk-5f238e76072d7926-92e57f-f18174b2" \
    -d "{\"model\":\"kr/claude-sonnet-4.5\",\"messages\":[{\"role\":\"system\",\"content\":$(printf '%s' "$AGENT_CONTENT" | jq -Rs .)},{\"role\":\"user\",\"content\":\"$TASK\"}]}" \
    | jq -r '.choices[0].message.content' 2>/dev/null
AGENT_EOF
chmod +x ~/bin/use_agent
echo "✅ use_agent created"

# Create agent-ref script
cat > ~/bin/agent-ref << 'REF_EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "📋 AGENTS BY DIVISION"
for dir in ~/.aider/agents/*/; do
    [ -d "$dir" ] && echo "  📁 $(basename "$dir"): $(find "$dir" -name "*.md" | wc -l) agents"
done
echo "Total: $(find ~/.aider/agents -name "*.md" | wc -l) agents"
REF_EOF
chmod +x ~/bin/agent-ref
echo "✅ agent-ref created"

# Create git_sync_all
cat > ~/bin/git_sync_all.sh << 'GIT_EOF'
#!/data/data/com.termux/files/usr/bin/bash
for repo in jarvis-mega-repo my-automator PocketStrike-AI jarvis-unified jarvis-boot omniroute-config llama-cpp-config termux-config jarvis-scripts; do
    if [ -d ~/$repo ]; then
        cd ~/$repo
        echo "📁 $repo"
        git pull 2>/dev/null
        git push 2>/dev/null
    fi
done
GIT_EOF
chmod +x ~/bin/git_sync_all.sh
echo "✅ git_sync_all created"

# Create test script
cat > ~/jarvis-unified/test_all.sh << 'TEST_EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "🧪 TESTING ALL"
echo "============================"
failed=0
test_service() {
    st=$(curl -s -o /dev/null -w "%{http_code}" "$2" 2>/dev/null)
    if [ "$st" = "200" ] || [ "$st" = "307" ]; then
        echo "  ✅ $1 running"
    else
        echo "  ❌ $1 down (status: $st)"
        ((failed++))
    fi
}
test_service "OmniRoute" "http://localhost:20128"
test_service "PocketStrike" "http://localhost:5000"
test_service "GlowUP" "http://localhost:8008"
echo ""
echo "📁 SCRIPTS:"
for s in use_agent agent-ref git_sync_all.sh; do
    if [ -f ~/bin/$s ]; then
        echo "  ✅ $s"
    else
        echo "  ❌ $s"
        ((failed++))
    fi
done
echo ""
echo "📁 REPOS:"
for r in jarvis-mega-repo my-automator PocketStrike-AI jarvis-unified jarvis-boot omniroute-config llama-cpp-config termux-config jarvis-scripts; do
    if [ -d ~/$r ]; then
        echo "  ✅ $r"
    else
        echo "  ❌ $r"
        ((failed++))
    fi
done
echo ""
if [ $failed -eq 0 ]; then
    echo "✅ ALL TESTS PASSED"
else
    echo "⚠️ $failed tests FAILED"
fi
TEST_EOF
chmod +x ~/jarvis-unified/test_all.sh
echo "✅ test_all created"

echo ""
echo "✅ BUILD COMPLETE"
echo ""
echo "🧪 Running tests..."
~/jarvis-unified/test_all.sh
