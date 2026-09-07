#!/data/data/com.termux/files/usr/bin/bash
echo "🧠 AUTO-MODEL SELECTION"
echo "============================"
models=("kr/claude-sonnet-4.5" "kr/deepseek-3.2" "qoder/qoder" "pollinations/gpt-4")
best_model=""
best_response=""

for model in "${models[@]}"; do
    echo "📡 Testing $model..."
    response=$(curl -s -X POST http://localhost:20128/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer sk-5f238e76072d7926-92e57f-f18174b2" \
        -d "{\"model\":\"$model\",\"messages\":[{\"role\":\"user\",\"content\":\"Say hello in 3 words\"}]}" \
        | grep -o '"content":"[^"]*"' | cut -d'"' -f4)
    if [ -n "$response" ]; then
        echo "  ✅ $model: $response"
        if [ -z "$best_response" ]; then
            best_model=$model
            best_response=$response
        fi
    else
        echo "  ❌ $model failed"
    fi
done

echo ""
echo "🏆 Best model: $best_model"
echo "📝 Response: $best_response"
