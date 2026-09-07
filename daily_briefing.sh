#!/data/data/com.termux/files/usr/bin/bash
echo "📋 DAILY BRIEFING — $(date)"
echo "============================"
echo "🛡️ SYSTEM:"
for s in omniroute pocketstrike glowup; do
    st=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:20128" 2>/dev/null)
    [ "$st" = "200" ] || [ "$st" = "307" ] && echo "  ✅ $s running" || echo "  ❌ $s down"
done
echo ""
echo "🧠 MODEL:"
grep -o '"model": "[^"]*"' ~/PocketStrike-AI/config.json 2>/dev/null | cut -d'"' -f4
echo ""
curl -s "wttr.in?format=%C+%t" 2>/dev/null | sed 's/^/🌤️ /'
echo ""
echo "🤖 AI BRIEFING:"
curl -s -X POST http://localhost:20128/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer sk-5f238e76072d7926-92e57f-f18174b2" \
    -d '{"model":"kr/claude-sonnet-4.5","messages":[{"role":"system","content":"You are JARVIS. Provide a brief daily briefing."},{"role":"user","content":"Give a short daily briefing for today."}]}' \
    | grep -o '"content":"[^"]*"' | cut -d'"' -f4 | sed 's/\\n/\n/g'
