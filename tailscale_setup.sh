#!/data/data/com.termux/files/usr/bin/bash
echo "🔒 TAILSCALE VPN SETUP"
echo "============================"
if command -v tailscale &> /dev/null; then
    echo "✅ Tailscale is installed"
    echo "📋 To connect: tailscale up"
else
    echo "⚠️ Install from: https://tailscale.com/download/android"
fi
