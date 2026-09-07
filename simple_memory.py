#!/data/data/com.termux/files/usr/bin/python3
import json
import os
from datetime import datetime

MEMORY_FILE = os.path.expanduser("~/jarvis-memory.json")

class SimpleMemory:
    def __init__(self):
        self.memory = self.load()
    
    def load(self):
        if os.path.exists(MEMORY_FILE):
            with open(MEMORY_FILE, 'r') as f:
                return json.load(f)
        return {"conversations": [], "preferences": {}, "facts": []}
    
    def save(self):
        with open(MEMORY_FILE, 'w') as f:
            json.dump(self.memory, f, indent=2)
    
    def add_conversation(self, user, assistant):
        self.memory["conversations"].append({
            "user": user,
            "assistant": assistant,
            "timestamp": datetime.now().isoformat()
        })
        self.save()
    
    def add_preference(self, key, value):
        self.memory["preferences"][key] = value
        self.save()
    
    def add_fact(self, fact):
        self.memory["facts"].append(fact)
        self.save()
    
    def get_recent(self, n=5):
        return self.memory["conversations"][-n:]
    
    def get_preferences(self):
        return self.memory["preferences"]
    
    def search(self, query):
        results = []
        for conv in self.memory["conversations"]:
            if query.lower() in conv["user"].lower() or query.lower() in conv["assistant"].lower():
                results.append(conv)
        return results

if __name__ == "__main__":
    memory = SimpleMemory()
    print("🧠 Simple Memory System Ready!")
    print(f"📊 Conversations: {len(memory.memory['conversations'])}")
    print(f"📋 Preferences: {len(memory.memory['preferences'])}")
    print(f"📝 Facts: {len(memory.memory['facts'])}")
