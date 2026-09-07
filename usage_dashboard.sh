#!/data/data/com.termux/files/usr/bin/bash
echo "📊 JARVIS USAGE DASHBOARD"
echo "============================"
echo "🔄 Services:"
curl -s -o /dev/null -w "  OmniRoute: %{http_code}\n" http://localhost:20128
curl -s -o /dev/null -w "  PocketStrike: %{http_code}\n" http://localhost:5000
curl -s -o /dev/null -w "  GlowUP: %{http_code}\n" http://localhost:8008
echo ""
echo "🧠 Current Model:"
grep -o '"model": "[^"]*"' ~/PocketStrike-AI/config.json 2>/dev/null | cut -d'"' -f4
echo ""
echo "📁 Repositories:"
ls ~/ | grep -E "jarvis|my-automator|PocketStrike" | wc -l
