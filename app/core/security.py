import bcrypt
import jwt
import datetime

def hash_password(password: str) -> str:
    """
    Meng-hash password menggunakan bcrypt.
    """
    salt = bcrypt.gensalt()
    hashed = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed.decode('utf-8')

def verify_password(password: str, hashed_password: str) -> bool:
    """
    Memverifikasi password dengan hash yang tersimpan.
    """
    return bcrypt.checkpw(password.encode('utf-8'), hashed_password.encode('utf-8'))

def create_token(data: dict, secret: str, expires_in: int = 3600) -> str:
    """
    Membuat token JWT.
    """
    payload = data.copy()
    payload.update({
        "exp": datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(seconds=expires_in)
    })
    return jwt.encode(payload, secret, algorithm="HS256")

def decode_token(token: str, secret: str) -> dict | None:
    """
    Mendecode dan memverifikasi token JWT.
    """
    try:
        return jwt.decode(token, secret, algorithms=["HS256"])
    except (jwt.ExpiredSignatureError, jwt.InvalidTokenError):
        return None
