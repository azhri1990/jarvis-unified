#!/data/data/com.termux/files/usr/bin/bash
echo="🐳 DOCKER SUPPORT"
echo "============================"
echo "To run Jarvis in Docker:"
echo "  docker build -t jarvis ."
echo "  docker run -p 5000:5000 -p 20128:20128 jarvis"
echo "Dockerfile template:"
cat > ~/jarvis-unified/Dockerfile << 'DF_EOF'
FROM python:3.11-slim
RUN apt update && apt install -y nodejs npm
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
RUN npm install -g omniroute
EXPOSE 5000 20128
CMD ["python", "server.py"]
DF_EOF
echo "✅ Dockerfile created"
