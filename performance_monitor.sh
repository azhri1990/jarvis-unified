#!/data/data/com.termux/files/usr/bin/bash
echo "📊 PERFORMANCE MONITOR"
echo "============================"
echo "Monitoring response times..."
services=("http://localhost:20128" "http://localhost:5000" "http://localhost:8008")
for service in "${services[@]}"; do
    start=$(date +%s%N)
    curl -s -o /dev/null "$service"
    end=$(date +%s%N)
    duration=$((($end - $start)/1000000))
    echo "  $service: ${duration}ms"
done
