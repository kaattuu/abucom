# Issue #0023: Pembuatan Dokumen Database Schema

## Deskripsi Tugas
Tugas ini bertujuan untuk menyusun dokumen utama `01_database_schema.sql` yang berada di dalam folder `docs/sdlc/03_design/`. Dokumen ini saat ini berstatus `[create_file]` dan harus menjadi file DDL (Data Definition Language) SQL lengkap yang mendefinisikan seluruh struktur tabel, kolom, tipe data, constraints (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, DEFAULT), indeks, dan relasi antar tabel untuk Sistem Manajemen Usaha Percetakan "AbuCom". Database schema ini adalah implementasi teknis langsung dari Data Dictionary dan menjadi fondasi utama bagi seluruh modul aplikasi.

## Persona Implementasi
Bertindaklah sebagai **Senior Database Architect** dan **Senior Backend Engineer** yang memiliki keahlian mendalam dalam perancangan skema basis data relasional MySQL 8.4 LTS. Anda menguasai penulisan DDL SQL yang bersih, terstruktur, mengikuti best practices industri, memahami normalisasi data, integritas referensial (FOREIGN KEY constraints), penggunaan ENUM untuk domain nilai terbatas, presisi desimal tinggi untuk data finansial, serta konvensi penamaan `snake_case`. Anda juga memahami arsitektur Multi-Branch Ready dan paradigma Functional Programming yang menjadi landasan proyek ini.

## File Referensi Utama
Dalam pembuatan dokumen ini, Anda **DIWAJIBKAN** untuk merujuk pada file berikut sebagai sumber data dan informasi utama:

1. `docs/sdlc/02_analysis/05_data_dictionary.md` — **REFERENSI UTAMA #1**: Berisi definisi lengkap 28 entitas data beserta seluruh atribut, tipe data, constraints, nilai default, deskripsi, dan catatan relasi. File ini adalah sumber kebenaran tunggal (single source of truth) untuk struktur tabel.
2. `docs/sdlc/02_analysis/06_access_control_matrix.md` — **REFERENSI UTAMA #2**: Berisi aturan audit trail triggers, klasifikasi data sensitif, dan aturan keamanan arsitektur yang harus dipertimbangkan dalam desain schema (misal: kolom `role` pada `users`, pembatasan akses tabel `loans` dan `asset_savings`).
3. `docs/sdlc/02_analysis/01_business_requirements.md` — **REFERENSI PENDUKUNG**: Berisi aturan bisnis (BR-01 s.d BR-10) yang mempengaruhi constraint dan domain nilai (misal: DP minimal 50%, saldo minimum PPOB Rp 150.000, batas target gaji Rp 15.000.000).
4. `docs/sdlc/02_analysis/02_software_requirements.md` — **REFERENSI PENDUKUNG**: Berisi spesifikasi teknis (MySQL 8.4 LTS, bcrypt rounds=12, JWT exp 8 jam, paradigma FP) dan kebutuhan fungsional (F-01 s.d F-09) yang mempengaruhi desain tabel.
5. `docs/sdlc/01_planning/04_tech_stack_decision.md` — **REFERENSI PENDUKUNG**: Berisi keputusan teknologi (MySQL 8.4 LTS Community Edition, engine InnoDB, charset utf8mb4) dan aturan arsitektur Multi-Branch Ready (`branch_id` di setiap tabel utama).

File `docs/sdlc/narasi.txt` **TIDAK diperlukan** untuk pembuatan database schema karena seluruh informasi yang dibutuhkan sudah tercakup lengkap dalam Data Dictionary dan dokumen referensi pendukung di atas.

## Instruksi Kelayakan & Kriteria Dokumen Utama

Harap patuhi instruksi berikut secara ketat saat menyusun isi dari dokumen `01_database_schema.sql`:

1. **Terjemahkan Data Dictionary ke DDL SQL Secara Presisi**: Setiap entitas pada Data Dictionary harus diterjemahkan menjadi satu statement `CREATE TABLE` yang lengkap. Pastikan nama tabel, nama kolom, tipe data, constraints, dan nilai default **100% konsisten** dengan definisi di Data Dictionary. Jangan mengubah, menambah, atau mengurangi kolom tanpa dasar dari referensi.

2. **Gunakan Standar MySQL 8.4 LTS**: Semua syntax DDL harus valid untuk MySQL 8.4 LTS Community Edition. Gunakan engine `InnoDB` untuk semua tabel (mendukung transaksi ACID dan FOREIGN KEY). Gunakan charset `utf8mb4` dan collation `utf8mb4_unicode_ci` untuk mendukung karakter Unicode lengkap.

3. **Urutan Pembuatan Tabel Berdasarkan Dependensi**: Tabel harus dibuat dalam urutan yang menghormati dependensi FOREIGN KEY. Tabel yang direferensi oleh tabel lain harus dibuat terlebih dahulu. Urutan yang benar berdasarkan Data Dictionary:
   - **Grup 1 (Tanpa dependensi FK)**: `branches`
   - **Grup 2 (Dependensi ke branches)**: `users`, `pricing_tiers`, `vendors`, `products_services`, `materials` (tanpa vendor_id dulu), `ppob_accounts`, `assets`, `routine_expenses`, `loans`, `asset_savings`
   - **Grup 3 (Dependensi ke Grup 2)**: `customers` (ke pricing_tiers), `employees` (ke users), `materials` (update FK vendor_id ke vendors), `transactions` (ke users, customers)
   - **Grup 4 (Dependensi ke Grup 3)**: `transaction_items`, `payments`, `orders_job_tracking`, `production_waste`, `ppob_mutations`, `employee_attendance`, `employee_loans`, `payroll`, `cash_reconciliation`, `stock_opname`, `bom`, `incentive_points`, `login_sessions`, `audit_trail`
   - Pastikan tidak ada error `Cannot add foreign key constraint` karena urutan pembuatan yang salah.

4. **Arsitektur Multi-Branch Ready**: Setiap tabel yang memiliki `branch_id` pada Data Dictionary HARUS menyertakan kolom `branch_id INT NOT NULL` dengan FOREIGN KEY ke `branches(id)`. Ini adalah persyaratan arsitektur mutlak.

5. **Presisi Desimal untuk Data Finansial dan Kuantitas**: Semua kolom yang menyangkut uang, kuantitas stok, dimensi, volume, dan perhitungan HPP HARUS menggunakan `DECIMAL(15,4)` sesuai konvensi Data Dictionary. Jangan gunakan `FLOAT` atau `DOUBLE`.

6. **ENUM dengan Domain Nilai Eksplisit**: Setiap kolom ENUM harus mencantumkan domain nilai yang persis sama dengan yang didefinisikan di Data Dictionary. Daftar ENUM yang harus ada:
   - `users.role`: `ENUM('Pemilik', 'Karyawan')`
   - `pricing_tiers.tier_name`: `ENUM('Retail', 'Grosir', 'Mitra')`
   - `products_services.service_type`: `ENUM('Percetakan', 'ATK', 'PPOB', 'Jasa Keuangan', 'Jasa Teknis')`
   - `employees.salary_schema`: `ENUM('Tetap', 'Persentase')`
   - `ppob_accounts.platform_name`: `ENUM('Mandiri', 'Dana', 'Gopay', 'OVO', 'LinkAja', 'ShopeePay')`
   - `assets.condition_status`: `ENUM('Normal', 'Rusak', 'Perbaikan')`
   - `transactions.payment_status`: `ENUM('Belum Bayar', 'DP', 'Lunas', 'Refund', 'Dibatalkan')`
   - `payments.payment_type`: `ENUM('DP', 'Lunas', 'Refund')`
   - `orders_job_tracking.status`: `ENUM('Antri', 'Proses Desain', 'Produksi', 'Selesai', 'Diambil', 'Dibatalkan')`
   - `ppob_mutations.mutation_type`: `ENUM('Kredit', 'Debit')`
   - `incentive_points.point_category`: `ENUM('Rutin', 'Dasar', 'Kustom', 'Teknis Berat')`
   - `loans.loan_type`: `ENUM('Tanpa Bunga', 'Berbunga')`
   - `audit_trail.action_type`: `ENUM('INSERT', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT')`

7. **Komentar SQL yang Informatif**: Setiap `CREATE TABLE` harus diawali dengan komentar SQL yang menjelaskan deskripsi entitas sesuai Data Dictionary. Gunakan format `-- ============================================` sebagai pemisah antar tabel agar mudah dibaca.

8. **Indeks untuk Performa Query**: Tambahkan indeks pada kolom yang sering digunakan untuk filtering dan joining:
   - Semua kolom `branch_id` (sudah ter-cover oleh FK index)
   - `transactions.transaction_date` — untuk filtering laporan per periode
   - `transactions.payment_status` — untuk filtering status pembayaran
   - `employee_attendance.work_date` — untuk filtering per tanggal kerja
   - `payroll.period_month` — untuk filtering per periode gaji
   - `audit_trail.timestamp` — untuk filtering log per waktu
   - `orders_job_tracking.status` — untuk filtering status pesanan

9. **Header File SQL**: File harus diawali dengan header komentar yang berisi: nama proyek, deskripsi file, versi database target (MySQL 8.4 LTS), charset (utf8mb4), engine (InnoDB), tanggal pembuatan, dan persona pembuat.

10. **Statement Pembuka**: Setelah header, sertakan statement `DROP DATABASE IF EXISTS` dan `CREATE DATABASE` dengan charset `utf8mb4`, diikuti `USE [nama_database]`, dan `SET FOREIGN_KEY_CHECKS = 0` di awal serta `SET FOREIGN_KEY_CHECKS = 1` di akhir file untuk menghindari error urutan FK saat eksekusi.

11. **Kelayakan untuk Fase SDLC Selanjutnya**: Schema ini harus layak dijadikan acuan oleh:
    - `02_erd_database.puml` — untuk visualisasi relasi antar tabel
    - `03_system_architecture.md` — untuk identifikasi modul data
    - `05_bom_hpp_design.md` — untuk struktur tabel BOM dan materials
    - `06_security_design.md` — untuk implementasi RBAC dan audit trail
    - Fase Implementation — untuk langsung dieksekusi sebagai DDL di MySQL server

12. **Bahasa Indonesia untuk Komentar**: Seluruh komentar SQL ditulis dalam Bahasa Indonesia yang natural, tidak ambigu, dan mudah dipahami. Nama tabel dan kolom tetap dalam bahasa Inggris `snake_case`.

13. **Referensi di Akhir File**: Cantumkan daftar file referensi yang digunakan sebagai komentar SQL di bagian paling akhir file.

14. **Aturan Khusus — Tabel `audit_trail`**: Tabel ini TIDAK boleh memiliki operasi DELETE dari level aplikasi. Data audit trail bersifat append-only (INSERT only). Hal ini harus didokumentasikan sebagai komentar pada tabel tersebut.

15. **Aturan Khusus — Soft Delete**: Tabel yang memiliki kolom `is_active` (seperti `branches`, `users`, `vendors`, `products_services`) menggunakan pola soft-delete. Tidak ada `DELETE` fisik, melainkan `UPDATE is_active = FALSE`. Dokumentasikan pola ini di komentar header.

16. **Aturan Khusus — Integritas Referensial**: Tentukan behavior `ON DELETE` dan `ON UPDATE` pada setiap FOREIGN KEY constraint:
    - Untuk FK ke `branches`: gunakan `ON DELETE RESTRICT ON UPDATE CASCADE` (cabang tidak boleh dihapus jika masih ada data terkait)
    - Untuk FK antar tabel transaksi: gunakan `ON DELETE RESTRICT ON UPDATE CASCADE`
    - Untuk FK opsional (nullable): gunakan `ON DELETE SET NULL ON UPDATE CASCADE`

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)

Anggap panduan ini akan dibaca oleh junior programmer atau AI model yang lebih murah dan akan langsung mengimplementasikan file target. Lakukan langkah-langkah berikut secara berurutan tanpa deviasi:

### Langkah 1: Baca Semua Referensi Wajib Sampai Tuntas
- Baca keseluruhan isi `docs/sdlc/02_analysis/05_data_dictionary.md` — ini adalah sumber utama. Catat semua 28 entitas, setiap atribut, tipe data, constraints, nilai default, dan catatan relasi.
- Baca keseluruhan isi `docs/sdlc/02_analysis/06_access_control_matrix.md` — catat aturan audit trail (Bagian 10) dan aturan keamanan tambahan (Bagian 11).
- Baca bagian yang relevan dari `docs/sdlc/02_analysis/01_business_requirements.md` — fokus pada Bagian 5 (Business Rules BR-01 s.d BR-10).
- Baca bagian yang relevan dari `docs/sdlc/02_analysis/02_software_requirements.md` — fokus pada spesifikasi teknis (MySQL 8.4, bcrypt, JWT) dan kebutuhan fungsional.
- Baca bagian yang relevan dari `docs/sdlc/01_planning/04_tech_stack_decision.md` — fokus pada keputusan database (Bagian 5.3) dan strategi Multi-Branch (Bagian 5.10).
- **JANGAN** mulai menulis SQL sebelum semua file referensi selesai dibaca.

### Langkah 2: Tulis Header File SQL
- Tulis blok komentar header di baris paling atas file `docs/sdlc/03_design/01_database_schema.sql`.
- Header harus memuat: nama proyek ("AbuCom — Sistem Manajemen Usaha Percetakan"), deskripsi file, versi (1.0.0), status ([create_file]), database target (MySQL 8.4 LTS Community Edition), engine (InnoDB), charset (utf8mb4), collation (utf8mb4_unicode_ci), tanggal pembuatan, dan persona pembuat (Senior Database Architect).
- Setelah header, tulis komentar pendek mengenai konvensi yang digunakan: penamaan snake_case, DECIMAL(15,4) untuk finansial, ENUM untuk domain nilai terbatas, soft-delete via is_active, dan arsitektur Multi-Branch Ready via branch_id.

### Langkah 3: Tulis Statement Pembuka Database
- Tulis `DROP DATABASE IF EXISTS abucom;`
- Tulis `CREATE DATABASE abucom CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`
- Tulis `USE abucom;`
- Tulis `SET FOREIGN_KEY_CHECKS = 0;` (agar urutan CREATE TABLE tidak menyebabkan error FK)

### Langkah 4: Tulis CREATE TABLE untuk 28 Entitas
Untuk setiap entitas dari Data Dictionary (Bagian 4), tulis statement `CREATE TABLE` dengan urutan berikut. Ikuti persis definisi atribut dari tabel di Data Dictionary:

**4.1 Entitas Master (10 tabel):**
1. `branches` — Tabel pertama karena hampir semua tabel lain mereferensi ini
2. `users` — FK ke branches
3. `pricing_tiers` — FK ke branches
4. `customers` — FK ke branches dan pricing_tiers
5. `vendors` — FK ke branches
6. `employees` — FK ke branches dan users
7. `products_services` — FK ke branches
8. `materials` — FK ke branches dan vendors
9. `ppob_accounts` — FK ke branches
10. `assets` — FK ke branches

**4.2 Entitas Transaksi (11 tabel):**
11. `transactions` — FK ke branches, users, customers
12. `transaction_items` — FK ke transactions, products_services
13. `payments` — FK ke transactions
14. `orders_job_tracking` — FK ke transactions (UNIQUE constraint)
15. `production_waste` — FK ke branches, materials
16. `ppob_mutations` — FK ke ppob_accounts, transactions (opsional)
17. `employee_attendance` — FK ke employees
18. `employee_loans` — FK ke employees
19. `payroll` — FK ke employees
20. `cash_reconciliation` — FK ke branches, users
21. `stock_opname` — FK ke branches, materials

**4.3 Entitas Pendukung (7 tabel):**
22. `bom` — FK ke products_services, materials
23. `incentive_points` — FK ke employees, transactions (opsional)
24. `login_sessions` — FK ke users
25. `routine_expenses` — FK ke branches
26. `loans` — FK ke branches
27. `audit_trail` — FK ke users (append-only, komentar khusus)
28. `asset_savings` — FK ke branches

Untuk setiap tabel, ikuti template berikut:
```sql
-- ============================================
-- Tabel: [nama_tabel]
-- Deskripsi: [salin deskripsi entitas dari Data Dictionary]
-- ============================================
CREATE TABLE [nama_tabel] (
    [kolom1] [tipe_data] [constraints] [default] COMMENT '[deskripsi dari Data Dictionary]',
    [kolom2] ...
    ...
    PRIMARY KEY (id),
    [FOREIGN KEY constraints dengan ON DELETE/ON UPDATE]
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='[deskripsi singkat tabel]';
```

### Langkah 5: Tulis Indeks Tambahan
- Setelah semua CREATE TABLE selesai, tulis statement `CREATE INDEX` untuk kolom-kolom yang sering digunakan untuk filtering (lihat poin 8 di Instruksi Kelayakan).
- Format: `CREATE INDEX idx_[nama_tabel]_[nama_kolom] ON [nama_tabel]([nama_kolom]);`

### Langkah 6: Tulis Statement Penutup
- Tulis `SET FOREIGN_KEY_CHECKS = 1;`
- Tulis blok komentar penutup berisi daftar referensi dokumen yang digunakan.

### Langkah 7: Validasi Kelengkapan Tabel
- Hitung jumlah statement `CREATE TABLE` — harus ada tepat **28 tabel**.
- Cocokkan nama setiap tabel dengan daftar entitas di Data Dictionary Bagian 3.
- Pastikan tidak ada tabel yang terlewat atau ditambahkan tanpa dasar.

### Langkah 8: Validasi Konsistensi dengan Data Dictionary
- Untuk setiap tabel, bandingkan kolom per kolom dengan tabel definisi atribut di Data Dictionary.
- Pastikan nama kolom, tipe data, constraints, dan nilai default **identik** dengan Data Dictionary.
- Jika ada perbedaan, ikuti Data Dictionary sebagai sumber kebenaran.

### Langkah 9: Validasi FOREIGN KEY
- Pastikan setiap FK merujuk ke tabel dan kolom yang benar sesuai "Catatan Relasi" di Data Dictionary.
- Pastikan setiap FK yang nullable (opsional) menggunakan `ON DELETE SET NULL`.
- Pastikan setiap FK yang wajib menggunakan `ON DELETE RESTRICT`.
- Cocokkan dengan Ringkasan Relasi Antar Entitas (Data Dictionary Bagian 5).

### Langkah 10: Validasi ENUM
- Cocokkan setiap domain nilai ENUM di SQL dengan definisi di Data Dictionary.
- Pastikan ejaan dan urutan nilai ENUM identik.

### Langkah 11: Validasi Syntax SQL
- Pastikan setiap statement diakhiri dengan titik koma (`;`).
- Pastikan tidak ada typo pada keyword SQL (CREATE, TABLE, INT, VARCHAR, dll).
- Pastikan semua string ENUM menggunakan tanda kutip tunggal (`'`).
- Pastikan komentar inline menggunakan `COMMENT '...'` pada setiap kolom.

### Langkah 12: Validasi Kebersihan Output
- Pastikan file hanya berisi DDL SQL yang bersih dan siap dieksekusi.
- Jangan tinggalkan instruksi kerja, checklist, atau komentar diskusi internal.
- File harus bisa langsung di-*source* ke MySQL server tanpa error.

### Langkah 13: Update Status di sdlc.txt
- Setelah dokumen selesai ditulis dan divalidasi, buka file `docs/sdlc/sdlc.txt`.
- Cari baris yang berisi `01_database_schema.sql` (baris 22).
- Ubah `status: [create_file]` menjadi `status: [done]`.
- Pastikan HANYA baris 22 yang berubah, tidak ada baris lain yang termodifikasi.

---

## Checklist Penerimaan (Definition of Done)
- [ ] File `docs/sdlc/03_design/01_database_schema.sql` berisi DDL SQL lengkap
- [ ] Tepat 28 tabel sesuai Data Dictionary
- [ ] Semua kolom, tipe data, constraints, dan default sesuai Data Dictionary
- [ ] Semua FOREIGN KEY terdefinisi dengan ON DELETE/ON UPDATE yang tepat
- [ ] Semua ENUM memiliki domain nilai yang tepat
- [ ] Indeks tambahan untuk kolom yang sering difilter
- [ ] Header file dengan metadata lengkap
- [ ] Komentar SQL deskriptif dalam Bahasa Indonesia
- [ ] Engine InnoDB, charset utf8mb4, collation utf8mb4_unicode_ci
- [ ] Referensi dokumen tercantum di akhir file
- [ ] Status di sdlc.txt berubah dari [create_file] ke [done]
- [ ] File SQL bersih, siap dieksekusi tanpa error di MySQL 8.4 LTS
