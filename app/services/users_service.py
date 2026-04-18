from typing import TypedDict
from app.core import db, config, security
from app.domain import users_domain
from app.data import users_data

# Response standar untuk service
ServiceResponse = TypedDict('ServiceResponse', {
    'success': bool,
    'message': str,
    'data': dict | None
})

def register_user(username: str, password: str) -> ServiceResponse:
    """
    Orkestrasi alur registrasi user:
    Validasi -> Cek Duplikasi -> Hash Password -> Simpan.
    """
    # 1. Validasi Domain (Pure Logic)
    u_val = users_domain.validate_username(username)
    if not u_val['is_valid']:
        return {'success': False, 'message': u_val['message'], 'data': None}
    
    p_val = users_domain.validate_password(password)
    if not p_val['is_valid']:
        return {'success': False, 'message': p_val['message'], 'data': None}
    
    # 2. Persiapan Koneksi Database
    app_config = config.get_config()
    conn = db.create_connection(app_config['db'])
    
    if not conn:
        return {'success': False, 'message': 'Gagal terhubung ke database.', 'data': None}
    
    try:
        # 3. Cek apakah username sudah dipakai (Data Layer)
        existing_user = users_data.find_user_by_username(conn, username)
        if existing_user:
            return {'success': False, 'message': 'Username sudah terdaftar.', 'data': None}
        
        # 4. Hash Password (Core Layer)
        hashed_password = security.hash_password(password)
        
        # 5. Simpan User (Data Layer)
        user_id = users_data.insert_user(conn, {
            'username': username,
            'password': hashed_password
        })
        
        if user_id:
            return {
                'success': True, 
                'message': 'Registrasi berhasil! Silakan login.', 
                'data': {'id': user_id, 'username': username}
            }
        
        return {'success': False, 'message': 'Terjadi kesalahan saat menyimpan data.', 'data': None}
        
    except Exception as e:
        return {'success': False, 'message': f'System Error: {str(e)}', 'data': None}
    
    finally:
        # 6. Pastikan koneksi selalu ditutup (Core Layer)
        db.close_connection(conn)

def authenticate_user(username: str, password: str) -> ServiceResponse:
    """
    Orkestrasi alur login user:
    Validasi -> Ambil Data -> Verifikasi Hash -> Generate Token.
    """
    # 1. Validasi Domain (Pure Logic)
    val = users_domain.validate_login_input(username, password)
    if not val['is_valid']:
        return {'success': False, 'message': val['message'], 'data': None}
    
    # 2. Persiapan Koneksi Database
    app_config = config.get_config()
    conn = db.create_connection(app_config['db'])
    
    if not conn:
        return {'success': False, 'message': 'Gagal terhubung ke database.', 'data': None}
    
    try:
        # 3. Ambil data user dari database (Data Layer)
        user = users_data.find_user_by_username(conn, username)
        if not user:
            return {'success': False, 'message': 'Username atau password salah.', 'data': None}
        
        # 4. Verifikasi Password (Core Layer)
        if not security.verify_password(password, user['password']):
            return {'success': False, 'message': 'Username atau password salah.', 'data': None}
        
        # 5. Generate Token (Core Layer)
        token_data = {'id': user['id'], 'username': user['username']}
        token = security.create_token(token_data, app_config['jwt_secret'])
        
        return {
            'success': True,
            'message': 'Login berhasil!',
            'data': {'token': token}
        }
        
    except Exception as e:
        return {'success': False, 'message': f'System Error: {str(e)}', 'data': None}
    
    finally:
        # 6. Pastikan koneksi selalu ditutup (Core Layer)
        db.close_connection(conn)
