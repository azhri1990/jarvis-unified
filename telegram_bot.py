#!/data/data/com.termux/files/usr/bin/python3
from telegram import Update
from telegram.ext import Application, CommandHandler, ContextTypes
import subprocess
import json
import os

# IMPORTANT: Replace with your actual bot token from @BotFather
BOT_TOKEN = "YOUR_BOT_TOKEN_HERE"

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(
        "🦾 JARVIS REMOTE\n"
        "Commands:\n"
        "/status — System status\n"
        "/run <cmd> — Execute command\n"
        "/agent <division> <agent> <task> — Use agent\n"
        "/model <model> — Switch model\n"
        "/help — Show this"
    )

async def status(update: Update, context: ContextTypes.DEFAULT_TYPE):
    msg = "📊 JARVIS STATUS\n\n"
    services = {"OmniRoute": "http://localhost:20128", "PocketStrike": "http://localhost:5000"}
    for name, url in services.items():
        try:
            status = subprocess.run(["curl", "-s", "-o", "/dev/null", "-w", "%{http_code}", url], capture_output=True, text=True, timeout=5)
            msg += f"✅ {name}: {status.stdout}\n" if status.stdout in ["200", "307"] else f"❌ {name}: {status.stdout}\n"
        except:
            msg += f"❌ {name}: timeout\n"
    await update.message.reply_text(msg)

async def run_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    cmd = " ".join(context.args)
    if not cmd:
        await update.message.reply_text("Usage: /run <command>")
        return
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=30)
        output = result.stdout or result.stderr
        if len(output) > 4000:
            output = output[:4000] + "\n... (truncated)"
        await update.message.reply_text(f"```\n{output}\n```", parse_mode="Markdown")
    except Exception as e:
        await update.message.reply_text(f"❌ Error: {str(e)}")

def main():
    app = Application.builder().token(BOT_TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("status", status))
    app.add_handler(CommandHandler("run", run_command))
    print("🤖 Telegram Bot running...")
    app.run_polling()

if __name__ == "__main__":
    main()
