# Issue: Pembuatan Dokumen Data Dictionary

## Deskripsi Tugas
Tugas ini bertujuan untuk menyusun dokumen utama `05_data_dictionary.md` yang berada di dalam folder `docs/sdlc/02_analysis/`. Dokumen ini saat ini berstatus `[create_file]` dan harus menjadi kamus data (data dictionary) yang mendefinisikan seluruh entitas data, atribut, tipe data, batasan (constraints), relasi antar entitas, serta domain nilai yang digunakan dalam Sistem Manajemen Usaha Percetakan "AbuCom". Data dictionary ini menjadi jembatan kritis antara fase analisis dan fase desain — menjadi acuan utama untuk pembuatan database schema, ERD, dan dokumen desain lainnya.

## Persona Implementasi
Bertindaklah sebagai **Senior Data Analyst**, **Senior Database Architect**, dan **Senior Business Analyst** yang sangat kuat dalam mengidentifikasi, mendefinisikan, dan mendokumentasikan seluruh entitas data dan atributnya dari dokumen kebutuhan bisnis dan kebutuhan perangkat lunak. Anda memiliki pengalaman mendalam dalam menyusun kamus data (data dictionary) yang presisi, tidak ambigu, konsisten secara terminologi, dan layak digunakan sebagai fondasi utama untuk perancangan skema basis data relasional. Anda mampu membedakan mana yang merupakan entitas utama, mana yang merupakan entitas transaksi, mana yang merupakan entitas pendukung, serta memetakan relasi antar entitas secara akurat tanpa halusinasi.

## File Referensi Utama
Dalam pembuatan dokumen ini, Anda **DIWAJIBKAN** untuk merujuk pada file berikut sebagai sumber data dan informasi utama:
1. `docs/sdlc/02_analysis/01_business_requirements.md`
2. `docs/sdlc/02_analysis/02_software_requirements.md`
3. `docs/sdlc/02_analysis/03_use_case_diagram.puml`
4. `docs/sdlc/02_analysis/04_workflow_diagram.puml`

Gunakan `docs/sdlc/narasi.txt` jika setelah membaca empat referensi utama di atas masih diperlukan detail tambahan mengenai jenis barang, satuan ukur, komposisi bahan baku, jenis akun digital, jenis layanan, struktur organisasi, atau data operasional lainnya yang belum tercakup secara eksplisit pada referensi utama. Untuk dokumen data dictionary, `narasi.txt` cenderung relevan karena berisi rincian jenis produk, bahan baku, akun digital, dan proses operasional yang memperkaya definisi atribut dan domain nilai. Namun, tetap gunakan secara selektif dan hanya ambil bagian yang benar-benar dibutuhkan oleh data dictionary.

## Instruksi Kelayakan & Kriteria Dokumen Utama
Harap patuhi instruksi berikut secara ketat saat menyusun isi dari dokumen `05_data_dictionary.md`:

1. **Identifikasi Entitas Data Secara Presisi**: Identifikasi seluruh entitas data yang disebut atau tersirat dari keempat file referensi utama. Entitas data meliputi: entitas master (pengguna, cabang, pelanggan, vendor, karyawan, produk, bahan baku, akun PPOB, aset), entitas transaksi (transaksi kasir, pembayaran, pesanan/job tracking, limbah produksi, mutasi PPOB/keuangan, kasbon, penggajian, rekonsiliasi kas, stock opname), dan entitas pendukung (audit trail, BOM, poin insentif, sesi login/token, pengeluaran rutin, pinjaman). Jangan melewatkan entitas apa pun yang sudah jelas disebutkan atau tersirat kuat pada referensi.
2. **Hanya Ambil Informasi yang Relevan untuk Data Dictionary**: Ambil dan rangkum HANYA data yang memang dibutuhkan untuk mendefinisikan struktur data: nama entitas, deskripsi entitas, nama atribut, deskripsi atribut, tipe data yang disarankan (misal: INT, VARCHAR, DECIMAL, DATETIME, ENUM, TEXT, BOOLEAN), batasan/constraints (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, DEFAULT, CHECK), domain nilai yang valid (contoh nilai ENUM: 'Antri', 'Proses Desain', 'Produksi', 'Selesai', 'Diambil'), dan relasi antar entitas. Jangan memasukkan detail alur proses, detail fungsi Python, detail CLI, atau logika bisnis prosedural yang lebih cocok untuk dokumen lain.
3. **Rangkum Seluruh Informasi Penting Tanpa Ada yang Terlewat**: Pastikan semua atribut data yang disebutkan secara eksplisit pada BRD, SRS, Use Case Diagram, dan Workflow Diagram sudah tercakup. Jika ada atribut yang jelas muncul di referensi (contoh: `branch_id` pada setiap entitas, `waste_reason` pada pencatatan limbah, `design_file_path` pada job tracking) tetapi tidak dimasukkan, hasil dianggap belum lengkap.
4. **Standar Struktur Data Dictionary Praktik Industri**: Data dictionary harus memakai struktur yang rapi, konsisten, dan mudah ditelusuri. Minimal harus memiliki komponen berikut per entitas:
   - **Nama Entitas**: Nama tabel/entitas dalam format snake_case yang konsisten.
   - **Deskripsi Entitas**: Penjelasan singkat tentang fungsi dan peran entitas ini dalam sistem.
   - **Tabel Definisi Atribut**: Tabel berisi kolom-kolom: Nama Atribut, Tipe Data, Panjang/Presisi (jika relevan), Constraints, Nilai Default (jika ada), Deskripsi.
   - **Catatan Relasi**: Penjelasan foreign key dan relasi ke entitas lain.
5. **Kelayakan Sebagai Acuan Fase SDLC Selanjutnya**: Data dictionary ini harus layak dijadikan referensi utama bagi fase desain selanjutnya, terutama:
   - `01_database_schema.sql` — untuk pembuatan DDL tabel, kolom, tipe data, dan constraints.
   - `02_erd_database.puml` — untuk pemetaan relasi antar entitas.
   - `03_system_architecture.md` — untuk identifikasi modul data yang dikelola sistem.
   - `05_bom_hpp_design.md` — untuk struktur data BOM dan HPP.
   - `06_access_control_matrix.md` — untuk pemetaan entitas data yang dibatasi aksesnya per peran.
   Karena itu, nama entitas, nama atribut, tipe data, dan istilah domain wajib stabil dan konsisten dengan dokumen referensi.
6. **Bahasa Indonesia yang Natural dan Tegas**: Gunakan deskripsi atribut dan deskripsi entitas dalam Bahasa Indonesia yang natural, tidak ambigu, tidak membingungkan, dan mudah dipahami oleh junior programmer atau AI model yang lebih murah. Untuk nama entitas dan nama atribut teknis, gunakan bahasa Inggris dalam format `snake_case` yang umum digunakan dalam basis data relasional.
7. **Kelengkapan Tanpa Halusinasi**: Jangan mengarang nama entitas, nama atribut, tipe data, atau domain nilai jika tidak ada dasar yang cukup dari referensi. Jika ada bagian penting yang belum memiliki data kuat, beri penanda yang jelas untuk pengisian manual.
8. **Penandaan Data yang Belum Tersedia**: Jika ada nama atribut, tipe data, domain nilai, atau batasan yang seharusnya ada tetapi belum cukup jelas dari referensi, tandai secara eksplisit menggunakan placeholder seperti `[PERLU_KLARIFIKASI_TIPE_DATA]`, `[PERLU_KLARIFIKASI_DOMAIN_NILAI]`, `[PERLU_KONFIRMASI_RELASI]`, `[PERLU_KONFIRMASI_CONSTRAINT]`, atau `[PERLU DIISI MANUAL: (deskripsi data yang kurang)]`.
9. **Aturan Output Konten Bersih**: Isi file `05_data_dictionary.md` harus berisi HANYA konten final dokumen data dictionary yang bersih dan siap dipakai. Jangan menyisipkan instruksi kerja, analisis sementara, checklist, atau komentar non-esensial yang membuat file target bising.
10. **Pencantuman Referensi di Bagian Penutup**: Cantumkan keterangan referensi yang digunakan di bagian akhir dokumen dalam format Markdown yang rapi. Cantumkan hanya file yang benar-benar dipakai.
11. **Konsistensi Nama dengan Dokumen Referensi**: Nama entitas, atribut, status, layanan, modul, dan istilah domain harus mengikuti istilah yang sudah mapan pada BRD, SRS, Use Case Diagram, dan Workflow Diagram. Jika ada istilah ganda yang mirip, pilih istilah yang paling kuat dan paling konsisten di referensi.
12. **Aturan Khusus Data Dictionary — Arsitektur Multi-Branch Ready**: Setiap entitas data WAJIB menyertakan atribut `branch_id` sebagai foreign key ke entitas cabang, sesuai dengan persyaratan arsitektur Multi-Branch Ready yang ditegaskan di BRD dan SRS. Jangan melewatkan atribut ini pada entitas mana pun.
13. **Aturan Khusus Data Dictionary — Presisi Desimal untuk Stok dan HPP**: Untuk atribut yang menyangkut kuantitas bahan baku, dimensi, volume, dan perhitungan HPP, pastikan tipe data yang direkomendasikan menggunakan `DECIMAL` dengan presisi yang cukup tinggi (misal: `DECIMAL(15,4)` atau lebih tinggi), bukan `FLOAT` atau `DOUBLE`, sesuai persyaratan presisi tinggi yang disebutkan pada SRS.
14. **Aturan Khusus Data Dictionary — Audit Trail**: Pastikan entitas audit trail memiliki atribut yang cukup untuk merekam: siapa yang melakukan aksi (`user_id`), aksi apa yang dilakukan (`action_type`), pada entitas mana (`target_entity`), kapan dilakukan (`timestamp`), dan detail perubahan (`change_detail`), sesuai persyaratan keamanan di BRD dan SRS.
15. **Aturan Khusus Data Dictionary — Pengelompokan Entitas**: Kelompokkan entitas berdasarkan domain fungsional agar mudah ditelusuri, misalnya:
    - **Entitas Master**: Cabang, Pengguna, Pelanggan, Vendor, Karyawan, Produk/Layanan, Bahan Baku, Akun PPOB/Digital, Aset.
    - **Entitas Transaksi**: Transaksi Kasir, Item Transaksi, Pembayaran, Pesanan/Job Tracking, Limbah Produksi, Mutasi PPOB/Keuangan, Kasbon, Penggajian, Rekonsiliasi Kas, Stock Opname.
    - **Entitas Pendukung**: BOM (Bill of Materials), Poin Insentif, Sesi Login/Token, Pengeluaran Rutin, Pinjaman (Tanpa Bunga & Bank), Audit Trail.
16. **(Poin Tambahan) Domain Nilai ENUM yang Eksplisit**: Untuk setiap atribut bertipe ENUM atau yang memiliki domain nilai terbatas, cantumkan semua nilai valid yang disebutkan pada referensi. Contoh: status pesanan (`Antri`, `Proses Desain`, `Produksi`, `Selesai`, `Diambil`), tipe pembayaran (`DP`, `Lunas`), skema harga (`Retail`, `Grosir`, `Mitra`), peran pengguna (`Pemilik`, `Karyawan`).
17. **(Poin Tambahan) Metadata Dokumen**: Sertakan metadata dokumen di bagian awal (Versi, Status, Tanggal Dibuat, Disusun Oleh) dalam format tabel Markdown yang konsisten dengan dokumen lain dalam proyek ini.
18. **(Poin Tambahan) Ringkasan Relasi Antar Entitas**: Di bagian akhir sebelum referensi, sertakan ringkasan tabel relasi antar entitas yang menunjukkan hubungan (one-to-many, many-to-many) beserta foreign key yang menghubungkannya, agar menjadi input langsung untuk pembuatan ERD.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)
Anggap panduan ini akan dibaca oleh junior programmer atau AI model yang lebih murah dan akan langsung mengimplementasikan file target. Lakukan langkah-langkah berikut secara berurutan tanpa deviasi:

1. **Langkah 1: Baca Semua Referensi Wajib Sampai Tuntas**
   - Baca keseluruhan isi `docs/sdlc/02_analysis/01_business_requirements.md`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/02_software_requirements.md`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/03_use_case_diagram.puml`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/04_workflow_diagram.puml`.
   - Jangan mulai menulis data dictionary sebelum keempat file ini selesai dibaca penuh.

2. **Langkah 2: Tentukan Apakah `narasi.txt` Masih Diperlukan**
   - Evaluasi apakah BRD, SRS, Use Case Diagram, dan Workflow Diagram sudah cukup untuk menjawab hal berikut:
     - jenis produk dan layanan yang harus menjadi entitas data,
     - jenis bahan baku dan satuan ukurnya,
     - jenis akun digital/PPOB yang harus dikelola,
     - struktur organisasi dan peran karyawan,
     - domain nilai spesifik (misal: daftar platform PPOB, skema poin insentif),
     - detail operasional lainnya yang mempengaruhi definisi atribut.
   - Jika masih ada kekosongan informasi spesifik mengenai detail di atas, baca `docs/sdlc/narasi.txt`.
   - Jika ternyata semua informasi sudah cukup dari empat referensi utama, jangan gunakan `narasi.txt`.

3. **Langkah 3: Identifikasi dan Daftar Seluruh Entitas Data**
   - Telusuri setiap bagian BRD (proses bisnis, kebutuhan fungsional, business rules) untuk mengidentifikasi entitas data yang tersirat.
   - Telusuri setiap fitur SRS (F-01 sampai F-09) untuk mengidentifikasi entitas data yang disebutkan eksplisit.
   - Telusuri Use Case Diagram untuk memastikan setiap use case yang melibatkan penyimpanan/manipulasi data sudah memiliki entitas yang sesuai.
   - Telusuri Workflow Diagram untuk mengidentifikasi entitas status, transisi, dan entitas pendukung alur proses.
   - Buat daftar lengkap semua entitas kandidat. Minimal harus mencakup entitas-entitas berikut (sesuaikan nama jika referensi menggunakan istilah yang lebih tepat):
     - `branches` (Cabang)
     - `users` (Pengguna/Login)
     - `customers` (Pelanggan)
     - `vendors` (Vendor/Supplier)
     - `employees` (Karyawan)
     - `products_services` (Produk dan Layanan)
     - `materials` (Bahan Baku)
     - `bom` (Bill of Materials)
     - `transactions` (Transaksi Kasir)
     - `transaction_items` (Item Transaksi)
     - `payments` (Pembayaran DP/Pelunasan)
     - `orders_job_tracking` (Pesanan/Job Tracking)
     - `production_waste` (Limbah Produksi)
     - `ppob_accounts` (Akun PPOB/Digital)
     - `ppob_mutations` (Mutasi PPOB/Keuangan)
     - `employee_attendance` (Kehadiran Karyawan)
     - `employee_loans` (Kasbon Karyawan)
     - `payroll` (Penggajian)
     - `incentive_points` (Poin Insentif)
     - `assets` (Aset)
     - `loans` (Pinjaman Tanpa Bunga & Bank)
     - `routine_expenses` (Pengeluaran Rutin)
     - `cash_reconciliation` (Rekonsiliasi Kas)
     - `stock_opname` (Stock Opname)
     - `audit_trail` (Audit Trail)
   - Jika ada entitas lain yang jelas tersirat dari referensi (misal: tabel harga khusus/pricing tiers, kategori produk, riwayat harga vendor), tambahkan.

4. **Langkah 4: Definisikan Atribut untuk Setiap Entitas**
   - Untuk setiap entitas, identifikasi semua atribut yang disebutkan atau tersirat kuat dari referensi.
   - Setiap atribut harus memiliki:
     - **Nama Atribut**: Dalam format `snake_case` (bahasa Inggris).
     - **Tipe Data**: Pilih tipe data MySQL yang tepat (`INT`, `BIGINT`, `VARCHAR(n)`, `TEXT`, `DECIMAL(p,s)`, `DATETIME`, `TIMESTAMP`, `BOOLEAN`, `ENUM(...)`, `DATE`).
     - **Constraints**: Tentukan constraints yang sesuai (`PK`, `FK`, `NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK`, `AUTO_INCREMENT`).
     - **Deskripsi**: Jelaskan dalam Bahasa Indonesia apa yang disimpan oleh atribut ini.
   - Ingat aturan wajib:
     - Setiap entitas WAJIB memiliki `branch_id` (FK ke `branches`).
     - Atribut kuantitas/dimensi/volume/HPP menggunakan `DECIMAL` presisi tinggi.
     - Setiap entitas transaksi sebaiknya memiliki `created_at` dan `updated_at`.
     - Setiap atribut yang bernilai terbatas harus menggunakan `ENUM` dengan domain nilai yang eksplisit.

5. **Langkah 5: Petakan Relasi Antar Entitas**
   - Identifikasi setiap foreign key dan hubungannya.
   - Tentukan kardinalitas relasi (one-to-one, one-to-many, many-to-many).
   - Contoh relasi yang harus ada berdasarkan referensi:
     - `transactions` → `customers` (many-to-one)
     - `transactions` → `users` (many-to-one, siapa yang mencatat)
     - `transaction_items` → `transactions` (many-to-one)
     - `transaction_items` → `products_services` (many-to-one)
     - `bom` → `products_services` (many-to-one, produk induk)
     - `bom` → `materials` (many-to-one, bahan penyusun)
     - `orders_job_tracking` → `transactions` (one-to-one atau many-to-one)
     - `payments` → `transactions` (many-to-one)
     - `production_waste` → `materials` (many-to-one)
     - `ppob_mutations` → `ppob_accounts` (many-to-one)
     - `employee_loans` → `employees` (many-to-one)
     - `payroll` → `employees` (many-to-one)
     - `incentive_points` → `employees` (many-to-one)
     - `audit_trail` → `users` (many-to-one)
   - Jika ada relasi yang tidak cukup jelas dari referensi, gunakan placeholder klarifikasi.

6. **Langkah 6: Validasi Domain Nilai ENUM**
   - Kumpulkan semua domain nilai yang disebutkan eksplisit pada referensi:
     - Status pesanan: `Antri`, `Proses Desain`, `Produksi`, `Selesai`, `Diambil`
     - Tipe pembayaran: `DP`, `Lunas`
     - Skema harga: `Retail`, `Grosir`, `Mitra`
     - Peran pengguna: `Pemilik`, `Karyawan`
     - Tipe layanan transaksi: `Percetakan`, `ATK`, `PPOB`, `Jasa Keuangan`, `Jasa Teknis`
     - Platform PPOB: `Mandiri`, `Dana`, `Gopay`, `OVO`, `LinkAja`, `ShopeePay`
     - Kategori poin insentif: `Rutin`, `Dasar`, `Kustom`, `Teknis Berat`
     - Skema gaji: `Tetap`, `Persentase`
     - Tipe pinjaman: `Tanpa Bunga`, `Berbunga`
   - Jika ada domain nilai lain yang tersirat dari referensi, tambahkan.
   - Jika ada domain nilai yang kemungkinan ada tapi tidak disebutkan eksplisit, gunakan placeholder.

7. **Langkah 7: Susun Dokumen dengan Struktur Standar**
   - Susun dokumen dengan urutan berikut:
     1. **Metadata Dokumen** (tabel: Versi, Status, Tanggal Dibuat, Disusun Oleh)
     2. **Pendahuluan** (tujuan dan ruang lingkup data dictionary)
     3. **Konvensi Penamaan dan Tipe Data** (standar penamaan tabel/kolom, tipe data MySQL yang digunakan)
     4. **Daftar Entitas Data** (daftar ringkas semua entitas per kelompok domain)
     5. **Definisi Detail Entitas** (per entitas: deskripsi + tabel atribut + catatan relasi)
        - Kelompokkan: Entitas Master → Entitas Transaksi → Entitas Pendukung
     6. **Ringkasan Relasi Antar Entitas** (tabel relasi dengan kardinalitas dan FK)
     7. **Referensi Dokumen** (daftar file yang digunakan)

8. **Langkah 8: Tulis Konten Final ke File Markdown**
   - Isi file `docs/sdlc/02_analysis/05_data_dictionary.md` dengan konten final dokumen.
   - Gunakan format tabel Markdown untuk definisi atribut setiap entitas.
   - Gunakan heading level yang konsisten (H2 untuk bagian utama, H3 untuk kelompok entitas, H4 untuk setiap entitas).
   - Tambahkan keterangan referensi yang digunakan di bagian penutup.

9. **Langkah 9: Validasi Kelengkapan Entitas dan Atribut**
   - Cocokkan kembali daftar entitas dengan BRD, SRS, Use Case Diagram, dan Workflow Diagram.
   - Untuk setiap fitur SRS (F-01 sampai F-09), pastikan ada entitas data yang mendukung penyimpanan datanya.
   - Untuk setiap business rule BRD (BR-01 sampai BR-10), pastikan ada atribut/entitas yang merepresentasikan aturan tersebut.
   - Pastikan tidak ada entitas atau atribut penting yang hilang.

10. **Langkah 10: Validasi Konsistensi Terminologi**
    - Periksa nama entitas, atribut, dan domain nilai satu per satu.
    - Pastikan penamaan konsisten dengan istilah yang sudah ada di BRD, SRS, Use Case Diagram, dan Workflow Diagram.
    - Jika ada istilah ganda yang berbeda tapi maknanya sama (misal: "pesanan" vs "order" vs "job"), pilih satu istilah yang paling mapan lalu gunakan konsisten.

11. **Langkah 11: Validasi Anti-Halusinasi**
    - Tinjau setiap entitas dan setiap atribut.
    - Untuk setiap elemen, tanyakan: "Apakah ini punya dasar kuat dari referensi?"
    - Jika jawabannya ragu, hapus elemen itu atau ganti dengan placeholder klarifikasi yang eksplisit.
    - Jangan mengarang nama tabel, nama kolom, tipe data, atau domain nilai yang tidak ada dasar dari referensi.

12. **Langkah 12: Validasi Kebersihan Output**
    - Pastikan file target hanya berisi isi dokumen final yang bersih.
    - Jangan tinggalkan instruksi kerja, checklist, hasil analisis mentah, atau komentar diskusi internal.
    - Hasil akhir harus siap dipakai secara profesional sebagai referensi fase SDLC berikutnya.

13. **Langkah 13: Validasi Kelayakan untuk Dokumen Turunan**
    - Pastikan data dictionary cukup kuat untuk dijadikan acuan oleh dokumen fase berikutnya.
    - Secara khusus, cek apakah dokumen ini akan membantu penyusunan:
      - `01_database_schema.sql` — apakah setiap entitas sudah memiliki definisi atribut dan tipe data yang cukup untuk langsung diterjemahkan ke DDL SQL?
      - `02_erd_database.puml` — apakah relasi antar entitas sudah terdefinisi jelas dengan kardinalitas dan FK?
      - `03_system_architecture.md` — apakah modul data sudah teridentifikasi?
      - `05_bom_hpp_design.md` — apakah struktur data BOM dan material sudah terdefinisi?
      - `06_access_control_matrix.md` — apakah entitas yang memiliki pembatasan akses sudah teridentifikasi?
    - Jika belum cukup informatif untuk dokumen turunan tersebut, revisi sampai definisi entitas dan atribut benar-benar lengkap.

14. **Langkah 14: Validasi Format Tabel Markdown**
    - Pastikan semua tabel Markdown ter-render dengan benar.
    - Periksa alignment header tabel, pemisah kolom, dan isi sel.
    - Pastikan tidak ada baris tabel yang rusak atau terpotong.
    - Pastikan setiap tabel definisi atribut memiliki kolom yang konsisten: No, Nama Atribut, Tipe Data, Constraints, Nilai Default, Deskripsi.
