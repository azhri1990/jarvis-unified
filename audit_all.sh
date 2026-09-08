#!/data/data/com.termux/files/usr/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   ULTIMATE JARVIS – 110-ITEM AUDIT   ${NC}"
echo -e "${GREEN}========================================${NC}"

TOTAL=0
OK=0

check_service() {
    ((TOTAL++))
    if curl -s -o /dev/null -w "%{http_code}" "$1" | grep -q "200\|307"; then
        echo -e "  ${GREEN}✅ $2${NC}"; ((OK++))
    else
        echo -e "  ${RED}❌ $2${NC}"
    fi
}

check_tool() {
    ((TOTAL++))
    if command -v $1 &>/dev/null; then
        echo -e "  ${GREEN}✅ $1${NC}"; ((OK++))
    else
        echo -e "  ${RED}❌ $1${NC}"
    fi
}

check_dir() {
    ((TOTAL++))
    if [ -d ~/$1 ]; then
        echo -e "  ${GREEN}✅ $1${NC}"; ((OK++))
    else
        echo -e "  ${RED}❌ $1${NC}"
    fi
}

check_file() {
    ((TOTAL++))
    if [ -f "$1" ]; then
        echo -e "  ${GREEN}✅ $1${NC}"; ((OK++))
    else
        echo -e "  ${RED}❌ $1${NC}"
    fi
}

echo -e "\n--- SERVICES ---"
check_service "http://localhost:20128" "OmniRoute"
check_service "http://localhost:5000"   "PocketStrike-AI"
check_service "http://localhost:8008"   "GlowUP AI"

echo -e "\n--- TOOLS ---"
for t in qwen mmx gga hermes supercode ollama core; do
    check_tool $t
done

echo -e "\n--- REPOSITORIES ---"
for r in jarvis-mega-repo my-automator PocketStrike-AI jarvis-unified jarvis-boot omniroute-config llama-cpp-config termux-config jarvis-scripts jarvis-roadmap jarvis-agent jarvis-plugins jarvis-android-app; do
    check_dir $r
done

echo -e "\n--- MANUAL STEPS (check yourself) ---"
echo "  ☐ Termux:Boot installed (F-Droid)"
echo "  ☐ Telegram bot token saved (~/.jarvis-telegram-token)"
echo "  ☐ Shizuku + Rish set up"
echo "  ☐ Local image generation (stable-diffusion.cpp)"
echo "  ☐ Web search API key (~/.jarvis-search-key)"
echo "  ☐ Flutter app built (APK exists)"
echo "  ☐ Home Assistant installed"

echo -e "\n${GREEN}✅ $OK / $TOTAL automated items verified.${NC}"
echo "Manual items remain: 7"
