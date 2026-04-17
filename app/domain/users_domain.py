import re
from typing import TypedDict

# Menggunakan sintaks fungsional untuk TypedDict (Tanpa kata kunci 'class')
ValidationResponse = TypedDict('ValidationResponse', {
    'is_valid': bool,
    'message': str
})

def validate_username(username: str) -> ValidationResponse:
    """
    Validasi aturan bisnis untuk username.
    """
    if not username:
        return {'is_valid': False, 'message': 'Username tidak boleh kosong.'}
    
    if len(username) < 3 or len(username) > 20:
        return {'is_valid': False, 'message': 'Panjang username harus antara 3 - 20 karakter.'}
    
    if not re.match(r"^\w+$", username):
        return {'is_valid': False, 'message': 'Username hanya boleh berisi huruf, angka, dan garis bawah.'}
    
    return {'is_valid': True, 'message': ''}

def validate_password(password: str) -> ValidationResponse:
    """
    Validasi aturan bisnis untuk kekuatan password.
    """
    if not password:
        return {'is_valid': False, 'message': 'Password tidak boleh kosong.'}
    
    if len(password) < 6:
        return {'is_valid': False, 'message': 'Password minimal harus 6 karakter.'}
    
    return {'is_valid': True, 'message': ''}
