import mysql.connector
from mysql.connector import Error
from app.core.config import DbConfig

def create_connection(config: DbConfig):
    """
    Membuat koneksi ke database MariaDB.
    Menerima config sebagai parameter.
    """
    try:
        connection = mysql.connector.connect(
            host=config['host'],
            port=config['port'],
            database=config['database'],
            user=config['user'],
            password=config['password']
        )
        if connection.is_connected():
            return connection
    except Error as e:
        print(f"Error: {e}")
        return None

def close_connection(connection):
    """
    Menutup koneksi database.
    """
    if connection and connection.is_connected():
        connection.close()
