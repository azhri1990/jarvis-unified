#!/data/data/com.termux/files/usr/bin/bash
notify() {
    termux-notification -t "$1" -c "$2" 2>/dev/null || echo "🔔 $1: $2"
}
case "$1" in
    "service-down") notify "⚠️ JARVIS Service Down" "$2 service is down!" ;;
    "service-up") notify "✅ JARVIS Service Up" "$2 service is now running!" ;;
    "model-switched") notify "🧠 Model Switched" "Now using: $2" ;;
    *) notify "🔔 JARVIS" "$1" ;;
esac
