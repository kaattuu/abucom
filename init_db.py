from app.core import db, config

def initialize_database():
    """
    Inisialisasi tabel database yang diperlukan untuk proyek Abucom.
    """
    print("Memulai inisialisasi database...")
    
    # 1. Ambil config
    app_config = config.get_config()
    db_config = app_config['db']
    
    # 2. Buat koneksi
    connection = db.create_connection(db_config)
    
    if not connection:
        print("[GAGAL] Tidak dapat terhubung ke database.")
        return
    
    try:
        cursor = connection.cursor()
        
        # 3. Buat tabel users
        create_users_table = """
        CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            username VARCHAR(50) UNIQUE NOT NULL,
            password VARCHAR(255) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB;
        """
        
        print("Membuat tabel 'users'...")
        cursor.execute(create_users_table)
        connection.commit()
        
        print("[SUKSES] Database berhasil diinisialisasi.")
        
    except Exception as e:
        print(f"[ERROR] Terjadi kesalahan: {e}")
    finally:
        db.close_connection(connection)

if __name__ == "__main__":
    initialize_database()
