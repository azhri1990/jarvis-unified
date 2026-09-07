#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 INSTALLING ALL MISSING FEATURES"
echo "============================================================"
echo ""

# ============================================================
# 1. INSTALL MEM0 (PERSISTENT MEMORY)
# ============================================================
echo "📦 1. Installing Mem0..."
pip install mem0ai -q 2>/dev/null
echo "   ✅ Mem0 installed"

# Create Mem0 integration
cat > ~/PocketStrike-AI/mem0_integration.py << 'EOF2'
#!/data/data/com.termux/files/usr/bin/python3
from mem0 import Memory
import json
import os

MEMORY_FILE = os.path.expanduser("~/jarvis-memory.json")

class JarvisMemory:
    def __init__(self):
        self.memory = Memory()
        self.user_id = "azhri1990"
        self.load_local()
    
    def load_local(self):
        if os.path.exists(MEMORY_FILE):
            with open(MEMORY_FILE, 'r') as f:
                self.local_memory = json.load(f)
        else:
            self.local_memory = {}
    
    def save_local(self):
        with open(MEMORY_FILE, 'w') as f:
            json.dump(self.local_memory, f)
    
    def add(self, content, metadata=None):
        result = self.memory.add(content, user_id=self.user_id, metadata=metadata)
        self.local_memory[content] = metadata
        self.save_local()
        return result
    
    def search(self, query):
        return self.memory.search(query, user_id=self.user_id)
    
    def get_all(self):
        return self.local_memory

if __name__ == "__main__":
    jarvis_memory = JarvisMemory()
    print("🧠 Jarvis Memory System Ready!")
EOF2

echo "   ✅ Mem0 integration created"

# ============================================================
# 2. INSTALL SCRAPEGRAPHAI (WEB SCRAPING)
# ============================================================
echo "📦 2. Installing ScrapeGraphAI..."
pip install scrapegraphai -q 2>/dev/null
echo "   ✅ ScrapeGraphAI installed"

# ============================================================
# 3. INSTALL AGENT REACH (SOCIAL MEDIA)
# ============================================================
echo "📦 3. Installing Agent Reach..."
mkdir -p ~/agents
cd ~/agents
if [ ! -d ~/agents/Agent-Reach ]; then
    git clone https://github.com/Panniantong/Agent-Reach.git
    cd Agent-Reach
    # Try to install dependencies (if requirements.txt exists)
    if [ -f requirements.txt ]; then
        pip install -r requirements.txt -q 2>/dev/null
    fi
    echo "   ✅ Agent Reach installed"
else
    echo "   ✅ Agent Reach already installed"
fi

# ============================================================
# 4. INSTALL SCRAPLING (ANTI-CAPTCHA)
# ============================================================
echo "📦 4. Installing Scrapling..."
cd ~/agents
if [ ! -d ~/agents/Scrapling ]; then
    git clone https://github.com/D4Vinci/Scrapling.git
    cd Scrapling
    if [ -f requirements.txt ]; then
        pip install -r requirements.txt -q 2>/dev/null
    fi
    echo "   ✅ Scrapling installed"
else
    echo "   ✅ Scrapling already installed"
fi

# ============================================================
# 5. CONFIGURE TELEGRAM BOT
# ============================================================
echo "📦 5. Configuring Telegram Bot..."
if [ ! -f ~/jarvis-unified/telegram_bot.py ]; then
    cat > ~/jarvis-unified/telegram_bot.py << 'EOF3'
#!/data/data/com.termux/files/usr/bin/python3
from telegram import Update
from telegram.ext import Application, CommandHandler

BOT_TOKEN = "YOUR_BOT_TOKEN_HERE"  # Replace with your token

async def start(update: Update, context):
    await update.message.reply_text("🦾 JARVIS REMOTE\nCommands: /status, /help")

async def status(update: Update, context):
    await update.message.reply_text("📊 JARVIS System Status\nAll systems operational.")

def main():
    app = Application.builder().token(BOT_TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("status", status))
    app.run_polling()

if __name__ == "__main__":
    main()
EOF3
    echo "   ✅ Telegram bot script created"
    echo "   ⚠️ Please add your bot token in ~/jarvis-unified/telegram_bot.py"
else
    echo "   ✅ Telegram bot script already exists"
fi

# ============================================================
# 6. VERIFY INSTALLATIONS
# ============================================================
echo ""
echo "📋 6. Verification:"
echo ""

python3 -c "import mem0" 2>/dev/null && echo "   ✅ Mem0" || echo "   ❌ Mem0"
python3 -c "import scrapegraphai" 2>/dev/null && echo "   ✅ ScrapeGraphAI" || echo "   ❌ ScrapeGraphAI"
[ -d ~/agents/Agent-Reach ] && echo "   ✅ Agent Reach" || echo "   ❌ Agent Reach"
[ -d ~/agents/Scrapling ] && echo "   ✅ Scrapling" || echo "   ❌ Scrapling"
[ -f ~/jarvis-unified/telegram_bot.py ] && echo "   ✅ Telegram Bot script" || echo "   ❌ Telegram Bot script"

echo ""
echo "✅ INSTALLATION COMPLETE!"
echo ""
echo "📋 To complete setup:"
echo "   1. Add your Telegram bot token to ~/jarvis-unified/telegram_bot.py"
echo "   2. Run ~/jarvis-unified/test_all.sh to verify everything"
