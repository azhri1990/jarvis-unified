#!/data/data/com.termux/files/usr/bin/bash
echo "🎨 THEME TOGGLE"
echo "============================"
echo "Toggle Dark/Light mode in PocketStrike-AI"
if grep -q "use-black-ui = true" ~/.termux/termux.properties; then
    sed -i 's/use-black-ui = true/use-black-ui = false/' ~/.termux/termux.properties
    echo "✅ Switched to Light mode"
else
    sed -i 's/use-black-ui = false/use-black-ui = true/' ~/.termux/termux.properties
    echo "✅ Switched to Dark mode"
fi
termux-reload-settings
