import sys
from app.services import auth_service

def show_main_menu():
    """
    Menampilkan menu utama.
    """
    print("\n=== ABUCOM CLI ===")
    print("1. Registrasi")
    print("2. Login")
    print("3. Keluar")
    
    choice = input("Pilih menu [1-3]: ")
    
    if choice == "1":
        menu_register()
    elif choice == "2":
        menu_login()
    elif choice == "3":
        print("Sampai jumpa!")
        sys.exit(0)
    else:
        print("Pilihan tidak valid.")

def menu_register():
    print("\n--- Form Registrasi ---")
    username = input("Username: ")
    password = input("Password: ")
    
    success, message = auth_service.register_user(username, password)
    
    if success:
        print(f"[SUKSES] {message}")
    else:
        print(f"[GAGAL] {message}")

def menu_login():
    print("\n--- Form Login ---")
    username = input("Username: ")
    password = input("Password: ")
    
    success, message, token = auth_service.login_user(username, password)
    
    if success:
        print(f"[SUKSES] {message}")
        print(f"Token JWT Anda: {token}")
    else:
        print(f"[GAGAL] {message}")
