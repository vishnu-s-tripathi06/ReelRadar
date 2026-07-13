import sqlite3
#pip install -r requirements.txt
DATABASE = "movies.db"


def get_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    return conn 

def initialize_database():
    with get_connection() as conn:
        with open("schema.sql") as file:
            conn.executescript(file.read())