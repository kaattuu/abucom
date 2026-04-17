import sys
from app.cli import users_cli

def show_main_menu():
    """
    Menampilkan menu utama aplikasi Abucom.
    """
    print("\n" + "="*30)
    print("      ABUCOM CLI SYSTEM")
    print("="*30)
    print("1. Registrasi User Baru")
    print("2. Login (Coming Soon)")
    print("3. Keluar")
    print("="*30)
    
    choice = input("Pilih Menu [1-3]: ")
    
    if choice == '1':
        users_cli.show_register_menu()
    elif choice == '2':
        print("\n[INFO] Fitur Login sedang dalam pengembangan.")
    elif choice == '3':
        print("\nTerima kasih telah menggunakan Abucom. Sampai jumpa!")
        sys.exit(0)
    else:
        print("\n[ERROR] Pilihan tidak valid.")

def main():
    """
    Entry point utama aplikasi.
    """
    try:
        while True:
            show_main_menu()
    except KeyboardInterrupt:
        print("\nAplikasi dihentikan oleh pengguna.")
        sys.exit(0)

if __name__ == "__main__":
    main()
