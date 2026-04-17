from app.services import users_service

def show_register_menu() -> None:
    """
    UI Terminal untuk alur registrasi user.
    Hanya bertanggung jawab untuk input() dan print().
    """
    print("\n" + "="*30)
    print("      FORM REGISTRASI USER")
    print("="*30)
    
    username = input("Username baru : ")
    password = input("Password baru : ")
    
    print("\nSedang memproses pendaftaran...")
    
    # Memanggil Service Layer
    result = users_service.register_user(username, password)
    
    # Menampilkan Feedback informatif ke pengguna
    if result['success']:
        print(f"\n[SUKSES] {result['message']}")
        if result['data']:
            print(f"ID User: {result['data']['id']}")
    else:
        print(f"\n[GAGAL] {result['message']}")
    
    print("="*30)
    input("\nTekan Enter untuk kembali ke menu utama...")
