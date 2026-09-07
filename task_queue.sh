#!/data/data/com.termux/files/usr/bin/bash
TASK_DIR="$HOME/.jarvis-tasks"
mkdir -p "$TASK_DIR"

add_task() {
    local task="$1"
    local timestamp=$(date +%s)
    echo "$task" > "$TASK_DIR/task_$timestamp.txt"
    echo "✅ Task added: $task"
}

process_tasks() {
    echo "📋 Processing task queue..."
    for task_file in "$TASK_DIR"/task_*.txt; do
        if [ -f "$task_file" ]; then
            task=$(cat "$task_file")
            echo "🔧 Executing: $task"
            eval "$task"
            rm "$task_file"
        fi
    done
}

list_tasks() {
    echo "📋 Pending tasks:"
    ls -la "$TASK_DIR" 2>/dev/null || echo "No tasks"
}

case "$1" in
    add) add_task "$2" ;;
    process) process_tasks ;;
    list) list_tasks ;;
    *) echo "Usage: $0 {add|process|list}" ;;
esac
