from app.cli import menus

def main():
    """
    Entry point utama aplikasi.
    """
    try:
        while True:
            menus.show_main_menu()
    except KeyboardInterrupt:
        print("\nAplikasi dihentikan oleh pengguna.")

if __name__ == "__main__":
    main()
