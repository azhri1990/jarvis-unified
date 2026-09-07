#!/data/data/com.termux/files/usr/bin/bash
echo="⏰ SCHEDULED COMMANDS"
echo "============================"
echo "Scheduling commands with cron:"
echo "  crontab -e"
echo "  Add: 0 8 * * * ~/jarvis-unified/daily_briefing.sh"
echo "  Add: 0 18 * * * ~/jarvis-unified/usage_dashboard.sh"
echo "To list scheduled jobs: crontab -l"
