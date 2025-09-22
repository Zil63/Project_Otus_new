import os
from flask import Flask
import pymysql

app = Flask(__name__)
app.secret_key = os.getenv("MYSITE_SECRET_KEY", "dev")

DB_HOST = os.getenv("DB_HOST", "database")
DB_USER = os.getenv("DB_USER", "root")
DB_PASS = os.getenv("DB_PASS", os.getenv("DB_ROOT_PASSWORD", ""))
DB_NAME = os.getenv("DB_NAME", "wordpress")

@app.route("/")
def index():
    try:
        conn = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASS, database=DB_NAME, connect_timeout=2)
        with conn.cursor() as cur:
            cur.execute("SELECT 1")
        msg = "DB OK"
    except Exception as e:
        msg = f"DB ERROR: {e}"
    return f"Hello from Flask! {msg}\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
