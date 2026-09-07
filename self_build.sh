#!/data/data/com.termux/files/usr/bin/bash

LOG_FILE="$HOME/jarvis-self-build.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# --- 1. Monitor Services ---
monitor_services() {
    log "📊 Monitoring services..."
    
    services=(
        "omniroute:http://localhost:20128"
        "pocketstrike:http://localhost:5000"
        "glowup:http://localhost:8008"
    )
    
    for service in "${services[@]}"; do
        name="${service%%:*}"
        url="${service##*:}"
        status=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
        if [ "$status" = "200" ] || [ "$status" = "307" ]; then
            log "✅ $name is running"
        else
            log "❌ $name is down (status: $status)"
            case $name in
                "omniroute") pkill -f omniroute; omniroute & ;;
                "pocketstrike") pkill -f "python server.py"; cd ~/PocketStrike-AI && python server.py & ;;
                "glowup") cd ~/jarvis-mega-repo/assistants/glowup-ai && python server.py & ;;
            esac
            sleep 2
        fi
    done
}

# --- 2. Run Engineering Upgrades ---
run_engineering_agent() {
    log "🧠 Running Engineering Agent for upgrades..."
    
    echo ""
    echo "📋 ENGINEERING UPGRADE RECOMMENDATIONS:"
    echo "========================================"
    
    curl -s -X POST http://localhost:20128/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer sk-5f238e76072d7926-92e57f-f18174b2" \
        -d '{
            "model": "kr/claude-sonnet-4.5",
            "messages": [
                {"role": "system", "content": "You are a software architect. Provide 3 specific, actionable upgrades for the Jarvis AI system."},
                {"role": "user", "content": "Analyze the Jarvis system and suggest upgrades for: 1) Performance 2) Features 3) Reliability. Output as numbered list with implementation steps."}
            ]
        }' | grep -o '"content":"[^"]*"' | cut -d'"' -f4 | sed 's/\\n/\n/g'
    
    echo ""
    log "✅ Engineering upgrade suggestions complete"
}

# --- 3. Self-Update ---
self_update() {
    log "🔄 Self-updating from GitHub..."
    
    for repo in ~/jarvis-mega-repo ~/my-automator ~/PocketStrike-AI ~/jarvis-unified; do
        if [ -d "$repo" ]; then
            cd "$repo"
            log "📁 Updating $(basename $repo)..."
            git pull 2>/dev/null || log "⚠️ Could not pull $(basename $repo)"
        fi
    done
    
    log "✅ Self-update complete"
}

# --- 4. Main Loop ---
main() {
    log "🚀 Starting Self-Building Jarvis..."
    
    while true; do
        echo ""
        echo "╔═══════════════════════════════════════════════╗"
        echo "║     SELF-BUILDING JARVIS                      ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Monitor & Heal Services                  ║"
        echo "║  2. Run Engineering Upgrades                 ║"
        echo "║  3. Self-Update from GitHub                  ║"
        echo "║  4. Run All (Full Self-Build)               ║"
        echo "║  0. Exit                                     ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose option: " choice
        
        case $choice in
            1) monitor_services ;;
            2) run_engineering_agent ;;
            3) self_update ;;
            4) monitor_services; run_engineering_agent; self_update ;;
            0) break ;;
            *) echo "Invalid option" ;;
        esac
    done
}

main
