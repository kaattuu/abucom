import os
from typing import TypedDict
from dotenv import load_dotenv

# Load .env file
load_dotenv()

DbConfig = TypedDict('DbConfig', {
    'host': str,
    'port': int,
    'database': str,
    'user': str,
    'password': str
})

AppConfig = TypedDict('AppConfig', {
    'db': DbConfig,
    'jwt_secret': str
})

def get_config() -> AppConfig:
    """
    Membaca konfigurasi dari environment variables.
    Fungsi ini murni mengembalikan data tanpa menyimpan state.
    """
    return {
        "db": {
            "host": os.getenv("DB_HOST", "localhost"),
            "port": int(os.getenv("DB_PORT", 3306)),
            "database": os.getenv("DB_NAME", "abucom_db"),
            "user": os.getenv("DB_USER", "root"),
            "password": os.getenv("DB_PASSWORD", ""),
        },
        "jwt_secret": os.getenv("JWT_SECRET", "default_secret_key"),
    }
