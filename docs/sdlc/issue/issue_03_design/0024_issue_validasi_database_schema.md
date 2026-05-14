# Issue #0024: Validasi Dokumen Database Schema

## Metadata Issue

| Atribut          | Detail                                                          |
| ---------------- | --------------------------------------------------------------- |
| **Nomor Issue**  | 0024                                                            |
| **Judul**        | Validasi Dokumen Database Schema                                |
| **Target File**  | `docs/sdlc/03_design/01_database_schema.sql`                    |
| **Status File**  | [draft]                                                         |
| **Folder Issue** | `docs/sdlc/issue/issue_03_design/`                              |
| **Dibuat Pada**  | 2026-05-14                                                      |
| **Dikerjakan Oleh** | Senior Database Architect & Senior SQL Reviewer (AI)         |

---

## 1. Deskripsi Tugas

Tugas ini bertujuan untuk **memeriksa, menganalisa, dan memvalidasi secara ketat** dokumen utama `docs/sdlc/03_design/01_database_schema.sql` yang saat ini berstatus `[draft]`. Dokumen ini adalah DDL SQL lengkap (Data Definition Language) yang mendefinisikan seluruh skema basis data sistem manajemen percetakan **AbuCom**.

Validator wajib memastikan bahwa setiap tabel, kolom, tipe data, constraint, ENUM, dan FOREIGN KEY di dalam file SQL tersebut **100% akurat, konsisten, dan siap pakai** sebagai fondasi utama bagi seluruh fase SDLC selanjutnya (ERD, System Architecture, Security Design, dan fase Implementation).

---

## 2. Persona Implementasi

Bertindaklah sebagai **Senior Database Architect** sekaligus **Senior SQL Code Reviewer** dengan pengalaman mendalam dalam:
- Perancangan skema basis data relasional MySQL 8.4 LTS
- Audit dan validasi DDL SQL terhadap dokumen spesifikasi (Data Dictionary)
- Penerapan prinsip integritas referensial, normalisasi, dan keamanan data
- Penulisan dokumentasi teknis yang bersih, tepat, dan bebas ambiguitas
- Standar industri sistem informasi manajemen bisnis (ERP/POS)

Anda **tidak boleh berasumsi** — setiap perubahan atau koreksi harus memiliki dasar dari dokumen referensi yang disebutkan di bawah.

---

## 3. File Referensi Wajib

Baca **seluruh isi** file-file berikut sebelum memulai validasi. Jangan melewatkan satu pun:

| No | File | Peran |
|----|------|-------|
| 1 | `docs/sdlc/02_analysis/05_data_dictionary.md` | **REFERENSI UTAMA #1** — Sumber kebenaran tunggal untuk seluruh definisi tabel, kolom, tipe data, constraint, dan relasi. |
| 2 | `docs/sdlc/02_analysis/06_access_control_matrix.md` | **REFERENSI UTAMA #2** — Aturan keamanan: audit trail, RBAC, tabel sensitif (loans, asset_savings). |
| 3 | `docs/sdlc/02_analysis/01_business_requirements.md` | **REFERENSI PENDUKUNG** — Business Rules (BR-01 s.d BR-10) yang mempengaruhi constraint dan domain nilai. |
| 4 | `docs/sdlc/02_analysis/02_software_requirements.md` | **REFERENSI PENDUKUNG** — Spesifikasi teknis (MySQL 8.4, bcrypt, JWT 8 jam, paradigma FP). |
| 5 | `docs/sdlc/01_planning/04_tech_stack_decision.md` | **REFERENSI PENDUKUNG** — Keputusan teknologi: InnoDB, utf8mb4, Multi-Branch Ready. |
| 6 | `docs/sdlc/narasi.txt` | **REFERENSI KONTEKS** — Baca jika ada informasi bisnis yang tidak tercakup di referensi 1–5. |

---

## 4. Poin Validasi Wajib

Lakukan seluruh poin berikut secara berurutan. **Jangan melewatkan satu pun poin.**

---

### 4.1. Komparasi Mendalam SQL vs Data Dictionary

Untuk setiap tabel dari 28 entitas yang ada di Data Dictionary (`05_data_dictionary.md` Bagian 4), lakukan perbandingan **kolom per kolom** dengan implementasi SQL di `01_database_schema.sql`.

**Yang harus dicek untuk setiap tabel:**

- [ ] Nama tabel di SQL **identik** dengan nama entitas di Data Dictionary (case-sensitive, snake_case)
- [ ] Jumlah kolom di SQL **sama persis** dengan jumlah atribut di Data Dictionary — tidak ada yang hilang, tidak ada yang ditambah tanpa dasar
- [ ] Nama kolom di SQL **identik** dengan nama atribut di Data Dictionary
- [ ] Tipe data di SQL **identik** dengan tipe data di Data Dictionary (misal: `INT` bukan `BIGINT`, `DECIMAL(15,4)` bukan `FLOAT`, `VARCHAR(150)` bukan `VARCHAR(200)`)
- [ ] Constraint (`NOT NULL`, `UNIQUE`, `AUTO_INCREMENT`) di SQL **sesuai** dengan kolom Constraints di Data Dictionary
- [ ] Nilai Default di SQL **sesuai** dengan kolom Nilai Default di Data Dictionary — termasuk nilai numerik, `TRUE`, `CURRENT_TIMESTAMP`, `CURRENT_DATE`
- [ ] Komentar kolom (`COMMENT '...'`) di SQL **akurat** dan tidak menyesatkan

**Daftar 28 tabel yang harus dicek:**

Entitas Master (10): `branches`, `users`, `pricing_tiers`, `customers`, `vendors`, `employees`, `products_services`, `materials`, `ppob_accounts`, `assets`

Entitas Transaksi (11): `transactions`, `transaction_items`, `payments`, `orders_job_tracking`, `production_waste`, `ppob_mutations`, `employee_attendance`, `employee_loans`, `payroll`, `cash_reconciliation`, `stock_opname`

Entitas Pendukung (7): `bom`, `incentive_points`, `login_sessions`, `routine_expenses`, `loans`, `audit_trail`, `asset_savings`

---

### 4.2. Kelengkapan Data dan Informasi dari Referensi

Periksa apakah semua **catatan relasi** dan **catatan implementasi** di Data Dictionary sudah tercermin di SQL:

- [ ] Setiap `*Catatan Relasi*` di Data Dictionary sudah ada FOREIGN KEY constraint-nya di SQL
- [ ] `*Catatan Implementasi*` pada entitas `employee_attendance`, `employee_loans`, `payroll`, `incentive_points`, `asset_savings` sudah didokumentasikan sebagai komentar SQL pada tabel tersebut
- [ ] Aturan business rules dari `01_business_requirements.md` yang relevan dengan schema (misal: min_balance Rp 150.000, deposit_recommend Rp 500.000 pada `ppob_accounts`) sudah tercermin sebagai nilai DEFAULT yang benar
- [ ] Aturan keamanan dari `06_access_control_matrix.md` untuk tabel sensitif (`loans`, `asset_savings`) sudah didokumentasikan dalam komentar SQL

---

### 4.3. Relevansi dan Kebersihan Dokumen

Pastikan dokumen SQL ini **hanya berisi** data dan informasi yang memang dibutuhkan oleh sebuah file DDL SQL:

- [ ] File tidak mengandung instruksi kerja, checklist, atau catatan diskusi yang bukan bagian dari DDL
- [ ] Tidak ada tabel yang dibuat di luar daftar 28 entitas resmi di Data Dictionary
- [ ] Tidak ada kolom yang ditambahkan tanpa dasar dari referensi
- [ ] Komentar SQL murni bersifat dokumentasi teknis, bukan catatan pribadi atau catatan implementasi fungsional yang seharusnya berada di dokumen lain

---

### 4.4. Standar Struktur Dokumen SQL Industri

Pastikan file SQL mengikuti standar struktur dokumen DDL industri:

- [ ] **Header file** memuat: nama proyek, deskripsi, versi, status, database target, engine, charset, collation, tanggal, dan persona pembuat
- [ ] **Konvensi** terdokumentasi di komentar header: snake_case, DECIMAL(15,4), ENUM, soft-delete, Multi-Branch
- [ ] **Statement pembuka** lengkap: `DROP DATABASE IF EXISTS`, `CREATE DATABASE`, `USE`, `SET FOREIGN_KEY_CHECKS = 0`
- [ ] **Pemisah tabel** menggunakan format `-- ============================================` yang konsisten
- [ ] **Setiap tabel** diawali komentar blok berisi: nama tabel dan deskripsi entitas
- [ ] **Setiap kolom** memiliki `COMMENT '...'` yang informatif
- [ ] **Setiap tabel** memiliki `ENGINE=InnoDB`, `DEFAULT CHARSET=utf8mb4`, `COLLATE=utf8mb4_unicode_ci`, dan `COMMENT='...'`
- [ ] **Indeks tambahan** untuk kolom filter penting terdefinisi setelah semua CREATE TABLE
- [ ] **Statement penutup**: `SET FOREIGN_KEY_CHECKS = 1`
- [ ] **Referensi dokumen** tercantum sebagai komentar SQL di bagian akhir file
- [ ] **Catatan khusus** `audit_trail` (append-only, no DELETE) terdokumentasi
- [ ] **Catatan khusus** soft-delete via `is_active` terdokumentasi di header

---

### 4.5. Kelayakan sebagai Referensi Fase SDLC Selanjutnya

Periksa apakah schema ini **sudah cukup informatif dan lengkap** untuk dijadikan input oleh dokumen berikutnya:

- [ ] `02_erd_database.puml` — Apakah semua tabel dan FK sudah terdefinisi jelas sehingga ERD bisa dibuat tanpa pertanyaan tambahan?
- [ ] `03_system_architecture.md` — Apakah identitas modul data sudah terlihat jelas dari kelompok tabel?
- [ ] `05_bom_hpp_design.md` — Apakah tabel `bom`, `materials`, `transaction_items` sudah memiliki kolom yang cukup untuk kalkulasi HPP?
- [ ] `06_security_design.md` — Apakah tabel `audit_trail`, `login_sessions`, kolom `role` di `users` sudah terdefinisi dengan baik untuk desain keamanan?
- [ ] **Fase Implementation** — Apakah file SQL ini bisa langsung di-*source* ke MySQL 8.4 tanpa error (tidak ada dependensi FK yang hilang, tidak ada syntax error yang terlihat)?

---

### 4.6. Kualitas Bahasa Indonesia pada Komentar SQL

Periksa seluruh komentar SQL (header, komentar tabel, komentar kolom):

- [ ] Bahasa Indonesia yang digunakan **natural** dan tidak kaku
- [ ] Tidak ada kalimat yang **ambigu** atau bisa ditafsirkan lebih dari satu makna
- [ ] Tidak ada kalimat yang **membingungkan** — junior programmer atau AI lain harus langsung paham
- [ ] Deskripsi kolom **spesifik** dan menjelaskan fungsi kolom, bukan hanya mengulang nama kolom
- [ ] Tidak ada typo atau kesalahan ejaan dalam komentar Bahasa Indonesia
- [ ] Nama tabel dan kolom tetap dalam Bahasa Inggris `snake_case` (tidak dicampur)

---

### 4.7. Mencegah Interupsi pada Fase SDLC Selanjutnya

Pastikan kualitas dokumen ini **tidak akan menimbulkan pertanyaan atau hambatan** bagi tim yang mengerjakan fase berikutnya:

- [ ] Setiap ENUM sudah memiliki nilai domain yang **eksplisit dan lengkap** — tidak ada ENUM tanpa nilai
- [ ] Setiap FK sudah memiliki `ON DELETE` dan `ON UPDATE` yang **eksplisit** — tidak ada FK tanpa behavior
- [ ] Setiap kolom bertipe DECIMAL yang menyangkut finansial menggunakan `DECIMAL(15,4)` — tidak ada `FLOAT` atau `DOUBLE`
- [ ] Tabel `audit_trail` memiliki komentar yang jelas bahwa ia **append-only** (tidak boleh ada DELETE dari level aplikasi)
- [ ] Tabel sensitif (`loans`, `asset_savings`) memiliki komentar yang merujuk pada aturan akses `role Pemilik` saja
- [ ] Kolom `updated_at` pada tabel `users` memiliki `ON UPDATE CURRENT_TIMESTAMP` — pastikan ini ada

---

### 4.8. Periksa Data Kosong atau Placeholder

Cari dan isi semua data yang kosong, tidak tersedia, atau berupa placeholder:

- [ ] Pastikan tidak ada nilai kolom yang berisi teks seperti `[ISI_INI]`, `TODO`, `???`, `N/A`, atau string kosong di tempat yang seharusnya ada nilai
- [ ] Pastikan nilai DEFAULT numerik menggunakan format `DECIMAL(15,4)` yang benar: `0.0000` atau nilai spesifik seperti `150000.0000`, `500000.0000`
- [ ] Jika ditemukan kolom tanpa COMMENT, tambahkan komentar yang sesuai
- [ ] Pastikan nama database konsisten — cek apakah `DROP DATABASE` dan `CREATE DATABASE` menggunakan nama yang sama (`abucom_db` atau `abucom`) — pilih satu dan konsisten

---

### 4.9. Validasi Teknis Khusus SQL

Periksa poin-poin teknis SQL berikut secara cermat:

**ENUM Domain:**
Cocokkan domain nilai setiap ENUM dengan Data Dictionary. Domain yang benar:
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

**FOREIGN KEY Behavior:**
- FK ke `branches(id)`: wajib `ON DELETE RESTRICT ON UPDATE CASCADE`
- FK antar tabel transaksi (wajib/NOT NULL): wajib `ON DELETE RESTRICT ON UPDATE CASCADE`
- FK opsional (nullable): wajib `ON DELETE SET NULL ON UPDATE CASCADE`
- Contoh FK opsional: `materials.vendor_id`, `employees.user_id`, `ppob_mutations.transaction_id`, `incentive_points.transaction_id`

**Urutan CREATE TABLE:**
Pastikan tabel yang direferensikan oleh FK dibuat **sebelum** tabel yang mereferensinya. Urutan yang benar:
1. `branches` (tidak ada FK)
2. `users`, `pricing_tiers`, `vendors`, `products_services`, `ppob_accounts`, `assets`, `routine_expenses`, `loans`, `asset_savings`
3. `customers` (FK ke pricing_tiers), `employees` (FK ke users), `materials` (FK ke vendors)
4. `transactions` (FK ke customers, users, branches)
5. `transaction_items`, `payments`, `orders_job_tracking`, `production_waste`, `ppob_mutations`, `employee_attendance`, `employee_loans`, `payroll`, `cash_reconciliation`, `stock_opname`
6. `bom`, `incentive_points`, `login_sessions`, `audit_trail`

**Indeks Tambahan:**
Pastikan ada `CREATE INDEX` untuk kolom berikut:
- `transactions.transaction_date`
- `transactions.payment_status`
- `employee_attendance.work_date`
- `payroll.period_month`
- `audit_trail.timestamp`
- `orders_job_tracking.status`

---

## 5. Tahapan Implementasi Terperinci (Low-Level Execution Guide)

Ikuti langkah-langkah ini secara **berurutan tanpa deviasi**. Jangan melompat langkah.

---

### Langkah 1: Baca Semua File Referensi Terlebih Dahulu

1. Buka dan baca seluruh isi `docs/sdlc/02_analysis/05_data_dictionary.md` dari baris pertama hingga baris terakhir. **Catat** seluruh 28 entitas berikut setiap atribut, tipe data, constraint, nilai default, dan catatan relasi/implementasinya.
2. Buka dan baca seluruh isi `docs/sdlc/02_analysis/06_access_control_matrix.md`. **Catat** aturan audit trail (Bagian 10 jika ada) dan aturan tabel sensitif.
3. Buka dan baca bagian Business Rules dari `docs/sdlc/02_analysis/01_business_requirements.md`. **Catat** BR-01 s.d BR-10, terutama yang berkaitan dengan nilai angka (batas saldo, persentase bagi hasil, dll).
4. Buka dan baca bagian spesifikasi teknis dari `docs/sdlc/02_analysis/02_software_requirements.md`. **Catat** versi MySQL, algoritma hash, durasi JWT.
5. Buka dan baca bagian keputusan database dari `docs/sdlc/01_planning/04_tech_stack_decision.md`. **Catat** engine, charset, collation, dan strategi Multi-Branch.
6. Baca `docs/sdlc/narasi.txt` jika ada informasi bisnis yang belum terjawab oleh referensi 1–5.
7. **BARU SETELAH** semua referensi dibaca, buka file `docs/sdlc/03_design/01_database_schema.sql`.

---

### Langkah 2: Validasi Header dan Statement Pembuka

1. Baca baris 1 hingga baris terakhir header SQL (antara `-- =====` pertama dan kedua).
2. Periksa apakah header memuat: nama proyek, deskripsi, versi, status, database target, engine, charset, collation, tanggal, dan persona.
3. Periksa apakah komentar konvensi ada di bawah header (snake_case, DECIMAL(15,4), ENUM, soft-delete, Multi-Branch).
4. Periksa apakah statement pembuka ada dan berurutan: `DROP DATABASE IF EXISTS` → `CREATE DATABASE` → `USE` → `SET FOREIGN_KEY_CHECKS = 0`.
5. **Catat nama database** yang digunakan — harus **konsisten** di seluruh file. Jika ada inkonsistensi, **perbaiki** agar seragam.

---

### Langkah 3: Validasi Setiap Tabel (Lakukan untuk 28 Tabel)

Untuk **setiap tabel**, lakukan prosedur berikut:

**3a. Temukan definisi tabel di Data Dictionary.**
- Buka `05_data_dictionary.md`, cari entitas yang namanya sama dengan tabel SQL.
- Tulis down (atau ingat) daftar kolom beserta tipe data, constraint, dan nilai default-nya.

**3b. Bandingkan dengan implementasi SQL.**
- Buka `01_database_schema.sql`, cari blok `CREATE TABLE [nama_tabel]`.
- Cocokkan **setiap baris kolom** satu per satu dengan Data Dictionary.

**3c. Periksa poin berikut untuk setiap kolom:**
- Nama kolom identik? (huruf kecil, underscore, tidak ada typo)
- Tipe data identik? (INT/VARCHAR/TEXT/DATE/DATETIME/DECIMAL(15,4)/BOOLEAN/ENUM)
- Constraint sesuai? (NOT NULL/UNIQUE/AUTO_INCREMENT ada/tidak ada sesuai DD)
- Nilai DEFAULT sesuai? (termasuk format angka desimal, TRUE/FALSE, fungsi SQL)
- COMMENT ada dan informatif?

**3d. Periksa FOREIGN KEY constraint:**
- Apakah semua FK yang disebutkan di "Catatan Relasi" Data Dictionary sudah ada?
- Apakah nama constraint menggunakan format `fk_[nama_tabel]_[nama_referensi]`?
- Apakah kolom FK yang nullable menggunakan `ON DELETE SET NULL`?
- Apakah kolom FK yang NOT NULL menggunakan `ON DELETE RESTRICT`?
- Apakah semua FK menggunakan `ON UPDATE CASCADE`?

**3e. Periksa table options:**
- Apakah ada `ENGINE=InnoDB`?
- Apakah ada `DEFAULT CHARSET=utf8mb4`?
- Apakah ada `COLLATE=utf8mb4_unicode_ci`?
- Apakah ada `COMMENT='...'` di level tabel?

**3f. Catat semua perbedaan/kesalahan** yang ditemukan. Tandai dengan label [PERBAIKAN DIPERLUKAN].

---

### Langkah 4: Validasi Semua ENUM

Setelah semua tabel dicek, lakukan validasi khusus ENUM:

1. Buat daftar semua kolom ENUM di file SQL.
2. Untuk setiap ENUM, bandingkan domain nilainya dengan Data Dictionary.
3. Pastikan **ejaan nilai ENUM identik** termasuk huruf besar/kecil dan spasi (misal: `'Proses Desain'` bukan `'proses desain'` atau `'ProsesDdesain'`).
4. Perbaiki jika ada perbedaan.

---

### Langkah 5: Validasi Indeks Tambahan

1. Cari bagian `CREATE INDEX` di file SQL.
2. Pastikan ada 6 indeks wajib (lihat Bagian 4.9 poin Indeks Tambahan).
3. Jika ada indeks yang hilang, **tambahkan** menggunakan format: `CREATE INDEX idx_[nama_tabel]_[nama_kolom] ON [nama_tabel]([nama_kolom]);`

---

### Langkah 6: Validasi Statement Penutup dan Referensi

1. Pastikan `SET FOREIGN_KEY_CHECKS = 1;` ada di bagian akhir file sebelum referensi.
2. Pastikan blok referensi dokumen ada di paling akhir file, berisi daftar semua file yang digunakan.
3. Jika ada file referensi baru yang digunakan dalam proses validasi ini, **tambahkan** ke daftar referensi di akhir file SQL.

---

### Langkah 7: Lakukan Semua Perbaikan ke File SQL

Setelah seluruh validasi selesai dan semua masalah tercatat:

1. Buka file `docs/sdlc/03_design/01_database_schema.sql`.
2. Lakukan **setiap perbaikan yang ditemukan** langsung ke file tersebut.
3. **Jangan hanya mencatat temuan** — harus langsung diperbaiki di file SQL.
4. Setelah semua perbaikan dilakukan, ubah **versi dokumen** di header:
   - Dari: `-- Versi         : 1.0.0`
   - Ke: `-- Versi         : 1.1.0`
5. Ubah **status dokumen** di header tetap `[draft]` — jangan ubah status, biarkan seperti semula karena status akan diubah pada tahapan SDLC berikutnya.

---

### Langkah 8: Update Status di sdlc.txt

Setelah semua perbaikan selesai dilakukan dan file SQL telah disimpan:

1. Buka file `docs/sdlc/sdlc.txt`.
2. Cari baris yang berisi `01_database_schema.sql` (baris 22).
3. Ubah `status: [draft]` menjadi `status: [check]`.
4. Pastikan **HANYA baris 22** yang berubah. Tidak ada baris lain yang dimodifikasi.
5. Simpan file `sdlc.txt`.

---

## 6. Poin Tambahan Spesifik untuk File DDL SQL

Poin berikut bersifat khusus karena dokumen ini adalah file SQL, bukan Markdown:

### 6.1. Validasi Sintaks SQL Dasar
- [ ] Setiap statement diakhiri dengan titik koma (`;`)
- [ ] Tidak ada tanda kutip yang tidak berpasangan
- [ ] Nilai ENUM menggunakan tanda kutip tunggal (`'`) bukan ganda (`"`)
- [ ] Nama kolom dan tabel tidak menggunakan reserved words MySQL tanpa backtick

### 6.2. Validasi Urutan Dependensi FK
- [ ] Tidak ada CREATE TABLE yang mereferensi tabel yang belum dibuat di atasnya
- [ ] `SET FOREIGN_KEY_CHECKS = 0` sudah ada di awal agar tidak error saat eksekusi berurutan

### 6.3. Konsistensi Nama Database
- [ ] `DROP DATABASE IF EXISTS` dan `CREATE DATABASE` menggunakan nama yang **sama persis**
- [ ] `USE [nama_database]` menggunakan nama yang **sama persis**
- [ ] Pilih salah satu: `abucom` atau `abucom_db` — gunakan secara konsisten di seluruh file

### 6.4. Kelayakan Eksekusi
- [ ] File dapat di-*source* langsung ke MySQL 8.4 tanpa modifikasi manual
- [ ] Tidak ada baris yang menggantung (incomplete statement)
- [ ] Tidak ada komentar yang memotong statement SQL

---

## 7. Checklist Penerimaan (Definition of Done)

Validasi dianggap **selesai** dan dokumen dianggap **layak** jika seluruh item berikut terpenuhi:

- [ ] Semua 28 tabel tervalidasi kolom per kolom terhadap Data Dictionary
- [ ] Tidak ada perbedaan antara SQL dan Data Dictionary yang belum diperbaiki
- [ ] Semua ENUM memiliki domain nilai yang identik dengan Data Dictionary
- [ ] Semua FOREIGN KEY memiliki `ON DELETE` dan `ON UPDATE` yang tepat
- [ ] Semua 6 indeks tambahan wajib ada
- [ ] Header file memuat metadata lengkap
- [ ] Komentar SQL seluruhnya dalam Bahasa Indonesia yang natural dan tidak ambigu
- [ ] Catatan khusus `audit_trail` (append-only) terdokumentasi
- [ ] Catatan khusus tabel sensitif (`loans`, `asset_savings`) terdokumentasi
- [ ] Catatan implementasi dari Data Dictionary tercermin sebagai komentar SQL
- [ ] Nama database konsisten di seluruh file
- [ ] Versi dokumen di header sudah diubah menjadi `1.1.0`
- [ ] Referensi dokumen lengkap di bagian akhir file SQL
- [ ] Status di `sdlc.txt` baris 22 berubah dari `[draft]` menjadi `[check]`
- [ ] File SQL bersih dan siap dieksekusi langsung di MySQL 8.4 LTS tanpa error

---

## 8. Referensi Issue Sebelumnya

- Issue #0023 (`0023_issue_database_schema.md`) — Issue pembuatan awal file `01_database_schema.sql`
