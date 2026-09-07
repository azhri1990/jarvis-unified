#!/data/data/com.termux/files/usr/bin/bash
echo "🔐 SSH HARDENING"
pkg install openssh -y
if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
fi
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
echo "📋 Public key:"
cat ~/.ssh/id_ed25519.pub
sshd
echo "✅ SSH server started on port 8022"
