#!/data/data/com.termux/files/usr/bin/bash
echo "🐝 AGENT SWARM"
echo "============================"
echo "Running multiple agents in parallel..."
agents=("sales-engineer" "content-creator" "software-architect")
for agent in "${agents[@]}"; do
    ~/bin/use_agent engineering "$agent" "Say hello" &
done
wait
echo "✅ Swarm complete!"
