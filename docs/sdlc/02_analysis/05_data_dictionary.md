# Data Dictionary — Sistem Manajemen Usaha Percetakan "AbuCom"

## Metadata Dokumen

| Atribut              | Detail                                                  |
| -------------------- | ------------------------------------------------------- |
| **Versi**            | 1.1.0                                                   |
| **Status**           | [finish]                                                |
| **Tanggal Dibuat**   | 2026-05-14                                              |
| **Disusun Oleh**     | Senior Data Analyst & Senior Database Architect (AI)    |

---

## 1. Pendahuluan

Dokumen Data Dictionary ini berfungsi sebagai acuan utama yang mendefinisikan struktur, tipe data, dan relasi dari setiap entitas data yang digunakan dalam operasional "AbuCom". Dokumen ini dirancang khusus untuk memenuhi standar pengembangan sistem dan memfasilitasi kebutuhan perancangan *database schema*, ERD, serta dokumen teknis turunan lainnya. Seluruh entitas didesain untuk siap mendukung arsitektur *Multi-Branch*.

## 2. Konvensi Penamaan dan Tipe Data

- **Penamaan Tabel dan Kolom:** Semua entitas dan atribut menggunakan konvensi bahasa Inggris dalam format `snake_case`.
- **Tipe Data Kuantitas dan Finansial:** Menggunakan `DECIMAL(15,4)` untuk perhitungan akurat (stok dimensi/volume/lembar, harga, HPP, dsb).
- **Primary Key:** `id` menggunakan `INT` atau `BIGINT` `AUTO_INCREMENT`.
- **Foreign Key:** Dinamakan sesuai tabel referensinya, misal `branch_id` merujuk ke tabel `branches`.
- **Tipe Karakter:** `VARCHAR` dengan variasi panjang sesuai kebutuhan data atau `TEXT` untuk deskripsi panjang.
- **Waktu:** `DATETIME` untuk pencatatan waktu transaksi dan log (seperti `created_at` dan `updated_at`).
- **Domain Nilai Spesifik:** Direpresentasikan dengan `ENUM` untuk mengikat data pada domain nilai yang terbatas dan valid.

---

## 3. Daftar Entitas Data

1. **Entitas Master:** `branches`, `users`, `customers`, `pricing_tiers`, `vendors`, `employees`, `products_services`, `materials`, `ppob_accounts`, `assets`
2. **Entitas Transaksi:** `transactions`, `transaction_items`, `payments`, `orders_job_tracking`, `production_waste`, `ppob_mutations`, `employee_attendance`, `employee_loans`, `payroll`, `cash_reconciliation`, `stock_opname`
3. **Entitas Pendukung:** `bom`, `incentive_points`, `login_sessions`, `routine_expenses`, `loans`, `audit_trail, `asset_savings``

---

## 4. Definisi Detail Entitas

### 4.1. Entitas Master

#### 1. `branches`
**Deskripsi Entitas**: Menyimpan informasi unit cabang usaha percetakan.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_name` | `VARCHAR(100)` | NOT NULL | - | Nama cabang percetakan |
| `address` | `TEXT` | NOT NULL | - | Alamat lengkap cabang |
| `phone_number` | `VARCHAR(20)` | - | - | Nomor telepon kontak cabang |
| `is_active` | `BOOLEAN` | NOT NULL | `TRUE` | Status operasional cabang (Aktif/Tidak) |
| `created_at` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Waktu pencatatan data cabang |

#### 2. `users`
**Deskripsi Entitas**: Menyimpan data login dan otorisasi dari pemilik maupun karyawan.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang tempat pengguna terdaftar |
| `username` | `VARCHAR(50)` | UNIQUE, NOT NULL | - | Username untuk login CLI |
| `password_hash` | `VARCHAR(255)` | NOT NULL | - | Hash password bcrypt |
| `role` | `ENUM('Pemilik', 'Karyawan')` | NOT NULL | - | Hak akses dan peran pengguna |
| `is_active` | `BOOLEAN` | NOT NULL | `TRUE` | Status keaktifan akun pengguna |
| `created_at` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Waktu akun dibuat |
| `updated_at` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Waktu akun terakhir diperbarui |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`.

#### 3. `pricing_tiers`
**Deskripsi Entitas**: Mengelola skema tingkatan harga (contoh: Retail, Grosir, Mitra).

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang |
| `tier_name` | `ENUM('Retail', 'Grosir', 'Mitra')` | UNIQUE, NOT NULL | - | Nama tingkatan harga |
| `min_qty` | `DECIMAL(15,4)` | NOT NULL | `0` | Kuantitas minimal untuk mendapatkan skema harga ini |
| `min_active_months` | `INT` | NOT NULL | `0` | Syarat durasi aktif pelanggan (bulan) untuk harga Mitra |
| `description` | `TEXT` | - | - | Deskripsi syarat dan ketentuan skema harga |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`.

#### 4. `customers`
**Deskripsi Entitas**: Menyimpan data kontak pelanggan dan riwayat keanggotaan.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang tempat pelanggan terdaftar |
| `pricing_tier_id` | `INT` | FK, NOT NULL | - | ID referensi skema harga pelanggan |
| `full_name` | `VARCHAR(150)` | NOT NULL | - | Nama lengkap pelanggan |
| `whatsapp_number` | `VARCHAR(20)` | - | - | Nomor kontak/WhatsApp pelanggan |
| `registered_date` | `DATE` | NOT NULL | `CURRENT_DATE` | Tanggal pelanggan pertama kali transaksi |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`. `pricing_tier_id` mereferensikan `pricing_tiers(id)`.
*Catatan Implementasi*: Sistem secara otomatis menentukan tier harga pelanggan berdasarkan `min_qty` transaksi saat ini atau status keaktifan di `min_active_months`.

#### 5. `vendors`
**Deskripsi Entitas**: Data supplier atau vendor yang memasok bahan baku atau layanan.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang |
| `vendor_name` | `VARCHAR(150)` | NOT NULL | - | Nama vendor atau supplier |
| `contact_person` | `VARCHAR(100)` | - | - | Nama narahubung vendor |
| `phone_number` | `VARCHAR(20)` | - | - | Nomor kontak vendor |
| `address` | `TEXT` | - | - | Alamat operasional vendor |
| `is_active` | `BOOLEAN` | NOT NULL | `TRUE` | Status kerjasama vendor |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`.

#### 6. `employees`
**Deskripsi Entitas**: Informasi detail mengenai karyawan (termasuk jabatan dan skema gaji).

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang penugasan karyawan |
| `user_id` | `INT` | FK, UNIQUE | - | ID akun pengguna login jika diberikan |
| `full_name` | `VARCHAR(150)` | NOT NULL | - | Nama lengkap karyawan |
| `position` | `VARCHAR(100)` | NOT NULL | - | Jabatan struktural karyawan |
| `salary_schema` | `ENUM('Tetap', 'Persentase')` | NOT NULL | `Persentase` | Skema dasar penentuan gaji karyawan |
| `base_salary` | `DECIMAL(15,4)` | NOT NULL | `0` | Nilai dasar gaji bulanan jika skema `Tetap` |
| `join_date` | `DATE` | NOT NULL | - | Tanggal masuk kerja (Mulai karyawan) |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`. `user_id` mereferensikan `users(id)`.

#### 7. `products_services`
**Deskripsi Entitas**: Menyimpan semua jenis produk, barang ritel (ATK), dan layanan.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang kepemilikan |
| `service_type` | `ENUM('Percetakan', 'ATK', 'PPOB', 'Jasa Keuangan', 'Jasa Teknis')` | NOT NULL | - | Kategori layanan/produk |
| `name` | `VARCHAR(150)` | NOT NULL | - | Nama produk/jasa |
| `base_price` | `DECIMAL(15,4)` | NOT NULL | - | Harga dasar retail produk/jasa |
| `stock_quantity` | `DECIMAL(15,4)` | NOT NULL | `0` | Saldo stok untuk tipe ATK (0 untuk Jasa) |
| `unit_of_measure` | `VARCHAR(20)` | - | - | Satuan ukur (pcs, lbr, dll) |
| `is_active` | `BOOLEAN` | NOT NULL | `TRUE` | Apakah produk/layanan tersedia |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`.

#### 8. `materials`
**Deskripsi Entitas**: Data inventaris bahan baku produksi beserta satuannya.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang penyimpanan bahan baku |
| `vendor_id` | `INT` | FK | - | ID vendor penyedia bahan ini |
| `material_name` | `VARCHAR(150)` | NOT NULL | - | Nama bahan baku (kertas, tinta, gagang, dll) |
| `stock_quantity` | `DECIMAL(15,4)` | NOT NULL | `0` | Kuantitas sisa stok secara presisi |
| `unit_of_measure` | `VARCHAR(20)` | NOT NULL | - | Satuan ukur presisi tinggi (rim, cm2, ml, dll) |
| `cost_per_unit` | `DECIMAL(15,4)` | NOT NULL | `0` | Harga modal per satuan ukur untuk kalkulasi HPP |
| `min_stock_alert` | `DECIMAL(15,4)` | NOT NULL | `0` | Batas kuantitas pemunculan peringatan stok |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`. `vendor_id` mereferensikan `vendors(id)`.

#### 9. `ppob_accounts`
**Deskripsi Entitas**: Master data akun digital dan bank PPOB.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang pengelola |
| `platform_name` | `ENUM('Mandiri', 'Dana', 'Gopay', 'OVO', 'LinkAja', 'ShopeePay')` | NOT NULL | - | Platform yang menaungi akun digital ini |
| `account_number` | `VARCHAR(50)` | NOT NULL | - | Nomor identitas / rekening / ponsel akun |
| `current_balance` | `DECIMAL(15,4)` | NOT NULL | `0` | Saldo aktual di dalam akun |
| `min_balance` | `DECIMAL(15,4)` | NOT NULL | `150000` | Batas saldo minimum (aturan Rp 150.000) |
| `deposit_recommend` | `DECIMAL(15,4)` | NOT NULL | `500000` | Nilai anjuran deposit saat saldo mencapai limit |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`.

#### 10. `assets`
**Deskripsi Entitas**: Data aset operasional (printer, mesin cetak, dll).

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang penempatan aset |
| `asset_name` | `VARCHAR(150)` | NOT NULL | - | Nama barang / mesin aset |
| `purchase_date` | `DATE` | NOT NULL | - | Tanggal aset dibeli |
| `purchase_price` | `DECIMAL(15,4)` | NOT NULL | `0` | Harga perolehan aset |
| `condition_status` | `ENUM('Normal', 'Rusak', 'Perbaikan')` | - | `Normal` | Status mesin (Normal, Rusak, Perbaikan) |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`.

---

### 4.2. Entitas Transaksi

#### 11. `transactions`
**Deskripsi Entitas**: Data utama dari seluruh layanan kasir lintas tipe.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang pelaksanaan transaksi |
| `user_id` | `INT` | FK, NOT NULL | - | ID pengguna kasir yang bertugas |
| `customer_id` | `INT` | FK, NOT NULL | - | ID pelanggan yang melakukan transaksi |
| `transaction_date` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Waktu transaksi di-*input* |
| `total_amount` | `DECIMAL(15,4)` | NOT NULL | `0` | Total tagihan nilai transaksi (setelah harga khusus) |
| `total_hpp` | `DECIMAL(15,4)` | NOT NULL | `0` | Total HPP (Cost of Goods Sold) transaksi ini |
| `payment_status` | `ENUM('Belum Bayar', 'DP', 'Lunas', 'Refund', 'Dibatalkan')` | NOT NULL | `Belum Bayar` | Status penyelesaian pembayaran transaksi |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`, `user_id` ke `users(id)`, `customer_id` ke `customers(id)`.

#### 12. `transaction_items`
**Deskripsi Entitas**: Baris detail (keranjang) dari transaksi induk.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `transaction_id` | `INT` | FK, NOT NULL | - | ID induk dari tabel `transactions` |
| `product_id` | `INT` | FK, NOT NULL | - | ID produk/layanan yang dibeli |
| `quantity` | `DECIMAL(15,4)` | NOT NULL | `1` | Kuantitas (mendukung desimal jika berupa ukuran) |
| `unit_price` | `DECIMAL(15,4)` | NOT NULL | `0` | Harga jual per kuantitas (disesuaikan dengan tier) |
| `subtotal` | `DECIMAL(15,4)` | NOT NULL | `0` | Total tagihan baris ini |
| `item_hpp` | `DECIMAL(15,4)` | NOT NULL | `0` | Total HPP khusus baris keranjang ini berdasarkan BOM |

*Catatan Relasi*: `transaction_id` mereferensikan `transactions(id)`. `product_id` mereferensikan `products_services(id)`.

#### 13. `payments`
**Deskripsi Entitas**: Histori pembayaran transaksi (pelunasan / penerimaan DP).

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `transaction_id` | `INT` | FK, NOT NULL | - | ID transaksi yang dilunasi/di-DP |
| `payment_date` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Waktu uang diterima |
| `amount_paid` | `DECIMAL(15,4)` | NOT NULL | `0` | Besaran uang nominal pembayaran |
| `payment_type` | `ENUM('DP', 'Lunas', 'Refund')` | NOT NULL | - | Status termin pembayaran yang diinput |

*Catatan Relasi*: `transaction_id` mereferensikan `transactions(id)`.

#### 14. `orders_job_tracking`
**Deskripsi Entitas**: Informasi spesifik untuk tracking tahapan produksi cetak.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `transaction_id` | `INT` | FK, UNIQUE, NOT NULL | - | ID transaksi induk yang terhubung ke job ini |
| `status` | `ENUM('Antri', 'Proses Desain', 'Produksi', 'Selesai', 'Diambil', 'Dibatalkan')` | NOT NULL | `Antri` | Status posisi pesanan percetakan di operasional |
| `design_file_path` | `VARCHAR(255)` | - | - | Path/URL direktori fisik/logis menyimpan file desain |
| `updated_at` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Kapan status ini diperbarui terakhir kali |

*Catatan Relasi*: `transaction_id` mereferensikan `transactions(id)`.

#### 15. `production_waste`
**Deskripsi Entitas**: Tabel pelaporan/pencatatan limbah dan bahan baku produksi cacat.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang |
| `material_id` | `INT` | FK, NOT NULL | - | ID bahan baku / material referensi |
| `waste_quantity` | `DECIMAL(15,4)` | NOT NULL | `0` | Kuantitas bahan terbuang/rusak dalam presisi desimal |
| `waste_reason` | `TEXT` | NOT NULL | - | Deskripsi penyebab kerusakan (salah desain, salah ukuran, dll) |
| `recorded_at` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Waktu kerusakan tercatat |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`. `material_id` mereferensikan `materials(id)`.

#### 16. `ppob_mutations`
**Deskripsi Entitas**: Pencatatan mutasi penambahan/pengurangan pada rekening digital.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `ppob_account_id` | `INT` | FK, NOT NULL | - | ID akun PPOB bersangkutan |
| `transaction_id` | `INT` | FK | - | ID referensi ke modul transaksi (opsional jika mutasi mandiri) |
| `mutation_type` | `ENUM('Kredit', 'Debit')` | NOT NULL | - | Penambahan (Kredit) atau pengurangan (Debit) |
| `amount` | `DECIMAL(15,4)` | NOT NULL | `0` | Nilai mutasi pergerakan kas |
| `mutation_date` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Waktu mutasi terjadi |
| `description` | `TEXT` | - | - | Catatan peruntukan mutasi (transfer ke A, dsb) |

*Catatan Relasi*: `ppob_account_id` mereferensikan `ppob_accounts(id)`. `transaction_id` mereferensikan `transactions(id)`.
*Catatan Implementasi*: Sistem akan memunculkan peringatan jika `current_balance` turun di bawah `min_balance`.

#### 17. `employee_attendance`
**Deskripsi Entitas**: Riwayat kehadiran karyawan per hari.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `employee_id` | `INT` | FK, NOT NULL | - | ID karyawan terkait |
| `check_in_time` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Jam kedatangan |
| `check_out_time` | `DATETIME` | - | - | Jam kepulangan |
| `work_date` | `DATE` | NOT NULL | `CURRENT_DATE` | Tanggal hari kerja terkait absensi ini |

*Catatan Relasi*: `employee_id` mereferensikan `employees(id)`.
*Catatan Implementasi*: Skema gaji persentase menggunakan bagi hasil 15% dari pendapatan bersih jika target bulanan tidak tercapai, sesuai BR-03.

#### 18. `employee_loans`
**Deskripsi Entitas**: Data hutang/kasbon internal karyawan ke perusahaan.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `employee_id` | `INT` | FK, NOT NULL | - | ID peminjam / karyawan terkait |
| `loan_amount` | `DECIMAL(15,4)` | NOT NULL | `0` | Nominal uang dihutang (kasbon) |
| `remaining_amount` | `DECIMAL(15,4)` | NOT NULL | `0` | Sisa nominal kasbon yang belum dipotong gaji |
| `loan_date` | `DATE` | NOT NULL | `CURRENT_DATE` | Tanggal pengambilan pinjaman |

*Catatan Relasi*: `employee_id` mereferensikan `employees(id)`.
*Catatan Implementasi*: Skema gaji persentase menggunakan bagi hasil 15% dari pendapatan bersih jika target bulanan tidak tercapai, sesuai BR-03.

#### 19. `payroll`
**Deskripsi Entitas**: Penerbitan rekapitulasi gaji karyawan (Slip Gaji Digital).

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `employee_id` | `INT` | FK, NOT NULL | - | ID karyawan penerima gaji |
| `period_month` | `VARCHAR(7)` | NOT NULL | - | Periode gaji, contoh format 'YYYY-MM' |
| `base_payment` | `DECIMAL(15,4)` | NOT NULL | `0` | Gaji dasar / gaji komisi persentase pendapatan perusahaan |
| `incentive_bonus` | `DECIMAL(15,4)` | NOT NULL | `0` | Total uang ekuivalen dari poin insentif bulanan |
| `loan_deduction` | `DECIMAL(15,4)` | NOT NULL | `0` | Total potongan kasbon hutang aktif karyawan pada bulan tsb |
| `net_salary` | `DECIMAL(15,4)` | NOT NULL | `0` | Uang bersih yang diserahkan/dibayarkan |
| `processed_at` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Tanggal waktu validasi dan penerbitan slip |

*Catatan Relasi*: `employee_id` mereferensikan `employees(id)`.
*Catatan Implementasi*: Skema gaji persentase menggunakan bagi hasil 15% dari pendapatan bersih jika target bulanan tidak tercapai, sesuai BR-03.

#### 20. `cash_reconciliation`
**Deskripsi Entitas**: Hasil laporan validasi jumlah fisik laci dibandingkan riwayat transaksi.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID unit cabang pelaksana rekonsiliasi |
| `user_id` | `INT` | FK, NOT NULL | - | Karyawan/User yang melaporkan |
| `system_balance` | `DECIMAL(15,4)` | NOT NULL | `0` | Kalkulasi saldo laci berdasarkan rekam transaksi database |
| `physical_balance` | `DECIMAL(15,4)` | NOT NULL | `0` | Kalkulasi lembaran uang tunai aktual laci fisik kasir |
| `difference` | `DECIMAL(15,4)` | NOT NULL | `0` | Nilai selisih (`physical` - `system`) |
| `reconciled_at` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Tanggal dan jam eksekusi penutupan shift/rekonsiliasi |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`. `user_id` mereferensikan `users(id)`.

#### 21. `stock_opname`
**Deskripsi Entitas**: Pencatatan penyesuaian/kecocokan data gudang.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang pelaksana opname |
| `material_id` | `INT` | FK, NOT NULL | - | ID bahan baku/barang di audit |
| `system_qty` | `DECIMAL(15,4)` | NOT NULL | `0` | Catatan persediaan material di sistem |
| `actual_qty` | `DECIMAL(15,4)` | NOT NULL | `0` | Angka persediaan material temuan nyata |
| `difference_qty` | `DECIMAL(15,4)` | NOT NULL | `0` | Ketidaksesuaian/Selisih presisi tinggi |
| `recorded_at` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Jam opname inventaris selesai |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`. `material_id` mereferensikan `materials(id)`.

---

### 4.3. Entitas Pendukung

#### 22. `bom` (Bill of Materials)
**Deskripsi Entitas**: Menyimpan resep / rumus komposisi material sebuah layanan pesanan (HPP Presisi).

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `product_id` | `INT` | FK, NOT NULL | - | ID produk utama/hasil cetakan |
| `material_id` | `INT` | FK, NOT NULL | - | ID referensi bahan penyusun / material dasar |
| `required_qty` | `DECIMAL(15,4)` | NOT NULL | `0` | Jumlah nilai presisi yang ditarik dari material stok per-1 satuan cetak produk |

*Catatan Relasi*: `product_id` mereferensikan `products_services(id)`. `material_id` mereferensikan `materials(id)`.

*Catatan Implementasi*: HPP dikalkulasi dengan menjumlahkan `required_qty` dikali `cost_per_unit` dari tabel `materials` yang terkait.

#### 23. `incentive_points`
**Deskripsi Entitas**: Catatan koleksi dan log akumulasi poin bonus kerja karyawan atas pekerjaan/job.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `employee_id` | `INT` | FK, NOT NULL | - | ID penerima komisi poin |
| `transaction_id` | `INT` | FK | - | ID transaksinya sebagai pelacakan referensi asal muasal poin |
| `point_category` | `ENUM('Rutin', 'Dasar', 'Kustom', 'Teknis Berat')` | NOT NULL | - | Tingkat kesulitan/bobot poin transaksi |
| `earned_points` | `INT` | NOT NULL | `0` | Besar poin utuh yang didapatkan (misal: 1, 3, 5, atau 10) |
| `earned_date` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Kapan pekerjaan ini diselesaikan |

*Catatan Relasi*: `employee_id` mereferensikan `employees(id)`. `transaction_id` mereferensikan `transactions(id)`.

*Catatan Implementasi*: Poin dikonversi ke nominal uang (misal 1 Poin = Rp 500) pada saat rekapitulasi `payroll` di akhir bulan.
*Catatan Implementasi*: Skema gaji persentase menggunakan bagi hasil 15% dari pendapatan bersih jika target bulanan tidak tercapai, sesuai BR-03.

#### 24. `login_sessions`
**Deskripsi Entitas**: Data persisten untuk token sesi pengguna aktif.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `user_id` | `INT` | FK, NOT NULL | - | ID pemegang hak sesi login |
| `jwt_token` | `VARCHAR(512)` | UNIQUE, NOT NULL | - | String panjang token penanda keaktifan validitas akses |
| `expires_at` | `DATETIME` | NOT NULL | - | Ambang batas kadaluarsa token/sesi 8 jam |

*Catatan Relasi*: `user_id` mereferensikan `users(id)`.

#### 25. `routine_expenses`
**Deskripsi Entitas**: Pengeluaran umum bisnis di luar operasional bahan baku.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang |
| `expense_name` | `VARCHAR(150)` | NOT NULL | - | Kategori nama keperluan anggaran biaya operasional (listrik, wifi, dll) |
| `amount` | `DECIMAL(15,4)` | NOT NULL | `0` | Besaran nominal angka dicairkan |
| `expense_date` | `DATE` | NOT NULL | `CURRENT_DATE` | Tanggal realisasi kebutuhan |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`.

#### 26. `loans`
**Deskripsi Entitas**: Rekap modal eksternal perusahaan dan perputaran pinjaman operasional.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID cabang bisnis bersangkutan |
| `loan_source` | `VARCHAR(150)` | NOT NULL | - | Pihak yang mengutangi (Teman/Orang Tua/Bank BRI/Bank Mandiri) |
| `loan_type` | `ENUM('Tanpa Bunga', 'Berbunga')` | NOT NULL | - | Sifat kewajiban utang piutang modal |
| `principal_amount` | `DECIMAL(15,4)` | NOT NULL | `0` | Besar nominal modal diinjeksi atau nilai total kredit |
| `remaining_debt` | `DECIMAL(15,4)` | NOT NULL | `0` | Nominal tagihan atau sisa pengembalian hutang usaha kepada investor/kreditur |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`.

#### 27. `audit_trail`
**Deskripsi Entitas**: Fitur tracking riwayat histori aktivitas yang berpotensi *fraud* / rekayasa.

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `user_id` | `INT` | FK, NOT NULL | - | Identitas subyek/pelaku yang memicu perubahan |
| `action_type` | `ENUM('INSERT', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT')` | NOT NULL | - | Sifat/kategori modifikasi aksi di sistem (INSERT, UPDATE, DELETE, LOGIN) |
| `target_entity` | `VARCHAR(50)` | NOT NULL | - | Objek tabel yang terkena dampaknya (misal 'materials', 'transactions') |
| `change_detail` | `TEXT` | NOT NULL | - | Narasi rincian komprehensif atas kejadian mutasi nilai spesifik (data sebelum/sesudah dirubah) |
| `timestamp` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Jejak rekam waktu peristiwa manipulasi terjadi |

*Catatan Relasi*: `user_id` mereferensikan `users(id)`.

---


#### 28. `asset_savings`
**Deskripsi Entitas**: Tabungan kas khusus pengadaan alat baru pemilik (diakses khusus role Pemilik).

| Nama Atribut | Tipe Data | Constraints | Nilai Default | Deskripsi |
| --- | --- | --- | --- | --- |
| `id` | `INT` | PK, AUTO_INCREMENT | - | ID unik auto-increment sebagai primary key tabel ini |
| `branch_id` | `INT` | FK, NOT NULL | - | ID referensi cabang |
| `account_name` | `VARCHAR(150)` | NOT NULL | - | Nama rekening / tempat tabungan |
| `balance` | `DECIMAL(15,4)` | NOT NULL | `0` | Saldo aktual tabungan aset |
| `last_updated` | `DATETIME` | NOT NULL | `CURRENT_TIMESTAMP` | Jejak rekam waktu peristiwa penambahan/penarikan |

*Catatan Relasi*: `branch_id` mereferensikan `branches(id)`.
*Catatan Implementasi*: Sesuai BR-10, data dari tabel ini secara eksplisit disembunyikan dari akses `role` Karyawan.

## 5. Ringkasan Relasi Antar Entitas (ERD Prep)

Tabel berikut menyajikan ringkasan seluruh dependensi/kardinalitas yang menghubungkan setiap entitas. Mayoritas tabel operasional merujuk secara Many-to-One terhadap `branches`.

| Entitas Sumber | Kolom Foreign Key | Entitas Tujuan | Jenis Kardinalitas |
| --- | --- | --- | --- |
| `users` | `branch_id` | `branches` | Many-to-One |
| `pricing_tiers` | `branch_id` | `branches` | Many-to-One |
| `customers` | `branch_id` | `branches` | Many-to-One |
| `customers` | `pricing_tier_id` | `pricing_tiers` | Many-to-One |
| `vendors` | `branch_id` | `branches` | Many-to-One |
| `employees` | `branch_id` | `branches` | Many-to-One |
| `employees` | `user_id` | `users` | One-to-One (Optional) |
| `products_services` | `branch_id` | `branches` | Many-to-One |
| `materials` | `branch_id` | `branches` | Many-to-One |
| `materials` | `vendor_id` | `vendors` | Many-to-One |
| `ppob_accounts` | `branch_id` | `branches` | Many-to-One |
| `assets` | `branch_id` | `branches` | Many-to-One |
| `transactions` | `branch_id` | `branches` | Many-to-One |
| `transactions` | `user_id` | `users` | Many-to-One |
| `transactions` | `customer_id` | `customers` | Many-to-One |
| `transaction_items` | `transaction_id` | `transactions` | Many-to-One |
| `transaction_items` | `product_id` | `products_services` | Many-to-One |
| `payments` | `transaction_id` | `transactions` | Many-to-One |
| `orders_job_tracking` | `transaction_id` | `transactions` | One-to-One |
| `production_waste` | `branch_id` | `branches` | Many-to-One |
| `production_waste` | `material_id` | `materials` | Many-to-One |
| `ppob_mutations` | `ppob_account_id` | `ppob_accounts` | Many-to-One |
| `ppob_mutations` | `transaction_id` | `transactions` | Many-to-One (Optional) |
| `employee_attendance` | `employee_id` | `employees` | Many-to-One |
| `employee_loans` | `employee_id` | `employees` | Many-to-One |
| `payroll` | `employee_id` | `employees` | Many-to-One |
| `cash_reconciliation` | `branch_id` | `branches` | Many-to-One |
| `cash_reconciliation` | `user_id` | `users` | Many-to-One |
| `stock_opname` | `branch_id` | `branches` | Many-to-One |
| `stock_opname` | `material_id` | `materials` | Many-to-One |
| `bom` | `product_id` | `products_services` | Many-to-One |
| `bom` | `material_id` | `materials` | Many-to-One |
| `incentive_points` | `employee_id` | `employees` | Many-to-One |
| `incentive_points` | `transaction_id` | `transactions` | Many-to-One (Optional) |
| `login_sessions` | `user_id` | `users` | Many-to-One |
| `routine_expenses` | `branch_id` | `branches` | Many-to-One |
| `loans` | `branch_id` | `branches` | Many-to-One |
| `audit_trail` | `user_id` | `users` | Many-to-One |
| `asset_savings` | `branch_id` | `branches` | Many-to-One |

---

## 6. Referensi Dokumen

Dokumen Data Dictionary ini merangkum data dan kapabilitas yang didefinisikan secara konseptual pada file-file sumber berikut:

- `docs/sdlc/02_analysis/01_business_requirements.md`
- `docs/sdlc/02_analysis/02_software_requirements.md`
- `docs/sdlc/02_analysis/03_use_case_diagram.puml`
- `docs/sdlc/02_analysis/04_workflow_diagram.puml`
- `docs/sdlc/narasi.txt`
