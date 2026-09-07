#!/data/data/com.termux/files/usr/bin/python3
import json
import hashlib
import os
import time

CACHE_DIR = os.path.expanduser("~/.jarvis-cache")
os.makedirs(CACHE_DIR, exist_ok=True)

def get_cache_key(model, prompt):
    return hashlib.md5(f"{model}:{prompt}".encode()).hexdigest()

def get_cached_response(model, prompt):
    cache_key = get_cache_key(model, prompt)
    cache_file = os.path.join(CACHE_DIR, cache_key)
    if os.path.exists(cache_file):
        with open(cache_file, 'r') as f:
            data = json.load(f)
            if time.time() - data['timestamp'] < 3600:
                return data['response']
    return None

def cache_response(model, prompt, response):
    cache_key = get_cache_key(model, prompt)
    cache_file = os.path.join(CACHE_DIR, cache_key)
    with open(cache_file, 'w') as f:
        json.dump({"response": response, "timestamp": time.time()}, f)

if __name__ == "__main__":
    print("🧠 Model Cache System Ready")
