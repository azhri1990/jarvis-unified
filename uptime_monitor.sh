#!/data/data/com.termux/files/usr/bin/bash
echo "⏱️ UPTIME MONITOR"
echo "============================"
echo "Tracking uptime for all services..."
echo "OmniRoute: $(curl -s -o /dev/null -w "%{http_code}" http://localhost:20128)"
echo "PocketStrike: $(curl -s -o /dev/null -w "%{http_code}" http://localhost:5000)"
echo "GlowUP: $(curl -s -o /dev/null -w "%{http_code}" http://localhost:8008)"
