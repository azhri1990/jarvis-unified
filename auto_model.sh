#!/data/data/com.termux/files/usr/bin/bash
echo "🧠 AUTO-MODEL SELECTION — Testing all providers..."
echo "============================"
models=(
    "kr/claude-sonnet-4.5"
    "kr/deepseek-3.2"
    "qoder/qoder"
    "pollinations/gpt-4"
)
for model in "${models[@]}"; do
    echo "📡 Testing $model..."
    response=$(curl -s -X POST http://localhost:20128/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer sk-5f238e76072d7926-92e57f-f18174b2" \
        -d "{\"model\":\"$model\",\"messages\":[{\"role\":\"user\",\"content\":\"Say hello in 3 words\"}]}" \
        | grep -o '"content":"[^"]*"' | cut -d'"' -f4)
    if [ -n "$response" ]; then
        echo "  ✅ $model: $response"
    else
        echo "  ❌ $model failed"
    fi
done
