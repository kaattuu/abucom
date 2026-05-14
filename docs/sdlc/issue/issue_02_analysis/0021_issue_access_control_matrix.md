# Issue: Pembuatan Dokumen Access Control Matrix

## Deskripsi Tugas
Tugas ini bertujuan untuk menyusun dokumen utama `06_access_control_matrix.md` yang berada di dalam folder `docs/sdlc/02_analysis/`. Dokumen ini saat ini berstatus `[create_file]` dan harus menjadi matriks kontrol akses (Access Control Matrix) yang mendefinisikan secara lengkap dan presisi hak akses setiap peran pengguna (role) terhadap setiap modul, fitur, entitas data, dan operasi (CRUD) dalam Sistem Manajemen Usaha Percetakan "AbuCom". Dokumen ini adalah fondasi keamanan sistem — menjadi acuan utama bagi implementasi Role-Based Access Control (RBAC) pada fase desain dan pengembangan selanjutnya.

## Persona Implementasi
Bertindaklah sebagai **Senior Information Security Analyst**, **Senior RBAC Architect**, dan **Senior Business Analyst** yang sangat kuat dalam mengidentifikasi, mengklasifikasikan, dan mendokumentasikan hak akses berbasis peran (RBAC) secara presisi dan tanpa ambigu. Anda memiliki pengalaman mendalam dalam menyusun matriks kontrol akses yang selaras dengan kebutuhan bisnis, aturan bisnis (*business rules*), dan arsitektur keamanan sistem. Anda mampu memetakan setiap peran pengguna ke setiap modul fungsional, entitas data, dan operasi CRUD secara granular, berdasarkan prinsip *Least Privilege* (hanya memberikan akses seminimal mungkin sesuai kebutuhan peran). Anda juga mampu mengidentifikasi data sensitif yang harus dibatasi aksesnya dan mendokumentasikan pembatasan tersebut secara eksplisit.

## File Referensi Utama
Dalam pembuatan dokumen ini, Anda **DIWAJIBKAN** untuk merujuk pada file berikut sebagai sumber data dan informasi utama:

1. `docs/sdlc/02_analysis/01_business_requirements.md`
2. `docs/sdlc/02_analysis/02_software_requirements.md`
3. `docs/sdlc/02_analysis/03_use_case_diagram.puml`
4. `docs/sdlc/02_analysis/04_workflow_diagram.puml`
5. `docs/sdlc/02_analysis/05_data_dictionary.md`

File `docs/sdlc/narasi.txt` **TIDAK diperlukan** untuk dokumen ini karena seluruh informasi mengenai peran pengguna (Pemilik dan Karyawan), pembatasan akses, aturan bisnis terkait keamanan, modul fungsional, dan entitas data sudah terdefinisi secara lengkap dan eksplisit pada kelima file referensi utama di atas.

## Instruksi Kelayakan & Kriteria Dokumen Utama
Harap patuhi instruksi berikut secara ketat saat menyusun isi dari dokumen `06_access_control_matrix.md`:

1. **Identifikasi Seluruh Peran Pengguna (Roles)**: Identifikasi dan definisikan seluruh peran pengguna yang disebutkan pada referensi. Berdasarkan BRD dan SRS, terdapat dua peran utama:
   - **Pemilik** — Memiliki akses tertinggi untuk menjalankan seluruh perintah, mengeksekusi semua fungsi sistem, melihat audit trail, dan mengakses seluruh laporan finansial termasuk data sensitif (tabungan pengadaan aset dan hutang bank berbunga).
   - **Karyawan** — Memiliki izin eksekusi terbatas pada modul operasional harian (kasir, gudang, produksi). Secara ketat tidak diberikan hak otorisasi untuk menampilkan data finansial sensitif.

2. **Pemetaan Akses per Modul Fungsional (Feature-Level Access Matrix)**: Untuk setiap modul fungsional yang ada di SRS (F-01 sampai F-09), tentukan hak akses dari masing-masing peran. Gunakan klasifikasi operasi CRUD (Create, Read, Update, Delete) atau klasifikasi yang lebih relevan sesuai sifat modul (misalnya: Execute, View, Manage). Modul yang harus dipetakan:
   - F-01: Modul Autentikasi dan Otorisasi
   - F-02: Modul Transaksi Multi-Lini Terpadu (Kasir)
   - F-03: Modul Manajemen Gudang dan HPP berbasis BOM
   - F-04: Modul Manajemen Pesanan (Job Tracking)
   - F-05: Modul Pencatatan Limbah Produksi (Waste Management)
   - F-06: Modul Manajemen SDM dan Penggajian Cerdas
   - F-07: Modul Jasa Keuangan & PPOB
   - F-08: Modul CRM (Pelanggan & Vendor)
   - F-09: Modul Pelaporan Keuangan dan Rekonsiliasi Kas

3. **Pemetaan Akses per Entitas Data (Data-Level Access Matrix)**: Untuk setiap entitas data yang terdefinisi di Data Dictionary (`05_data_dictionary.md`), tentukan hak akses CRUD dari masing-masing peran. Entitas data mencakup seluruh 28 tabel yang ada di Data Dictionary:
   - **Entitas Master:** `branches`, `users`, `customers`, `pricing_tiers`, `vendors`, `employees`, `products_services`, `materials`, `ppob_accounts`, `assets`
   - **Entitas Transaksi:** `transactions`, `transaction_items`, `payments`, `orders_job_tracking`, `production_waste`, `ppob_mutations`, `employee_attendance`, `employee_loans`, `payroll`, `cash_reconciliation`, `stock_opname`
   - **Entitas Pendukung:** `bom`, `incentive_points`, `login_sessions`, `routine_expenses`, `loans`, `audit_trail`, `asset_savings`

4. **Identifikasi dan Proteksi Data Sensitif**: Identifikasi secara eksplisit entitas data dan atribut yang mengandung informasi sensitif yang HANYA boleh diakses oleh Pemilik, berdasarkan aturan bisnis BR-10 dan persyaratan keamanan SRS. Data sensitif yang harus dilindungi meliputi:
   - `loans` — Khususnya data pinjaman bank berbunga (kewajiban bayar bulanan bank)
   - `asset_savings` — Tabungan kas pengadaan alat baru pemilik
   - Laporan finansial sensitif pada modul F-09 (Ringkasan Aset/Pinjaman)

5. **Pemetaan Akses terhadap Use Case**: Untuk setiap use case yang ada di Use Case Diagram (`03_use_case_diagram.puml`), konfirmasi peran mana yang memiliki akses langsung dan mana yang mewarisi akses melalui relasi *extends*. Pastikan mapping ini konsisten dengan relasi aktor yang sudah ada di diagram (Pemilik *extends* Karyawan).

6. **Integrasi dengan Aturan Bisnis (Business Rules)**: Setiap pembatasan akses harus di-cross-reference dengan business rules yang relevan dari BRD. Minimal harus membahas dan menerapkan:
   - **BR-01**: Budaya cross-functional karyawan — akses operasional lintas modul untuk karyawan
   - **BR-10**: Larangan karyawan melihat data pinjaman bank berbunga dan tabungan pengadaan aset pemilik
   - Persyaratan keamanan BRD Bagian 4: Pemisahan akses data RBAC dan Audit Trail

7. **Standar Struktur Access Control Matrix Praktik Industri**: Dokumen harus memakai struktur standar industri yang rapi dan mudah ditelusuri. Komponen minimal yang harus ada:
   - **Metadata Dokumen**: Tabel berisi Versi, Status, Tanggal Dibuat, Disusun Oleh
   - **Pendahuluan**: Tujuan, ruang lingkup, dan prinsip dasar RBAC yang diterapkan
   - **Definisi Peran (Role Definitions)**: Deskripsi detail setiap peran dan tanggung jawabnya
   - **Matriks Akses per Modul Fungsional**: Tabel dengan kolom Modul, Sub-Fitur, Pemilik (hak akses), Karyawan (hak akses), dan Catatan/Keterangan
   - **Matriks Akses per Entitas Data**: Tabel dengan kolom Entitas, Pemilik (CRUD), Karyawan (CRUD), dan Catatan Pembatasan
   - **Daftar Data Sensitif dan Pembatasannya**: Tabel terpisah yang mencantumkan data sensitif, alasan klasifikasi, dan siapa yang boleh akses
   - **Aturan Keamanan Tambahan**: Audit Trail, enkripsi kredensial, validasi token JWT, dan kebijakan keamanan terkait lainnya
   - **Referensi Dokumen**: Daftar file yang digunakan

8. **Kelayakan Sebagai Acuan Fase SDLC Selanjutnya**: Dokumen ini harus layak dijadikan referensi utama bagi:
   - `03_design/06_security_design.md` — untuk implementasi detail mekanisme RBAC dan enkripsi
   - `03_design/01_database_schema.sql` — untuk implementasi filter data berdasarkan role di level query
   - `03_design/04_cli_interaction_flow.puml` — untuk render menu CLI berdasarkan hak akses role
   - Fase implementasi — untuk penerapan validasi akses pada setiap endpoint/fungsi

9. **Bahasa Indonesia yang Natural dan Tegas**: Gunakan deskripsi dalam Bahasa Indonesia yang natural, tidak ambigu, dan mudah dipahami. Untuk istilah teknis RBAC (seperti Create, Read, Update, Delete, Role, Permission), gunakan istilah bahasa Inggris standar yang sudah umum dipahami di industri.

10. **Kelengkapan Tanpa Halusinasi**: Jangan mengarang hak akses, pembatasan, atau peran pengguna yang tidak memiliki dasar dari referensi. Semua keputusan akses harus bisa dilacak ke BRD, SRS, Use Case Diagram, Workflow Diagram, atau Data Dictionary.

11. **Penandaan Data yang Belum Tersedia**: Jika ada keputusan akses yang seharusnya ada tetapi belum cukup jelas dari referensi, tandai secara eksplisit menggunakan placeholder seperti `[PERLU_KONFIRMASI_AKSES]`, `[PERLU_KLARIFIKASI_PEMBATASAN]`, atau `[PERLU DIISI MANUAL: (deskripsi keputusan akses yang kurang)]`.

12. **Aturan Output Konten Bersih**: Isi file `06_access_control_matrix.md` harus berisi HANYA konten final dokumen yang bersih dan siap dipakai. Jangan menyisipkan instruksi kerja, analisis sementara, checklist, atau komentar non-esensial.

13. **Pencantuman Referensi di Bagian Penutup**: Cantumkan keterangan referensi yang digunakan di bagian akhir dokumen dalam format Markdown yang rapi. Cantumkan hanya file yang benar-benar dipakai.

14. **(Poin Tambahan) Konsistensi Notasi Akses**: Gunakan notasi akses yang konsisten di seluruh dokumen. Rekomendasi notasi:
    - **C** = Create (Membuat data baru)
    - **R** = Read (Membaca/melihat data)
    - **U** = Update (Mengubah data yang ada)
    - **D** = Delete (Menghapus data)
    - **✓** = Memiliki akses penuh untuk operasi tersebut
    - **✗** = Tidak memiliki akses sama sekali
    - **Terbatas** = Memiliki akses parsial dengan syarat tertentu (jelaskan di kolom Catatan)
    Definisikan legenda notasi ini di bagian awal dokumen sebelum tabel matriks akses agar tidak ambigu.

15. **(Poin Tambahan) Mapping Use Case ke Role**: Sertakan tabel mapping antara setiap Use Case dari Use Case Diagram dengan peran yang berhak mengaksesnya, untuk memastikan konsistensi antara Access Control Matrix dengan Use Case Diagram yang sudah ada.

16. **(Poin Tambahan) Prinsip Keamanan yang Diterapkan**: Dokumentasikan prinsip-prinsip keamanan yang mendasari keputusan akses dalam dokumen ini, minimal mencakup:
    - **Least Privilege**: Setiap peran hanya diberikan akses minimum yang diperlukan
    - **Separation of Duties**: Pemisahan tugas operasional dan manajerial/finansial
    - **Data Classification**: Klasifikasi data berdasarkan tingkat sensitivitasnya (Publik, Internal, Rahasia)

17. **(Poin Tambahan) Integrasi Audit Trail**: Dokumentasikan operasi-operasi kritis mana saja yang WAJIB dicatat di tabel `audit_trail`, termasuk siapa yang melakukan, kapan, dan apa yang dilakukan. Ini menjadi pelengkap matriks akses untuk kebutuhan forensik dan compliance.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)
Anggap panduan ini akan dibaca oleh junior programmer atau AI model yang lebih murah dan akan langsung mengimplementasikan file target. Lakukan langkah-langkah berikut secara berurutan tanpa deviasi:

1. **Langkah 1: Baca Semua Referensi Wajib Sampai Tuntas**
   - Baca keseluruhan isi `docs/sdlc/02_analysis/01_business_requirements.md`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/02_software_requirements.md`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/03_use_case_diagram.puml`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/04_workflow_diagram.puml`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/05_data_dictionary.md`.
   - Jangan mulai menulis Access Control Matrix sebelum kelima file ini selesai dibaca penuh.
   - Fokus khusus saat membaca:
     - **BRD Bagian 4 (Kebutuhan Non-Fungsional)**: Perhatikan poin "Keamanan & Pemisahan Akses Data" yang menjelaskan RBAC dan Audit Trail.
     - **BRD Bagian 5 (Aturan Bisnis)**: Perhatikan BR-01 (cross-functional) dan BR-10 (larangan karyawan akses data sensitif).
     - **SRS Bagian 2 (Karakteristik Pengguna)**: Perhatikan definisi hak akses Pemilik dan Karyawan.
     - **SRS Bagian 5 (Keamanan)**: Perhatikan mekanisme RBAC, enkripsi, dan audit trail.
     - **Use Case Diagram**: Perhatikan relasi aktor (`Pemilik -|> Karyawan : <<extends>>`) yang berarti Pemilik mewarisi semua akses Karyawan, PLUS memiliki akses tambahan eksklusif.
     - **Use Case Diagram**: Perhatikan use case mana yang hanya terhubung ke `Pemilik` (bukan `Karyawan`): UC_BOM, UC_Kasbon, UC_Gaji, UC_Vendor, UC_Rekonsiliasi, UC_Laporan, UC_Sensitif.
     - **Data Dictionary Bagian 4**: Perhatikan setiap entitas, terutama catatan implementasi yang menyebutkan pembatasan akses (misal: `asset_savings` menyebutkan "data ini secara eksplisit disembunyikan dari akses role Karyawan").

2. **Langkah 2: Kumpulkan Semua Informasi Akses dari Referensi**
   Buat catatan internal (jangan ditulis ke file target) berisi:
   - Daftar semua peran: `Pemilik`, `Karyawan`
   - Daftar semua modul fungsional (F-01 s.d. F-09) beserta sub-fiturnya
   - Daftar semua use case beserta peran yang mengaksesnya
   - Daftar semua entitas data dari Data Dictionary
   - Daftar semua aturan bisnis yang berkaitan dengan akses (BR-01, BR-10, dan aturan keamanan BRD Bagian 4)
   - Daftar data sensitif yang secara eksplisit disebutkan harus dibatasi

3. **Langkah 3: Tentukan Hak Akses per Modul Fungsional**
   Untuk setiap modul fungsional, tentukan akses berdasarkan informasi dari referensi:
   - **F-01 (Autentikasi)**: Pemilik dan Karyawan — keduanya melakukan login. Pemilik = Execute. Karyawan = Execute.
   - **F-02 (Transaksi Kasir)**: Karyawan memiliki akses penuh untuk mencatat transaksi (berdasarkan Use Case: UC_Transaksi terhubung ke Karyawan). Pemilik mewarisi akses ini. Pembatalan & Retur juga diakses Karyawan (UC_Retur adalah extend dari UC_Transaksi).
   - **F-03 (Gudang & BOM)**: Karyawan bisa mengelola inventaris operasional (UC_Inventaris terhubung ke Karyawan). Namun pengelolaan BOM (UC_BOM) hanya terhubung ke Pemilik.
   - **F-04 (Job Tracking)**: Karyawan memiliki akses (UC_StatusPesanan dan UC_Arsip terhubung ke Karyawan).
   - **F-05 (Waste Management)**: Karyawan memiliki akses (UC_Limbah terhubung ke Karyawan).
   - **F-06 (SDM & Penggajian)**: Karyawan bisa absen (UC_Absen terhubung ke Karyawan). Namun kasbon (UC_Kasbon) dan penggajian (UC_Gaji) hanya terhubung ke Pemilik.
   - **F-07 (PPOB & Jasa Keuangan)**: Karyawan bisa mencatat transaksi PPOB (UC_PPOB terhubung ke Karyawan). Pengecekan saldo adalah include dari UC_PPOB.
   - **F-08 (CRM)**: Karyawan bisa mengelola data pelanggan (UC_Pelanggan terhubung ke Karyawan). Namun data vendor (UC_Vendor) hanya terhubung ke Pemilik.
   - **F-09 (Laporan & Rekonsiliasi)**: Rekonsiliasi kas (UC_Rekonsiliasi), laporan keuangan (UC_Laporan), dan data finansial sensitif (UC_Sensitif) semuanya hanya terhubung ke Pemilik.

4. **Langkah 4: Tentukan Hak Akses per Entitas Data**
   Untuk setiap entitas data, tentukan akses CRUD berdasarkan modul fungsional yang menggunakannya:
   - Entitas yang diakses oleh modul Karyawan → Karyawan mendapat C/R/U sesuai kebutuhan operasional
   - Entitas yang diakses hanya oleh modul Pemilik → hanya Pemilik yang mendapat akses
   - Entitas data sensitif (`loans`, `asset_savings`) → hanya Pemilik (R/U), Karyawan = ✗ total
   - Entitas `audit_trail` → Pemilik: R (read-only, tidak boleh dimodifikasi), Karyawan: ✗
   - Entitas `users` → Pemilik: CRUD penuh, Karyawan: R pada data sendiri saja
   - **Penting**: Untuk operasi Delete, pertimbangkan bahwa sistem ini menggunakan immutable log dan ACID transaction. Oleh karena itu, mayoritas entitas kemungkinan TIDAK memperbolehkan hard delete, melainkan menggunakan soft delete (mengubah `is_active` ke FALSE) atau tidak ada delete sama sekali.

5. **Langkah 5: Dokumentasikan Data Sensitif dan Pembatasannya**
   Buat tabel khusus yang memuat:
   - Nama entitas/atribut sensitif
   - Alasan klasifikasi sebagai data sensitif (referensi ke BR-10 atau aturan keamanan BRD)
   - Peran yang diizinkan mengakses
   - Peran yang dilarang mengakses

6. **Langkah 6: Dokumentasikan Aturan Audit Trail**
   Identifikasi operasi-operasi kritis yang WAJIB dicatat di audit trail:
   - INSERT/UPDATE/DELETE pada entitas transaksi keuangan
   - Login dan Logout pengguna
   - Perubahan data inventaris (stok bahan baku, barang retail)
   - Perubahan status pesanan (job tracking)
   - Pencatatan limbah produksi
   - Akses ke data finansial sensitif
   - Perubahan data karyawan, penggajian, dan kasbon

7. **Langkah 7: Buat Mapping Use Case ke Role**
   Buat tabel yang memetakan setiap use case dari Use Case Diagram ke peran yang memiliki akses:
   - Karyawan: UC_Login, UC_Transaksi, UC_Bayar, UC_Retur, UC_Inventaris, UC_StatusPesanan, UC_Arsip, UC_Limbah, UC_Absen, UC_PPOB, UC_Saldo, UC_Pelanggan
   - Pemilik (eksklusif, tidak dimiliki Karyawan): UC_BOM, UC_Kasbon, UC_Gaji, UC_Vendor, UC_Rekonsiliasi, UC_Laporan, UC_Sensitif
   - Pemilik juga mewarisi seluruh akses Karyawan karena relasi extends

8. **Langkah 8: Susun Dokumen dengan Struktur Standar**
   Susun dokumen dengan urutan berikut:
   1. **Metadata Dokumen** (tabel: Versi, Status, Tanggal Dibuat, Disusun Oleh)
   2. **Pendahuluan** (tujuan, ruang lingkup, dan prinsip RBAC)
   3. **Legenda Notasi Akses** (definisi simbol C, R, U, D, ✓, ✗, Terbatas)
   4. **Prinsip Keamanan yang Diterapkan** (Least Privilege, Separation of Duties, Data Classification)
   5. **Definisi Peran Pengguna (Role Definitions)** (deskripsi detail Pemilik dan Karyawan)
   6. **Matriks Akses per Modul Fungsional** (tabel per modul F-01 s.d. F-09 dengan sub-fitur)
   7. **Matriks Akses per Entitas Data** (tabel per entitas data dengan operasi CRUD)
   8. **Daftar Data Sensitif dan Pembatasannya** (tabel terpisah khusus data sensitif)
   9. **Mapping Use Case ke Peran** (tabel mapping UC ke role)
   10. **Aturan Audit Trail** (operasi kritis yang wajib di-log)
   11. **Aturan Keamanan Tambahan** (enkripsi, token JWT, mekanisme filter data role)
   12. **Referensi Dokumen** (daftar file referensi yang digunakan)

9. **Langkah 9: Tulis Konten Final ke File Markdown**
   - Isi file `docs/sdlc/02_analysis/06_access_control_matrix.md` dengan konten final dokumen (overwrite isi file yang ada karena saat ini hanya berisi placeholder).
   - Gunakan format tabel Markdown untuk semua matriks akses.
   - Gunakan heading level yang konsisten (H2 untuk bagian utama, H3 untuk sub-bagian).
   - Pastikan semua tabel Markdown ter-render dengan benar (alignment header, pemisah kolom, isi sel tidak terpotong).

10. **Langkah 10: Validasi Kelengkapan Pemetaan Akses**
    - Cocokkan kembali setiap modul fungsional (F-01 s.d. F-09) — pastikan tidak ada modul yang terlewat.
    - Cocokkan kembali setiap entitas data dari Data Dictionary (28 tabel) — pastikan tidak ada entitas yang terlewat.
    - Cocokkan kembali setiap use case dari Use Case Diagram — pastikan tidak ada use case yang terlewat.
    - Cocokkan kembali setiap aturan bisnis terkait akses (BR-01, BR-10) — pastikan sudah diterapkan.

11. **Langkah 11: Validasi Konsistensi dengan Referensi**
    - Periksa apakah hak akses yang ditetapkan konsisten dengan relasi aktor di Use Case Diagram.
    - Periksa apakah pembatasan data sensitif konsisten dengan BR-10 dan catatan implementasi di Data Dictionary.
    - Periksa apakah modul yang diakses Karyawan konsisten dengan use case yang terhubung ke aktor Karyawan.
    - Periksa apakah modul eksklusif Pemilik konsisten dengan use case yang hanya terhubung ke aktor Pemilik.

12. **Langkah 12: Validasi Anti-Halusinasi**
    - Tinjau setiap baris matriks akses.
    - Untuk setiap keputusan akses, tanyakan: "Apakah ini punya dasar kuat dari referensi?"
    - Jika ada keputusan akses yang tidak bisa dilacak ke referensi, gunakan placeholder `[PERLU_KONFIRMASI_AKSES]`.
    - Jangan mengarang peran baru, modul baru, atau pembatasan akses yang tidak ada dasarnya.

13. **Langkah 13: Validasi Kebersihan Output**
    - Pastikan file target hanya berisi isi dokumen final yang bersih.
    - Jangan tinggalkan instruksi kerja, checklist, catatan internal, atau komentar diskusi.
    - Hasil akhir harus siap dipakai secara profesional sebagai referensi fase SDLC berikutnya.

14. **Langkah 14: Validasi Kelayakan untuk Dokumen Turunan**
    - Pastikan Access Control Matrix cukup kuat untuk dijadikan acuan oleh dokumen fase berikutnya:
      - `03_design/06_security_design.md` — apakah mekanisme RBAC sudah terdefinisi cukup jelas untuk diimplementasikan secara teknis?
      - `03_design/01_database_schema.sql` — apakah pembatasan akses per entitas data sudah jelas sehingga bisa diterapkan di level query?
      - `03_design/04_cli_interaction_flow.puml` — apakah menu dan sub-menu yang dapat dilihat per role sudah terdefinisi?
    - Jika belum cukup informatif, revisi hingga definisi akses benar-benar lengkap dan tidak ambigu.

15. **Langkah 15: Validasi Format Tabel Markdown**
    - Pastikan semua tabel Markdown ter-render dengan benar.
    - Periksa alignment header tabel, pemisah kolom, dan isi sel.
    - Pastikan tidak ada baris tabel yang rusak atau terpotong.
    - Pastikan semua simbol notasi (✓, ✗, C, R, U, D) terbaca dengan jelas di setiap sel tabel.
