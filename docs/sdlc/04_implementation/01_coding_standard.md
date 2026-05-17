# Coding Standard — Sistem Manajemen Usaha Percetakan "AbuCom"

## 1. Metadata Dokumen

| Atribut | Detail |
|---|---|
| **Versi** | 1.1.0 |
| **Status** | [finish] |
| **Tanggal** | 2026-05-17 |
| **Disusun Oleh** | AI Developer (Antigravity) |
| **Divalidasi Oleh** | AI Developer (Validator) |

---

## Daftar Isi
- [1. Metadata Dokumen](#1-metadata-dokumen)
- [2. Pendahuluan & Tujuan](#2-pendahuluan--tujuan)
- [3. Teknologi & Versi Terkunci](#3-teknologi--versi-terkunci)
- [4. Paradigma Functional Programming](#4-paradigma-functional-programming)
- [5. Gaya Penulisan Kode & PEP 8](#5-gaya-penulisan-kode--pep-8)
- [6. Konvensi Penamaan](#6-konvensi-penamaan)
- [7. Type Hints & Docstring](#7-type-hints--docstring)
- [8. Arsitektur Berlapis & Struktur Direktori](#8-arsitektur-berlapis--struktur-direktori)
- [9. Pola Koneksi Database FP](#9-pola-koneksi-database-fp)
- [10. Keamanan Kode](#10-keamanan-kode)
- [11. Penanganan Error](#11-penanganan-error)
- [12. Presisi Data Finansial](#12-presisi-data-finansial)
- [13. Kompatibilitas Lintas OS](#13-kompatibilitas-lintas-os)
- [14. Kebutuhan Non-Fungsional Kode](#14-kebutuhan-non-fungsional-kode)
- [15. Checklist Kepatuhan Kode](#15-checklist-kepatuhan-kode)
- [16. Glosarium](#16-glosarium)
- [17. Riwayat Perubahan](#17-riwayat-perubahan)
- [18. Referensi](#18-referensi)

---

## 2. Pendahuluan & Tujuan

Dokumen **Coding Standard** ini disusun sebagai panduan teknis yang **mutlak dan wajib** dipatuhi oleh seluruh pengembang (baik manusia maupun agen AI) dalam membangun Sistem Manajemen Usaha Percetakan "AbuCom". 

Tujuan utama dokumen ini adalah untuk memastikan konsistensi, keandalan, keamanan, dan keterbacaan basis kode (codebase). Proyek AbuCom adalah aplikasi **Command Line Interface (CLI)** yang ditulis dalam bahasa **Python** murni dengan paradigma **Functional Programming (FP)**. Seluruh data dipertahankan secara transaksional pada basis data lokal **MySQL 8.4 LTS**.

---

## 3. Teknologi & Versi Terkunci

Untuk mencegah inkonsistensi eksekusi antar *environment*, seluruh dependensi dan modul wajib menggunakan versi berikut dan dikunci secara ketat di dalam berkas `requirements.txt`.

| Komponen / Library | Versi Wajib | Keterangan |
|---|---|---|
| **Bahasa Pemrograman** | Python 3.14.2+ | FP murni, type hints, pathlib bawaan |
| **Database** | MySQL 8.4 LTS | Community Edition (Lokal) |
| **Konektor DB** | `mysql-connector-python==9.3.0` | Akses stateless, hasil query bentuk tuple |
| **Keamanan (Hashing)** | `bcrypt==4.3.0` | Perlindungan brute-force password & PIN |
| **Keamanan (Token)** | `PyJWT==2.10.1` | Autentikasi stateless, algoritma HS256 |
| **Manajemen Konfigurasi** | `python-dotenv==1.1.0` | Isolasi secret keys di `.env` lokal |

---

## 4. Paradigma Functional Programming

Sistem AbuCom **melarang mutlak** penggunaan Object-Oriented Programming (OOP) untuk logika bisnis. Seluruh alur data harus menerapkan Functional Programming (FP).

### 4.1 Pure Functions
Fungsi harus menerima input, dan menghasilkan output tanpa mengubah *state* eksternal (*no side-effects*).

**BENAR (FP - Pure Function):**
```python
def calculate_subtotal(price: int, qty: float) -> float:
    return float(price) * qty
```

**SALAH (OOP / Side Effect):**
```python
# global state mutation
total_amount = 0
def calculate_subtotal(price, qty):
    global total_amount
    total_amount += (price * qty)
```

### 4.2 Immutable Data
Gunakan struktur data yang tidak dapat diubah (immutable) seperti `tuple`. Hindari memanipulasi *dictionary* yang sudah ada secara *in-place*.

**BENAR (Membuat struktur baru):**
```python
def update_stock(item: tuple, used_qty: float) -> tuple:
    # item = (id, name, current_stock)
    return (item[0], item[1], item[2] - used_qty)
```

**SALAH (Modifikasi in-place):**
```python
def update_stock(item_dict: dict, used_qty: float):
    item_dict['current_stock'] -= used_qty  # Mutasi in-place!
```

### 4.3 Larangan Class
Deklarasi `class` DILARANG digunakan untuk memetakan objek bisnis karena melanggar prinsip Functional Programming yang tidak mentolerir keberadaan instansiasi atribut *state*.

**DILARANG (Menggunakan Class):**
```python
class Transaction:
    def __init__(self, amount):
        self.amount = amount
    def commit(self):
        pass
```

**WAJIB (Menggunakan Fungsi Murni):**
```python
def commit_transaction(amount: float, db_conn) -> bool:
    # eksekusi query SQL dengan db_conn
    return True
```

### 4.4 Higher-Order Functions
Transformasi dan agregasi daftar data (*list/tuple*) wajib memaksimalkan pemakaian `map()`, `filter()`, dan `functools.reduce()`.

```python
import functools

# Contoh penggunaan map & reduce untuk menghitung total pendapatan bulanan
incomes = [15000.00, 25000.50, 10000.00]
total_income = functools.reduce(lambda acc, val: acc + val, incomes, 0.0)
```

### 4.5 State Passing Pattern
DILARANG ada session global karena melanggar prinsip kemurnian fungsi (FP). Konteks seperti `db_conn` atau `jwt_payload` (yang berisi `branch_id`) wajib dikirimkan secara eksplisit (*passed as arguments*).

```python
def process_order(db_conn, jwt_payload: dict, items: tuple) -> bool:
    branch_id = jwt_payload['branch_id']
    # Eksekusi dengan branch_id dan db_conn...
    return True
```

### 4.6 Function Composition
Alur bisnis dibentuk dengan memanggil rentetan fungsi (komposisi berantai), di mana *output* fungsi pertama menjadi *input* fungsi berikutnya.

```python
# validate_input -> check_pricing_tier -> calculate_hpp -> deduct_stock -> record_transaction
```

### 4.7 Side-Effect Isolation
Isolasi area yang menghasilkan *side-effects* (Impure Shell, contoh: kueri I/O ke *database*, *print* CLI) dari logika komputasi matematis/bisnis (Pure Core). Logika penghitungan HPP harus murni, dan barulah hasilnya diserahkan ke fungsi penyimpan SQL.

---

## 5. Gaya Penulisan Kode & PEP 8

Penulisan kode wajib mematuhi panduan standar **PEP 8**:
- **Indentasi**: Menggunakan 4 spasi (Space). Dilarang menggunakan Tab.
- **Panjang Baris**: Maksimal 79 karakter untuk baris kode, dan maksimal 72 karakter untuk baris komentar (*docstring*).
- **Baris Kosong**: 2 baris kosong sebelum deklarasi fungsi (*top-level*), dan 1 baris kosong untuk memisahkan blok logika di dalam sebuah fungsi.
- **Import**: Diurutkan secara alfabetis berdasarkan kelompok:
  1. *Standard library* (mis: `os`, `functools`)
  2. *Third-party library* (mis: `mysql.connector`, `jwt`)
  3. *Local/Project module* (mis: `from utils.formatters import ...`)

---

## 6. Konvensi Penamaan

| Kategori | Konvensi / Aturan | Contoh |
|---|---|---|
| **Fungsi / Metode** | `snake_case` (Gunakan kata kerja) | `calculate_hpp()`, `fetch_active_records()` |
| **Variabel / Argumen** | `snake_case` (Deskriptif) | `user_id`, `jwt_payload`, `branch_id` |
| **Konstanta Global** | `UPPER_SNAKE_CASE` | `MAX_LOGIN_ATTEMPTS`, `JWT_SECRET_KEY` |
| **Nama File / Modul** | `snake_case.py` | `cashier_service.py`, `formatters.py` |
| **Nama Tabel SQL** | `snake_case` (Plural/Jamak) | `transactions`, `employees`, `audit_trail` |
| **Kunci Dictionary** | `snake_case` (String literal) | `{'user_id': 1, 'role': 'Pemilik'}` |

---

## 7. Type Hints & Docstring

### 7.1 Type Hints
Seluruh definisi fungsi wajib menyertakan tipe data pada argumen input dan nilai kembaliannya. Gunakan modul `typing` untuk struktur kompleks.

### 7.2 Docstring (Google Style)
Wajib menggunakan *Google Style docstring* untuk fungsi utama logika bisnis.

**Contoh Kode Lengkap (Type Hints & Docstring):**
```python
from typing import Tuple, Dict

def calculate_discount(price: int, is_wholesale: bool) -> float:
    """
    Menghitung diskon berdasarkan harga awal dan status grosir.

    Args:
        price (int): Harga dasar produk.
        is_wholesale (bool): True jika kuantitas memenuhi syarat grosir.

    Returns:
        float: Harga akhir setelah diskon.
    """
    if is_wholesale:
        return float(price) * 0.9  # diskon 10%
    return float(price)
```

---

## 8. Arsitektur Berlapis & Struktur Direktori

Sistem menggunakan **Layered Architecture** dengan alur *Top-Down*. Lapisan bawah DILARANG memanggil lapisan di atasnya.
1. **Presentation Layer (`cli/`)**: Merender menu, memproses input *prompt*, menampilkan output.
2. **Application/Service Layer (`services/`)**: Fungsi murni untuk logika bisnis (HPP, Gaji).
3. **Data Access Layer (`data/`)**: Menjalankan kueri SQL dengan format tuple dan filter otomatis *soft delete*.
4. **Security Layer (`security/`)**: Validasi *bcrypt*, *pyjwt*, *RBAC*, dan *Audit Trail*.
5. **Utility Layer (`utils/`)**: Memuat `.env`, penanganan lintasan lintas OS (`pathlib`).

**Struktur Direktori:**
```text
abucom/
├── main.py
├── requirements.txt
├── .env
├── cli/
├── services/
├── data/
├── security/
└── utils/
```

---

## 9. Pola Koneksi Database FP

- **Stateless Connection**: Tidak ada objek koneksi abadi. Koneksi (*db_conn*) harus diteruskan (*passed*) sebagai parameter fungsi.
- **Hasil Kueri Immutable**: Cursor MySQL harus mengembalikan `tuple` atau susunan `dict` standar yang bersifat *immutable*.
- **Transaksi ACID**: Setiap alur mutasi yang memengaruhi lebih dari satu tabel wajib diawali dengan *Start Transaction*, diakhiri dengan `commit()`, atau `rollback()` apabila salah satu proses gagal.
- **Filter Branch ID Wajib**: Semua fungsi Data Access Layer wajib mengeksekusi *Parameterized Query* dengan parameter `branch_id`.

**BENAR (Parameterized Query + branch_id filter):**
```python
def fetch_inventory(db_conn, branch_id: int) -> tuple:
    cursor = db_conn.cursor()
    query = "SELECT id, stock FROM materials WHERE branch_id = %s AND is_deleted = 0"
    cursor.execute(query, (branch_id,))
    return cursor.fetchall()
```

**SALAH (Concatenation SQL Injection!):**
```python
# DILARANG KERAS!
query = "SELECT * FROM materials WHERE branch_id = " + str(branch_id)
```

---

## 10. Keamanan Kode

1. **Parameterized Queries**: Selalu gunakan tupel pengikatan (`%s` di MySQL) untuk kueri SQL.
2. **Hashing Password**: Menggunakan pustaka *pure function* `bcrypt`.
   ```python
   # Contoh hashing (rounds 12 sesuai standar)
   hashed = bcrypt.hashpw(password.encode(), bcrypt.gensalt(rounds=12))
   ```
3. **Token Autentikasi**: Menggunakan JWT untuk otorisasi *stateless*.
   ```python
   token = jwt.encode(payload, secret_key, algorithm="HS256")
   ```
4. **Manajemen Secret**: `DB_HOST`, `DB_USER`, `DB_PASS`, dan *Secret Key* wajib dibaca dari file lokal `.env` menggunakan `python-dotenv` karena berkas ini berisi kredensial rahasia yang tidak boleh terekspos di repositori kode. Berkas `.env` DILARANG disatukan ke Git.
5. **Audit Trail Append-Only**: Fungsi `log_audit()` akan menambahkan entri baru. Pemanggilan SQL `UPDATE` atau `DELETE` pada tabel log DILARANG mutlak karena melanggar prinsip *Append-Only* historis data.
6. **Soft Delete**: Klausa `DELETE` DILARANG untuk entitas operasional agar rekam jejak tidak hilang. Semua kueri modifikasi hapus harus berupa *update flag*.
   ```python
   # Contoh Soft Delete
   cursor.execute("UPDATE products SET is_deleted = 1 WHERE id = %s", (product_id,))
   ```
7. **SQL Role-Based Filtering**: Tambahkan `WHERE employee_id = %s` pada kueri sensitif jika *role* adalah `Karyawan`. DILARANG memberikan akses baca ke entitas rahasia (seperti Tabungan Aset atau Laba Rugi) bagi `role` Karyawan.
8. **Proteksi Brute-Force & Idle Auto-Logout**: Main event loop CLI wajib memiliki mekanisme perlindungan *Idle Timeout* (10 menit) yang menghapus sesi JWT aktif jika tidak ada interaksi, dan mengunci akun pengguna (lockout secara logikal) jika terjadi 5x kegagalan autentikasi berturut-turut.
9. **Suspicious Transaction PIN Authorization**: Implementasikan penahanan proses *commit* transaksi jasa keuangan dengan nominal di atas Rp 5.000.000, yang wajib didahului oleh proses otorisasi input PIN Pemilik menggunakan fungsi `bcrypt`.

---

## 11. Penanganan Error

- **Stack Trace Hiding**: Terminal CLI pelanggan dan kasir DILARANG menampilkan peringatan eror sintaks Python atau rincian basis data untuk menghindari eksploitasi peretas terhadap topologi sistem.
- **Pesan Ramah CLI**: Eror harus ditangkap oleh fungsi pembungkus *try-except*, yang akan mengembalikan *tuple* informasi generik untuk pengguna akhir (contoh: `"Peringatan: Validasi data transaksi gagal."`).
- **Rollback Otomatis**: Jika terjadi pengecualian (*exception*) saat mutasi DB, fungsi harus secara eksplisit memanggil `db_conn.rollback()`.
- **Internal Logging**: Detail kesalahan sebenarnya dicatat ke dalam log di lapisan aplikasi, bukan di CLI terminal.

```python
def execute_payment(db_conn, data: tuple) -> bool:
    try:
        # Proses SQL ...
        db_conn.commit()
        return True
    except Exception as e:
        db_conn.rollback()
        # WAJIB: catat error ke log internal untuk pelacakan bug
        log_system_error("execute_payment", str(e))
        return False
```

---

## 12. Presisi Data Finansial

Seluruh nilai uang dan harga DILARANG dievaluasi menggunakan *floating-point* standar Python (`float`) karena sifat komputasi *float* yang menyebabkan galat pembulatan berbahaya pada rekapitulasi finansial.
- **Database**: Semua nilai uang dan kalkulasi finansial wajib menggunakan `DECIMAL(15,4)` di schema MySQL.
- **Python**: Gunakan modul standar `decimal.Decimal` untuk presisi penuh tanpa galat pembulatan.

**BENAR (Presisi Terjaga):**
```python
from decimal import Decimal

def calculate_tax(amount: Decimal) -> Decimal:
    return amount * Decimal('0.11')
```

**SALAH (Float Membahayakan Finansial):**
```python
# Berpotensi menyebabkan galat 0.0000000000001
def calculate_tax(amount: float) -> float:
    return amount * 0.11 
```

---

## 13. Kompatibilitas Lintas OS

Sistem harus bisa beroperasi identik di OS Windows dan Linux (Debian). DILARANG menyisipkan literal garis miring lintasan berkas (`\` atau `/`) karena perbedaan konvensi pemisah path pada OS akan menyebabkan *crash*. Gunakan fungsi murni standar `pathlib.Path()`.

**BENAR (Pathlib OS-Agnostic):**
```python
from pathlib import Path

def get_config_path() -> Path:
    return Path('utils') / 'config.ini'
```

**SALAH (String OS-Specific):**
```python
# Dilarang, karena akan menyebabkan error di Linux
filepath = "utils\\config.ini" 
```

---

## 14. Kebutuhan Non-Fungsional Kode

- **Latensi CLI**: Seluruh rentetan pemanggilan fungsi dari *prompt* input hingga layar terminal kembali dirender, wajib memiliki waktu komputasi kurang dari **150 milidetik (ms)**.
- **Efisiensi Memori (RAM)**: Pemrosesan HPP tingkat berat DILARANG menelan RAM melebihi **256 MB**.
- **Optimasi Query**: Pastikan penggunaan `map()` dan `filter()` dilakukan dengan bijaksana dengan menarik spesifik kolom `SELECT col1, col2` ketimbang lambang bintang `SELECT *`.

---

## 15. Checklist Kepatuhan Kode

Reviewer manusia dan AI Agent harus melakukan verifikasi ketat sebelum me-*merge* kode menggunakan instrumen kriteria berikut:

- [ ] Seluruh fungsi sudah ditulis tanpa instansiasi atribut (*Pure Functions*).
- [ ] Seluruh **pembacaan data (SELECT)** selalu menggunakan filter wajib `is_deleted = 0` dan **penghapusan data (DELETE)** DILARANG secara fisik melainkan menggunakan *flag* `is_deleted = 1`.
- [ ] Kode bebas dari penggunaan kata kunci `class` untuk penentuan alur *Business Layer*.
- [ ] Variabel *state* (`branch_id`, `db_conn`) dideklarasi sebagai parameter eksplisit (Tidak ada variabel global).
- [ ] Struktur penamaan file sesuai standar *snake_case.py*.
- [ ] Skrip menggunakan modul standar `pathlib` untuk pembukaan lintasan berkas.
- [ ] Seluruh komunikasi kueri basis data memakai substitusi Parameterisasi SQL `%s`.
- [ ] Kalkulasi bilangan berbasis Rupiah sepenuhnya memakai modul `decimal.Decimal`.
- [ ] Token autentikasi murni dikelola dengan skema JWT secara *stateless*.
- [ ] Proteksi *Brute-Force* dan *Idle Auto-Logout* terintegrasi pada perulangan peristiwa CLI (main event loop).
- [ ] Mutasi `INSERT` dan `UPDATE` dibungkus menggunakan blok transaksi ACID murni (`commit` / `rollback`).
- [ ] Pesan kesalahan fatal seperti jejak tumpukan (*stack trace*) tidak pernah merembes bocor ke layar CLI.

---

## 16. Glosarium

- **FP (Functional Programming):** Paradigma pemrograman terstruktur yang menghindari efek samping eksternal, di mana program dirakit dengan penerapan fungsi matematis murni.
- **RBAC (Role-Based Access Control):** Skema pengendalian akses keamanan yang membatasi hak guna berdasarkan profil pengguna yang teridentifikasi.
- **ACID (Atomicity, Consistency, Isolation, Durability):** Seperangkat prinsip yang memastikan modifikasi pangkalan data beroperasi secara aman, utuh, dan tahan kegagalan sistem.
- **JWT (JSON Web Token):** Standar industri untuk menerbitkan token identitas aman berdasar pertukaran klaim data yang tidak tersimpan di sisi server.
- **bcrypt:** Pustaka keamanan yang menangani proses enkripsi sandi melalui fungsi komputasi *hashing* lambat guna menjegal skenario pembobolan *brute-force*.
- **Soft Delete:** Teknik mempertahankan arsip logikal pada memori basis data menggunakan flag `is_deleted=1`, tanpa pernah menghancurkannya secara fisik lewat kueri hapus.
- **Audit Trail:** Log kronologis abadi tanpa izin ubah (`Append-Only`) yang menyimpan tapak interaksi transaksi rawan demi pengawasan bisnis.
- **BOM (Bill of Materials):** Rincian seluruh komponen bahan mentah serta besaran dimensinya yang mensyaratkan penciptaan satu objek jualan utuh.

---

## 17. Riwayat Perubahan

| Versi | Tanggal | Diubah Oleh | Keterangan |
|---|---|---|---|
| 1.0.0 | 2026-05-17 | AI Developer (Antigravity) | Pembuatan draf dokumen awal sesuai format Markdown murni yang berorientasi standar pengembangan perusahaan. |
| 1.1.0 | 2026-05-17 | AI Developer (Validator) | Verifikasi kepatuhan dan pelengkapan dokumen sesuai mandat validasi Issue #44 (Penambahan TOC, proteksi JWT & bcrypt Brute-force, Idle timeout, Soft Delete yang komprehensif, dan revisi diksi naratif). |

---

## 18. Referensi

Dokumen ini disusun merujuk langsung ke persyaratan bisnis, infrastruktur teknis, serta arsitektur yang dituangkan di file berikut:
1. `docs/sdlc/01_planning/04_tech_stack_decision.md`
2. `docs/sdlc/01_planning/05_innovation_proposal.md`
3. `docs/sdlc/02_analysis/02_software_requirements.md`
4. `docs/sdlc/03_design/03_system_architecture.md`
5. `docs/sdlc/03_design/06_security_design.md`
