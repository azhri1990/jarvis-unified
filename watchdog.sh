#!/data/data/com.termux/files/usr/bin/bash
LOG="$HOME/jarvis-watchdog.log"
services=("omniroute:http://localhost:20128" "pocketstrike:http://localhost:5000" "glowup:http://localhost:8008")
log() { echo "[$(date '+%H:%M:%S')] $1" >> "$LOG"; }
restart() {
    case $1 in
        omniroute) pkill -f omniroute; omniroute & ;;
        pocketstrike) pkill -f "python server.py"; cd ~/PocketStrike-AI && python server.py & ;;
        glowup) cd ~/jarvis-mega-repo/assistants/glowup-ai && python server.py & ;;
    esac
}
while true; do
    for s in "${services[@]}"; do
        n="${s%%:*}"; u="${s##*:}"
        st=$(curl -s -o /dev/null -w "%{http_code}" "$u" 2>/dev/null)
        if [ "$st" != "200" ] && [ "$st" != "307" ]; then
            log "⚠️ $n DOWN → restarting"
            restart "$n"
            sleep 3
        fi
    done
    sleep 30
done
