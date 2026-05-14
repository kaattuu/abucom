# Access Control Matrix — Sistem Manajemen Usaha Percetakan "AbuCom"

## 1. Metadata Dokumen

| Atribut              | Detail                                                  |
| -------------------- | ------------------------------------------------------- |
| **Versi**            | 1.0.0                                                   |
| **Status**           | [draft]                                                |
| **Tanggal Dibuat**   | 2026-05-14                                              |
| **Disusun Oleh**     | Senior Information Security Analyst, Senior RBAC Architect, & Senior Business Analyst |

---

## 2. Pendahuluan

Dokumen Access Control Matrix (ACM) ini disusun sebagai landasan arsitektur keamanan bagi Sistem Manajemen Usaha Percetakan "AbuCom". Dokumen ini mendefinisikan secara ketat hak akses setiap peran (role) pengguna terhadap modul fungsional, antarmuka eksekusi, entitas data, serta mencakup aturan proteksi terhadap data-data sensitif perusahaan. ACM ini berfungsi sebagai panduan teknis yang presisi untuk diimplementasikan pada fase desain dan pengembangan perangkat lunak selanjutnya, dengan mengadopsi standar industri *Role-Based Access Control* (RBAC).

---

## 3. Legenda Notasi Akses

Dokumen ini menggunakan notasi standar untuk mendefinisikan hak akses sistem:

*   **C (Create)**: Hak untuk membuat atau merekam data baru (INSERT).
*   **R (Read)**: Hak untuk melihat, membaca, atau mengekstrak data (SELECT).
*   **U (Update)**: Hak untuk mengubah atau memperbarui data yang sudah ada (UPDATE).
*   **D (Delete)**: Hak untuk menghapus data (DELETE / Soft-Delete).
*   **✓ (Penuh)**: Memiliki akses penuh untuk mengeksekusi fitur atau operasi tersebut.
*   **✗ (Ditolak)**: Tidak memiliki akses sama sekali (Akses diblokir).
*   **Terbatas**: Memiliki akses parsial dengan kondisi tertentu (dijelaskan di kolom Catatan).

---

## 4. Prinsip Keamanan yang Diterapkan

Sistem keamanan AbuCom dirancang berdasarkan prinsip-prinsip arsitektur keamanan berikut:

1.  **Least Privilege**: Setiap peran pengguna (role) hanya diberikan hak akses pada tingkat paling minimum yang benar-benar dibutuhkan untuk menyelesaikan tugas operasional mereka.
2.  **Separation of Duties (Pemisahan Tugas)**: Memisahkan kewenangan tugas-tugas operasional harian (kasir, gudang, produksi) dari kewenangan tugas manajerial/finansial tingkat tinggi.
3.  **Data Classification (Klasifikasi Data)**: Mengklasifikasikan aset data menjadi Publik/Operasional, Internal Terbatas, dan Rahasia (Sensitif), serta menetapkan dinding proteksi akses yang solid pada data-data Rahasia.

---

## 5. Definisi Peran Pengguna (Role Definitions)

Dalam sistem AbuCom, terdapat dua entitas peran utama yang secara struktural dipetakan melalui *Role-Based Access Control*:

1.  **Pemilik (Owner)**
    *   **Deskripsi**: Entitas administrator tertinggi di dalam sistem, biasanya dipegang langsung oleh pemilik usaha.
    *   **Hak Akses**: Memiliki kontrol absolut terhadap seluruh fungsi sistem (✓ Execute all). Mewarisi (*extends*) seluruh akses yang dimiliki Karyawan. Memiliki hak eksklusif untuk mengakses modul Laporan Keuangan, mengeksekusi audit trail, dan melihat informasi finansial paling sensitif seperti tabungan pengadaan aset serta riwayat hutang bank berbunga.
2.  **Karyawan (Staff)**
    *   **Deskripsi**: Entitas operasional yang bertugas melayani pelanggan, memproses transaksi, dan menjalankan fungsi gudang atau produksi.
    *   **Hak Akses**: Diberikan kewenangan penuh untuk melakukan pencatatan transaksi lintas divisi (budaya *cross-functional* sesuai BR-01), mengelola inventaris harian, absensi, dan memproses pembayaran kasir. Secara tegas (*Strict Restriction*) **TIDAK DIIZINKAN** untuk mengakses atau menampilkan rekapitulasi data Laba Rugi perusahaan, aset simpanan Pemilik, dan data pinjaman bank berbunga.

---

## 6. Matriks Akses per Modul Fungsional (Feature-Level Access)

Tabel berikut memetakan tingkat otorisasi akses dari masing-masing peran terhadap modul sistem (*use case* operasional):

| Modul | Sub-Fitur (Eksekusi / Tampilan) | Pemilik | Karyawan | Catatan / Keterangan Pembatasan |
| :--- | :--- | :---: | :---: | :--- |
| **F-01: Autentikasi** | Login ke Sistem CLI | ✓ | ✓ | Sistem merender menu utama sesuai token peran. |
| **F-02: Transaksi Kasir** | Pencatatan Pesanan/Transaksi Multi-Lini | ✓ | ✓ | Karyawan mengeksekusi transaksi harian. |
| | Memproses Pembayaran (DP/Lunas) | ✓ | ✓ | |
| | Memproses Pembatalan & Retur | ✓ | ✓ | Karyawan dapat mengeksekusi jika validasi batas waktu lolos. |
| **F-03: Gudang & BOM** | Mengelola Inventaris Operasional | ✓ | ✓ | Update stok bahan baku dan ATK. |
| | Mengelola *Bill of Materials* (BOM) | ✓ | ✗ | Pengaturan rumus produk (HPP) hanya dilakukan oleh Pemilik. |
| **F-04: Job Tracking** | Memperbarui Status Pesanan | ✓ | ✓ | |
| | Mencatat Lokasi Arsip File Desain | ✓ | ✓ | |
| **F-05: Waste Management**| Mencatat Limbah Produksi (Cacat/Rusak) | ✓ | ✓ | Diperlukan karyawan untuk jaga keseimbangan stok. |
| **F-06: SDM & Penggajian**| Pencatatan Kehadiran (Absensi) | ✓ | ✓ | |
| | Mengelola Kasbon (Pinjaman Karyawan) | ✓ | ✗ | Persetujuan hutang dipegang Pemilik. |
| | Komputasi & Penerbitan Gaji (Payroll)| ✓ | ✗ | Perhitungan skema cerdas hanya diproses Pemilik. Karyawan hanya bisa melihat slip miliknya (melalui Read). |
| **F-07: PPOB & Keuangan** | Eksekusi Transaksi Mutasi/Pulsa/PPOB | ✓ | ✓ | |
| | Pengecekan Ambang Batas Saldo PPOB | ✓ | ✓ | Muncul sebagai notifikasi otomatis di CLI Kasir. |
| **F-08: CRM** | Mengelola Data Pelanggan | ✓ | ✓ | Karyawan butuh untuk transaksi member. |
| | Mengelola Data Vendor (Supplier) | ✓ | ✗ | Perbandingan harga dan kontrak hanya oleh Pemilik. |
| **F-09: Rekonsiliasi Kas**| Laporan Rekonsiliasi Kas (Fisik Laci) | ✓ | ✗ | Pencocokan data laci mutlak oleh Pemilik. |
| | Pencetakan Laporan Keuangan/Laba Rugi| ✓ | ✗ | Hak istimewa manajerial. |
| | Akses Data Finansial Sensitif (Aset) | ✓ | ✗ | Blokir ketat (BR-10) untuk Karyawan. |

---

## 7. Matriks Akses per Entitas Data (Data-Level Access)

Tabel berikut menjabarkan izin komputasi *database* secara langsung pada level operasi (CRUD). *Catatan umum: Operasi Delete (D) secara praktik mayoritas direpresentasikan sebagai "Soft Delete" melalui pembaruan atribut status (`is_active` = `FALSE`).*

### 7.1. Entitas Master Data

| Entitas Data (`table`) | Pemilik | Karyawan | Catatan Pembatasan |
| :--- | :---: | :---: | :--- |
| `branches` | C, R, U, D | R | Karyawan hanya memerlukan referensi `branch_id`. |
| `users` | C, R, U, D | Terbatas | Karyawan hanya (R, U) terhadap *password* atau *username* milik akunnya sendiri. |
| `pricing_tiers` | C, R, U, D | R | Digunakan sistem saat transaksi Karyawan. |
| `customers` | C, R, U, D | C, R, U | Karyawan butuh untuk CRM saat kasir. |
| `vendors` | C, R, U, D | ✗ | Eksklusif untuk operasional bisnis Pemilik. |
| `employees` | C, R, U, D | Terbatas | Karyawan (R) hanya dapat melihat data profil dirinya sendiri. |
| `products_services` | C, R, U, D | R | Sebagai referensi master katalog untuk transaksi. |
| `materials` | C, R, U, D | R, U | Karyawan dapat meng-Update kuantitas stok karena proses pemotongan HPP otomatis/Waste. |
| `ppob_accounts` | C, R, U, D | R, U | Karyawan melihat list akun dan memotong saldo (U) saat transaksi. |
| `assets` | C, R, U, D | ✗ | Daftar aset berat eksklusif dilihat Pemilik. |

### 7.2. Entitas Transaksi Operasional

| Entitas Data (`table`) | Pemilik | Karyawan | Catatan Pembatasan |
| :--- | :---: | :---: | :--- |
| `transactions` | C, R, U, D | C, R, U | Karyawan mencatat transaksi dan meng-Update status pembayaran/batal. D tidak diperbolehkan. |
| `transaction_items` | C, R, U, D | C, R | Item ditambahkan tanpa D (menggunakan rekam log kekal). |
| `payments` | C, R, U, D | C, R | Pencatatan termin pembayaran (DP/Lunas). |
| `orders_job_tracking` | C, R, U, D | C, R, U | Update perubahan status produksi harian. |
| `production_waste` | C, R, U, D | C, R | Pencatatan bahan baku gagal/cacat oleh operator. |
| `ppob_mutations` | C, R, U, D | C, R | Pencatatan riwayat transaksi digital. |
| `employee_attendance` | C, R, U, D | C, R | Absensi karyawan harian. |
| `employee_loans` | C, R, U, D | Terbatas | Karyawan (R) hanya melihat nilai sisa kasbon dirinya sendiri. |
| `payroll` | C, R, U, D | Terbatas | Karyawan (R) hanya dapat membaca riwayat/slip gaji miliknya. |
| `cash_reconciliation` | C, R, U, D | ✗ | Eksekusi audit fisik kasir dan pelaporan mutlak oleh Pemilik. |
| `stock_opname` | C, R, U, D | C, R | Karyawan ikut melaksanakan pendataan lapangan dan *input* opname. |

### 7.3. Entitas Data Pendukung & Keamanan

| Entitas Data (`table`) | Pemilik | Karyawan | Catatan Pembatasan |
| :--- | :---: | :---: | :--- |
| `bom` (Bill of Materials)| C, R, U, D | R | Karyawan (Sistem) butuh (R) guna kalkulasi HPP kasir otomatis. |
| `incentive_points` | C, R, U, D | Terbatas | Karyawan (R) melihat poin reward milik dirinya sendiri. |
| `login_sessions` | C, R, U, D | C, R, D | Karyawan membuat sesi (C) saat login dan menghapusnya (D) saat logout. |
| `routine_expenses` | C, R, U, D | ✗ | Pengeluaran operasional diatur oleh Pemilik. |
| `loans` | C, R, U, D | ✗ | **SENSITIF.** Data hutang usaha/bank. Sesuai BR-10. |
| `asset_savings` | C, R, U, D | ✗ | **SENSITIF.** Data tabungan masa depan. Sesuai BR-10. |
| `audit_trail` | R | ✗ | Pemilik (Read-Only) melihat laporan *fraud log*. Tidak boleh ada yang melakukan C/U/D secara manual (hanya diakses backend level aplikasi). |

---

## 8. Daftar Data Sensitif dan Pembatasannya

Tabel ini merinci daftar data berklasifikasi Rahasia yang mendapatkan proteksi lapis ganda di tingkat *Query* dan Antarmuka Aplikasi:

| Nama Entitas / Atribut Sensitif | Alasan Klasifikasi Keamanan | Pihak yang Diizinkan | Pihak yang Dilarang |
| :--- | :--- | :---: | :---: |
| `loans` (Pinjaman Berbunga Bank) | BR-10: Berisi nilai hutang krusial perusahaan yang dapat memicu kepanikan karyawan jika salah persepsi. | Pemilik | Karyawan |
| `asset_savings` (Tabungan Aset) | BR-10: Kekayaan murni pemilik yang dirahasiakan demi menghindari diskursus tuntutan kenaikan upah tak berdasar. | Pemilik | Karyawan |
| Laporan Laba Rugi Bulanan (F-09) | Hak eksklusif informasi manajerial; menampakkan profitibilitas utuh bisnis di lintas cabang. | Pemilik | Karyawan |
| `payroll` & `employee_loans` (Privasi) | Menghindari konflik horizontal antar karyawan perihal komparasi besaran komisi, sisa kasbon, maupun hukuman/potongan. | Pemilik | Karyawan (kecuali record dirinya sendiri) |

---

## 9. Pemetaan Akses terhadap Use Case (Use Case Mapping)

Berdasarkan *Use Case Diagram*, tabel berikut menegaskan relasi akses antara *Role* dan *Use Case*:

| ID Use Case | Nama Use Case (Fungsi Aplikasi) | Akses Pemilik | Akses Karyawan | Referensi Relasi |
| :--- | :--- | :---: | :---: | :--- |
| `UC_Login` | Melakukan Autentikasi (Login) | ✓ | ✓ | Aktor Karyawan |
| `UC_Transaksi` | Mencatat Transaksi Multi-Lini | ✓ | ✓ | Aktor Karyawan |
| `UC_Bayar` | Memproses Pembayaran (DP/Lunas) | ✓ | ✓ | *Include* dari UC_Transaksi |
| `UC_Retur` | Memproses Pembatalan & Retur | ✓ | ✓ | *Extend* dari UC_Transaksi |
| `UC_Inventaris`| Mengelola Inventaris Operasional | ✓ | ✓ | Aktor Karyawan |
| `UC_BOM` | Mengelola Bill of Materials (BOM) | ✓ | ✗ | **Aktor Pemilik Eksklusif** |
| `UC_StatusPesanan`| Memperbarui Status Pesanan | ✓ | ✓ | Aktor Karyawan |
| `UC_Arsip` | Mencatat Lokasi Arsip Desain | ✓ | ✓ | Aktor Karyawan |
| `UC_Limbah` | Mencatat Limbah Produksi | ✓ | ✓ | Aktor Karyawan |
| `UC_Absen` | Mencatat Kehadiran Masuk/Keluar | ✓ | ✓ | Aktor Karyawan |
| `UC_Kasbon` | Mengelola Data Kasbon Karyawan | ✓ | ✗ | **Aktor Pemilik Eksklusif** |
| `UC_Gaji` | Memproses Penggajian Cerdas & Insentif | ✓ | ✗ | **Aktor Pemilik Eksklusif** |
| `UC_PPOB` | Mencatat Transaksi PPOB & Keuangan | ✓ | ✓ | Aktor Karyawan |
| `UC_Saldo` | Mengecek Ambang Batas Saldo | ✓ | ✓ | *Include* dari UC_PPOB |
| `UC_Pelanggan` | Mengelola Data Pelanggan | ✓ | ✓ | Aktor Karyawan |
| `UC_Vendor` | Mengelola Data Vendor & Harga | ✓ | ✗ | **Aktor Pemilik Eksklusif** |
| `UC_Rekonsiliasi` | Melakukan Rekonsiliasi Kas (Fisik vs Sistem)| ✓ | ✗ | **Aktor Pemilik Eksklusif** |
| `UC_Laporan` | Mencetak Laporan Keuangan & Laba Rugi | ✓ | ✗ | **Aktor Pemilik Eksklusif** |
| `UC_Sensitif` | Mengakses Data Finansial Sensitif | ✓ | ✗ | **Aktor Pemilik Eksklusif** |

---

## 10. Aturan Penulisan Jejak Audit (Audit Trail Log)

Sistem memberlakukan pencatatan paksa *(forced logging)* secara otomatis oleh aplikasi di latar belakang tanpa intervensi pengguna untuk operasi-operasi sensitif berikut:

1.  **Transaksi Keuangan Utama**: Segala *INSERT/UPDATE/DELETE* pada entitas `transactions`, `payments`, `ppob_mutations`, `routine_expenses`, dan `cash_reconciliation`.
2.  **Jejak Autentikasi**: Percobaan masuk (sukses maupun gagal) dan aktivitas log-out dari entitas `login_sessions`.
3.  **Integritas Barang**: Manipulasi (pengurangan non-penjualan atau *input* baru) stok *inventory* pada tabel `materials`, `products_services`, dan perubahan via `stock_opname` serta manipulasi status lewat `production_waste`.
4.  **Mutasi SDM & Kasbon**: Penambahan dan penyesuaian nominal pinjaman staf (`employee_loans`) serta penerbitan slip akhir `payroll`.
5.  **Akses Sensitif Manajerial**: Saat Pemilik membaca / mengekstrak tabel Laba Rugi atau rincian *Loans* Bank (Tipe operasi baca ini dicatat untuk rekam forensik akses akun).

---

## 11. Aturan Keamanan Tambahan & Pengamanan Arsitektur

Kebijakan implementasi pengamanan tambahan yang wajib dibangun oleh *Software Engineer/Developer* pada tahapan kode meliputi:

1.  **Enkripsi Kredensial**: Tabel `users` pantang menyimpan format teks biasa. Sistem menggunakan algoritma komputasi `bcrypt` (minimum `Rounds = 12`) untuk kolom `password_hash`.
2.  **Mekanisme Otorisasi API (Jika Terpisah) & CLI**: Validasi berbasis Token *JSON Web Token* (JWT). Token mengusung durasi kadaluarsa (*exp*) maksimum **8 jam**, dan di dalamnya disuntikkan set identitas: `user_id`, `role`, dan batas skop `branch_id`.
3.  **SQL Role-Based Filtering**: Pengembang diwajibkan menuliskan klausa validasi di level Query basis data. Jika *query* meminta akses tabel `loans` namun objek status memori (`role`) adalah `Karyawan`, maka fungsi akan melempar *(throw)* `UnauthorizedException` dan tidak memproses *database connection*.
4.  **CLI Interface Rendering**: Menu-menu manajerial (seperti "Menu Laba Rugi", "Menu Audit") dilarang di-render ke layar monitor apabila pengguna aktif berstatus `Karyawan`.

---

## 12. Referensi Dokumen

1. `docs/sdlc/02_analysis/01_business_requirements.md`
2. `docs/sdlc/02_analysis/02_software_requirements.md`
3. `docs/sdlc/02_analysis/03_use_case_diagram.puml`
4. `docs/sdlc/02_analysis/04_workflow_diagram.puml`
5. `docs/sdlc/02_analysis/05_data_dictionary.md`
