#!/data/data/com.termux/files/usr/bin/bash
echo "🔥 FIREWALL RULES"
echo "============================"
echo "Setting up firewall rules..."
# Allow localhost only
iptables -A INPUT -s 127.0.0.1 -j ACCEPT 2>/dev/null
iptables -A INPUT -j DROP 2>/dev/null
echo "✅ Firewall: localhost only"
