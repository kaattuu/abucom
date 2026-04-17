import re

def validate_username(username: str) -> tuple[bool, str]:
    """
    Memvalidasi username.
    Hanya boleh alfanumerik dan garis bawah, panjang 3-20 karakter.
    """
    if not username:
        return False, "Username tidak boleh kosong."
    if len(username) < 3 or len(username) > 20:
        return False, "Panjang username harus antara 3 - 20 karakter."
    if not re.match(r"^\w+$", username):
        return False, "Username hanya boleh berisi huruf, angka, dan garis bawah."
    return True, ""

def validate_password_strength(password: str) -> tuple[bool, str]:
    """
    Memvalidasi kekuatan password.
    Minimal 6 karakter.
    """
    if not password:
        return False, "Password tidak boleh kosong."
    if len(password) < 6:
        return False, "Password minimal 6 karakter."
    return True, ""
