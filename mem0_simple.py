#!/data/data/com.termux/files/usr/bin/python3
import json
import os
from datetime import datetime

MEMORY_FILE = os.path.expanduser("~/jarvis-memory.json")

class Mem0Simple:
    def __init__(self):
        self.memory = self.load()
    
    def load(self):
        if os.path.exists(MEMORY_FILE):
            with open(MEMORY_FILE, 'r') as f:
                return json.load(f)
        return {"conversations": [], "preferences": {}, "facts": [], "users": {}}
    
    def save(self):
        with open(MEMORY_FILE, 'w') as f:
            json.dump(self.memory, f, indent=2)
    
    def add_memory(self, user_id, content, metadata=None):
        if user_id not in self.memory["users"]:
            self.memory["users"][user_id] = []
        self.memory["users"][user_id].append({
            "content": content,
            "metadata": metadata or {},
            "timestamp": datetime.now().isoformat()
        })
        self.save()
    
    def search(self, query, user_id=None):
        results = []
        users = [user_id] if user_id else self.memory["users"].keys()
        for uid in users:
            if uid in self.memory["users"]:
                for item in self.memory["users"][uid]:
                    if query.lower() in item["content"].lower():
                        results.append(item)
        return results
    
    def get_all(self, user_id=None):
        if user_id:
            return self.memory["users"].get(user_id, [])
        return self.memory["users"]

if __name__ == "__main__":
    mem = Mem0Simple()
    print("🧠 Mem0 Simple Memory System Ready!")
    print(f"📊 Users: {len(mem.memory['users'])}")
