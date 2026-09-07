#!/data/data/com.termux/files/usr/bin/bash
echo "🚀 PUSHING ALL REPOS"
for repo in jarvis-mega-repo my-automator PocketStrike-AI jarvis-unified jarvis-boot omniroute-config llama-cpp-config termux-config jarvis-scripts; do
    if [ -d ~/$repo ]; then
        cd ~/$repo
        echo "📁 $repo"
        git add .
        git commit -m "Ultimate Jarvis: self-building, self-testing, self-healing" 2>/dev/null
        git push origin main 2>/dev/null || git push origin master 2>/dev/null
    fi
done
echo "✅ ALL REPOS PUSHED!"
