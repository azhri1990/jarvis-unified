# JARVIS API DOCUMENTATION

## OmniRoute API
- Base URL: http://localhost:20128/v1
- Endpoints:
  - POST /chat/completions — Send chat messages
  - GET /models — List available models

## PocketStrike-AI API
- Base URL: http://localhost:5000
- Endpoints:
  - POST /chat — Chat interface
  - GET /config — Get current config
  - POST /config — Update config

## GlowUP AI API
- Base URL: http://localhost:8008
- Endpoints:
  - GET / — Health check
  - POST /analyze — Analyze style
  - POST /recommend — Get outfit recommendations
