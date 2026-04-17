from typing import Any

def find_user_by_username(conn: Any, username: str) -> dict | None:
    """
    Mengambil data user berdasarkan username dari database.
    Layer ini pasif, menerima koneksi dari layer di atasnya.
    """
    cursor = conn.cursor(dictionary=True)
    query = "SELECT * FROM users WHERE username = %s LIMIT 1"
    cursor.execute(query, (username,))
    user = cursor.fetchone()
    cursor.close()
    return user

def insert_user(conn: Any, user_data: dict) -> int | None:
    """
    Menyimpan user baru ke dalam database.
    """
    cursor = conn.cursor()
    query = "INSERT INTO users (username, password) VALUES (%s, %s)"
    try:
        cursor.execute(query, (user_data['username'], user_data['password']))
        conn.commit()
        last_id = cursor.lastrowid
        cursor.close()
        return last_id
    except Exception as e:
        conn.rollback()
        cursor.close()
        # Mengembalikan None jika gagal insert (misal: duplicate entry)
        return None
