# Issue #0025: Pembuatan Dokumen ERD Database

## Metadata Issue

| Atribut             | Detail                                                             |
| ------------------- | ------------------------------------------------------------------ |
| **Nomor Issue**     | 0025                                                               |
| **Judul**           | Pembuatan Dokumen ERD Database                                     |
| **Target File**     | `docs/sdlc/03_design/02_erd_database.puml`                        |
| **Status File**     | [create_file]                                                      |
| **Folder Issue**    | `docs/sdlc/issue/issue_03_design/`                                 |
| **Dibuat Pada**     | 2026-05-14                                                         |
| **Dikerjakan Oleh** | Senior Database Architect & Senior Data Modeler (AI)               |

---

## 1. Deskripsi Tugas

Tugas ini bertujuan untuk menyusun dokumen utama `02_erd_database.puml` yang berada di dalam folder `docs/sdlc/03_design/`. Dokumen ini saat ini berstatus `[create_file]` dan harus menjadi file ERD (Entity Relationship Diagram) lengkap dalam format PlantUML yang memvisualisasikan seluruh 28 entitas data, atribut utama setiap entitas, relasi antar entitas (FOREIGN KEY), dan kardinalitas (One-to-One, One-to-Many, Many-to-One) untuk Sistem Manajemen Usaha Percetakan "AbuCom".

ERD ini adalah representasi visual langsung dari Database Schema (`01_database_schema.sql`) dan Data Dictionary (`05_data_dictionary.md`), serta menjadi acuan utama bagi dokumen desain lainnya di fase SDLC selanjutnya.

---

## 2. Persona Implementasi

Bertindaklah sebagai **Senior Database Architect** dan **Senior Data Modeler** yang memiliki keahlian mendalam dalam:
- Perancangan dan visualisasi model data relasional menggunakan PlantUML
- Pembacaan DDL SQL dan penerjemahan ke diagram ERD yang akurat
- Pemahaman kardinalitas relasi (One-to-One, One-to-Many, Many-to-One) dan notasi PlantUML
- Pengelompokan entitas secara logis (Master, Transaksi, Pendukung) untuk keterbacaan diagram
- Konvensi penamaan `snake_case` dan arsitektur Multi-Branch Ready

---

## 3. File Referensi Utama

Dalam pembuatan dokumen ini, Anda **DIWAJIBKAN** untuk merujuk pada file berikut sebagai sumber data dan informasi utama:

| No | File | Peran |
|----|------|-------|
| 1 | `docs/sdlc/03_design/01_database_schema.sql` | **REFERENSI UTAMA #1** — Implementasi DDL SQL lengkap 28 tabel dengan seluruh kolom, tipe data, constraints, FOREIGN KEY, ENUM, dan indeks. File ini adalah sumber kebenaran teknis untuk struktur tabel yang harus divisualisasikan. |
| 2 | `docs/sdlc/02_analysis/05_data_dictionary.md` | **REFERENSI UTAMA #2** — Berisi definisi lengkap 28 entitas beserta seluruh atribut, catatan relasi, dan kardinalitas di Bagian 5 (Ringkasan Relasi Antar Entitas / ERD Prep). Bagian 5 ini adalah sumber utama untuk menentukan garis relasi dan kardinalitas pada ERD. |

File `docs/sdlc/narasi.txt` **TIDAK diperlukan** untuk pembuatan ERD karena seluruh informasi struktural dan relasional sudah tercakup lengkap dalam Database Schema dan Data Dictionary.

---

## 4. Instruksi Kelayakan & Kriteria Dokumen Utama

Harap patuhi instruksi berikut secara ketat saat menyusun isi dari dokumen `02_erd_database.puml`:

### 4.1. Terjemahkan Seluruh 28 Entitas ke PlantUML Entity

Setiap tabel dari Database Schema harus divisualisasikan sebagai satu `entity` PlantUML. Pastikan:
- Nama entitas **identik** dengan nama tabel di SQL (snake_case)
- Setiap entitas menampilkan **seluruh kolom** beserta tipe datanya
- Kolom Primary Key ditandai dengan simbol `*` (asterisk) atau stereotip `<<PK>>`
- Kolom Foreign Key ditandai dengan stereotip `<<FK>>`
- Kolom yang memiliki constraint UNIQUE ditandai jika memungkinkan

### 4.2. Visualisasikan Seluruh Relasi Antar Entitas

Gunakan tabel kardinalitas dari Data Dictionary Bagian 5 (Ringkasan Relasi Antar Entitas) sebagai sumber utama. Daftar lengkap 39 relasi yang **WAJIB** ada:

**Relasi ke `branches` (16 relasi Many-to-One):**
1. `users` → `branches` via `branch_id` (Many-to-One)
2. `pricing_tiers` → `branches` via `branch_id` (Many-to-One)
3. `customers` → `branches` via `branch_id` (Many-to-One)
4. `vendors` → `branches` via `branch_id` (Many-to-One)
5. `employees` → `branches` via `branch_id` (Many-to-One)
6. `products_services` → `branches` via `branch_id` (Many-to-One)
7. `materials` → `branches` via `branch_id` (Many-to-One)
8. `ppob_accounts` → `branches` via `branch_id` (Many-to-One)
9. `assets` → `branches` via `branch_id` (Many-to-One)
10. `transactions` → `branches` via `branch_id` (Many-to-One)
11. `production_waste` → `branches` via `branch_id` (Many-to-One)
12. `cash_reconciliation` → `branches` via `branch_id` (Many-to-One)
13. `stock_opname` → `branches` via `branch_id` (Many-to-One)
14. `routine_expenses` → `branches` via `branch_id` (Many-to-One)
15. `loans` → `branches` via `branch_id` (Many-to-One)
16. `asset_savings` → `branches` via `branch_id` (Many-to-One)

**Relasi lainnya (23 relasi):**
17. `customers` → `pricing_tiers` via `pricing_tier_id` (Many-to-One)
18. `employees` → `users` via `user_id` (One-to-One, Optional)
19. `materials` → `vendors` via `vendor_id` (Many-to-One, Optional)
20. `transactions` → `users` via `user_id` (Many-to-One)
21. `transactions` → `customers` via `customer_id` (Many-to-One)
22. `transaction_items` → `transactions` via `transaction_id` (Many-to-One)
23. `transaction_items` → `products_services` via `product_id` (Many-to-One)
24. `payments` → `transactions` via `transaction_id` (Many-to-One)
25. `orders_job_tracking` → `transactions` via `transaction_id` (One-to-One)
26. `production_waste` → `materials` via `material_id` (Many-to-One)
27. `ppob_mutations` → `ppob_accounts` via `ppob_account_id` (Many-to-One)
28. `ppob_mutations` → `transactions` via `transaction_id` (Many-to-One, Optional)
29. `employee_attendance` → `employees` via `employee_id` (Many-to-One)
30. `employee_loans` → `employees` via `employee_id` (Many-to-One)
31. `payroll` → `employees` via `employee_id` (Many-to-One)
32. `cash_reconciliation` → `users` via `user_id` (Many-to-One)
33. `stock_opname` → `materials` via `material_id` (Many-to-One)
34. `bom` → `products_services` via `product_id` (Many-to-One)
35. `bom` → `materials` via `material_id` (Many-to-One)
36. `incentive_points` → `employees` via `employee_id` (Many-to-One)
37. `incentive_points` → `transactions` via `transaction_id` (Many-to-One, Optional)
38. `login_sessions` → `users` via `user_id` (Many-to-One)
39. `audit_trail` → `users` via `user_id` (Many-to-One)

### 4.3. Notasi Kardinalitas PlantUML

Gunakan notasi PlantUML yang benar untuk setiap jenis kardinalitas:
- **One-to-Many / Many-to-One**: `||--o{` atau `}o--||`
- **One-to-One (Wajib)**: `||--||`
- **One-to-One (Optional)**: `||--o|` atau `|o--||`
- **Many-to-One (Optional FK)**: `}o--o|` — gunakan notasi opsional pada sisi FK yang nullable

### 4.4. Pengelompokan Entitas Secara Logis

Kelompokkan entitas menggunakan `package` atau `rectangle` PlantUML agar diagram mudah dibaca:
- **Entitas Master (10 tabel)**: `branches`, `users`, `pricing_tiers`, `customers`, `vendors`, `employees`, `products_services`, `materials`, `ppob_accounts`, `assets`
- **Entitas Transaksi (11 tabel)**: `transactions`, `transaction_items`, `payments`, `orders_job_tracking`, `production_waste`, `ppob_mutations`, `employee_attendance`, `employee_loans`, `payroll`, `cash_reconciliation`, `stock_opname`
- **Entitas Pendukung (7 tabel)**: `bom`, `incentive_points`, `login_sessions`, `routine_expenses`, `loans`, `audit_trail`, `asset_savings`

### 4.5. Header dan Metadata File PlantUML

File harus diawali dengan blok komentar yang berisi:
- Nama proyek: "AbuCom — Sistem Manajemen Usaha Percetakan"
- Deskripsi: Entity Relationship Diagram (ERD) — Visualisasi Relasi Seluruh Entitas Database
- Versi: 1.0.0
- Status: [create_file]
- Database Target: MySQL 8.4 LTS Community Edition
- Total Entitas: 28 tabel
- Total Relasi: 39 relasi
- Tanggal Pembuatan: (tanggal pengerjaan)
- Persona: Senior Database Architect & Senior Data Modeler

### 4.6. Pengaturan Visual Diagram

- Gunakan directive `skinparam` untuk mengatur tampilan (font, warna, ukuran)
- Atur arah diagram (`left to right direction` atau `top to bottom direction`) — pilih yang menghasilkan layout paling rapi untuk 28 entitas
- Gunakan warna yang berbeda untuk setiap kelompok entitas (Master, Transaksi, Pendukung) agar mudah dibedakan secara visual
- Pastikan garis relasi tidak saling tumpang tindih sebisa mungkin

### 4.7. Kelayakan untuk Fase SDLC Selanjutnya

ERD ini harus layak dijadikan acuan oleh:
- `03_system_architecture.md` — untuk visualisasi lapisan data dan identifikasi modul
- `05_bom_hpp_design.md` — untuk memahami relasi antara `bom`, `materials`, `products_services`, dan `transaction_items`
- `06_security_design.md` — untuk memahami relasi `audit_trail`, `login_sessions`, dan `users`
- Fase Implementation — untuk panduan visual bagi developer dalam memahami struktur dan relasi database

### 4.8. Bahasa Indonesia untuk Komentar

Seluruh komentar di dalam file PlantUML (baris yang diawali `'` atau blok `/' ... '/`) ditulis dalam Bahasa Indonesia yang natural, tidak ambigu, dan mudah dipahami. Nama entitas dan kolom tetap dalam bahasa Inggris `snake_case`.

### 4.9. Referensi di Akhir File

Cantumkan daftar file referensi yang digunakan sebagai komentar PlantUML di bagian paling akhir file (sebelum `@enduml`).

### 4.10. Tandai Data yang Tidak Tersedia

Jika ditemukan informasi relasi atau kardinalitas yang tidak konsisten antara Database Schema dan Data Dictionary, tandai dengan komentar `' [PERLU VERIFIKASI MANUAL]` pada baris relasi tersebut agar bisa ditinjau secara manual.

---

## 5. Tahapan Implementasi Terperinci (Low-Level Execution Guide)

Ikuti langkah-langkah ini secara **berurutan tanpa deviasi**. Jangan melompat langkah.

---

### Langkah 1: Baca Semua Referensi Wajib Sampai Tuntas

1. Buka dan baca **seluruh isi** `docs/sdlc/03_design/01_database_schema.sql` dari baris pertama hingga baris terakhir. **Catat** seluruh 28 nama tabel, seluruh kolom beserta tipe datanya, seluruh FOREIGN KEY constraint (nama kolom FK, tabel tujuan, kolom tujuan), dan apakah FK tersebut nullable atau NOT NULL.
2. Buka dan baca **seluruh isi** `docs/sdlc/02_analysis/05_data_dictionary.md` dari baris pertama hingga baris terakhir. **Fokus khusus** pada:
   - Bagian 4 (Definisi Detail Entitas) — untuk daftar kolom dan catatan relasi setiap entitas
   - Bagian 5 (Ringkasan Relasi Antar Entitas / ERD Prep) — ini adalah **peta utama** untuk menggambar garis relasi dan kardinalitas
3. **JANGAN** mulai menulis PlantUML sebelum kedua file referensi selesai dibaca sepenuhnya.

---

### Langkah 2: Tulis Header File PlantUML

1. Buka file `docs/sdlc/03_design/02_erd_database.puml` (file ini sudah ada, **timpa seluruh isinya**).
2. Tulis `@startuml` di baris pertama.
3. Tulis blok komentar header setelah `@startuml` menggunakan format komentar PlantUML (`' komentar satu baris`). Header harus memuat: nama proyek, deskripsi file, versi (1.0.0), status ([create_file]), database target (MySQL 8.4 LTS), total entitas (28), total relasi (39), tanggal pembuatan, dan persona pembuat.

---

### Langkah 3: Tulis Konfigurasi Visual (skinparam)

Setelah header, tulis konfigurasi visual:

1. Tentukan arah diagram: `left to right direction` (direkomendasikan untuk 28 entitas agar diagram tidak terlalu panjang ke bawah).
2. Tulis `skinparam` untuk mengatur tampilan entity:
   - `skinparam linetype ortho` — garis relasi berbelok 90 derajat agar rapi
   - `skinparam entity` — atur font, border, dan background color
3. Definisikan warna untuk setiap kelompok entitas menggunakan variabel atau langsung pada package.

---

### Langkah 4: Tulis Definisi Entitas (28 Entitas)

Untuk setiap tabel dari Database Schema, tulis definisi `entity` PlantUML. Ikuti template berikut:

```plantuml
entity "nama_tabel" as nama_tabel {
  * id : INT <<PK>>
  --
  kolom1 : TIPE_DATA <<FK>>
  kolom2 : TIPE_DATA
  ...
}
```

**Aturan penulisan entitas:**
- Baris pertama setelah `{` adalah Primary Key, ditandai dengan `*` (asterisk)
- Gunakan pemisah `--` antara PK dan kolom lainnya
- Kolom Foreign Key ditandai dengan `<<FK>>`
- Kolom ENUM dituliskan tipe datanya sebagai `ENUM` (tidak perlu menuliskan nilai domain di diagram)
- Kolom nullable **TIDAK** diberi tanda `*`
- Kolom NOT NULL diberi tanda `*` (kecuali PK yang sudah ditandai)

**Urutan penulisan entitas harus sesuai kelompok:**

**4.1. Entitas Master (10 entitas) — tulis dalam package "Entitas Master":**
1. `branches` (6 kolom: id, branch_name, address, phone_number, is_active, created_at)
2. `users` (8 kolom: id, branch_id, username, password_hash, role, is_active, created_at, updated_at)
3. `pricing_tiers` (6 kolom: id, branch_id, tier_name, min_qty, min_active_months, description)
4. `customers` (6 kolom: id, branch_id, pricing_tier_id, full_name, whatsapp_number, registered_date)
5. `vendors` (7 kolom: id, branch_id, vendor_name, contact_person, phone_number, address, is_active)
6. `employees` (8 kolom: id, branch_id, user_id, full_name, position, salary_schema, base_salary, join_date)
7. `products_services` (8 kolom: id, branch_id, service_type, name, base_price, stock_quantity, unit_of_measure, is_active)
8. `materials` (8 kolom: id, branch_id, vendor_id, material_name, stock_quantity, unit_of_measure, cost_per_unit, min_stock_alert)
9. `ppob_accounts` (7 kolom: id, branch_id, platform_name, account_number, current_balance, min_balance, deposit_recommend)
10. `assets` (6 kolom: id, branch_id, asset_name, purchase_date, purchase_price, condition_status)

**4.2. Entitas Transaksi (11 entitas) — tulis dalam package "Entitas Transaksi":**
11. `transactions` (8 kolom: id, branch_id, user_id, customer_id, transaction_date, total_amount, total_hpp, payment_status)
12. `transaction_items` (7 kolom: id, transaction_id, product_id, quantity, unit_price, subtotal, item_hpp)
13. `payments` (5 kolom: id, transaction_id, payment_date, amount_paid, payment_type)
14. `orders_job_tracking` (5 kolom: id, transaction_id, status, design_file_path, updated_at)
15. `production_waste` (6 kolom: id, branch_id, material_id, waste_quantity, waste_reason, recorded_at)
16. `ppob_mutations` (7 kolom: id, ppob_account_id, transaction_id, mutation_type, amount, mutation_date, description)
17. `employee_attendance` (5 kolom: id, employee_id, check_in_time, check_out_time, work_date)
18. `employee_loans` (5 kolom: id, employee_id, loan_amount, remaining_amount, loan_date)
19. `payroll` (7 kolom: id, employee_id, period_month, base_payment, incentive_bonus, loan_deduction, net_salary, processed_at — total 8 kolom)
20. `cash_reconciliation` (7 kolom: id, branch_id, user_id, system_balance, physical_balance, difference, reconciled_at)
21. `stock_opname` (7 kolom: id, branch_id, material_id, system_qty, actual_qty, difference_qty, recorded_at)

**4.3. Entitas Pendukung (7 entitas) — tulis dalam package "Entitas Pendukung":**
22. `bom` (4 kolom: id, product_id, material_id, required_qty)
23. `incentive_points` (6 kolom: id, employee_id, transaction_id, point_category, earned_points, earned_date)
24. `login_sessions` (4 kolom: id, user_id, jwt_token, expires_at)
25. `routine_expenses` (5 kolom: id, branch_id, expense_name, amount, expense_date)
26. `loans` (6 kolom: id, branch_id, loan_source, loan_type, principal_amount, remaining_debt)
27. `audit_trail` (6 kolom: id, user_id, action_type, target_entity, change_detail, timestamp)
28. `asset_savings` (5 kolom: id, branch_id, account_name, balance, last_updated)

---

### Langkah 5: Tulis Definisi Relasi (39 Relasi)

Setelah semua entitas terdefinisi, tulis blok relasi. Gunakan notasi PlantUML:

**Notasi yang harus digunakan:**
- `||--o{` = One (wajib) to Many → contoh: `branches ||--o{ users` (satu branch memiliki banyak users)
- `||--||` = One-to-One (wajib) → contoh: `transactions ||--|| orders_job_tracking`
- `|o--||` = One-to-One (optional di sisi kiri) → contoh: `users |o--|| employees` (user_id nullable pada employees)
- `||--o{` dengan komentar optional → untuk FK nullable seperti `materials.vendor_id`

Untuk FK nullable/optional, gunakan notasi `o` (lingkaran kosong) pada sisi FK:
- `vendors ||--o{ materials` — vendor_id nullable, gunakan: `vendors |o--o{ materials`
- `transactions |o--o{ ppob_mutations` — transaction_id nullable
- `transactions |o--o{ incentive_points` — transaction_id nullable

Tulis setiap relasi dengan label nama kolom FK. Format:
```plantuml
branches ||--o{ users : "branch_id"
```

**Tulis semua 39 relasi sesuai daftar di Instruksi 4.2.**

---

### Langkah 6: Tulis Komentar Referensi dan Penutup

1. Sebelum `@enduml`, tulis blok komentar berisi daftar referensi dokumen:
   ```
   ' =================================================================
   ' REFERENSI DOKUMEN:
   ' 1. docs/sdlc/03_design/01_database_schema.sql (Referensi Utama #1)
   ' 2. docs/sdlc/02_analysis/05_data_dictionary.md (Referensi Utama #2)
   ' =================================================================
   ```
2. Tulis `@enduml` sebagai baris terakhir file.

---

### Langkah 7: Validasi Kelengkapan

Sebelum menyimpan, lakukan validasi berikut:

1. **Hitung jumlah entitas** — harus ada tepat **28 entitas** di dalam file.
2. **Hitung jumlah relasi** — harus ada tepat **39 relasi** sesuai tabel di Data Dictionary Bagian 5.
3. **Cocokkan nama setiap entitas** dengan nama tabel di Database Schema — harus identik.
4. **Cocokkan setiap kolom** pada entitas PlantUML dengan kolom di Database Schema — harus identik jumlah dan namanya.
5. **Cocokkan setiap relasi** dengan tabel Ringkasan Relasi di Data Dictionary Bagian 5 — harus identik entitas sumber, kolom FK, entitas tujuan, dan kardinalitas.
6. **Pastikan syntax PlantUML valid** — tidak ada tanda kurung yang tidak berpasangan, tidak ada keyword yang salah eja.

---

### Langkah 8: Validasi Kebersihan Output

1. Pastikan file hanya berisi kode PlantUML yang bersih dan valid.
2. Jangan tinggalkan instruksi kerja, checklist, atau komentar diskusi internal.
3. Komentar yang ada hanya berupa dokumentasi teknis (header, penjelasan kelompok, referensi).
4. File harus bisa langsung di-render oleh PlantUML tanpa error.

---

### Langkah 9: Update Status di sdlc.txt

Setelah dokumen selesai ditulis dan divalidasi:

1. Buka file `docs/sdlc/sdlc.txt`.
2. Cari baris yang berisi `02_erd_database.puml` (baris 23).
3. Ubah `status: [create_file]` menjadi `status: [done]`.
4. Pastikan **HANYA baris 23** yang berubah, tidak ada baris lain yang termodifikasi.

---

## 6. Poin Tambahan Spesifik untuk File ERD PlantUML

### 6.1. Konsistensi dengan Database Schema

ERD ini harus **100% konsisten** dengan file `01_database_schema.sql`. Jika ada perbedaan antara Database Schema dan Data Dictionary, **ikuti Database Schema** sebagai sumber kebenaran karena Database Schema sudah melewati proses validasi (Issue #0024).

### 6.2. Keterbacaan Diagram

Dengan 28 entitas dan 39 relasi, diagram akan cukup kompleks. Untuk menjaga keterbacaan:
- Posisikan `branches` di pusat atau bagian atas karena memiliki paling banyak relasi (16 relasi)
- Posisikan `transactions` dekat dengan `branches` karena memiliki banyak relasi turunan
- Gunakan `together { }` jika diperlukan untuk mengelompokkan entitas yang saling berhubungan erat

### 6.3. Tidak Perlu Menampilkan Nilai ENUM

Dalam ERD, cukup tuliskan tipe kolom sebagai `ENUM` tanpa merinci nilai domain. Detail nilai ENUM sudah terdokumentasi di Data Dictionary dan Database Schema.

### 6.4. Tidak Perlu Menampilkan Nilai Default

Dalam ERD, tidak perlu menuliskan nilai default kolom. ERD fokus pada struktur dan relasi, bukan detail implementasi.

---

## 7. Checklist Penerimaan (Definition of Done)

- [ ] File `docs/sdlc/03_design/02_erd_database.puml` berisi diagram ERD PlantUML lengkap
- [ ] Tepat 28 entitas sesuai Database Schema dan Data Dictionary
- [ ] Seluruh kolom pada setiap entitas sesuai dengan Database Schema
- [ ] Tepat 39 relasi sesuai tabel Ringkasan Relasi di Data Dictionary Bagian 5
- [ ] Kardinalitas setiap relasi akurat (Many-to-One, One-to-One, Optional)
- [ ] Entitas dikelompokkan dalam 3 package (Master, Transaksi, Pendukung)
- [ ] Header file memuat metadata lengkap
- [ ] Konfigurasi visual (skinparam) terdefinisi
- [ ] Komentar dalam Bahasa Indonesia yang natural dan tidak ambigu
- [ ] Referensi dokumen tercantum di akhir file
- [ ] Syntax PlantUML valid dan bisa di-render tanpa error
- [ ] Status di sdlc.txt baris 23 berubah dari [create_file] ke [done]
- [ ] File bersih dari instruksi kerja dan catatan non-teknis

---

## 8. Referensi Issue Sebelumnya

- Issue #0023 (`0023_issue_database_schema.md`) — Issue pembuatan awal file `01_database_schema.sql`
- Issue #0024 (`0024_issue_validasi_database_schema.md`) — Issue validasi file `01_database_schema.sql`
