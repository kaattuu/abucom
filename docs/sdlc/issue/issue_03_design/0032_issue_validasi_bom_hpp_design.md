# Issue #0032 — Validasi & Perbaikan Dokumen BOM & HPP Design

## Metadata Issue

| Atribut            | Detail                                                                 |
|--------------------|------------------------------------------------------------------------|
| **Nomor Issue**    | 0032                                                                   |
| **Judul**          | Validasi & Perbaikan Dokumen BOM & HPP Design                         |
| **Fase SDLC**      | 03_design                                                              |
| **Dokumen Target** | `docs/sdlc/03_design/05_bom_hpp_design.md`                            |
| **Status Dokumen** | [draft]                                                                |
| **Prioritas**      | Tinggi                                                                 |
| **Dibuat Oleh**    | Senior Manufacturing Engineer & Senior Cost Accounting Architect (AI) |
| **Tanggal**        | 2026-05-17                                                             |

---

## Persona yang Harus Digunakan

Kamu adalah **Senior Manufacturing Engineer** sekaligus **Senior Cost Accounting Architect** dan **Technical Documentation Reviewer** berpengalaman lebih dari 15 tahun dalam merancang sistem Bill of Materials (BOM) dan kalkulasi Harga Pokok Produksi (HPP) untuk industri percetakan dan manufaktur skala kecil-menengah berbasis sistem informasi Python/CLI. Kamu memiliki keahlian mendalam dalam:

- Merancang struktur BOM satu level dan multi-level untuk produk percetakan (stempel, cetak foto, baliho, undangan, dsb.).
- Memvalidasi formula kalkulasi HPP metode Average Cost terhadap standar akuntansi biaya industri.
- Mendeteksi data BOM yang tidak lengkap, harga modal yang masih kosong, atau formula yang tidak konsisten.
- Memastikan dokumen desain BOM-HPP cukup detail dan akurat sebagai referensi utama untuk fase implementasi (coding modul transaksi, gudang, dan pelaporan).
- Menilai kelengkapan skenario edge case agar implementor tidak perlu bertanya ulang.
- Memastikan semua data yang bersifat `[PERLU DIISI MANUAL]` diisi dengan nilai yang realistis, relevan, dan konsisten dengan konteks usaha percetakan AbuCom.

Kamu **tidak boleh berasumsi, berhenti di tengah jalan, atau melewatkan satu poin pun** dari instruksi ini. Kamu bekerja secara sistematis, teliti, dan bertanggung jawab penuh atas hasil akhir dokumen.

---

## Tujuan Issue

Melakukan **pemeriksaan, analisis, dan validasi menyeluruh** terhadap dokumen utama `05_bom_hpp_design.md` yang masih berstatus `[draft]`, lalu **menuangkan semua perbaikan langsung ke dalam file dokumen tersebut**, sehingga dokumen ini layak naik status dan siap dijadikan referensi utama untuk fase implementasi modul transaksi, gudang, waste management, dan pelaporan laba rugi.

---

## File yang Harus Dibaca Sebelum Mulai

Baca dan pahami **seluruh isi** file-file berikut sebelum melakukan satu pun perubahan. Jangan melewatkan satu file pun:

1. **Dokumen Target (yang akan diperbaiki):**
   - `docs/sdlc/03_design/05_bom_hpp_design.md`

2. **File Referensi Utama:**
   - `docs/sdlc/narasi.txt` — narasi kebutuhan bisnis asli dari pemilik usaha (baca dan periksa relevansinya)
   - `docs/sdlc/02_analysis/01_business_requirements.md` — kebutuhan bisnis BR-01 s.d BR-xx termasuk jenis layanan, produk, dan aturan harga
   - `docs/sdlc/02_analysis/02_software_requirements.md` — kebutuhan fungsional F-02 (Transaksi), F-03 (Gudang & BOM), F-04 (Job Tracking), F-05 (Waste)
   - `docs/sdlc/02_analysis/05_data_dictionary.md` — definisi entitas `materials`, `bom`, `products_services`, `transaction_items`, `production_waste`, `audit_trail`
   - `docs/sdlc/03_design/01_database_schema.sql` — DDL tabel `bom`, `materials`, `products_services`, `transaction_items`, `production_waste`
   - `docs/sdlc/03_design/02_erd_database.puml` — relasi antar entitas yang terkait BOM dan HPP
   - `docs/sdlc/03_design/03_system_architecture.md` — arsitektur berlapis, alur data transaksi, strategi keamanan

> **PERINGATAN:** Jangan mulai menulis atau mengubah apapun sebelum selesai membaca semua file di atas. Catat semua temuan dulu di memori kerja kamu, baru kemudian eksekusi perbaikan secara menyeluruh dalam satu langkah penulisan.

---

## Tahapan Pelaksanaan (Wajib Diikuti Secara Berurutan)

### TAHAP 1 — Komparasi Mendalam dengan Semua File Referensi

**Langkah 1.1 — Baca `narasi.txt`**
- Baca seluruh isi `docs/sdlc/narasi.txt`.
- Catat semua jenis produk/layanan percetakan yang disebut oleh pemilik usaha.
- Catat semua jenis bahan baku yang disebut (kertas, tinta, karet, flexi, dsb.).
- Catat semua aturan bisnis terkait harga, modal, dan perhitungan keuntungan.
- Tandai: apakah setiap elemen bisnis ini sudah terefleksi dalam BOM dan formula HPP di dokumen target?
- Jika `narasi.txt` sudah sepenuhnya tercakup oleh file referensi teknis lain, catat kesimpulan tersebut dan lanjutkan. Jangan melewatkan langkah ini.

**Langkah 1.2 — Baca `01_business_requirements.md`**
- Catat semua jenis layanan yang disebutkan: Percetakan, ATK, PPOB, Jasa Keuangan, Jasa Teknis.
- Catat semua produk percetakan yang disebutkan secara eksplisit.
- Catat aturan harga: Retail, Grosir, Mitra (BR-08).
- Catat aturan margin: apakah ada batas minimum margin laba?
- Bandingkan daftar produk di BRD dengan daftar produk di katalog BOM dokumen target. Catat produk yang ada di BRD tapi belum masuk katalog BOM.

**Langkah 1.3 — Baca `02_software_requirements.md`**
- Fokus pada F-02 (Transaksi Kasir), F-03 (Gudang & BOM), F-05 (Waste Management).
- Catat: fitur apa saja terkait BOM yang harus didukung sistem (Kelola BOM, Hitung HPP, Validasi Stok)?
- Catat: kalkulasi HPP dipicu oleh event apa saja?
- Catat: output apa yang harus dihasilkan (struk digital, laporan, dsb.)?
- Bandingkan dengan alur integrasi di dokumen target (Bagian 6). Catat yang hilang atau tidak akurat.

**Langkah 1.4 — Baca `05_data_dictionary.md`**
- Catat semua atribut tabel `bom`: nama kolom, tipe data, constraint, default value.
- Catat semua atribut tabel `materials`: nama kolom, tipe data, constraint (khususnya `cost_per_unit`, `stock_quantity`, `unit`).
- Catat semua atribut tabel `transaction_items`: nama kolom yang terkait HPP (`item_hpp`, `unit_price`, dsb.).
- Catat semua atribut tabel `production_waste`.
- Bandingkan dengan definisi yang digunakan di dokumen target. Catat ketidaksesuaian nama kolom, tipe data, atau constraint.

**Langkah 1.5 — Baca `01_database_schema.sql`**
- Cari definisi DDL tabel: `bom`, `materials`, `products_services`, `transaction_items`, `production_waste`.
- Catat nama kolom yang tepat, tipe data aktual, dan constraint yang didefinisikan.
- Verifikasi: apakah dokumen target menggunakan nama kolom yang persis sama dengan DDL?
- Catat setiap ketidaksesuaian (misal: dokumen menyebut `cost_per_unit` tapi di DDL namanya berbeda).

**Langkah 1.6 — Baca `02_erd_database.puml`**
- Catat relasi antar entitas: `products_services` ↔ `bom` ↔ `materials`.
- Verifikasi: apakah relasi yang dijelaskan di Bagian 2.1 dokumen target sudah sesuai dengan ERD?
- Catat jika ada entitas yang terlibat dalam ekosistem BOM-HPP tapi tidak disebutkan di dokumen target.

**Langkah 1.7 — Baca `03_system_architecture.md`**
- Catat lapisan arsitektur yang bertanggung jawab atas kalkulasi BOM-HPP (Business Logic Layer).
- Catat alur data transaksi dari perspektif arsitektur.
- Verifikasi: apakah alur integrasi di dokumen target (Bagian 6) konsisten dengan arsitektur sistem?

**Langkah 1.8 — Buat Daftar Temuan Gap**
- Buat daftar temuan di memori kerja kamu berisi:
  - `[MISSING]` — data/informasi yang ada di referensi tapi tidak ada di dokumen target
  - `[INACCURATE]` — data yang ada di dokumen target tapi berbeda dari referensi
  - `[INCOMPLETE]` — data yang ada tapi tidak cukup detail untuk diimplementasikan
  - `[EMPTY]` — field yang masih kosong atau berisi placeholder `[PERLU DIISI MANUAL]`
  - `[ORPHAN]` — data yang ada di dokumen target tapi tidak didukung referensi manapun

---

### TAHAP 2 — Validasi Kelengkapan Katalog BOM

**Langkah 2.1 — Periksa apakah semua produk percetakan utama sudah memiliki BOM:**
- [ ] Stempel Flash
- [ ] Cetak Foto (4R, A4, 10R — apakah semua ukuran sudah ada atau hanya 4R?)
- [ ] Buku Yasin
- [ ] Undangan Pernikahan
- [ ] Cetak Baliho (berbagai ukuran)
- [ ] Cetak Stiker A3+
- [ ] Nama Dada (Name Tag)
- [ ] Produk lain yang disebut di BRD atau narasi.txt tapi belum ada di katalog BOM

**Langkah 2.2 — Periksa kelengkapan setiap baris BOM:**
- Apakah setiap bahan baku memiliki satuan (UoM) yang jelas dan konsisten dengan tabel konversi?
- Apakah `required_qty` sudah menggunakan tipe data `DECIMAL` (bukan integer)?
- Apakah setiap bahan baku sudah disebutkan bersumber dari tabel `materials`?

**Langkah 2.3 — Isi semua harga modal yang masih kosong:**
- Dokumen target saat ini memiliki banyak baris dengan nilai `[PERLU DIISI MANUAL: harga beli aktual dari supplier]`.
- Kamu **wajib mengisi** semua nilai ini dengan harga yang realistis dalam konteks usaha percetakan skala kecil-menengah di Indonesia (dalam Rupiah).
- Gunakan estimasi harga pasar yang wajar dan konsisten. Contoh acuan:
  - Gagang stempel: Rp 5.000 – Rp 8.000/pcs
  - Karet flash: Rp 80 – Rp 120/cm²
  - Tinta stempel: Rp 300 – Rp 500/ml
  - Kertas foto glossy 4R (10x15cm = 150 cm²): Rp 500 – Rp 800/lembar → konversi ke per cm²
  - Bahan flexi 280gr: Rp 12.000 – Rp 18.000/m²
  - Tinta solvent: Rp 80 – Rp 120/ml
- Cantumkan semua harga yang kamu isi dalam tabel katalog BOM di Bagian 3.
- Pastikan harga yang kamu isi konsisten dengan contoh perhitungan di Bagian 5.2.

---

### TAHAP 3 — Validasi Relevansi dan Fokus Dokumen

**Langkah 3.1 — Periksa apakah semua konten memang milik dokumen BOM & HPP Design:**
- Dokumen ini harus fokus pada: struktur data BOM, katalog komposisi bahan baku, strategi konversi UoM, formula HPP, alur integrasi ke modul lain, skenario edge case BOM-HPP.
- **Bukan milik dokumen ini:** detail DDL database (ada di `01_database_schema.sql`), detail arsitektur kelas Python (ada di `03_system_architecture.md`), detail alur CLI (ada di `04_cli_interaction_flow.puml`).
- Jika ada konten yang terlalu masuk ke domain dokumen lain, sederhanakan menjadi referensi singkat saja.

**Langkah 3.2 — Periksa konsistensi terminologi:**
- Pastikan istilah yang digunakan konsisten di seluruh dokumen: `HPP` (bukan berganti-ganti dengan `COGS` atau `modal`).
- Pastikan nama kolom database konsisten dengan DDL aktual.
- Pastikan nama tabel database konsisten dengan DDL aktual.

---

### TAHAP 4 — Validasi Standar Struktur Dokumen

**Langkah 4.1 — Periksa kelengkapan elemen struktur dokumen:**

- [ ] **Metadata dokumen:** Versi, Status, Tanggal, Disusun Oleh
- [ ] **Pendahuluan & Tujuan:** menjelaskan ruang lingkup dengan jelas
- [ ] **Definisi Struktur BOM:** relasi entitas dan penjelasan kolom kunci
- [ ] **Katalog BOM Produk:** minimal 6 produk dengan semua bahan baku dan harga terisi
- [ ] **Strategi Konversi UoM:** tabel konversi lengkap untuk semua kategori satuan
- [ ] **Formula Kalkulasi HPP:** formula matematis dan contoh perhitungan nyata
- [ ] **Alur Integrasi BOM-HPP ke Transaksi:** langkah-langkah atomik yang jelas
- [ ] **Strategi Cross-Usage Stok:** aturan prioritas dan sinkronisasi stok retail vs produksi
- [ ] **Integrasi Waste Management:** alur pencatatan limbah dan dampak ke stok
- [ ] **Integrasi HPP ke Pelaporan Laba Rugi:** formula dan metrik profitabilitas
- [ ] **Skenario Edge Case dan Validasi:** minimal 4 skenario kritis
- [ ] **Skema Harga Bertingkat dan HPP:** aturan margin check
- [ ] **Strategi Versioning Harga (Average Cost):** formula restock dan update cost
- [ ] **Tabel Mapping Entitas BOM-HPP:** pemetaan peran setiap entitas
- [ ] **Referensi Dokumen:** daftar file referensi lengkap di bagian paling akhir

**Langkah 4.2 — Periksa apakah ada bagian penting yang belum ada dan perlu ditambahkan:**
- Apakah ada penjelasan tentang **kondisi produk yang tidak memiliki BOM** (ATK, PPOB, Jasa) dan bagaimana HPP-nya dihitung? Jika belum ada, tambahkan.
- Apakah ada penjelasan tentang **alur Kelola BOM** dari sisi CLI (tambah bahan, hapus bahan, update qty)? Jika belum ada, tambahkan ringkasannya.
- Apakah ada penjelasan tentang **trigger otomatis rekalkulasi HPP** saat ada perubahan `cost_per_unit` di tabel `materials`? Jika belum ada, tambahkan.

---

### TAHAP 5 — Validasi Kelayakan sebagai Referensi Fase Berikutnya

**Langkah 5.1 — Simulasikan sebagai junior programmer yang akan mengerjakan modul berikut:**

Bayangkan kamu adalah junior programmer yang akan membuat kode Python menggunakan `05_bom_hpp_design.md` sebagai referensi utama untuk modul-modul berikut:
- `modules/transactions.py` — modul transaksi kasir yang memanggil kalkulasi HPP
- `modules/inventory.py` — modul gudang yang mengelola stok material dan BOM
- `modules/waste.py` — modul pencatatan limbah produksi
- `modules/reports.py` — modul laporan laba rugi
- `04_implementation/03_module_structure.md` — struktur modul
- `03_design/06_security_design.md` — desain keamanan

**Langkah 5.2 — Untuk setiap modul, periksa:**
- Apakah dokumen sudah memberikan informasi yang cukup untuk membuat fungsi `calculate_hpp(product_id, quantity)`?
- Apakah langkah validasi stok sebelum transaksi sudah cukup detail (query apa, kondisi apa, pesan error apa)?
- Apakah alur rollback transaksi saat stok tidak cukup sudah dijelaskan?
- Apakah formula Average Cost sudah cukup detail untuk diimplementasikan dalam fungsi `update_material_cost(material_id, qty_baru, harga_beli_baru)`?
- Catat semua pertanyaan yang tidak terjawab dan tambahkan jawaban/penjelasannya ke dokumen target.

---

### TAHAP 6 — Validasi Bahasa Indonesia

**Langkah 6.1 — Periksa kualitas bahasa di seluruh dokumen:**
- Baca semua kalimat dalam dokumen.
- Tandai kalimat yang:
  - Ambigu atau bisa ditafsirkan lebih dari satu cara
  - Menggunakan istilah teknis tanpa penjelasan (untuk istilah yang belum diperkenalkan sebelumnya)
  - Menggunakan kalimat pasif yang tidak jelas subjeknya
  - Terlalu panjang dan membingungkan (pecah menjadi beberapa kalimat)

**Langkah 6.2 — Standar bahasa yang harus dipenuhi:**
- Gunakan kalimat aktif dan langsung.
- Istilah teknis standar (BOM, HPP, Average Cost, ACID, JWT) boleh digunakan apa adanya.
- Nama kolom dan tabel database harus ditulis dalam format `code` (backtick).
- Setiap aturan bisnis harus diawali dengan kata yang tegas: "Sistem **wajib**...", "Sistem **harus**...", "Sistem **tidak boleh**...".

---

### TAHAP 7 — Validasi Data Kosong dan Kelengkapan

**Langkah 7.1 — Periksa semua bagian untuk data yang tidak lengkap:**
- Apakah ada field dalam tabel katalog BOM yang masih berisi `[PERLU DIISI MANUAL]`?
- Apakah ada contoh perhitungan yang menggunakan nilai placeholder?
- Apakah ada skenario edge case yang hanya disebutkan judul tapi tidak ada penjelasannya?
- Apakah ada referensi ke tabel atau kolom database yang namanya tidak valid?

**Langkah 7.2 — Isi semua data yang kosong:**
- **Harga modal material:** Isi semua nilai `[PERLU DIISI MANUAL]` dengan harga realistis dalam Rupiah sesuai instruksi di Langkah 2.3.
- **Contoh perhitungan:** Pastikan semua angka dalam contoh di Bagian 5.2 konsisten dengan harga yang telah diisi di katalog BOM Bagian 3.
- Jangan mengisi data dengan asumsi yang tidak berdasar — gunakan logika harga pasar percetakan Indonesia yang wajar.
- Jika benar-benar ada data yang tidak bisa ditentukan dari referensi manapun, tandai dengan: `[PERLU DIKONFIRMASI: deskripsi kebutuhan data]`.

---

### TAHAP 8 — Eksekusi Perbaikan ke Dokumen Target

> **PENTING:** Semua perbaikan harus dituangkan langsung ke file `docs/sdlc/03_design/05_bom_hpp_design.md`. Jangan membuat file baru atau file sementara.

**Langkah 8.1 — Tulis ulang atau tambahkan konten yang diperbaiki:**
- Terapkan semua temuan dari Tahap 1–7 langsung ke dokumen.
- Jika ada bagian yang perlu ditambahkan, sisipkan di posisi yang logis sesuai alur dokumen.
- Jika ada kalimat yang perlu diperbaiki, perbaiki langsung.
- Jika ada data yang perlu diisi, isi langsung.
- Jika ada tabel yang perlu diperluas, perluas tabelnya.

**Langkah 8.2 — Update versi dokumen di metadata:**
- Ubah versi di tabel metadata dari `1.0.0` menjadi `1.1.0`.
- Contoh perubahan:
  ```
  | **Versi** | 1.0.0 |   →   | **Versi** | 1.1.0 |
  ```

**Langkah 8.3 — Status dokumen JANGAN diubah:**
- Status dokumen **tetap `[draft]`** — perubahan status adalah wewenang pemilik proyek, bukan tugasmu.
- Jangan mengubah baris `| **Status** | [draft] |` menjadi apapun.

**Langkah 8.4 — Tambahkan referensi baru jika ada:**
- Jika dalam proses perbaikan kamu menggunakan file referensi yang belum tercantum di Bagian 14 (Referensi Dokumen), tambahkan file tersebut di baris paling bawah daftar tersebut.
- Format: `- \`path/ke/file\``

---

### TAHAP 9 — Verifikasi Akhir Setelah Perbaikan

Setelah semua perbaikan diterapkan, lakukan verifikasi akhir dengan membaca ulang seluruh dokumen dari awal hingga akhir:

**Checklist Verifikasi Akhir:**
- [ ] Semua harga modal di katalog BOM sudah terisi (tidak ada `[PERLU DIISI MANUAL]` yang tersisa)
- [ ] Nama kolom dan tabel konsisten dengan DDL di `01_database_schema.sql`
- [ ] Formula HPP matematis valid dan contoh perhitungan menggunakan angka yang konsisten dengan katalog
- [ ] Alur integrasi ke transaksi kasir sudah mencakup: lookup BOM → validasi stok → kalkulasi HPP → potong stok → audit trail → commit
- [ ] Alur rollback saat stok tidak cukup sudah dijelaskan
- [ ] Formula Average Cost untuk restock sudah ada dan benar
- [ ] Skenario edge case minimal mencakup: produk tanpa BOM, material habis di tengah proses, pembatalan transaksi, retur barang
- [ ] Skema harga bertingkat (Retail/Grosir/Mitra) dan dampaknya ke margin sudah dijelaskan
- [ ] Integrasi waste management sudah lengkap (input, dampak stok, dampak akuntansi)
- [ ] Integrasi ke laporan laba rugi sudah lengkap dengan formula
- [ ] Bahasa Indonesia natural, tidak ambigu, dan mudah dipahami junior programmer
- [ ] Tidak ada kalimat yang terlalu teknis tanpa penjelasan
- [ ] Tabel mapping entitas BOM-HPP mencakup semua entitas yang terlibat
- [ ] Referensi dokumen di Bagian 14 sudah lengkap dan semua path valid
- [ ] Versi sudah diupdate ke `1.1.0`
- [ ] Status tetap `[draft]`

---

## Poin Tambahan Spesifik untuk Dokumen BOM & HPP Design

Selain poin-poin umum di atas, khusus untuk dokumen BOM & HPP pada proyek AbuCom percetakan, periksa juga:

**A. Konsistensi Satuan Ukur Lintas Dokumen:**
- Verifikasi bahwa satuan ukur (UoM) yang digunakan di katalog BOM konsisten dengan satuan yang didefinisikan di tabel `materials` pada `05_data_dictionary.md` dan `01_database_schema.sql`.
- Jika ada ketidaksesuaian satuan, sesuaikan dan catat alasan penyesuaiannya.

**B. Penanganan Produk Dimensi Kustom (Baliho, Stiker):**
- Verifikasi bahwa dokumen sudah menjelaskan secara detail bagaimana sistem menghitung `required_qty` untuk produk yang ukurannya bisa bervariasi (input panjang × lebar dari kasir).
- Pastikan ada penjelasan tentang bagaimana nilai `required_qty` di tabel `bom` diperlakukan untuk produk dimensi kustom vs produk fixed-size.

**C. Konsistensi Contoh Perhitungan:**
- Pastikan semua angka dalam contoh perhitungan (Bagian 5.2) konsisten dengan harga yang ada di katalog BOM (Bagian 3).
- Jika sebelumnya ada nilai contoh yang tidak konsisten dengan harga yang baru diisi, update contoh perhitungannya.

**D. Aturan Pembulatan HPP:**
- Apakah dokumen sudah menjelaskan aturan pembulatan untuk nilai HPP? (Misal: dibulatkan ke satuan Rupiah terdekat, atau disimpan dengan presisi 4 desimal di database?)
- Jika belum ada, tambahkan penjelasannya.

**E. Penanganan HPP untuk Layanan Non-Percetakan:**
- Dokumen harus secara eksplisit menjelaskan bagaimana HPP dihitung untuk: ATK (dari `cost_per_unit` di `products_services`), PPOB (modal = nilai tagihan), Jasa Teknis (modal = 0 atau biaya suku cadang), Jasa Keuangan (modal = nilai uang yang ditransfer).
- Jika bagian ini belum ada atau belum lengkap, tambahkan sebagai sub-bagian baru.

**F. Validasi Stok Sebelum Transaksi — Detail Query:**
- Dokumen harus menyebutkan secara eksplisit query atau logika yang digunakan untuk validasi stok: `SELECT stock_quantity FROM materials WHERE material_id = ?` dan kondisi `stock_quantity >= required_qty * order_qty`.
- Jika belum ada, tambahkan penjelasan low-level ini agar junior programmer tidak ambigu.

---

## Output yang Diharapkan

Setelah issue ini selesai diimplementasikan:

1. **File `docs/sdlc/03_design/05_bom_hpp_design.md`** sudah diperbarui dengan:
   - Versi `1.1.0` di metadata
   - Semua harga modal di katalog BOM sudah terisi dengan nilai Rupiah yang realistis
   - Semua contoh perhitungan konsisten dengan harga yang terisi
   - Semua bagian yang kurang detail sudah diperlengkap
   - Semua bagian yang kurang (sesuai checklist) sudah ditambahkan
   - Bahasa Indonesia yang natural dan tidak ambigu
   - Referensi dokumen yang lengkap di bagian akhir

2. **Tidak ada file baru** yang dibuat selain perubahan pada file target di atas.

3. **Tidak ada perubahan pada file referensi** — file referensi hanya dibaca, tidak dimodifikasi.

4. **Status di `sdlc.txt` tidak diubah** — perubahan status adalah wewenang pemilik proyek.

---

## Referensi Issue Ini

- `docs/sdlc/03_design/05_bom_hpp_design.md` — dokumen target
- `docs/sdlc/narasi.txt`
- `docs/sdlc/02_analysis/01_business_requirements.md`
- `docs/sdlc/02_analysis/02_software_requirements.md`
- `docs/sdlc/02_analysis/05_data_dictionary.md`
- `docs/sdlc/03_design/01_database_schema.sql`
- `docs/sdlc/03_design/02_erd_database.puml`
- `docs/sdlc/03_design/03_system_architecture.md`
