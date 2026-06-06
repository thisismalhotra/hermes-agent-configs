
import sys
import datetime
import subprocess

def run_command(cmd):
    """Execates a terminal command and returns output."""
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout, result.stderr, result.returncode

def log_to_file(level, message):
    """Maintains a local audit log for all agent actions."""
    log_path = "/Users/gauravmalhotra/hermes_system_audit.log"
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    entry = f"[{timestamp}] [{level}] {message}\n"
    try:
        with open(log_path, "a") as f:
            f.write(entry)
    except Exception as e:
        print(f"Logging error: {e}")
    return entry

def dispatch(priority, message):
    """The routing engine."""
    # 1. Log the event locally first
    log_entry = log_to_file(priority.upper(), message)
    print(f"LOGGED: {log_entry.strip()}")

    # 2. Determine destinations based on priority
    destinations = []
    if priority == "urgent":
        destinations = ["imessage", "telegram"]
    elif priority == "info":
        destinations = ["telegram"]
    else:
        destinations = ["telegram"]

    # 3. Execute delivery via terminal simulation (to be replaced by actual tools)
    formatted_msg = f"[{priority.upper()}] {message}"
    
    for dest in destinations:
        print(f"[SENDING TO {dest.upper()}]: {formatted_msg}")
        
        if dest == "imessage":
            cmd = f"echo 'Simulating iMessage delivery: {formatted_msg}'"
            stdout, stderr, rc = run_command(cmd)
            print("  -> iMessage handoff successful." if rc == 0 else "  -> iMessage failed.")
        
        elif dest == "telegram":
            cmd = f"echo 'Simulating Telegram delivery: {formatted_msg}'"
            stdout, stderr, rc = run_command(cmd)
            print("  -> Telegram handoff successful." if rc == 0 else "  -> Telegram failed.")

    return f"Dispatched to: {', '.join(destinations)}"

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: python dispatcher.py <priority: urgent|info> <message>")
        sys.exit(1)
    
    prio = sys.argv[1].lower()
    msg = sys.argv[2]
    result = dispatch(prio, msg)
    print(result)
