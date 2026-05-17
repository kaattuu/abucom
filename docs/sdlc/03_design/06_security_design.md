# Security Design — Sistem Manajemen Usaha Percetakan AbuCom

## 1. Metadata Dokumen

| Atribut | Detail |
|---|---|
| **Versi** | 1.0.0 |
| **Status** | [draft] |
| **Tanggal Dibuat** | 2026-05-17 |
| **Disusun Oleh** | Senior Information Security Architect & Senior Cybersecurity Engineer (AI) |

## 2. Pendahuluan & Tujuan

Dokumen Security Design ini disusun sebagai panduan teknis utama yang mendefinisikan secara lengkap arsitektur keamanan untuk Sistem Manajemen Usaha Percetakan "AbuCom". Ruang lingkup dokumen ini mencakup mekanisme autentikasi dan otorisasi, penegakan Role-Based Access Control (RBAC), perlindungan data sensitif, audit trail, serta ketahanan sistem terhadap serangan. Arsitektur keamanan ini bertindak sebagai Security Layer terpusat yang melindungi modul autentikasi, transaksi kasir, gudang, pelaporan keuangan, dan SDM, memastikan bahwa operasional bisnis berjalan dengan integritas data dan kerahasiaan yang tinggi. Desain ini merujuk pada standar industri seperti NIST Cybersecurity Framework dan ISO/IEC 27002:2022.

## 3. Prinsip Keamanan Fundamental

Sistem AbuCom menerapkan 6 prinsip keamanan fundamental berikut:
1. **Least Privilege (Hak Akses Minimal):** Setiap peran hanya diberikan izin pada tingkat paling minimum yang dibutuhkan untuk menyelesaikan tugas. *Penerapan:* Karyawan hanya dapat melihat menu operasional harian dan terblokir dari menu Laba Rugi atau data aset pemilik.
2. **Separation of Duties (Pemisahan Tugas):** Memisahkan kewenangan tugas operasional dari tugas finansial/manajerial tingkat tinggi. *Penerapan:* Karyawan dapat membuat transaksi, tetapi pencocokan (rekonsiliasi) kas laci fisik dan sistem mutlak dilakukan oleh Pemilik.
3. **Data Classification (Klasifikasi Data):** Membagi aset data menjadi Publik/Operasional, Internal Terbatas, dan Rahasia (Sensitif). *Penerapan:* Data pinjaman bank (`loans`) dan tabungan pemilik (`asset_savings`) diklasifikasikan sebagai Rahasia dan tidak dapat diakses oleh Karyawan.
4. **Defense in Depth (Pertahanan Berlapis):** Kontrol keamanan ganda di berbagai lapisan. *Penerapan:* Selain filter menu antarmuka CLI yang disembunyikan untuk Karyawan, lapisan data juga dilindungi dengan klausa SQL Role-Based Filtering.
5. **Fail-Safe Defaults (Standar Aman):** Akses pengguna secara *default* ditolak kecuali secara eksplisit diizinkan. *Penerapan:* Jika verifikasi JWT gagal atau terjadi eksepsi tidak terduga, sistem secara *default* akan menolak akses dan membatalkan transaksi (`rollback`).
6. **Complete Mediation (Mediasi Lengkap):** Semua permintaan akses divalidasi otorisasinya. *Penerapan:* Setiap fungsi yang dieksekusi di backend wajib mengekstrak dan memvalidasi `role` dan `branch_id` dari JWT tanpa terkecuali.

## 4. Arsitektur Autentikasi (Authentication Design)

Mekanisme autentikasi menggunakan JSON Web Token (JWT) yang *stateless* dan murni diimplementasikan melalui paradigma Functional Programming (FP).

### Alur Login CLI
1. **Input CLI:** Pengguna memasukkan `username` dan `password` di prompt CLI.
2. **Hash & Verifikasi:** Sistem mengambil hash kata sandi dari database. `bcrypt.checkpw()` dipanggil secara *stateless* untuk memverifikasi kecocokan sandi dengan konfigurasi keamanan 12 *salt rounds*.
3. **Generate JWT:** Jika valid, `pyjwt` men-generate token dengan algoritma **HS256** menggunakan `secret_key` yang dimuat dari `.env`.
4. **Struktur Payload:** Token memuat atribut: `user_id`, `role`, `branch_id`, dan `exp` (berlaku 8 jam).
5. **Penyimpanan Sesi:** Token yang dihasilkan akan dicatat ke dalam tabel `login_sessions` (atribut `jwt_token`, `expires_at`).
6. **Selesai:** Pengguna diarahkan ke Menu Utama berbasis hak akses.

### Diagram Alur Login
```text
[Input CLI] --> (Prompt: username & password)
                   |
                   v
[Query DB]  --> SELECT password_hash, role, branch_id FROM users WHERE username = ?
                   |
                   v
[Verifikasi]--> bcrypt.checkpw(input_password, password_hash)
                   |-- (Gagal) -> Hitung percobaan (Brute-force protection) -> Tolak Akses
                   |
                   |-- (Sukses) -> Lanjut
                   v
[Generate]  --> jwt.encode({user_id, role, branch_id, exp: 8h}, secret_key, algorithm="HS256")
                   |
                   v
[Simpan Sesi]-> INSERT INTO login_sessions (user_id, jwt_token, expires_at)
                   |
                   v
[Render Menu]-> Tampilkan opsi CLI berdasarkan role
```

### Alur Logout
Pengguna yang memilih menu keluar (*logout*) akan memicu eksekusi `DELETE` secara fisik dari level aplikasi (pengecualian khusus) atau invalidasi pada tabel `login_sessions` untuk token miliknya. Sesi lokal CLI akan dibersihkan, dan pengguna dikembalikan ke prompt login awal.

## 5. Arsitektur Otorisasi RBAC (Authorization Design)

Sistem menggunakan kontrol akses berbasis peran (RBAC) yang tidak memerlukan *database lookup* berulang; filter otorisasi membaca secara langsung dari payload JWT aktif.

### Definisi Role
- **Pemilik (Owner):** Memiliki kontrol absolut terhadap semua fungsi (Hak Akses Penuh: C/R/U/D).
- **Karyawan (Staff):** Memiliki akses fungsional terbatas pada operasional harian kasir, PPOB, produksi, dan gudang.

### Filter Menu CLI
Modul Presentation Layer akan menyembunyikan opsi menu sensitif (seperti Laporan Keuangan, Audit Trail, atau Kasbon Karyawan lain) jika `role` dari JWT bernilai `Karyawan`.

### SQL Role-Based Filtering & Proteksi Data Sensitif
Lapisan Data Access menerapkan penyaring kondisional secara ketat pada kueri basis data:
- Akses ke entitas sensitif (`loans`, `asset_savings`, Laporan Laba Rugi) akan otomatis melempar `UnauthorizedException` jika yang memanggil kueri memiliki `role = 'Karyawan'`.
- Tabel dengan akses personal (`users`, `employees`, `employee_loans`, `payroll`, `incentive_points`) ditambahkan klausa penapis `WHERE employee_id = ?` atau `WHERE user_id = ?` saat dipanggil oleh Karyawan, sehingga mereka hanya bisa melihat data milik sendiri.

### Ringkasan Matriks Akses (Berdasarkan ACM)
- **Tabel Transaksi & PPOB:** Karyawan memiliki hak C/R/U untuk kelancaran operasional.
- **Tabel Master Gudang & Barang:** Karyawan memiliki hak R (Baca) dan U (Ubah/Potong stok).
- **Tabel Laporan & Audit:** Pemilik (Read-Only) melihat keseluruhan `audit_trail` dan laporan aset; Karyawan ✗ (Ditolak).

## 6. Desain Audit Trail

Mekanisme pencatatan audit (*audit trail*) dirancang untuk menyimpan jejak kronologi mutasi data secara imutabel.

### Struktur Tabel `audit_trail`
Kolom: `id`, `user_id`, `action_type`, `target_entity`, `change_detail`, `timestamp`.

### Kategori Operasi Wajib Log
Berdasarkan aturan ACM, kelima kategori berikut wajib dicatat:
1. Transaksi Keuangan Utama (Mutasi, PPOB, Pembayaran).
2. Jejak Autentikasi (Login dan Logout).
3. Integritas Barang & Harga (Modifikasi inventaris, BOM, harga, stock opname).
4. Mutasi SDM & Kasbon (Perubahan hutang karyawan, payroll).
5. Akses Sensitif Manajerial (Aktivitas pembacaan data aset / tabungan / hutang oleh Pemilik).

### Aturan Imutabilitas (Append-Only)
Tabel `audit_trail` berlaku absolut sebagai entitas *Append-Only* (hanya menerima `INSERT`). Kode aplikasi tidak memiliki dan tidak diizinkan menggunakan kueri `UPDATE` atau `DELETE` pada tabel ini.

### Implementasi Functional Programming
Pencatatan dikelola oleh satu fungsi murni:
`def log_audit(user_id: int, action_type: str, target_entity: str, change_detail: str, db_conn) -> None:`
Fungsi ini dipanggil sebagai instruksi komplementer di setiap akhir transaksi berhasil. Format string `change_detail` distandardisasi (contoh: "UPDATE stok kertas_a4 dari 500 ke 450 (pemotongan transaksi #123)").

## 7. Soft Delete Framework

Dilarang keras melakukan perintah penghapusan SQL fisik (`DELETE`) pada aplikasi (kecuali tabel `login_sessions`).
- **Skema Dasar:** Tabel master memiliki kolom `is_active BOOLEAN DEFAULT TRUE`. (Tabel lain dapat menggunakan ekuivalensi nama seperti `is_deleted = 0`).
- **Penerapan Kueri:** Setiap rutin pembacaan (`SELECT`) wajib menyelipkan penapis aktif `WHERE is_active = TRUE` atau `WHERE is_deleted = 0`.
- **Dampak:** Integritas referensial antar entitas terjaga (contoh: pegawai yang sudah berhenti datanya tetap ada untuk validasi historis BOM dan HPP di tabel riwayat transaksi).

## 8. Proteksi Brute-Force & Idle Auto-Logout

- **Brute-Force Protection:** Sistem mendeteksi kegagalan *login* berturut-turut. Pada respons yang gagal, aplikasi menunda pengembalian pesan (*latency* buatan) selama 500ms. Jika mencapai ambang batas **5 kali gagal**, akun dikunci secara logikal (`is_locked = 1`). Pembukaan kunci (*unlock*) mutlak harus dilakukan oleh Pemilik melalui modul administratif.
- **Idle Timeout:** Sistem membaca fungsi internal `time.time()` selama *prompt event loop* berjalan. Jika interaksi pengguna terhenti total selama durasi **10 menit**, sesi JWT dinonaktifkan secara sepihak, token dihapus dari memori dan `login_sessions`, dan pengguna dipaksa masuk ke layar *login* awal.

## 9. Validasi PIN Transaksi Finansial

Menerapkan kontrol otorisasi ganda *(Maker-Checker)* pada aliran transfer keuangan bernilai tinggi.
- **Threshold:** Transaksi keluaran pada Jasa Keuangan > Rp 5.000.000.
- **Mekanisme:** Proses transaksi ditunda (SQL `COMMIT` ditahan sementara). Aplikasi meminta kasir memanggil Pemilik untuk memasukkan PIN.
- **Verifikasi:** PIN tervalidasi menggunakan `bcrypt.checkpw()`. Jika valid, transaksi dilanjutkan (`commit`); jika gagal/dibatalkan, perubahan basis data diurungkan (`rollback`).

## 10. Pencadangan Database Otomatis Terenkripsi

Demi menjamin keamanan terhadap kehilangan fatal (ransomware / hardware failure), pangkalan data dicadangkan dengan strategi berikut:
- **Alat Pelaksana:** Menjalankan utilitas bawaan `mysqldump` yang dipanggil melalui rutin `subprocess` skrip Python terpisah (`backup.py`).
- **Penjadwalan:** Dieksekusi via `cron job` (Linux) atau `Task Scheduler` (Windows) pada jam penutupan operasional.
- **Keamanan Salinan:** Hasil cadangan dimampatkan dan dikunci menggunakan kata sandi lokal, yang dibaca aman dari berkas `.env`.
- **Retensi Waktu:** Skrip secara periodik menghapus arsip data lama yang telah melampaui **30 hari**.

## 11. Strategi Penanganan Error Aman

Pengendalian eksepsi dan kegagalan aplikasi harus menjaga kerahasiaan topologi internal:
- **Stack Trace Hiding:** Sama sekali tidak diperbolehkan ada *stack trace* Python atau sintaksis eror SQL yang merembes tampil ke layar CLI kasir.
- **Pesan Generik Ramah Pengguna:** Menampilkan peringatan yang dapat dimengerti, seperti: "Peringatan: Gagal memproses data, periksa kembali nominal Anda". Detail eror spesifik dialihkan ke fail *log* internal (*backend*).
- **Rollback Otomatis:** Setiap blok fungsional transaksi menerapkan prinsip pemulihan aman dengan pemanggilan `connection.rollback()` pada kegagalan operasi.

## 12. Keamanan Koneksi Database & Multi-Branch

### Koneksi Database (FP Pattern)
- Kredensial pangkalan data (`DB_HOST`, `DB_USER`, `DB_PASS`, rahasia JWT) dikelola secara eksklusif menggunakan modul `python-dotenv` dari berkas `.env`. Berkas tersebut dilarang dimasukkan ke dalam versi repositori (`.gitignore`).
- Eksekusi instruksi ke database mutlak menggunakan pendekatan **Parameterized Queries** *(prepared statements)* melalui `mysql-connector-python` untuk menghindari serangan *SQL Injection*.
- Modifikasi tabel dilindungi dengan jaminan ACID transaction komputasi basis data: diproses di dalam blok logika yang ditutup dengan pengesahan berpasangan (start transaction → commit / rollback).

### Isolasi Keamanan Lintas Cabang (Multi-Branch Ready)
- Kode identitas `branch_id` diekstrak dari kredibilitas payload JWT saat pengguna aktif, tidak diizinkan berupa penyematan variabel bebas di program.
- Semua pemanggilan kueri (terutama transaksional operasional) wajib menyelipkan klausa SQL `WHERE branch_id = ?`, membatasi tumpang-tindih atau kebocoran data antar entitas unit cabang secara absolut.

## 13. Tabel Ringkasan Klasifikasi Data & Entitas Keamanan

### A. Klasifikasi Sensitivitas Data
| Tingkat | Atribut Data | Perlakuan Akses |
|---|---|---|
| **Publik/Operasional** | Katalog, Harga, Barang Stok | Tersedia terbuka untuk C/R/U Karyawan operasional |
| **Internal Terbatas** | Data Pribadi, Kasbon, Poin Insentif, Gaji | Filter `WHERE user_id=?` (Hanya yang bersangkutan) |
| **Rahasia (Sensitif)** | Tabungan aset, Pinjaman berbunga, Laba Rugi | Filter JWT mutlak (Akses Ditolak bagi Karyawan) |

### B. Pemetaan Entitas Keamanan Utama
| Nama Tabel | Peran pada Keamanan Sistem |
|---|---|
| `users` | Tempat hash password bcrypt dan status akun (role, lock) disimpan |
| `login_sessions` | Menyimpan token aktif pengguna untuk fungsi auto-logout/invalidasi |
| `audit_trail` | Rekam jejak abadi yang imutabel dari segala aktivitas sistem signifikan |
| `loans`, `asset_savings` | Kategori data rahasia tertinggi di basis data yang terisolasi untuk Pemilik |

## 14. Skenario Serangan & Mitigasi

| Tipe Serangan Potensial | Mitigasi dalam Arsitektur |
|---|---|
| **Brute-Force Attack** | Algoritma *bcrypt* (rounds 12) + *lockout* setelah 5 kegagalan + jeda respons 500ms. |
| **SQL Injection** | Penggunaan rutin parametrik murni (*Parameterized Queries*) pada Driver MySQL konektor. |
| **Privilege Escalation** | Otorisasi RBAC divalidasi langsung oleh payload *signature* `pyjwt` di setiap eksekusi antar-layer. Modifikasi JWT mandiri akan ditolak kriptografinya. |
| **Session Hijacking** | Penggunaan token yang kadaluwarsa sendiri sesudah 8 jam + Mekanisme *idle timeout* 10 menit. |
| **Data Tampering (Kasir Fraud)**| Penghapusan data dihalangi (*soft delete only*). Modifikasi dicatat langsung dan abadi di tabel `audit_trail`. |

## 15. Referensi

- `docs/sdlc/03_design/03_system_architecture.md`
- `docs/sdlc/02_analysis/06_access_control_matrix.md`
- `docs/sdlc/02_analysis/01_business_requirements.md`
- `docs/sdlc/02_analysis/02_software_requirements.md`
- `docs/sdlc/03_design/01_database_schema.sql`
- `docs/sdlc/01_planning/04_tech_stack_decision.md`
- `docs/sdlc/01_planning/05_innovation_proposal.md`
