#!/data/data/com.termux/files/usr/bin/bash
echo="🪝 CUSTOM WEBHOOKS"
echo "============================"
echo "Webhook endpoints:"
echo "  http://localhost:5000/webhook/trigger"
echo "  http://localhost:5000/webhook/status"
echo "To add a webhook:"
echo "  curl -X POST http://localhost:5000/webhook/add -d '{\"url\":\"https://example.com\"}'"
