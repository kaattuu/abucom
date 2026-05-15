# Issue #0027: Pembuatan Dokumen System Architecture

## Deskripsi Tugas

Tugas ini bertujuan untuk menyusun dokumen utama `03_system_architecture.md` yang berada di dalam folder `docs/sdlc/03_design/`. Dokumen ini saat ini berstatus `[create_file]` dan harus menjadi dokumen arsitektur sistem yang lengkap, mendefinisikan keseluruhan struktur teknis aplikasi AbuCom — meliputi arsitektur aplikasi (lapisan/layer), pola organisasi kode (Functional Programming), struktur modul, alur data antar komponen, strategi koneksi database, mekanisme autentikasi/otorisasi, strategi penanganan error, serta pemetaan hubungan antara 20 modul fungsional dengan entitas database. Dokumen ini menjadi cetak biru teknis utama yang menjembatani fase Design menuju fase Implementation.

---

## Persona Implementasi

Bertindaklah sebagai **Senior Software Architect** dan **Senior System Designer** yang memiliki keahlian mendalam dalam:

- Perancangan arsitektur aplikasi CLI berbasis Python dengan paradigma **Functional Programming (FP) murni** (tanpa `class` untuk logika bisnis).
- Desain arsitektur berlapis (*Layered Architecture*) untuk aplikasi monolitik lokal.
- Pemetaan modul fungsional ke struktur direktori dan file Python.
- Perancangan alur data (*data flow*) antar komponen sistem tanpa OOP.
- Strategi koneksi database MySQL menggunakan `mysql-connector-python` secara fungsional.
- Implementasi RBAC (*Role-Based Access Control*) menggunakan JWT (`pyjwt`) dan hashing (`bcrypt`) dalam paradigma FP.
- Arsitektur *Multi-Branch Ready* dengan `branch_id` sebagai parameter eksplisit di setiap fungsi.
- Penulisan dokumen teknis standar industri yang jelas dan tidak ambigu.

---

## File Referensi Utama

Dalam pembuatan dokumen ini, Anda **DIWAJIBKAN** untuk merujuk pada file berikut:

1. `docs/sdlc/01_planning/04_tech_stack_decision.md` — **REFERENSI UTAMA #1**: Berisi keputusan teknologi (Python 3.14.2+, MySQL 8.4 LTS, paradigma FP murni, CLI, library wajib beserta versinya, strategi Multi-Branch Ready, model AI-Augmented Development). Rangkum informasi berikut:
   - Bahasa: Python 3.14.2+ dengan FP murni (tidak boleh ada `class` untuk logika bisnis, gunakan `pure functions`, `map()`, `filter()`, `functools.reduce()`, data `immutable` via `tuple`/`dict` baru).
   - Database: MySQL 8.4 LTS Community Edition, engine InnoDB, charset utf8mb4.
   - Library: `mysql-connector-python==9.3.0` (hasil query berupa `tuple`), `python-dotenv==1.1.0` (kredensial dari `.env`), `bcrypt==4.3.0` (hashing password, rounds=12), `pyjwt==2.10.1` (token JWT, exp=8 jam, payload: `user_id`, `role`, `branch_id`).
   - Antarmuka: CLI/Console dengan navigasi menu hierarkis berbasis angka.
   - OS Target: Linux Debian 12 Bookworm dan Windows 11 24H2 (gunakan `pathlib.Path()` untuk semua operasi path).
   - Skalabilitas: Multi-Branch Ready — setiap fungsi modul menerima `branch_id` sebagai argumen wajib, tidak ada query tanpa `WHERE branch_id = ?`.

2. `docs/sdlc/01_planning/01_project_charter.md` — **REFERENSI UTAMA #2**: Berisi deskripsi 20 modul fungsional (Bagian 3.1), spesifikasi teknis, struktur organisasi 7 posisi, dan susunan tim pengembang. Rangkum informasi berikut:
   - 20 modul: (1) Manajemen Produk Percetakan, (2) Penjualan ATK, (3) Layanan PPOB, (4) Jasa Keuangan, (5) Jasa Teknis, (6) Stok & Gudang, (7) HPP & BOM, (8) Harga & Pembayaran, (9) Antrian & Job Tracking, (10) SDM & Penggajian, (11) Poin Karyawan, (12) Pinjaman, (13) Keuangan & Pelaporan, (14) Aset, (15) Supplier & Hutang, (16) CRM Pelanggan, (17) Keamanan & Audit, (18) Input Data Awal, (19) Arsitektur Multi-Cabang, (20) Inovasi & Best Practice.
   - 7 posisi organisasi: Kepala Percetakan (Pemilik), Pramuniaga, Kasir, Desainer, Bagian Produksi Cetak, Staf Fotocopy & Print, Bagian Gudang.
   - Budaya kerja cross-functional.

3. `docs/sdlc/02_analysis/02_software_requirements.md` — **REFERENSI UTAMA #3**: Berisi kebutuhan fungsional detail (F-01 s.d F-09) dan kebutuhan non-fungsional (performa, keamanan, keandalan). Rangkum informasi berikut:
   - F-01: Autentikasi — bcrypt hash, JWT generate (exp 8 jam, payload user_id/role/branch_id).
   - F-02: Transaksi Kasir Multi-Lini — harga grosir (qty>=50), harga mitra (aktif>=3 bulan), DP minimal 50%, batal (DP hangus jika >= Proses Desain), retur (max 1x24 jam).
   - F-03: Gudang & BOM — kalkulasi HPP via BOM, pemotongan stok desimal presisi (`Decimal`), cross-usage stok retail/produksi.
   - F-04: Job Tracking — status: Antri→Proses Desain→Produksi→Selesai→Diambil, arsip path file desain.
   - F-05: Waste Management — pencatatan limbah bahan baku rusak/cacat.
   - F-06: SDM & Penggajian — gaji tetap (Rp 3.000.000 jika pendapatan >= Rp 15.000.000) vs persentase (15%), poin insentif (1/3/5/10), kasbon potong gaji.
   - F-07: PPOB & Jasa Keuangan — multi-akun, peringatan saldo < Rp 150.000, deposit Rp 500.000.
   - F-08: CRM — pelanggan & vendor, immutable log insertion.
   - F-09: Pelaporan — agregasi reduce/filter, role-based filtering ketat untuk data sensitif.
   - Non-fungsional: latency <= 150ms, RAM <= 256MB, ACID transaction (commit/rollback).

4. `docs/sdlc/02_analysis/06_access_control_matrix.md` — **REFERENSI UTAMA #4**: Berisi matriks RBAC lengkap (2 role: Pemilik/Karyawan), daftar data sensitif, aturan audit trail, dan aturan keamanan arsitektur. Rangkum informasi berikut:
   - Prinsip: Least Privilege, Separation of Duties, Defense in Depth, Fail-Safe Defaults, Complete Mediation.
   - Tabel sensitif (khusus Pemilik): `loans`, `asset_savings`, Laporan Laba Rugi.
   - Audit trail wajib pada: transaksi keuangan, autentikasi, integritas barang/harga, mutasi SDM/kasbon, akses data sensitif.
   - Keamanan tambahan: brute-force protection (5x gagal = lock), idle timeout, secure error handling (jangan bocorkan stack trace/SQL).
   - SQL Role-Based Filtering: klausa `WHERE employee_id = ?` atau `WHERE user_id = ?` untuk akses Terbatas.

5. `docs/sdlc/03_design/01_database_schema.sql` — **REFERENSI UTAMA #5**: Berisi 22 tabel DDL lengkap yang sudah diimplementasikan. Rangkum informasi berikut:
   - Tabel master: `branches`, `users`, `pricing_tiers`, `customers`, `vendors`, `employees`, `products_services`, `materials`, `ppob_accounts`, `assets`.
   - Tabel transaksi: `transactions`, `transaction_items`, `payments`, `orders_job_tracking`, `production_waste`, `ppob_mutations`, `employee_attendance`, `employee_loans`, `payroll`, `cash_reconciliation`, `stock_opname`.
   - Tabel pendukung: `bom`, `incentive_points`, `login_sessions`, `routine_expenses`, `loans`, `audit_trail`, `asset_savings`.
   - Konvensi: snake_case, DECIMAL(15,4) untuk finansial, ENUM untuk domain terbatas, branch_id di setiap tabel utama, soft-delete via is_active, InnoDB, utf8mb4.

6. `docs/sdlc/03_design/02_erd_database.puml` — **REFERENSI PENDUKUNG**: Berisi visualisasi relasi antar tabel dalam format PlantUML. Gunakan sebagai referensi tambahan untuk memahami hubungan entitas.

7. `docs/sdlc/01_planning/05_innovation_proposal.md` — **REFERENSI PENDUKUNG**: Berisi 5 inovasi yang harus diintegrasikan ke arsitektur:
   - (1) Automated Local Encrypted Database Backup — skrip utilitas terpisah, `mysqldump` via `subprocess`, retensi 30 hari.
   - (2) Idle Auto-Logout & Brute-Force Protection — idle timeout 10 menit, lock setelah 5x gagal login.
   - (3) Standardized Design File Naming Generator — format `[TANGGAL]_[KODE_ORDER]_[NAMA_PELANGGAN]_[ITEM]`.
   - (4) Soft Delete Data Retention Framework — `is_deleted` universal, filter `WHERE is_deleted = 0`.
   - (5) Suspicious Transaction PIN Authorization — PIN pemilik via bcrypt untuk transaksi > Rp 5.000.000.

File `docs/sdlc/narasi.txt` **TIDAK diperlukan** karena seluruh informasi sudah tercakup lengkap dalam dokumen referensi di atas.

---

## Instruksi Kelayakan & Kriteria Dokumen Utama

Harap patuhi instruksi berikut secara ketat saat menyusun isi dari dokumen `03_system_architecture.md`:

1. **Definisikan Arsitektur Berlapis (Layered Architecture)**: Dokumen harus mendefinisikan lapisan-lapisan arsitektur aplikasi secara jelas. Karena ini adalah aplikasi CLI monolitik berbasis FP murni, gunakan pendekatan lapisan fungsional seperti:
   - **Presentation Layer (CLI)**: Modul yang menangani rendering menu, input pengguna, dan output terminal.
   - **Application/Service Layer**: Modul yang berisi pure functions logika bisnis utama (kalkulasi HPP, penggajian, rekonsiliasi, dll).
   - **Data Access Layer**: Modul yang berisi fungsi-fungsi koneksi dan query ke MySQL (pembungkus `cursor.execute()`).
   - **Security Layer**: Modul yang menangani autentikasi (bcrypt/JWT), otorisasi (RBAC filter), dan audit trail.
   - **Utility/Infrastructure Layer**: Modul utilitas seperti konfigurasi `.env`, path handling (`pathlib`), formatter, dan backup.
   - Jelaskan tanggung jawab, batasan, dan aturan komunikasi antar lapisan. Lapisan atas boleh memanggil lapisan bawah, tetapi TIDAK sebaliknya.

2. **Pemetaan 20 Modul ke Struktur Direktori Python**: Buat proposal struktur direktori/folder proyek Python yang logis dan terorganisir. Petakan 20 modul fungsional dari Project Charter ke dalam folder dan file Python yang konkret. Gunakan konvensi penamaan `snake_case`. Contoh struktur:
   ```
   abucom/
   ├── main.py
   ├── cli/
   ├── services/
   ├── data/
   ├── security/
   ├── utils/
   └── config/
   ```
   Pastikan setiap modul memiliki file yang jelas dan tidak ada logika bisnis yang tercampur dengan presentasi.

3. **Diagram Arsitektur (Teks/ASCII atau Mermaid)**: Sertakan diagram arsitektur dalam format teks ASCII atau Mermaid Markdown yang menunjukkan:
   - Hubungan antar lapisan arsitektur.
   - Alur data dari input pengguna CLI → logika bisnis → database → output CLI.
   - Posisi komponen keamanan (JWT, bcrypt, RBAC) dalam alur.

4. **Alur Data Utama (Data Flow)**: Jelaskan alur data untuk minimal 3 skenario kritis:
   - **Alur Login**: Input username/password → bcrypt verify → JWT generate → session store → menu rendering berdasarkan role.
   - **Alur Transaksi Kasir**: Pilih layanan → input item/qty → kalkulasi harga (tier check) → kalkulasi HPP (BOM lookup) → potong stok → catat transaksi → update audit trail.
   - **Alur Penggajian**: Trigger payroll → hitung pendapatan bersih → tentukan skema gaji → hitung poin insentif → potong kasbon → generate slip gaji.

5. **Strategi Koneksi Database (FP Pattern)**: Jelaskan pola koneksi database yang digunakan secara fungsional:
   - Bagaimana koneksi MySQL dibuat dan dikelola tanpa OOP (tanpa connection pool class).
   - Bagaimana transaksi ACID dikelola (commit/rollback) dalam konteks FP.
   - Bagaimana hasil query (`tuple`) diproses oleh pure functions.
   - Bagaimana `branch_id` diinjeksikan ke setiap query secara konsisten.

6. **Arsitektur Keamanan**: Jelaskan implementasi keamanan secara arsitektural:
   - Alur autentikasi JWT (generate, validate, expire, blacklist).
   - Implementasi RBAC: bagaimana role dari JWT payload digunakan untuk memfilter menu CLI dan query database.
   - Pola audit trail: kapan dan bagaimana log ditulis ke tabel `audit_trail`.
   - Integrasi 5 inovasi keamanan dari Innovation Proposal.

7. **Strategi Penanganan Error**: Jelaskan pola penanganan error secara arsitektural:
   - Bagaimana exception ditangkap tanpa membocorkan informasi sensitif (stack trace, SQL query).
   - Bagaimana rollback database dilakukan saat terjadi error di tengah transaksi.
   - Bagaimana pesan error yang ramah ditampilkan ke pengguna CLI.

8. **Arsitektur Multi-Branch Ready**: Jelaskan bagaimana arsitektur mendukung multi-cabang:
   - `branch_id` sebagai parameter wajib di setiap fungsi service dan data access.
   - Tidak ada query tanpa filter `WHERE branch_id = ?`.
   - Strategi konfigurasi branch aktif saat login.

9. **Pemetaan Modul ke Entitas Database**: Buat tabel matriks yang memetakan 20 modul fungsional ke tabel-tabel database yang digunakan oleh masing-masing modul. Ini menjadi panduan bagi developer saat implementasi.

10. **Standar Kode FP yang Wajib Diterapkan**: Rangkum aturan FP yang harus ditaati di seluruh arsitektur:
    - Semua logika bisnis ditulis sebagai pure functions.
    - Data immutable (tuple, dict baru, tidak ada mutasi in-place).
    - Tidak ada `class` untuk logika bisnis (dataclass read-only boleh untuk wadah data jika diperlukan).
    - Gunakan `map()`, `filter()`, `functools.reduce()` untuk transformasi koleksi data.
    - Setiap fungsi modul database menerima `branch_id` sebagai argumen wajib.

11. **Metadata Dokumen**: Sertakan tabel metadata dokumen di bagian atas file dengan format:
    - Judul Dokumen, Versi (1.0.0), Status ([create_file]), Tanggal Dibuat, Disusun Oleh (persona).

12. **Bahasa Indonesia**: Seluruh isi dokumen ditulis dalam Bahasa Indonesia yang natural, tidak ambigu, dan mudah dipahami. Istilah teknis boleh menggunakan bahasa Inggris yang sudah umum digunakan di industri IT.

13. **Tandai Data Kosong**: Jika ada data atau keputusan arsitektur yang belum bisa ditentukan karena tidak tersedia di file referensi, tandai dengan format: `[PERLU DIISI MANUAL: deskripsi apa yang perlu diisi]`.

14. **Referensi di Akhir Dokumen**: Cantumkan daftar file referensi yang digunakan di bagian paling akhir dokumen.

15. **Output Bersih**: Hanya tuangkan hasil akhir (konten bersih) dokumen arsitektur. Jangan menyertakan instruksi pengerjaan, proses pemikiran, atau komentar tambahan.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)

Panduan ini akan dibaca oleh junior programmer atau AI model yang lebih murah dan akan langsung mengimplementasikan file target. Lakukan langkah-langkah berikut secara berurutan tanpa deviasi:

### Langkah 1: Baca Semua Referensi Wajib Sampai Tuntas

- Baca keseluruhan isi `docs/sdlc/01_planning/04_tech_stack_decision.md` — catat semua keputusan teknologi, versi library, aturan FP, dan strategi Multi-Branch.
- Baca keseluruhan isi `docs/sdlc/01_planning/01_project_charter.md` — catat 20 modul fungsional (Bagian 3.1), spesifikasi teknis (Bagian 7), dan struktur organisasi (Bagian 9).
- Baca keseluruhan isi `docs/sdlc/02_analysis/02_software_requirements.md` — catat kebutuhan fungsional F-01 s.d F-09 (Bagian 4) dan kebutuhan non-fungsional (Bagian 5).
- Baca keseluruhan isi `docs/sdlc/02_analysis/06_access_control_matrix.md` — catat prinsip keamanan (Bagian 4), matriks RBAC (Bagian 6-7), data sensitif (Bagian 8), aturan audit trail (Bagian 10), dan aturan keamanan tambahan (Bagian 11).
- Baca keseluruhan isi `docs/sdlc/03_design/01_database_schema.sql` — catat semua nama tabel, kolom, relasi FK, dan konvensi yang digunakan.
- Baca keseluruhan isi `docs/sdlc/03_design/02_erd_database.puml` — pahami visualisasi relasi antar tabel.
- Baca keseluruhan isi `docs/sdlc/01_planning/05_innovation_proposal.md` — catat 5 inovasi dan spesifikasi teknisnya (Bagian 5).
- **JANGAN** mulai menulis dokumen sebelum semua file referensi selesai dibaca dan dipahami.

### Langkah 2: Tulis Metadata Dokumen

- Buka file `docs/sdlc/03_design/03_system_architecture.md`.
- Hapus konten placeholder yang ada.
- Tulis judul dokumen: `# System Architecture — Sistem Manajemen Usaha Percetakan "AbuCom"`.
- Tulis tabel Metadata Dokumen: Versi 1.0.0, Status [create_file], Tanggal Dibuat (tanggal hari ini), Disusun Oleh (Senior Software Architect & Senior System Designer (AI)).

### Langkah 3: Tulis Bagian Pendahuluan

- Tulis ringkasan eksekutif yang menjelaskan tujuan dokumen ini dalam konteks SDLC.
- Jelaskan bahwa dokumen ini adalah cetak biru arsitektur teknis yang menjembatani fase Design ke Implementation.
- Sebutkan batasan arsitektur: CLI monolitik, FP murni, MySQL lokal, Multi-Branch Ready.

### Langkah 4: Tulis Arsitektur Berlapis (Layered Architecture)

- Definisikan 5 lapisan arsitektur (Presentation, Application/Service, Data Access, Security, Utility/Infrastructure).
- Untuk setiap lapisan, jelaskan: tanggung jawab, contoh fungsi/modul yang masuk ke lapisan ini, dan aturan komunikasi.
- Buat diagram arsitektur dalam format Mermaid atau ASCII yang menunjukkan hubungan antar lapisan.
- Tegaskan aturan: lapisan atas boleh memanggil lapisan bawah, TIDAK sebaliknya.

### Langkah 5: Tulis Struktur Direktori Proyek

- Buat proposal struktur direktori Python yang memetakan 20 modul ke folder dan file.
- Gunakan format tree (`├──`, `└──`, `│`) untuk visualisasi.
- Pastikan setiap modul memiliki tempat yang jelas.
- Pisahkan CLI handlers, service functions, data access functions, dan security functions ke folder berbeda.

### Langkah 6: Tulis Alur Data Utama

- Jelaskan minimal 3 alur data kritis:
  1. Alur Login (input → bcrypt verify → JWT generate → session → menu render).
  2. Alur Transaksi Kasir (pilih layanan → input item → harga tier → HPP BOM → potong stok → catat → audit trail).
  3. Alur Penggajian (trigger → hitung pendapatan → skema gaji → poin → kasbon → slip).
- Gunakan format langkah-langkah bernomor atau diagram alur sederhana untuk setiap alur.

### Langkah 7: Tulis Strategi Koneksi Database

- Jelaskan pola koneksi MySQL secara FP (tanpa OOP): fungsi `create_connection()` yang mengembalikan objek koneksi, fungsi `execute_query()` yang menerima koneksi dan query string, mengembalikan `tuple`.
- Jelaskan pola transaksi ACID: `connection.start_transaction()` → eksekusi query → `connection.commit()` jika sukses → `connection.rollback()` jika exception.
- Jelaskan bagaimana `branch_id` diinjeksikan ke setiap query.

### Langkah 8: Tulis Arsitektur Keamanan

- Jelaskan alur JWT lengkap (generate, validate pada setiap aksi, expire check, blacklist di `login_sessions`).
- Jelaskan implementasi RBAC: extract role dari JWT → filter menu CLI → filter query database.
- Jelaskan pola audit trail: setiap fungsi krusial memanggil fungsi `log_audit()` setelah eksekusi.
- Integrasikan 5 inovasi dari Innovation Proposal ke dalam arsitektur keamanan.

### Langkah 9: Tulis Strategi Penanganan Error

- Jelaskan pola try/except di setiap fungsi data access.
- Jelaskan aturan: exception detail di-log ke audit/log internal, pesan generik ke CLI.
- Jelaskan pola rollback otomatis saat exception terjadi di tengah transaksi.

### Langkah 10: Tulis Arsitektur Multi-Branch Ready

- Jelaskan bahwa `branch_id` adalah parameter pertama atau kedua di setiap fungsi service/data access.
- Jelaskan bahwa saat login, `branch_id` di-extract dari JWT dan diteruskan ke semua fungsi.
- Jelaskan bahwa tidak ada query yang boleh berjalan tanpa filter `branch_id`.

### Langkah 11: Tulis Matriks Modul vs Entitas Database

- Buat tabel yang memetakan 20 modul ke tabel-tabel database yang digunakan.
- Format: kolom Modul | Tabel Database Utama | Tabel Database Pendukung.

### Langkah 12: Tulis Standar Kode FP

- Rangkum semua aturan FP yang wajib ditaati dari Tech Stack Decision.
- Berikan contoh pola kode yang benar (pure function) dan yang salah (mutasi state, penggunaan class).

### Langkah 13: Tulis Riwayat Versi dan Referensi

- Tulis tabel Riwayat Versi (v1.0.0, tanggal, persona, keterangan).
- Tulis daftar Referensi Dokumen di bagian paling akhir.

### Langkah 14: Validasi Kelengkapan Dokumen

- Pastikan semua 11 bagian utama ada (Pendahuluan, Arsitektur Berlapis, Struktur Direktori, Alur Data, Koneksi DB, Keamanan, Error Handling, Multi-Branch, Matriks Modul-DB, Standar Kode FP, Referensi).
- Pastikan semua data dari referensi sudah terangkum lengkap tanpa ada yang terlewat.
- Pastikan tidak ada instruksi kerja atau komentar proses yang tertinggal.
- Pastikan bahasa Indonesia natural dan tidak ambigu.

### Langkah 15: Update Status di sdlc.txt

- Setelah dokumen selesai ditulis dan divalidasi, buka file `docs/sdlc/sdlc.txt`.
- Cari baris yang berisi `03_system_architecture.md` (baris 24).
- Ubah `status: [create_file]` menjadi `status: [done]`.
- Pastikan HANYA baris 24 yang berubah, tidak ada baris lain yang termodifikasi.

---

## Poin Tambahan Spesifik untuk System Architecture

Berikut poin tambahan yang relevan dan spesifik untuk dokumen arsitektur sistem ini:

1. **Strategi Entry Point Aplikasi**: Jelaskan bagaimana `main.py` berfungsi sebagai satu-satunya entry point, memuat konfigurasi `.env`, membuka koneksi database, dan memulai event loop CLI utama.

2. **Pola Komposisi Fungsi (Function Composition)**: Jelaskan bagaimana fungsi-fungsi kecil dikomposisikan menjadi alur bisnis yang lebih besar tanpa menggunakan inheritance atau polymorphism OOP. Misalnya, alur transaksi kasir adalah komposisi dari `validate_input() → check_pricing_tier() → calculate_hpp() → deduct_stock() → record_transaction() → log_audit()`.

3. **Strategi Konfigurasi Aplikasi**: Jelaskan bagaimana konfigurasi (kredensial DB, secret key JWT, parameter bisnis seperti threshold PIN) dikelola melalui `.env` dan diakses via `os.getenv()` secara fungsional.

4. **Pola State Passing (Bukan Global State)**: Tegaskan bahwa tidak ada penggunaan variabel global untuk menyimpan state. Semua state (koneksi DB, token JWT aktif, branch_id) diteruskan sebagai parameter fungsi secara eksplisit.

5. **Strategi Rendering Menu CLI**: Jelaskan bagaimana menu CLI dirender secara dinamis berdasarkan role dari JWT payload — menu yang tidak diizinkan untuk Karyawan tidak pernah di-render sama sekali (bukan hanya di-disable).

---

## Checklist Penerimaan (Definition of Done)

- [ ] File `docs/sdlc/03_design/03_system_architecture.md` berisi dokumen arsitektur lengkap
- [ ] Arsitektur berlapis terdefinisi dengan jelas (5 lapisan)
- [ ] Diagram arsitektur tersedia (Mermaid/ASCII)
- [ ] Struktur direktori proyek Python terdefinisi
- [ ] 20 modul fungsional terpetakan ke struktur direktori
- [ ] Minimal 3 alur data kritis terjelaskan
- [ ] Strategi koneksi database FP terjelaskan
- [ ] Arsitektur keamanan (JWT, RBAC, audit trail) terjelaskan
- [ ] 5 inovasi dari Innovation Proposal terintegrasi
- [ ] Strategi penanganan error terjelaskan
- [ ] Arsitektur Multi-Branch Ready terjelaskan
- [ ] Matriks pemetaan Modul vs Entitas Database tersedia
- [ ] Standar kode FP terangkum
- [ ] Metadata dokumen lengkap
- [ ] Bahasa Indonesia natural dan tidak ambigu
- [ ] Data kosong ditandai dengan `[PERLU DIISI MANUAL]`
- [ ] Referensi dokumen tercantum di akhir file
- [ ] Dokumen bersih tanpa instruksi kerja atau komentar proses
- [ ] Status di sdlc.txt berubah dari [create_file] ke [done]
