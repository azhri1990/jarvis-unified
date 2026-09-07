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
