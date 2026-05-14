# Issue #0026 — Validasi & Penyempurnaan Dokumen Utama: ERD Database

| Atribut         | Detail                                                              |
|-----------------|---------------------------------------------------------------------|
| **Nomor Issue** | 0026                                                                |
| **Judul**       | Validasi & Penyempurnaan Dokumen Utama: ERD Database                |
| **Target File** | `docs/sdlc/03_design/02_erd_database.puml`                          |
| **Status Saat Ini** | `[draft]`                                                       |
| **Fase SDLC**   | 03 — Design                                                         |
| **Prioritas**   | Tinggi                                                              |
| **Dikerjakan Oleh** | Junior Programmer / LLM Model AI                                |
| **Tanggal Dibuat** | 2026-05-14                                                       |

---

## 1. Latar Belakang

Dokumen `02_erd_database.puml` adalah dokumen utama pada fase Design yang berfungsi sebagai visualisasi relasi seluruh entitas database sistem AbuCom. Dokumen ini saat ini masih berstatus `[draft]` dan perlu divalidasi secara ketat sebelum dapat dijadikan acuan bagi fase implementasi berikutnya.

File ini adalah diagram PlantUML yang mendeskripsikan 28 tabel dan 39 relasi dalam database MySQL 8.4 LTS. Kesalahan atau ketidaklengkapan pada dokumen ini akan berdampak langsung pada seluruh fase implementasi dan pengujian sistem.

---

## 2. Persona yang Harus Digunakan

Sebelum memulai pekerjaan, **wajib** mengaktifkan dan mempertahankan persona berikut secara konsisten selama seluruh sesi pengerjaan:

> **Persona: Senior Database Architect + Senior Data Modeler + Technical Documentation Reviewer**
>
> Kamu adalah seorang ahli database senior berpengalaman lebih dari 10 tahun dalam merancang skema database untuk sistem ERP/POS berbasis UMKM hingga enterprise. Kamu juga seorang technical documentation reviewer yang sangat ketat dan tidak akan meloloskan dokumen yang ambigu, tidak lengkap, atau tidak konsisten. Kamu memahami dengan sangat baik standar praktik industri untuk diagram ERD, normalisasi database (1NF, 2NF, 3NF, BCNF), serta konvensi penamaan entitas dalam sistem manajemen usaha percetakan. Kamu tidak boleh bersikap permisif — jika ada kesalahan atau kekurangan, kamu **wajib** menemukan dan memperbaikinya.

---

## 3. Dokumen Referensi Wajib

Sebelum memulai analisis, **baca dan pahami seluruh isi** file-file berikut secara lengkap dan berurutan:

| No  | Path File                                              | Peran                                                               |
|-----|--------------------------------------------------------|---------------------------------------------------------------------|
| 1   | `docs/sdlc/03_design/02_erd_database.puml`             | **[DOKUMEN UTAMA]** — file yang akan diperiksa, dianalisis, dan diperbaiki |
| 2   | `docs/sdlc/03_design/01_database_schema.sql`           | **[Referensi Utama #1]** — sumber kebenaran definisi tabel, kolom, tipe data, constraint, dan relasi |
| 3   | `docs/sdlc/02_analysis/05_data_dictionary.md`          | **[Referensi Utama #2]** — sumber kebenaran definisi bisnis setiap entitas dan atributnya |
| 4   | `docs/sdlc/narasi.txt`                                 | **[Referensi Konteks Bisnis]** — narasi bisnis pemilik usaha sebagai acuan relevansi fungsional |

> **PERINGATAN:** Jangan memulai langkah apapun sebelum seluruh file referensi di atas selesai dibaca dan dipahami. Kesalahan membaca referensi akan menyebabkan halusinasi dan output yang tidak akurat.

---

## 4. Tahapan Implementasi (Low-Level Instructions)

Ikuti tahapan berikut **secara berurutan**. Jangan melompat ke tahapan berikutnya sebelum tahapan saat ini selesai sepenuhnya.

---

### Tahap 1: Persiapan — Baca Semua Referensi

**Langkah 1.1** — Buka dan baca file `docs/sdlc/03_design/01_database_schema.sql` secara penuh dari baris pertama hingga baris terakhir.
- Catat secara mental: daftar nama tabel, nama kolom tiap tabel, tipe data, constraint (PK, FK, UNIQUE, NOT NULL, DEFAULT), dan relasi FK yang ada.

**Langkah 1.2** — Buka dan baca file `docs/sdlc/02_analysis/05_data_dictionary.md` secara penuh.
- Catat secara mental: deskripsi bisnis tiap entitas, makna tiap atribut, dan apakah ada entitas yang disebutkan di data dictionary namun belum ada di ERD.

**Langkah 1.3** — Buka dan baca file `docs/sdlc/narasi.txt` secara penuh.
- Catat secara mental: semua fitur bisnis yang disebutkan pemilik (sistem poin, kasbon, rekonsiliasi kas, stock opname, aset, pinjaman, audit trail, dsb.) dan pastikan semua fitur ini sudah terwakili oleh entitas dalam ERD.

**Langkah 1.4** — Buka file `docs/sdlc/03_design/02_erd_database.puml` sebagai objek yang akan dianalisis.
- Identifikasi: jumlah entitas yang terdefinisi, jumlah relasi yang terdefinisi, dan struktur paket/grouping yang digunakan.

---

### Tahap 2: Validasi Kelengkapan Entitas (Komparasi ERD vs SQL Schema)

**Langkah 2.1 — Hitung dan Bandingkan Jumlah Tabel**
- Hitung jumlah tabel yang terdefinisi di `01_database_schema.sql` (baris `CREATE TABLE`).
- Hitung jumlah entitas yang terdefinisi di `02_erd_database.puml` (baris `entity`).
- Jika jumlahnya tidak sama, identifikasi tabel mana yang ada di SQL namun tidak ada di ERD, atau sebaliknya.
- Catat temuan sebagai: `[TEMUAN-2.1] Ketidaksesuaian jumlah entitas: ...`

**Langkah 2.2 — Validasi Nama Entitas**
- Untuk setiap entitas di ERD, pastikan nama entitasnya **identik sama persis** (case-sensitive) dengan nama tabel di `01_database_schema.sql`.
- Jika ada perbedaan nama (typo, singkatan, dll.), catat sebagai: `[TEMUAN-2.2] Nama entitas tidak konsisten: ERD='...' vs SQL='...'`

**Langkah 2.3 — Validasi Atribut/Kolom per Entitas**
- Untuk setiap entitas di ERD, bandingkan daftar atributnya satu per satu dengan kolom yang ada di tabel yang sama di `01_database_schema.sql`.
- Pastikan:
  - Tidak ada kolom yang ada di SQL namun tidak ada di ERD.
  - Tidak ada atribut di ERD yang tidak ada di SQL (atribut hantu/halusinasi).
  - Tipe data yang ditampilkan di ERD konsisten dengan tipe data di SQL (misalnya: `INT`, `VARCHAR(n)`, `DECIMAL(15,4)`, `TEXT`, `BOOLEAN`, `DATE`, `DATETIME`, `ENUM`).
  - Penandaan Primary Key (`<<PK>>`) dan Foreign Key (`<<FK>>`) akurat untuk setiap atribut.
  - Penandaan wajib (`*` = NOT NULL) dan opsional (tanpa `*` = nullable) sudah benar sesuai constraint di SQL.
- Catat setiap ketidaksesuaian sebagai: `[TEMUAN-2.3] Entitas 'nama_tabel': atribut '...' — masalah: ...`

---

### Tahap 3: Validasi Kelengkapan Relasi (Komparasi ERD vs SQL Schema)

**Langkah 3.1 — Hitung dan Bandingkan Jumlah Relasi**
- Hitung jumlah relasi FK yang terdefinisi di `01_database_schema.sql` (baris `FOREIGN KEY ... REFERENCES ...`).
- Hitung jumlah relasi yang terdefinisi di `02_erd_database.puml` (baris relasi PlantUML).
- Header ERD mengklaim ada 39 relasi. Verifikasi klaim ini.
- Catat temuan sebagai: `[TEMUAN-3.1] Jumlah relasi di SQL=X, di ERD=Y.`

**Langkah 3.2 — Validasi Arah dan Kardinalitas Setiap Relasi**
- Untuk setiap relasi FK di `01_database_schema.sql`, cari relasi yang bersesuaian di ERD.
- Pastikan:
  - Arah relasi sudah benar (tabel mana yang menjadi "satu" dan mana yang menjadi "banyak").
  - Notasi kardinalitas PlantUML sudah tepat:
    - `||--o{` untuk One-to-Many wajib (NOT NULL FK).
    - `|o--o{` untuk One-to-Many opsional (nullable FK).
    - `||--||` untuk One-to-One wajib.
    - `|o--||` untuk One-to-One opsional.
  - Label relasi yang digunakan adalah nama kolom FK yang benar.
- Catat setiap ketidaksesuaian sebagai: `[TEMUAN-3.2] Relasi 'A→B': masalah kardinalitas/arah/label — ...`

**Langkah 3.3 — Cek Relasi yang Hilang**
- Untuk setiap FK di SQL, pastikan ada relasi yang merepresentasikannya di ERD. Jika ada FK di SQL yang tidak memiliki relasi di ERD, catat sebagai: `[TEMUAN-3.3] Relasi hilang: FK 'kolom' di tabel 'nama_tabel' tidak ada di ERD.`

---

### Tahap 4: Validasi Relevansi terhadap Bisnis (Komparasi ERD vs Data Dictionary vs narasi.txt)

**Langkah 4.1 — Validasi Relevansi Fungsional**
- Cocokkan setiap entitas di ERD dengan fitur bisnis yang disebutkan di `narasi.txt`.
- Untuk setiap fitur bisnis utama berikut, pastikan ada entitas yang merepresentasikannya:
  - [ ] Sistem multi-cabang (branches)
  - [ ] Manajemen pengguna dan hak akses (users, login_sessions, audit_trail)
  - [ ] Manajemen karyawan (employees)
  - [ ] Sistem penggajian (payroll)
  - [ ] Sistem poin insentif karyawan (incentive_points)
  - [ ] Sistem kasbon/pinjaman karyawan (employee_loans)
  - [ ] Absensi karyawan (employee_attendance)
  - [ ] Manajemen pelanggan dan tier harga (customers, pricing_tiers)
  - [ ] Manajemen produk dan layanan (products_services)
  - [ ] Manajemen bahan baku (materials)
  - [ ] Manajemen vendor/supplier (vendors)
  - [ ] Sistem BOM/komposisi produk (bom)
  - [ ] Sistem transaksi (transactions, transaction_items, payments)
  - [ ] Job tracking/manajemen pesanan (orders_job_tracking)
  - [ ] Pencatatan limbah produksi (production_waste)
  - [ ] Manajemen PPOB (ppob_accounts, ppob_mutations)
  - [ ] Rekonsiliasi kas (cash_reconciliation)
  - [ ] Stock opname (stock_opname)
  - [ ] Manajemen aset (assets, asset_savings)
  - [ ] Pengeluaran rutin (routine_expenses)
  - [ ] Pinjaman modal (loans)
- Jika ada fitur yang belum terwakili oleh entitas manapun, catat sebagai: `[TEMUAN-4.1] Fitur bisnis '...' tidak memiliki entitas representasi di ERD.`

**Langkah 4.2 — Validasi Tidak Ada Entitas Berlebih (Scope Creep)**
- Pastikan tidak ada entitas di ERD yang sama sekali tidak dapat dikaitkan dengan fitur bisnis manapun yang didefinisikan di `narasi.txt` atau `05_data_dictionary.md`.
- Jika ada, catat sebagai: `[TEMUAN-4.2] Entitas '...' tidak relevan dengan kebutuhan bisnis yang terdefinisi.`

---

### Tahap 5: Validasi Standar Struktur Dokumen PlantUML

**Langkah 5.1 — Validasi Header Dokumen**
- Pastikan header (`@startuml` comment block) mengandung informasi lengkap dan akurat:
  - Nama Proyek
  - Deskripsi dokumen
  - Versi dokumen
  - Status dokumen
  - Database target
  - Total entitas (harus sesuai hasil hitung Langkah 2.1)
  - Total relasi (harus sesuai hasil hitung Langkah 3.1)
  - Tanggal pembuatan
  - Persona
- Jika ada informasi yang salah atau tidak akurat, catat sebagai: `[TEMUAN-5.1] Header tidak akurat: field '...' seharusnya '...'`

**Langkah 5.2 — Validasi Pengelompokan Entitas (Paket/Package)**
- Pastikan setiap entitas dikelompokkan ke dalam paket yang logis dan konsisten:
  - `Entitas Master`: entitas yang bersifat referensi/induk (branches, users, customers, vendors, employees, products_services, materials, ppob_accounts, assets, pricing_tiers)
  - `Entitas Transaksi`: entitas yang merekam kejadian/event bisnis
  - `Entitas Pendukung`: entitas yang bersifat pendukung/junction/log
- Jika ada entitas yang berada di paket yang tidak sesuai, catat sebagai: `[TEMUAN-5.2] Entitas '...' seharusnya berada di paket '...' bukan '...'`

**Langkah 5.3 — Validasi Sintaks PlantUML**
- Pastikan tidak ada kesalahan sintaks PlantUML yang umum:
  - Setiap `entity` diikuti oleh blok `{ }` yang valid.
  - Pembatas kolom wajib/opsional menggunakan `--` (double dash) setelah PK.
  - Setiap relasi menggunakan notasi PlantUML yang valid.
  - Tidak ada karakter ilegal dalam nama entitas atau label relasi.
  - `@startuml` dan `@enduml` hadir di baris pertama dan terakhir.
- Catat setiap masalah sintaks sebagai: `[TEMUAN-5.3] Masalah sintaks: ...`

**Langkah 5.4 — Validasi Bagian Referensi Dokumen**
- Pastikan bagian `REFERENSI DOKUMEN` di akhir file mencantumkan semua file yang dijadikan referensi secara akurat dan lengkap dengan path yang benar.
- Jika ada referensi yang hilang atau path yang salah, catat sebagai: `[TEMUAN-5.4] Referensi dokumen tidak lengkap/tidak akurat: ...`

---

### Tahap 6: Validasi Kesiapan sebagai Referensi Fase Berikutnya

**Langkah 6.1 — Uji Keterbacaan oleh Pihak Ketiga**
- Bacalah dokumen ERD ini seolah-olah kamu adalah junior programmer yang baru pertama kali melihatnya.
- Tanyakan pada diri sendiri:
  - Apakah grouping entitas sudah logis dan mudah dipahami?
  - Apakah label relasi (nama kolom FK) sudah jelas menggambarkan hubungan antar tabel?
  - Apakah notasi `*` (wajib) dan tanpa `*` (opsional) sudah konsisten dan mudah dibaca?
  - Apakah ada entitas atau relasi yang ambigu atau membingungkan?
- Catat setiap masalah keterbacaan sebagai: `[TEMUAN-6.1] Masalah keterbacaan: ...`

**Langkah 6.2 — Cek Kesiapan untuk Fase Implementasi**
- Pastikan ERD ini sudah cukup informatif untuk digunakan sebagai acuan saat menulis kode (membuat model, query JOIN, atau desain API endpoint).
- Khususnya pastikan:
  - Semua FK sudah tergambar dengan jelas sehingga developer bisa mengetahui cara JOIN antar tabel.
  - Setiap tabel pivot/junction (misalnya `bom`) sudah terlihat jelas relasi dua arahnya.
  - Tidak ada "orphan entity" (entitas yang tidak memiliki relasi sama sekali) yang seharusnya punya relasi.
- Catat temuan sebagai: `[TEMUAN-6.2] Kesiapan implementasi: ...`

---

### Tahap 7: Validasi Penggunaan Bahasa Indonesia

**Langkah 7.1 — Periksa Komentar dan Label**
- Periksa seluruh komentar (`'`), label paket, dan label relasi dalam file `.puml`.
- Pastikan bahasa yang digunakan natural, tidak ambigu, dan mudah dipahami oleh junior programmer atau LLM lain.
- Khususnya periksa:
  - Nama paket/package sudah ditulis dalam Bahasa Indonesia yang baku dan jelas.
  - Komentar pada bagian relasi sudah deskriptif dan tidak membingungkan.
  - Tidak ada singkatan yang tidak standar atau tidak umum.
- Catat temuan sebagai: `[TEMUAN-7.1] Masalah bahasa/komentar: ...`

---

### Tahap 8: Validasi Data Kosong dan Field yang Perlu Diisi

**Langkah 8.1 — Identifikasi Nilai ENUM yang Tidak Terdefinisi**
- Untuk setiap kolom bertipe `ENUM` di ERD (ditandai dengan `: ENUM`), pastikan di `01_database_schema.sql` sudah ada definisi nilai-nilai ENUM yang valid.
- ERD tidak perlu mencantumkan nilai ENUM secara eksplisit, namun pastikan tidak ada kolom ENUM di SQL yang nilainya kosong atau belum didefinisikan.
- Catat temuan sebagai: `[TEMUAN-8.1] ENUM tidak terdefinisi: kolom '...' di tabel '...'`

**Langkah 8.2 — Periksa Konsistensi Metadata Header**
- Pastikan field `Total Entitas` dan `Total Relasi` di header dokumen sudah diisi dengan nilai yang benar dan sesuai hasil hitung pada Tahap 2 dan Tahap 3.
- Jika belum sesuai, catat sebagai: `[TEMUAN-8.2] Metadata header tidak akurat: ...`

---

### Tahap 9: Implementasi Perbaikan ke File Dokumen Utama

> **ATURAN KRITIS:** Semua perbaikan **WAJIB** ditulis langsung ke file `docs/sdlc/03_design/02_erd_database.puml`. Jangan hanya melaporkan temuan tanpa memperbaikinya.

**Langkah 9.1 — Terapkan Semua Perbaikan**
- Untuk setiap temuan yang dicatat pada Tahap 2 hingga Tahap 8:
  - Perbaiki langsung pada baris yang relevan di file `02_erd_database.puml`.
  - Jika ada entitas yang hilang, tambahkan blok `entity` yang lengkap di paket yang sesuai.
  - Jika ada relasi yang hilang, tambahkan baris relasi di bagian yang sesuai (Master/lainnya).
  - Jika ada atribut yang salah atau hilang, perbaiki/tambahkan di blok `entity` yang tepat.
  - Jika ada kesalahan kardinalitas, perbaiki notasi relasi pada baris yang bersesuaian.

**Langkah 9.2 — Update Versi Dokumen**
- Setelah semua perbaikan diterapkan, update field versi di header dokumen.
- Format versi: `MAJOR.MINOR.PATCH`
  - Jika ada penambahan/penghapusan entitas atau relasi: naikkan `MINOR` (contoh: `1.0.0` → `1.1.0`).
  - Jika hanya perbaikan kecil (typo, kardinalitas, komentar): naikkan `PATCH` (contoh: `1.0.0` → `1.0.1`).
  - Jika ada perubahan struktural besar (reorganisasi paket, perubahan desain fundamental): naikkan `MAJOR` (contoh: `1.0.0` → `2.0.0`).
- **JANGAN** mengubah status dari `[draft]` menjadi `[finish]` atau `[check]`. Perubahan status hanya dilakukan oleh pemilik proyek.

**Langkah 9.3 — Update Bagian Referensi Dokumen**
- Di bagian paling bawah file (sebelum `@enduml`), pastikan bagian `REFERENSI DOKUMEN` sudah mencantumkan semua file yang benar-benar digunakan sebagai referensi dalam proses validasi ini.
- Jika ada referensi baru yang digunakan (misalnya `narasi.txt`), tambahkan di baris baru mengikuti format yang sudah ada:
  ```
  ' 3. docs/sdlc/narasi.txt (Referensi Konteks Bisnis)
  ```

---

### Tahap 10: Verifikasi Akhir

**Langkah 10.1 — Baca Ulang Dokumen yang Sudah Diperbaiki**
- Setelah semua perbaikan diterapkan, baca ulang file `02_erd_database.puml` dari awal hingga akhir sekali lagi.
- Pastikan tidak ada inkonsistensi baru yang muncul akibat proses perbaikan.
- Pastikan seluruh temuan yang dicatat sudah diperbaiki dan tidak ada yang terlewat.

**Langkah 10.2 — Buat Ringkasan Laporan Perbaikan**
- Di akhir sesi, buat ringkasan singkat yang mencantumkan:
  - Total temuan yang ditemukan (per kategori).
  - Total perbaikan yang diterapkan.
  - Versi dokumen sebelum dan sesudah perbaikan.
  - Daftar entitas atau relasi yang ditambahkan/dimodifikasi/dihapus (jika ada).

---

## 5. Poin Tambahan Spesifik untuk Dokumen ERD PlantUML

Selain poin-poin utama di atas, perhatikan hal-hal spesifik berikut yang relevan dengan karakter dokumen ERD berbasis PlantUML:

### 5.1 Konsistensi Notasi Wajib/Opsional
- Simbol `*` (asterisk) sebelum nama atribut berarti kolom tersebut `NOT NULL` (wajib diisi).
- Kolom tanpa `*` berarti kolom tersebut `nullable` (boleh kosong/NULL).
- Pastikan setiap kolom yang `NOT NULL` di SQL menggunakan `*` di ERD, dan setiap kolom `nullable` di SQL tidak menggunakan `*` di ERD.

### 5.2 Akurasi Tipe Data di ERD
- ERD harus menampilkan tipe data yang akurat dan informatif, bukan hanya label generik.
- Gunakan format: `nama_kolom : TIPE_DATA(presisi)` jika ada presisi (contoh: `DECIMAL(15,4)`, `VARCHAR(150)`).
- Untuk `ENUM`, cukup tulis `: ENUM` tanpa mencantumkan nilai-nilainya (agar ERD tidak terlalu verbose).

### 5.3 Validasi Relasi Polimorfik
- Periksa apakah ada kolom FK yang nullable di ERD yang menggunakan notasi kardinalitas wajib (||). Jika FK-nya nullable di SQL, maka notasi ERD **harus** menggunakan `|o` (zero-or-one) bukan `||` (exactly-one) di sisi "satu".

### 5.4 Kelengkapan Komentar Relasi
- Setiap blok relasi di ERD harus memiliki komentar yang jelas (menggunakan `'`) yang menjelaskan konteks relasi tersebut, misalnya jumlah relasi dalam blok tersebut.
- Pastikan klaim jumlah relasi di komentar (misalnya `' Relasi ke branches (16 relasi Many-to-One)`) sudah akurat dan sesuai dengan jumlah baris relasi yang sebenarnya ada di bawah komentar tersebut.

### 5.5 Pengecekan Relasi Self-Referencing
- Periksa apakah ada tabel di SQL yang memiliki FK yang menunjuk ke tabel itu sendiri (self-referencing/hierarki). Jika ada, pastikan relasi ini juga tergambar di ERD.

### 5.6 Konsistensi Warna Paket
- Pastikan setiap paket memiliki warna yang konsisten dan berbeda antara satu paket dengan paket lainnya untuk memudahkan pembacaan visual:
  - `Entitas Master`: `#E6F3FF` (biru muda)
  - `Entitas Transaksi`: `#E6FFE6` (hijau muda)
  - `Entitas Pendukung`: `#FFE6E6` (merah muda)

---

## 6. Definisi Selesai (Definition of Done)

Issue ini dianggap **selesai** jika dan hanya jika semua kondisi berikut terpenuhi:

- [ ] Semua entitas di ERD sudah divalidasi dan konsisten 100% dengan tabel di `01_database_schema.sql`.
- [ ] Semua relasi di ERD sudah divalidasi dan konsisten 100% dengan FK di `01_database_schema.sql`.
- [ ] Semua atribut per entitas sudah divalidasi (nama, tipe data, PK/FK, wajib/opsional).
- [ ] Semua fitur bisnis utama di `narasi.txt` sudah terwakili oleh entitas yang relevan.
- [ ] Metadata header (total entitas, total relasi, versi) sudah diperbarui dengan nilai yang akurat.
- [ ] Tidak ada "orphan entity" (entitas tanpa relasi yang seharusnya memiliki relasi).
- [ ] Notasi kardinalitas setiap relasi sudah akurat (nullable FK = `|o`, NOT NULL FK = `||`).
- [ ] Komentar dan label dalam dokumen sudah menggunakan Bahasa Indonesia yang natural dan tidak ambigu.
- [ ] Versi dokumen sudah dinaikkan sesuai besar perubahan yang dilakukan.
- [ ] Bagian `REFERENSI DOKUMEN` di akhir file sudah lengkap dan akurat.
- [ ] File `02_erd_database.puml` sudah disimpan dengan semua perubahan yang diterapkan.
- [ ] Ringkasan laporan perbaikan sudah dibuat dan disampaikan.

---

## 7. Referensi Dokumen Issue Ini

1. `docs/sdlc/sdlc.txt` — Peta dokumen SDLC proyek AbuCom
2. `docs/sdlc/03_design/02_erd_database.puml` — Dokumen utama yang divalidasi
3. `docs/sdlc/03_design/01_database_schema.sql` — Referensi SQL Schema
4. `docs/sdlc/02_analysis/05_data_dictionary.md` — Referensi Data Dictionary
5. `docs/sdlc/narasi.txt` — Referensi narasi bisnis pemilik usaha
