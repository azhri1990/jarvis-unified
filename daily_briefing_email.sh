#!/data/data/com.termux/files/usr/bin/bash
BRIEFING=$(~/jarvis-unified/daily_briefing.sh 2>/dev/null)
echo "$BRIEFING" > ~/jarvis-briefing-latest.txt
echo "✅ Daily briefing saved to ~/jarvis-briefing-latest.txt"
