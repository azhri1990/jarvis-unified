#!/bin/bash
echo "🔍 ULTIMATE JARVIS — FINAL AUDIT"
TOTAL=0; OK=0

# Services
for p in 20128 5000 8008 11434; do
  ((TOTAL++))
  curl -s -o /dev/null "http://localhost:$p/health" 2>/dev/null && { echo "✅ Port $p"; ((OK++)); } || echo "❌ Port $p"
done

# Tools
for t in ollama omniroute python node npm; do
  ((TOTAL++))
  command -v $t &>/dev/null && { echo "✅ $t"; ((OK++)); } || echo "❌ $t"
done

# Repos
for r in OmniRoute PocketStrike-AI GlowUP DroidNet-Sentinel soc-toolkit-termux mimic termux-mcp-server AndroMate Termux-AI aria-termux; do
  ((TOTAL++))
  [ -d ~/$r ] && { echo "✅ $r"; ((OK++)); } || echo "❌ $r"
done

echo "✅ $OK / $TOTAL verified"
[ $OK -eq $TOTAL ] && echo "🎉 100% COMPLETE!" || echo "⏳ $((TOTAL-OK)) remaining"
