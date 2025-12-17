from fastapi import FastAPI
import psycopg2
import os

app = FastAPI()

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_NAME = os.getenv("DB_NAME", "testdb")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASS = os.getenv("DB_PASS", "postgres")


@app.get("/health")
def health():
    return {"status": "healthy"}

@app.get("/ready")
def ready():
    return {"status": "ready"}


@app.get("/users")
def get_users():
    try:
        conn = psycopg2.connect(
            host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASS
        )
        cur = conn.cursor()
        cur.execute("SELECT id, name FROM users;")
        rows = cur.fetchall()
        cur.close()
        conn.close()
        return {"users": rows}
    except Exception as e:
        return {"error": str(e)}


@app.post("/users")
def add_user(name: str):
    try:
        conn = psycopg2.connect(
            host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASS
        )
        cur = conn.cursor()
        cur.execute("INSERT INTO users (name) VALUES (%s);", (name,))
        conn.commit()
        cur.close()
        conn.close()
        return {"status": "user added", "name": name}
    except Exception as e:
        return {"error": str(e)}
