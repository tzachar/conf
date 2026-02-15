import sqlite3
import re
import os
import socket
import sys

# --- CONFIGURATION ---
HISTORY_FILE = os.path.expanduser("~/.zsh_history")
DB_FILE = os.path.expanduser("~/.histdb/zsh-history.db")  # Default location, adjust if needed
CURRENT_HOST = socket.gethostname()
DEFAULT_DIR = os.path.expanduser("~") # We must guess the directory for old commands
# ---------------------

def parse_zsh_history(filepath):
    """
    Parses .zsh_history handling multiline commands.
    Yields tuples of (timestamp, duration, command).
    """
    # Regex to find the start of a history entry: : 167888888:0;command...
    # The duration is sometimes just matched as digits.
    line_start_re = re.compile(r'^: (\d+):(\d+);(.*)$')
    
    current_entry = None
    
    with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
        for line in f:
            match = line_start_re.match(line)
            if match:
                # If we were building an entry, yield it now
                if current_entry:
                    yield current_entry
                
                # Start new entry
                timestamp = int(match.group(1))
                duration = int(match.group(2))
                command = match.group(3)
                current_entry = {'ts': timestamp, 'dur': duration, 'cmd': command}
            else:
                # This is a continuation of a multiline command
                if current_entry:
                    current_entry['cmd'] += "\n" + line.rstrip('\n')

        # Yield the final entry
        if current_entry:
            yield current_entry

def get_or_create_place(cursor, host, directory):
    cursor.execute("SELECT id FROM places WHERE host = ? AND dir = ?", (host, directory))
    res = cursor.fetchone()
    if res:
        return res[0]
    
    cursor.execute("INSERT INTO places (host, dir) VALUES (?, ?)", (host, directory))
    return cursor.lastrowid

def get_or_create_command(cursor, argv):
    # Try to insert; ignore if exists due to unique constraint
    cursor.execute("INSERT OR IGNORE INTO commands (argv) VALUES (?)", (argv,))
    
    # Retrieve the ID (whether it was just inserted or already existed)
    cursor.execute("SELECT id FROM commands WHERE argv = ?", (argv,))
    return cursor.fetchone()[0]

def main():
    if not os.path.exists(DB_FILE):
        print(f"Error: Database file not found at {DB_FILE}")
        print("Please initialize histdb first or update the DB_FILE path in the script.")
        sys.exit(1)

    print(f"Opening database: {DB_FILE}")
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()

    # 1. Setup the 'Place' ID
    # We map all imported history to the current host and Home directory
    # to satisfy the foreign key constraint.
    place_id = get_or_create_place(c, CURRENT_HOST, DEFAULT_DIR)
    print(f"Importing with Place ID: {place_id} ({CURRENT_HOST}:{DEFAULT_DIR})")

    count = 0
    batch_data = []
    
    # 2. Iterate and Insert
    print("Reading history file...")
    for entry in parse_zsh_history(HISTORY_FILE):
        
        # Get Command ID
        cmd_id = get_or_create_command(c, entry['cmd'])
        
        # Prepare row for history table
        # schema: (session, command_id, place_id, exit_status, start_time, duration)
        # We use '0' for session and exit_status as they are unknown.
        batch_data.append((0, cmd_id, place_id, 0, entry['ts'], entry['dur']))
        
        count += 1
        if count % 1000 == 0:
            c.executemany("""
                INSERT INTO history (session, command_id, place_id, exit_status, start_time, duration)
                VALUES (?, ?, ?, ?, ?, ?)
            """, batch_data)
            conn.commit()
            batch_data = []
            print(f"Processed {count} lines...")

    # Insert remaining
    if batch_data:
        c.executemany("""
            INSERT INTO history (session, command_id, place_id, exit_status, start_time, duration)
            VALUES (?, ?, ?, ?, ?, ?)
        """, batch_data)
        conn.commit()

    print(f"Done! Imported {count} commands.")
    conn.close()

if __name__ == "__main__":
    main()
