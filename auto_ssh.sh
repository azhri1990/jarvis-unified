#!/data/data/com.termux/files/usr/bin/bash
echo "🔐 AUTO-SSH ON BOOT"
echo "============================"
echo "Setting up SSH to start on boot..."
mkdir -p ~/.termux/boot
cat > ~/.termux/boot/start_ssh.sh << 'EOF22_INNER'
#!/data/data/com.termux/files/usr/bin/bash
sshd
echo "SSH started at $(date)" >> ~/ssh-boot.log
EOF22_INNER
chmod +x ~/.termux/boot/start_ssh.sh
echo "✅ SSH will start on boot"
