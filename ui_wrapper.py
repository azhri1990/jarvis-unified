from flask import Flask, send_from_directory
app = Flask(__name__)

@app.route('/')
def index():
    return "<h1>JARVIS Unified UI</h1><ul><li><a href='/'>Home</a></li><li><a href='/holographic'>Holographic</a></li></ul>"

@app.route('/holographic')
def holographic():
    return send_from_directory('/data/data/com.termux/files/home/jarvis-holographic', 'index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
