#!/data/data/com.termux/files/usr/bin/bash

set -e  # stop on error

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

print_green() { echo -e "${GREEN}$1${NC}"; }
print_yellow() { echo -e "${YELLOW}$1${NC}"; }
print_red() { echo -e "${RED}$1${NC}"; }
print_blue() { echo -e "${BLUE}$1${NC}"; }

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}   ULTIMATE JARVIS – BOOTSTRAP        ${NC}"
echo -e "${BLUE}========================================${NC}"

# ---- 1. Clone all repositories ----
print_blue "\n[1] CLONING REPOSITORIES FROM GITHUB..."

REPOS=(
    "jarvis-mega-repo"
    "my-automator"
    "PocketStrike-AI"
    "jarvis-boot"
    "omniroute-config"
    "llama-cpp-config"
    "termux-config"
    "jarvis-scripts"
    "jarvis-roadmap"
    "jarvis-agent"
    "jarvis-plugins"
    "jarvis-android-app"
)

USER="azhri1990"  # your GitHub username

for repo in "${REPOS[@]}"; do
    if [ ! -d ~/$repo ]; then
        print_yellow "  Cloning $repo..."
        git clone https://github.com/$USER/$repo.git ~/$repo 2>/dev/null || {
            print_red "  ❌ Failed to clone $repo (maybe it doesn't exist). Creating empty directory."
            mkdir -p ~/$repo
        }
    else
        print_green "  ✅ $repo already exists"
    fi
done

# ---- 2. Install command-line tools ----
print_blue "\n[2] INSTALLING CLI TOOLS..."

# qwen (npm package)
if ! command -v qwen &>/dev/null; then
    print_yellow "  Installing qwen..."
    npm install -g qwen-code 2>/dev/null || print_red "  ❌ qwen install failed"
else
    print_green "  ✅ qwen already installed"
fi

# mmx (Minimax CLI)
if ! command -v mmx &>/dev/null; then
    print_yellow "  Installing mmx..."
    npm install -g minimax-cli 2>/dev/null || print_red "  ❌ mmx install failed"
else
    print_green "  ✅ mmx already installed"
fi

# gga (Git-GPT)
if ! command -v gga &>/dev/null; then
    print_yellow "  Installing gga..."
    npm install -g git-gpt 2>/dev/null || print_red "  ❌ gga install failed"
else
    print_green "  ✅ gga already installed"
fi

# hermes (Hermes Agent)
if ! command -v hermes &>/dev/null; then
    print_yellow "  Installing hermes..."
    npm install -g hermes-agent 2>/dev/null || print_red "  ❌ hermes install failed"
else
    print_green "  ✅ hermes already installed"
fi

# supercode
if ! command -v supercode &>/dev/null; then
    print_yellow "  Installing supercode..."
    npm install -g supercode 2>/dev/null || print_red "  ❌ supercode install failed"
else
    print_green "  ✅ supercode already installed"
fi

# ollama (via curl install)
if ! command -v ollama &>/dev/null; then
    print_yellow "  Installing ollama..."
    curl -fsSL https://ollama.ai/install.sh | sh 2>/dev/null || print_red "  ❌ ollama install failed"
else
    print_green "  ✅ ollama already installed"
fi

# core (assume it's a local script)
if ! command -v core &>/dev/null; then
    print_yellow "  Installing core (from jarvis-mega-repo)..."
    if [ -f ~/jarvis-mega-repo/core.sh ]; then
        cp ~/jarvis-mega-repo/core.sh ~/bin/core
        chmod +x ~/bin/core
        print_green "  ✅ core installed"
    else
        print_red "  ❌ core not found in mega-repo"
    fi
else
    print_green "  ✅ core already installed"
fi

# ---- 3. Install Python dependencies for services ----
print_blue "\n[3] INSTALLING PYTHON DEPS..."

pip install flask requests beautifulsoup4 2>/dev/null

# ---- 4. Start services ----
print_blue "\n[4] STARTING SERVICES..."

start_service() {
    local name=$1
    local cmd=$2
    local url=$3
    local status=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
    if [ "$status" = "200" ] || [ "$status" = "307" ]; then
        print_green "  ✅ $name already running"
    else
        print_yellow "  Starting $name..."
        eval "$cmd" &
        sleep 3
        local new_status=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
        if [ "$new_status" = "200" ] || [ "$new_status" = "307" ]; then
            print_green "  ✅ $name started"
        else
            print_red "  ❌ $name failed to start"
        fi
    fi
}

# Ensure services directories exist and have server scripts
if [ -d ~/PocketStrike-AI ]; then
    start_service "PocketStrike-AI" "cd ~/PocketStrike-AI && python server.py" "http://localhost:5000"
else
    print_red "  ❌ PocketStrike-AI directory missing, can't start"
fi

if [ -d ~/jarvis-mega-repo/assets/glowup-ai ]; then
    start_service "GlowUP AI" "cd ~/jarvis-mega-repo/assets/glowup-ai && python app.py" "http://localhost:8008"
else
    print_red "  ❌ GlowUP AI directory missing, can't start"
fi

# OmniRoute (assume it's a global command or script)
if command -v omniroute &>/dev/null; then
    start_service "OmniRoute" "omniroute" "http://localhost:20128"
else
    print_red "  ❌ omniroute command not found. Please install OmniRoute separately."
fi

# ---- 5. Create bin directory and aliases ----
mkdir -p ~/bin
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

print_blue "\n[5] BOOTSTRAP COMPLETE!"
print_green "✅ Automated part done. Now follow the manual steps below."
