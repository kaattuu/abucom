from typing import Any
from mysql.connector.cursor import MySQLCursor

def find_user_by_username(connection, username: str) -> dict | None:
    """
    Mencari user berdasarkan username.
    """
    cursor: MySQLCursor = connection.cursor(dictionary=True)
    query = "SELECT * FROM users WHERE username = %s"
    cursor.execute(query, (username,))
    result = cursor.fetchone()
    cursor.close()
    return result

def insert_user(connection, user_data: dict) -> int | None:
    """
    Memasukkan user baru ke database.
    Menerima dictionary user_data.
    """
    cursor = connection.cursor()
    query = "INSERT INTO users (username, password) VALUES (%s, %s)"
    try:
        cursor.execute(query, (user_data['username'], user_data['password']))
        connection.commit()
        last_id = cursor.lastrowid
        cursor.close()
        return last_id
    except Exception as e:
        connection.rollback()
        cursor.close()
        print(f"Error insert_user: {e}")
        return None
