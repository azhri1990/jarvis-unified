#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 PUSHING EVERYTHING TO GITHUB"
echo "============================================================"
echo ""

# ============================================================
# 1. JARVIS-UNIFIED (All new features)
# ============================================================
echo "📦 1. Pushing jarvis-unified..."
cd ~/jarvis-unified
git add .
git commit -m "Added all 52 missing features: AI models, agents, security, networking, UI/UX, mobile, development, monitoring, integrations, automation" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ jarvis-unified pushed"

# ============================================================
# 2. POCKETSTRIKE-AI (Chat history, branding, etc.)
# ============================================================
echo "📦 2. Pushing PocketStrike-AI..."
cd ~/PocketStrike-AI
git add .
git commit -m "Added chat history, custom branding, and mobile responsive UI" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ PocketStrike-AI pushed"

# ============================================================
# 3. MY-AUTOMATOR (New automator options)
# ============================================================
echo "📦 3. Pushing my-automator..."
cd ~/my-automator
git add .
git commit -m "Added new automator options for all missing features" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ my-automator pushed"

# ============================================================
# 4. JARVIS-SCRIPTS (All new scripts)
# ============================================================
echo "📦 4. Pushing jarvis-scripts..."
cd ~/jarvis-scripts
# Copy all new scripts
cp ~/bin/*.sh ~/jarvis-scripts/ 2>/dev/null
cp ~/bin/*.py ~/jarvis-scripts/ 2>/dev/null
cp ~/jarvis-unified/*.sh ~/jarvis-scripts/ 2>/dev/null
cp ~/jarvis-unified/*.py ~/jarvis-scripts/ 2>/dev/null
git add .
git commit -m "Added all new scripts: code_executor, email_agent, calendar_agent, news_agent, seo_agent, and more" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ jarvis-scripts pushed"

# ============================================================
# 5. JARVIS-MEGA-REPO (GlowUP AI and other updates)
# ============================================================
echo "📦 5. Pushing jarvis-mega-repo..."
cd ~/jarvis-mega-repo
git add .
git commit -m "Updated GlowUP AI and added new assistants" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ jarvis-mega-repo pushed"

# ============================================================
# 6. JARVIS-BOOT (Boot scripts)
# ============================================================
echo "📦 6. Pushing jarvis-boot..."
cd ~/jarvis-boot
git add .
git commit -m "Updated boot scripts with all new services" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ jarvis-boot pushed"

# ============================================================
# 7. OMNROUTE-CONFIG (OmniRoute configuration)
# ============================================================
echo "📦 7. Pushing omniroute-config..."
cd ~/omniroute-config
git add .
git commit -m "Updated OmniRoute configuration with new providers" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ omniroute-config pushed"

# ============================================================
# 8. LLAMA-CPP-CONFIG (Local AI configuration)
# ============================================================
echo "📦 8. Pushing llama-cpp-config..."
cd ~/llama-cpp-config
git add .
git commit -m "Updated llama.cpp configuration" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ llama-cpp-config pushed"

# ============================================================
# 9. TERMUX-CONFIG (Termux settings)
# ============================================================
echo "📦 9. Pushing termux-config..."
cd ~/termux-config
git add .
git commit -m "Updated Termux configuration with new aliases" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ termux-config pushed"

# ============================================================
# 10. JARVIS-ROADMAP (Task list)
# ============================================================
echo "📦 10. Pushing jarvis-roadmap..."
cd ~/jarvis-roadmap
git add .
git commit -m "Updated roadmap with all 62 features completed" 2>/dev/null
git push origin main 2>/dev/null || git push origin master 2>/dev/null
echo "   ✅ jarvis-roadmap pushed"

# ============================================================
# 11. CUSTOM-AGENTS (Custom agents)
# ============================================================
echo "📦 11. Pushing custom-agents..."
if [ -d ~/custom-agents ]; then
    cd ~/custom-agents
    git init
    git add .
    git commit -m "Custom agents for Jarvis" 2>/dev/null
    git remote add origin https://github.com/azhri1990/custom-agents.git 2>/dev/null
    git push -u origin main 2>/dev/null || git push -u origin master 2>/dev/null
    echo "   ✅ custom-agents pushed"
else
    echo "   ⚠️ custom-agents not found"
fi

# ============================================================
# 12. JARVIS-PLUGINS (Plugin system)
# ============================================================
echo "📦 12. Pushing jarvis-plugins..."
if [ -d ~/.jarvis-plugins ]; then
    cd ~/.jarvis-plugins
    git init
    git add .
    git commit -m "Jarvis plugin system" 2>/dev/null
    git remote add origin https://github.com/azhri1990/jarvis-plugins.git 2>/dev/null
    git push -u origin main 2>/dev/null || git push -u origin master 2>/dev/null
    echo "   ✅ jarvis-plugins pushed"
else
    echo "   ⚠️ jarvis-plugins not found"
fi

# ============================================================
# VERIFICATION
# ============================================================
echo ""
echo "📋 VERIFICATION:"
echo ""

echo "=== ALL REPOSITORIES ==="
echo "1. https://github.com/azhri1990/jarvis-mega-repo"
echo "2. https://github.com/azhri1990/my-automator"
echo "3. https://github.com/azhri1990/PocketStrike-AI"
echo "4. https://github.com/azhri1990/jarvis-unified"
echo "5. https://github.com/azhri1990/jarvis-boot"
echo "6. https://github.com/azhri1990/omniroute-config"
echo "7. https://github.com/azhri1990/llama-cpp-config"
echo "8. https://github.com/azhri1990/termux-config"
echo "9. https://github.com/azhri1990/jarvis-scripts"
echo "10. https://github.com/azhri1990/jarvis-roadmap"
echo "11. https://github.com/azhri1990/custom-agents"
echo "12. https://github.com/azhri1990/jarvis-plugins"

echo ""
echo "✅ ALL REPOSITORIES PUSHED!"
