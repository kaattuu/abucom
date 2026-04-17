from app.core.config import get_config
from app.core import db, security
from app.domain import validation
from app.data import user_repository

def register_user(username, password) -> tuple[bool, str]:
    """
    Orkestrasi proses registrasi user.
    """
    # 1. Validasi domain
    is_valid_u, msg_u = validation.validate_username(username)
    if not is_valid_u:
        return False, msg_u
    
    is_valid_p, msg_p = validation.validate_password_strength(password)
    if not is_valid_p:
        return False, msg_p
    
    # 2. Persiapan DB
    config = get_config()
    connection = db.create_connection(config['db'])
    if not connection:
        return False, "Gagal terhubung ke database."
    
    try:
        # 3. Cek apakah user sudah ada
        existing_user = user_repository.find_user_by_username(connection, username)
        if existing_user:
            return False, "Username sudah digunakan."
        
        # 4. Hash password
        hashed_password = security.hash_password(password)
        
        # 5. Simpan ke data layer
        user_id = user_repository.insert_user(connection, {
            "username": username,
            "password": hashed_password
        })
        
        if user_id:
            return True, "Registrasi berhasil."
        else:
            return False, "Gagal menyimpan user baru."
    finally:
        db.close_connection(connection)

def login_user(username, password) -> tuple[bool, str, str | None]:
    """
    Orkestrasi proses login.
    Mengembalikan (status, pesan, token).
    """
    config = get_config()
    connection = db.create_connection(config['db'])
    if not connection:
        return False, "Gagal terhubung ke database.", None
    
    try:
        # 1. Ambil user dari data layer
        user = user_repository.find_user_by_username(connection, username)
        if not user:
            return False, "Username tidak ditemukan.", None
        
        # 2. Verifikasi password via core
        if not security.verify_password(password, user['password']):
            return False, "Password salah.", None
        
        # 3. Buat token JWT via core
        token = security.create_token({"id": user['id'], "username": user['username']}, config['jwt_secret'])
        return True, "Login berhasil.", token
    finally:
        db.close_connection(connection)
