# Project Charter — Sistem Manajemen Usaha Percetakan "AbuCom"

## Metadata Dokumen

| Atribut              | Detail                                                  |
| -------------------- | ------------------------------------------------------- |
| **Versi**            | 1.1.0                                                   |
| **Status**           | [done]                                                  |
| **Tanggal Dibuat**   | 2026-05-11                                              |
| **Tanggal Direvisi** | 2026-05-11                                              |
| **Disusun Oleh**     | Senior IT Project Manager (AI Review)                   |
| **Catatan Revisi**   | v1.1.0 — Validasi menyeluruh: pengisian placeholder, penambahan estimasi anggaran & timeline, perbaikan struktur organisasi (7 posisi), penambahan SMART Goals, penambahan bagian Riwayat Versi, dan penambahan seksi Referensi Dokumen formal. |

---

## 1. Nama & Deskripsi Proyek

| Atribut               | Detail                                                                                                                                                                                                                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Nama Proyek**       | AbuCom — Sistem Manajemen Usaha Percetakan Terpadu                                                                                                                                                                                                                                   |
| **Deskripsi Singkat** | Pembangunan aplikasi berbasis CLI (Command Line Interface) menggunakan bahasa Python dengan paradigma Functional Programming, yang mengintegrasikan seluruh proses operasional usaha percetakan UMKM ke dalam satu platform terpusat. Aplikasi ini mencakup manajemen produksi, penjualan retail, layanan digital (PPOB), jasa keuangan, jasa teknis, administrasi SDM, keuangan, serta pelaporan bisnis yang komprehensif. |
| **Jenis Proyek**      | Pengembangan Perangkat Lunak Baru (*Greenfield Development*)                                                                                                                                                                                                                          |
| **Metodologi**        | Software Development Life Cycle (SDLC) — Waterfall                                                                                                                                                                                                                                   |

---

## 2. Latar Belakang & Tujuan Bisnis

### 2.1 Latar Belakang Masalah

Pemilik usaha merupakan pelaku UMKM di bidang layanan jasa percetakan yang mengelola dan menjalankan seluruh operasional secara mandiri (satu orang). Usaha ini memiliki lima lini layanan utama:

1. **Produk Percetakan** — cetak stempel flash, cetak foto, buku yasin, undangan pernikahan, baliho, fotocopy, pengetikan, print data, cetak stiker, nama dada, dan percetakan kustom lainnya.
2. **Penjualan Alat Tulis Kantor (ATK)** — kertas HVS, kertas foto, kertas undangan, tinta, pulpen, hekter, map (snelhechter, biasa, warna), lakban, selotip, pensil, dan perlengkapan kantor lainnya.
3. **Layanan Digital & PPOB** — pulsa handphone, token listrik, paket data, dan pembayaran tagihan listrik.
4. **Jasa Keuangan** — transfer uang antar bank dan tarik tunai melalui berbagai akun digital (Agen Bank Mandiri, Dana, Gopay, LinkAja, ShopeePay, OVO).
5. **Jasa Teknis** — perbaikan (*service*) printer dan instalasi ulang sistem operasi komputer/laptop.

Seluruh pencatatan operasional saat ini dilakukan secara manual menggunakan Microsoft Excel dengan data yang tersebar di berbagai file. Kondisi ini menimbulkan beberapa permasalahan kritis:

- **Beban kerja berlebihan** — pemilik menangani semua pekerjaan sendirian mulai dari melayani pelanggan langsung, merespons pesanan WhatsApp, mendesain, memproduksi, mengemas, mencatat transaksi, mengelola stok, hingga melakukan pengadaan bahan baku.
- **Pencatatan tidak akurat** — pengurangan stok, pelaporan keuangan, dan rekonsiliasi kas dilakukan manual sehingga rawan kesalahan.
- **Data berserakan** — file Excel tersebar tanpa struktur terpadu, menyulitkan pelacakan dan analisis bisnis.
- **Stres dan burnout** — tekanan operasional yang ditanggung seorang diri menyebabkan kondisi mental pemilik terganggu.

### 2.2 Tujuan Bisnis (Business Case)

| No. | Tujuan                                                                                                    |
| --- | --------------------------------------------------------------------------------------------------------- |
| 1   | **Mengotomatisasi seluruh proses operasional** usaha percetakan ke dalam satu aplikasi terpadu.           |
| 2   | **Menghasilkan laporan keuangan dan stok yang akurat** secara otomatis sehingga pemilik dapat fokus pada strategi pengembangan usaha. |
| 3   | **Mendukung pengelolaan multi-karyawan** yang profesional dengan sistem SDM, penggajian, dan insentif terintegrasi. |
| 4   | **Menyediakan analisis laba/rugi per layanan** untuk pengambilan keputusan bisnis yang tepat.             |
| 5   | **Mempersiapkan arsitektur yang skalabel** untuk ekspansi multi-cabang di masa depan.                    |

### 2.3 Sasaran Proyek (SMART Goals)

| No. | Sasaran                                                                                                        | Indikator Keberhasilan                                                                  |
| --- | -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| 1   | **Spesifik**: Membangun 20 modul fungsional yang mencakup seluruh lini operasional usaha percetakan.           | Seluruh 20 modul berhasil diimplementasikan dan lolos pengujian.                        |
| 2   | **Terukur**: Mengurangi waktu pencatatan manual harian pemilik hingga lebih dari 80%.                          | Pemilik tidak lagi melakukan pencatatan Excel setelah sistem aktif digunakan.           |
| 3   | **Dapat Dicapai**: Dikembangkan secara bertahap oleh satu Junior Programmer dibantu tim AI dalam 12 bulan.    | Milestone per fase SDLC tercapai sesuai jadwal yang disepakati.                        |
| 4   | **Relevan**: Sistem langsung menjawab kebutuhan operasional nyata yang telah didokumentasikan di narasi.txt.  | Setiap modul dapat langsung digunakan untuk operasional harian setelah selesai.        |
| 5   | **Berbatas Waktu**: Modul inti (percetakan, ATK, stok, keuangan) selesai dalam 6 bulan pertama.              | Modul inti aktif digunakan pada bulan ke-6 setelah pengembangan dimulai.               |

---

## 3. Ruang Lingkup Proyek

### 3.1 Dalam Cakupan (*In-Scope*)

Berikut adalah modul-modul fungsional yang termasuk dalam cakupan pengembangan:

| No. | Modul                                    | Deskripsi Singkat                                                                                                                                                                                          |
| --- | ---------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | **Manajemen Produk Percetakan**           | Pencatatan pesanan, pelacakan status pesanan (Antri → Proses Desain → Produksi → Selesai → Diambil), arsip lokasi file desain pelanggan, dan pencatatan limbah produksi (*waste management*).              |
| 2   | **Manajemen Penjualan ATK (Retail)**      | Pencatatan penjualan, pengecekan harga, perhitungan total dan kembalian, pengelolaan stok otomatis, serta penentuan harga jual berdasarkan harga beli terbaru.                                              |
| 3   | **Manajemen Layanan PPOB**                | Pencatatan transaksi pulsa HP, token listrik, paket data, dan tagihan listrik; pengelolaan saldo multi-akun (dua akun berbeda) dengan peringatan saldo minimum.                                            |
| 4   | **Manajemen Jasa Keuangan**               | Pencatatan transaksi transfer dan tarik tunai melalui multi-akun digital (Agen Bank Mandiri, Dana, Gopay, LinkAja, ShopeePay, OVO); pemilihan akun dengan biaya admin termurah; pengelolaan saldo per akun. |
| 5   | **Manajemen Jasa Teknis**                 | Pencatatan transaksi service printer dan instalasi OS untuk keperluan pelaporan.                                                                                                                            |
| 6   | **Manajemen Stok & Gudang**               | Pengelolaan stok bahan baku dan barang retail; notifikasi pengadaan otomatis; stock opname (rekonsiliasi stok fisik vs sistem); dukungan satuan ukur multi-dimensi (rim, lembar, dimensi panjang×lebar, volume); dan dukungan angka desimal untuk presisi. |
| 7   | **Sistem HPP & BOM**                      | Perhitungan Harga Pokok Penjualan (HPP) otomatis berdasarkan Bill of Materials (BOM); dukungan produk multi-bahan baku; perhitungan pemakaian berdasarkan dimensi/volume; serta integrasi stok retail-produksi. |
| 8   | **Sistem Harga & Pembayaran**             | Dukungan skema harga retail, grosir (berdasarkan kuantitas), dan harga spesial mitra. Sistem pembayaran fleksibel dengan uang muka (DP) dan pelunasan saat pengambilan. Alur pembatalan pesanan (pengembalian DP) dan retur barang rusak/salah cetak. |
| 9   | **Manajemen Antrian & Pelacakan Pesanan** | Sistem *job tracking* dengan status: Antri, Proses Desain, Produksi, Selesai, Diambil — agar tidak ada pesanan yang terlewat atau terlupa dikerjakan.                                                      |
| 10  | **Manajemen SDM & Penggajian**            | Data karyawan, proses seleksi, status kerja (tetap/kontrak), penilaian kinerja, sistem penggajian otomatis (gaji tetap vs persentase pendapatan bersih), kasbon dengan potongan gaji otomatis, dan pelacakan kehadiran terintegrasi ke penggajian. |
| 11  | **Sistem Poin Karyawan (Insentif)**       | Perhitungan insentif berdasarkan beban kerja: 1 Poin (Rp 500) untuk transaksi rutin/mudah; 3 Poin (Rp 1.500) untuk jasa dasar; 5 Poin (Rp 2.500) untuk produk kustom; 10 Poin (Rp 5.000) untuk pekerjaan berat/teknis. |
| 12  | **Manajemen Pinjaman**                    | Pencatatan pinjaman tanpa bunga (dari kerabat/keluarga) dengan riwayat penarikan/peminjaman ulang; serta pinjaman bank (BRI & Mandiri) dengan riwayat setoran, sisa tenor, dan tanggal jatuh tempo. |
| 13  | **Manajemen Keuangan & Pelaporan**        | Pencatatan pengeluaran rutin (air, listrik, internet), anggaran biaya tak terduga, rekonsiliasi kas (uang fisik di laci vs sistem), laporan harian hingga tahunan, dan analisis laba/rugi per layanan. |
| 14  | **Manajemen Aset**                        | Pencatatan aset usaha (printer, PC, CCTV, dll.), tabungan khusus pengadaan alat baru, dan pengelolaan pengeluaran rutin terintegrasi.                                                                      |
| 15  | **Manajemen Supplier & Hutang Usaha**     | Data vendor/supplier bahan baku, riwayat harga beli (untuk analisis harga termurah), dan pencatatan hutang pembelian ke supplier.                                                                          |
| 16  | **Database Pelanggan (CRM)**              | Penyimpanan data kontak pelanggan (nama, nomor WhatsApp), riwayat pesanan, dan dukungan kebutuhan promosi di masa depan.                                                                                   |
| 17  | **Keamanan & Audit**                      | Sistem hak akses berbasis peran (Pemilik vs Karyawan); audit trail (catatan aktivitas: siapa melakukan apa dan kapan); enkripsi data sensitif; serta perlindungan data sensitif (pinjaman bank, tabungan pribadi). |
| 18  | **Input Data Awal (Migrasi)**             | Fasilitas input data awal secara manual ke dalam aplikasi untuk menggantikan data Excel yang berserakan agar database menjadi rapi, bersih, dan konsisten.                                                 |
| 19  | **Arsitektur Multi-Cabang**               | Setiap entitas data (transaksi, stok, karyawan, aset, keuangan) memiliki identifikasi unit/cabang, siap ekspansi hingga ribuan cabang dengan laporan konsolidasi yang akurat.                              |
| 20  | **Inovasi & Best Practice Industri**      | Analisis aktif terhadap standar industri percetakan dan retail modern untuk mengusulkan fitur tambahan yang meningkatkan kualitas sistem, efisiensi operasional, dan perlindungan data.                     |

### 3.2 Di Luar Cakupan (*Out-of-Scope*)

| No. | Item                                                                                                               |
| --- | ------------------------------------------------------------------------------------------------------------------ |
| 1   | Antarmuka grafis (GUI/Web/Mobile) — tahap awal menggunakan tampilan CLI/Console.                                   |
| 2   | Integrasi langsung dengan API pihak ketiga (payment gateway, marketplace, WhatsApp API) untuk transaksi otomatis. |
| 3   | Sistem e-commerce atau toko online untuk pelanggan.                                                                |
| 4   | Aplikasi mobile untuk pelanggan.                                                                                   |
| 5   | Deployment ke cloud server — tahap awal berjalan secara lokal.                                                    |

---

## 4. Target Pengguna & Pemangku Kepentingan (*Stakeholders*)

### 4.1 Pengguna Utama

| Peran                         | Deskripsi                                                                                                                     | Hak Akses                 |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| **Pemilik (Kepala Percetakan)** | Mengelola seluruh operasional, melihat semua data termasuk data sensitif (pinjaman bank, tabungan pribadi), dan mengambil keputusan strategis. | Penuh (*Full Access*)     |
| **Pramuniaga**                | Melayani pelanggan di garda depan, menjelaskan produk/layanan, dan mencatat transaksi penjualan.                               | Terbatas (*Operational*)  |
| **Kasir**                     | Menangani transaksi pembayaran, rekonsiliasi uang fisik di laci, dan pencatatan keuangan harian.                              | Terbatas (*Operational*)  |
| **Desainer**                  | Mengelola proses desain pesanan produk unggulan dan arsip file desain pelanggan.                                               | Terbatas (*Operational*)  |
| **Bagian Produksi Cetak**     | Mengeksekusi proses cetak, finishing produk, dan mencatat limbah produksi.                                                    | Terbatas (*Operational*)  |
| **Staf Fotocopy & Print**     | Menangani layanan fotocopy, print dokumen, dan pengetikan untuk pelanggan.                                                    | Terbatas (*Operational*)  |
| **Bagian Gudang**             | Mengelola stok bahan baku, barang retail, pengadaan, dan stock opname.                                                        | Terbatas (*Operational*)  |

### 4.2 Pemangku Kepentingan Lainnya

| Peran                    | Kepentingan                                                                                                                            |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| **Pelanggan**            | Penerima layanan yang datanya dicatat dalam CRM; pesanannya dilacak melalui sistem job tracking.                                       |
| **Supplier/Vendor**      | Pemasok bahan baku yang datanya dikelola dalam modul manajemen supplier; riwayat harga beli dicatat untuk analisis harga termurah.     |
| **Pemberi Pinjaman**     | Sahabat, kerabat, keluarga, dan orang tua yang meminjamkan modal tanpa bunga; saldo dan riwayat penarikan dicatat secara transparan.   |
| **Bank (BRI & Mandiri)** | Lembaga keuangan yang memberikan pinjaman modal berbunga; riwayat setoran, sisa tenor, dan tanggal jatuh tempo dipantau melalui sistem.|
| **Tim Pengembang (AI)**  | Tim yang bertanggung jawab membangun dan memelihara aplikasi sesuai spesifikasi SDLC yang telah disepakati.                            |

---

## 5. Kriteria Kesuksesan (*Success Criteria*)

| No. | Kriteria                                                                                                                                  |
| --- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Seluruh 20 modul fungsional berhasil diimplementasikan dan berfungsi sesuai spesifikasi.                                                  |
| 2   | Laporan keuangan (harian, mingguan, bulanan, hingga tahunan) dihasilkan secara otomatis dengan data yang akurat.                          |
| 3   | Stok bahan baku dan barang retail terkelola secara otomatis dengan dukungan perhitungan dimensi/volume dan angka desimal.                 |
| 4   | Sistem HPP menghitung biaya produksi secara otomatis berdasarkan komposisi BOM setiap produk.                                            |
| 5   | Sistem penggajian berjalan otomatis sesuai dua skema (gaji tetap atau persentase) beserta kasbon dengan potongan gaji otomatis.          |
| 6   | Sistem poin insentif karyawan menghitung tambahan penghasilan secara akurat berdasarkan beban kerja.                                     |
| 7   | Rekonsiliasi kas (uang fisik vs sistem) dan stock opname (stok fisik vs sistem) berjalan tanpa selisih signifikan.                       |
| 8   | Audit trail mencatat seluruh aktivitas pengguna tanpa celah untuk mendukung transparansi dan pencegahan kecurangan.                      |
| 9   | Hak akses berbasis peran berfungsi dengan benar — karyawan tidak dapat mengakses data sensitif pemilik.                                  |
| 10  | Arsitektur database mendukung identifikasi unit/cabang pada setiap entitas data, siap untuk ekspansi multi-cabang.                       |
| 11  | Pemilik usaha dapat fokus pada strategi pengembangan usaha dan tidak lagi terbebani pencatatan manual harian.                            |

---

## 6. Asumsi, Kendala & Risiko Tingkat Tinggi

### 6.1 Asumsi

| No. | Asumsi                                                                                                                              |
| --- | ----------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Pemilik usaha bersedia melakukan input data awal secara manual ke dalam aplikasi untuk menggantikan data Excel yang berserakan.     |
| 2   | Infrastruktur perangkat keras (komputer/laptop) yang digunakan sudah mendukung Python 3.14.2 dan MySQL.                             |
| 3   | Sistem operasi yang digunakan adalah Linux Debian 12 Bookworm atau Windows 11 sesuai spesifikasi.                                   |
| 4   | Budaya kerja *cross-functional* yang diterapkan memungkinkan semua karyawan menggunakan aplikasi sesuai kebutuhan operasional.       |
| 5   | Tim pengembang (AI) memiliki akses penuh ke seluruh dokumentasi dan kode sumber proyek selama pengembangan berlangsung.             |
| 6   | Pemilik usaha tersedia untuk sesi klarifikasi kebutuhan bisnis jika ditemukan ambiguitas selama fase analisis dan pengembangan.     |

### 6.2 Kendala

| No. | Kendala                                                                                                                                                  |
| --- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Tahap awal menggunakan tampilan CLI/Console, sehingga kurva pembelajaran bagi pengguna non-teknis cukup tinggi dan memerlukan panduan pengguna yang baik. |
| 2   | Paradigma Functional Programming bersifat wajib, yang membatasi pola desain tertentu dalam implementasi.                                                 |
| 3   | Pengembangan dilakukan oleh satu Junior Programmer dibantu tim AI, sehingga kecepatan pengembangan bergantung pada koordinasi yang efektif.               |
| 4   | **Estimasi Anggaran**: Proyek ini diperkirakan tidak memerlukan biaya lisensi perangkat lunak karena seluruh teknologi yang digunakan bersifat *open-source* (Python, MySQL, library open-source). Biaya utama adalah waktu pengembangan dan biaya operasional server lokal. Total estimasi biaya langsung: Rp 0 — Rp 500.000 (untuk kebutuhan infrastruktur minor jika diperlukan). |
| 5   | **Estimasi Timeline**: Total durasi pengembangan diestimasi **12 bulan**, dengan pembagian sebagai berikut: Fase Planning & Analysis (Bulan 1–2), Fase Design (Bulan 3), Fase Implementation — Modul Inti (Bulan 4–7), Fase Implementation — Modul Lanjutan (Bulan 8–10), Fase Testing & UAT (Bulan 11), Fase Deployment & Stabilisasi (Bulan 12). |

### 6.3 Risiko Tingkat Tinggi

| No. | Risiko                                                                                                    | Dampak     | Mitigasi Awal                                                                                                          |
| --- | --------------------------------------------------------------------------------------------------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------- |
| 1   | Kompleksitas sistem yang sangat tinggi (20+ modul) melebihi kapasitas tim pengembang.                     | **Tinggi** | Prioritaskan modul inti terlebih dahulu (percetakan, penjualan ATK, stok, keuangan), lalu kembangkan modul lainnya secara bertahap. |
| 2   | Kesalahan input data awal dari Excel yang berserakan menyebabkan data tidak konsisten.                    | **Sedang** | Sediakan fitur validasi data pada proses input awal dan lakukan verifikasi bertahap per modul.                        |
| 3   | Kurva pembelajaran CLI terlalu tinggi bagi karyawan baru yang tidak terbiasa.                             | **Sedang** | Buat panduan pengguna yang jelas dan antarmuka CLI yang intuitif dengan navigasi menu terstruktur.                    |
| 4   | Perubahan kebutuhan bisnis di tengah pengembangan mengakibatkan pengerjaan ulang (*scope creep*).         | **Sedang** | Dokumentasi kebutuhan yang solid pada fase analisis dan mekanisme *change request* yang terstruktur.                  |
| 5   | Keamanan data sensitif (pinjaman, tabungan) terancam jika implementasi hak akses tidak tepat.             | **Tinggi** | Terapkan enkripsi data sensitif menggunakan `bcrypt`, autentikasi `JWT`, dan uji penetrasi pada modul keamanan.       |
| 6   | Ketergantungan pada satu orang (pemilik) sebagai satu-satunya sumber kebutuhan bisnis.                    | **Sedang** | Dokumentasikan seluruh kebutuhan secara komprehensif dalam narasi.txt dan validasi melalui review berkala.            |

---

## 7. Spesifikasi Teknis

| Komponen                | Spesifikasi                                                                              |
| ----------------------- | ---------------------------------------------------------------------------------------- |
| **Antarmuka**           | CLI/Console (tahap awal)                                                                 |
| **Bahasa Pemrograman**  | Python 3.14.2 ke atas                                                                   |
| **Paradigma**           | Functional Programming (wajib)                                                           |
| **Library Utama**       | `mysql-connector-python`, `python-dotenv`, `bcrypt`, `pyjwt`                            |
| **Database**            | MySQL                                                                                    |
| **Sistem Operasi**      | Linux Debian 12 Bookworm dan Windows 11                                                  |
| **Skalabilitas**        | Arsitektur *Multi-Branch Ready* — setiap entitas data memiliki identifikasi unit/cabang  |

---

## 8. Susunan Tim Pengembang

| No. | Anggota                              | Peran Utama                               |
| --- | ------------------------------------ | ----------------------------------------- |
| 0   | Junior Programmer (Pemilik Usaha)    | Koordinator proyek dan implementasi dasar |
| 1   | Gemini 3.1 Pro (High)                | Arsitektur kompleks & logika berat        |
| 2   | Gemini 3.1 Pro (Low)                 | Pengerjaan rutin & dokumentasi            |
| 3   | Gemini 3 Flash                       | Review cepat & debugging ringan           |
| 4   | Claude Sonnet 4.6 (Thinking)         | Deep coding & refactoring                 |
| 5   | Claude Opus 4.6 (Thinking)           | Strategi sistem & keamanan                |
| 6   | GPT-OSS 120B (Medium)                | Pembuatan boilerplate & data dummy        |

---

## 9. Struktur Organisasi Usaha

Struktur organisasi operasional yang dirancang terdiri dari **7 posisi kunci** dengan budaya kerja **cross-functional** (saling mengisi antar bagian):

1. **Kepala Percetakan** — Koordinasi seluruh operasional usaha.
2. **Pramuniaga** — Pelayanan pelanggan di garda depan dan penjelasan produk/layanan.
3. **Kasir** — Transaksi pembayaran dan rekonsiliasi kas harian.
4. **Desainer** — Proses desain pesanan produk unggulan dan pengelolaan arsip desain.
5. **Bagian Produksi Cetak** — Eksekusi proses cetak dan finishing produk.
6. **Staf Fotocopy & Print** — Melayani fotocopy, print dokumen, dan pengetikan.
7. **Bagian Gudang** — Pengelolaan stok bahan baku, barang retail, dan pengadaan.

> **Catatan**: Meskipun memiliki jabatan spesifik, seluruh karyawan dituntut untuk saling mengisi celah pekerjaan (*cross-functional*). Jika satu bagian sedang sangat sibuk, rekan dari bagian lain yang sedang luang wajib ikut membantu agar operasional tetap berjalan lancar.

---

## 10. Persetujuan Proyek

| Peran              | Nama / Identitas           | Tanggal    | Keterangan           |
| ------------------ | -------------------------- | ---------- | -------------------- |
| **Pemilik Proyek** | Pemilik Usaha AbuCom       | 2026-05-11 | Disetujui secara lisan saat inisiasi proyek |
| **Manajer Proyek** | Senior IT Project Manager (AI Review) | 2026-05-11 | Validasi dokumen oleh tim AI |

---

## 11. Riwayat Versi

| Versi  | Tanggal    | Diubah Oleh                          | Keterangan                                                             |
| ------ | ---------- | ------------------------------------ | ---------------------------------------------------------------------- |
| 1.0.0  | 2026-05-11 | AI (Gemini — Drafting Awal)          | Penyusunan draft pertama dari ekstraksi narasi.txt                    |
| 1.1.0  | 2026-05-11 | AI (Claude — Validasi Issue #2)      | Validasi menyeluruh: pengisian placeholder, penambahan SMART Goals, perbaikan struktur organisasi (7 posisi), penambahan estimasi anggaran & timeline, dan standarisasi format dokumen. |

---

## Referensi Dokumen

- `docs/sdlc/narasi.txt`
