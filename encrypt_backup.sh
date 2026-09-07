#!/data/data/com.termux/files/usr/bin/bash
echo "🔐 ENCRYPTED CONFIG BACKUP"
echo "============================"
echo "Backing up and encrypting configs..."
BACKUP_FILE="jarvis-backup-$(date +%Y%m%d).tar.gz.gpg"
tar -czf - ~/PocketStrike-AI/config.json ~/.omniroute/.env 2>/dev/null | gpg -c - > ~/$BACKUP_FILE
echo "✅ Backup saved to: $BACKUP_FILE"
echo "📋 To restore: gpg -d $BACKUP_FILE | tar -xz"
