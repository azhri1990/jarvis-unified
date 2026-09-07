#!/data/data/com.termux/files/usr/bin/bash
echo "🚀 SELF-BUILD STARTED"
echo "1. Starting watchdog..."
~/jarvis-unified/watchdog.sh &
sleep 3
echo "2. Running upgrades..."
curl -s -X POST http://localhost:20128/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer sk-5f238e76072d7926-92e57f-f18174b2" \
    -d '{"model":"kr/claude-sonnet-4.5","messages":[{"role":"system","content":"You are a software architect."},{"role":"user","content":"Suggest 3 specific upgrades for Jarvis."}]}' \
    | grep -o '"content":"[^"]*"' | cut -d'"' -f4 | sed 's/\\n/\n/g'
echo "3. Updating from GitHub..."
for repo in ~/jarvis-mega-repo ~/my-automator ~/PocketStrike-AI ~/jarvis-unified; do
    cd $repo && git pull 2>/dev/null
done
echo "✅ Self-build complete!"
