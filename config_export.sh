#!/data/data/com.termux/files/usr/bin/bash
echo "📋 CONFIG EXPORT/IMPORT"
echo "============================"
export_config() {
    tar -czf jarvis-config-$(date +%Y%m%d).tar.gz \
        ~/PocketStrike-AI/config.json \
        ~/.omniroute/.env \
        ~/.termux/termux.properties \
        ~/my-automator/modules/ 2>/dev/null
    echo "✅ Config exported to jarvis-config-$(date +%Y%m%d).tar.gz"
}
import_config() {
    echo "📁 Available backups:"
    ls -la ~/jarvis-config-*.tar.gz
    read -p "Enter backup filename: " backup
    tar -xzf ~/$backup -C ~/
    echo "✅ Config restored"
}
case "$1" in
    export) export_config ;;
    import) import_config ;;
    *) echo "Usage: $0 {export|import}" ;;
esac
