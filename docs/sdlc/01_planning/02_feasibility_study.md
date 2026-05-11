# Feasibility Study — Sistem Manajemen Usaha Percetakan "AbuCom"

## Metadata Dokumen

| Atribut              | Detail                                                                                                                                           |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Versi**            | 1.2.0                                                                                                                                            |
| **Status**           | [finish]                                                                                                                                         |
| **Tanggal Dibuat**   | 2026-05-11                                                                                                                                       |
| **Tanggal Direvisi** | 2026-05-11                                                                                                                                       |
| **Disusun Oleh**     | Senior Business Analyst & Enterprise Architect (AI Review)                                                                                       |
| **Catatan Revisi**   | v1.2.0 — Validasi menyeluruh: penajaman analisa kelayakan ekonomi, teknis, operasional, dan jadwal; penyelarasan dengan Project Charter; penambahan bagian Riwayat Versi. |

---

## 1. Executive Summary

Dokumen ini menyajikan evaluasi kelayakan menyeluruh terhadap proyek **AbuCom — Sistem Manajemen Usaha Percetakan Terpadu**, sebuah aplikasi berbasis CLI (*Command Line Interface*) yang dibangun menggunakan bahasa Python dengan paradigma *Functional Programming*. Sistem ini dirancang secara khusus untuk mengotomatisasi seluruh proses operasional usaha percetakan UMKM ke dalam satu platform terpusat.

Evaluasi kelayakan proyek ini dilakukan berdasarkan lima dimensi utama: **Teknis, Operasional, Ekonomi/Finansial, Jadwal, dan Risiko**. Berdasarkan analisis komprehensif yang telah dilakukan, berikut adalah ringkasan temuan:

- **Kelayakan Teknis**: **Layak.** Seluruh teknologi yang dibutuhkan (Python 3.14.2, MySQL, dan library *open-source* terkait) tersedia secara gratis dan sudah sangat matang (*mature*). Kapabilitas tim pengembang yang didukung oleh enam agen AI (*Artificial Intelligence*) khusus dinilai sangat memadai untuk menangani kompleksitas 20 modul fungsional.
- **Kelayakan Operasional**: **Layak dengan Catatan.** Sistem yang dirancang secara langsung menjawab permasalahan kritis yang dialami oleh pemilik usaha, seperti beban kerja yang berlebihan dan pencatatan manual yang rawan kesalahan. Namun, penggunaan antarmuka CLI memerlukan strategi adaptasi khusus bagi karyawan non-teknis, termasuk penyediaan panduan pengguna yang komprehensif.
- **Kelayakan Ekonomi**: **Layak.** Estimasi biaya pengembangan langsung sangat minimal (Maksimal Rp 500.000 dialokasikan untuk infrastruktur minor). Investasi ini sangat kecil dibandingkan dengan proyeksi manfaat berupa efisiensi waktu, pencegahan kerugian finansial akibat selisih stok, serta peningkatan kapasitas layanan.
- **Kelayakan Jadwal**: **Layak dengan Mitigasi.** Rencana waktu tempuh (*timeline*) 12 bulan dinilai realistis dengan syarat menggunakan pendekatan pengembangan modular bertahap (prioritas penyelesaian modul inti pada 6 bulan pertama) dan disiplin dalam mengelola cakupan proyek (*scope management*).
- **Risiko**: Terdapat 6 risiko utama yang teridentifikasi, namun seluruhnya telah memiliki strategi mitigasi yang jelas dan dapat dieksekusi.

**Keputusan Eksekutif: GO** — Proyek dinyatakan sepenuhnya layak untuk dilanjutkan ke fase berikutnya dalam siklus SDLC (*Requirements Analysis & Design*).

---

## 2. Project Background & Objective

### 2.1 Latar Belakang

Pemilik usaha "AbuCom" merupakan pelaku UMKM yang bergerak di bidang layanan jasa percetakan. Saat ini, pemilik mengelola dan menjalankan seluruh operasional usaha yang mencakup lima lini layanan utama secara mandiri:

1. **Produk Percetakan** — Cetak stempel *flash*, cetak foto, buku yasin, undangan pernikahan, baliho, fotocopy, pengetikan, print data, cetak stiker, nama dada, dan percetakan kustom lainnya.
2. **Penjualan Alat Tulis Kantor (ATK / Retail)** — Kertas HVS, kertas foto, kertas undangan, tinta, pulpen, hekter, map (*snelhechter*, biasa, warna), lakban, selotip, pensil, dan perlengkapan kantor lainnya.
3. **Layanan Digital & PPOB** — Penjualan pulsa *handphone*, token listrik, paket data, serta pembayaran berbagai tagihan listrik (menggunakan dua akun yang berbeda).
4. **Jasa Keuangan** — Layanan transfer uang antar bank dan tarik tunai melalui berbagai akun digital (Agen Bank Mandiri, Dana, Gopay, LinkAja, ShopeePay, OVO).
5. **Jasa Teknis** — Perbaikan (*service*) printer dan instalasi ulang sistem operasi pada komputer atau laptop.

Seluruh kegiatan pencatatan transaksi, pengurangan stok, hingga laporan keuangan saat ini masih dikelola secara manual menggunakan Microsoft Excel dengan file yang berserakan. Hal ini menimbulkan tantangan operasional yang masif berupa: beban kerja yang sangat tinggi, risiko *human error* pada laporan keuangan dan stok bahan baku, serta tekanan mental (*burnout*) pada pemilik. 

### 2.2 Tujuan Proyek

Proyek ini dibangun untuk menjawab permasalahan di atas dengan tujuan utama sebagai berikut:

| No. | Tujuan                                                                                                          |
| --- | --------------------------------------------------------------------------------------------------------------- |
| 1   | Mengotomatisasi dan mengintegrasikan seluruh lini operasional usaha percetakan ke dalam satu aplikasi terpadu.  |
| 2   | Menghasilkan laporan pergerakan stok, perhitungan Harga Pokok Penjualan (HPP), dan laporan keuangan yang akurat.|
| 3   | Mendukung pengelolaan dan pendelegasian tugas kepada multi-karyawan (7 posisi operasional) dengan fitur RBAC.   |
| 4   | Menyediakan analisis profitabilitas yang transparan untuk pengambilan keputusan strategis.                      |
| 5   | Membangun arsitektur fondasi perangkat lunak yang *Multi-Branch Ready* untuk rencana ekspansi di masa depan.    |

---

## 3. Technical Feasibility

### 3.1 Ketersediaan Teknologi

Tumpukan teknologi (*tech stack*) yang direncanakan berfokus pada efisiensi biaya dan keandalan sistem jangka panjang:

| Komponen               | Teknologi Pendukung    | Status       | Justifikasi                                                                |
| ---------------------- | ---------------------- | ------------ | -------------------------------------------------------------------------- |
| Bahasa Pemrograman     | Python 3.14.2+         | ✅ Tersedia   | *Open-source*, matang, komunitas besar, dan dukungan pengolahan data kuat. |
| Paradigma Kode         | Functional Programming | ✅ Tersedia   | Pendekatan pemrograman tanpa *side-effects*, menghasilkan sistem yang presisi. |
| Basis Data (*Database*)| MySQL                  | ✅ Tersedia   | *Open-source*, tangguh untuk pemrosesan transaksi yang kompleks.           |
| Ekosistem Library      | `mysql-connector-python`, `python-dotenv` | ✅ Tersedia   | Stabil, resmi, dan terdokumentasi dengan baik.                           |
| Kriptografi & Keamanan | `bcrypt`, `pyjwt`      | ✅ Tersedia   | Standar industri untuk *hashing password* dan *stateless authentication*.  |
| Antarmuka Pengguna     | CLI (*Command Line*)   | ✅ Tersedia   | Pilihan arsitektur yang paling cepat dan stabil pada fase awal (*MVP*).    |

### 3.2 Ketersediaan Infrastruktur

Sistem ini tidak bergantung pada infrastruktur *cloud* berbayar. Seluruh implementasi awal dapat berjalan di atas infrastruktur lokal yang sudah tersedia:
- **Sistem Operasi**: Windows 11 dan Linux Debian 12 Bookworm.
- **Perangkat Keras**: Komputer dan laptop *existing* milik usaha telah memenuhi syarat spesifikasi minimum untuk *host* database lokal dan mengeksekusi *script* Python.

### 3.3 Kapabilitas Tim Pengembang

Proyek ini menggunakan model pengembangan modern yang efisien (*AI-Augmented Development*):

| Anggota                           | Peran Teknis Utama                   |
| --------------------------------- | ------------------------------------ |
| Junior Programmer (Pemilik Usaha) | Implementator, *Project Manager*     |
| Gemini 3.1 Pro (High)             | Arsitektur kompleks & algoritma berat|
| Gemini 3.1 Pro (Low)              | Pembuatan dokumen & *boilerplate*    |
| Gemini 3 Flash                    | *Debugging* cepat & *code review*    |
| Claude Sonnet 4.6 (Thinking)      | Pemrograman mendalam & *refactoring* |
| Claude Opus 4.6 (Thinking)        | Strategi keamanan sistem & audit     |
| GPT-OSS 120B (Medium)             | Pembuatan data *dummy* uji coba      |

### 3.4 Kesimpulan Kelayakan Teknis

**LAYAK.** Penggunaan perangkat lunak bersifat *open-source* meminimalisir risiko lisensi. Infrastruktur yang telah tersedia sepenuhnya memenuhi spesifikasi. Kolaborasi dengan agen AI tingkat lanjut memitigasi keterbatasan keahlian teknis secara signifikan, memungkinkan pencapaian sistem yang matang (*enterprise-grade*) meskipun dikerjakan oleh pengembang junior.

---

## 4. Operational Feasibility

### 4.1 Penyelesaian Masalah Bisnis

| Permasalahan Saat Ini                        | Solusi Sistem                                                                               |
| -------------------------------------------- | ------------------------------------------------------------------------------------------- |
| *Single Point of Failure* pada pemilik       | Distribusi tugas ke berbagai peran (Pramuniaga, Kasir, Produksi) dengan log audit.          |
| Kesalahan pencatatan manual di Excel         | *Database* terpusat dengan integritas referensial yang ketat, dan validasi *input*.         |
| Manajemen status pesanan yang buruk          | Sistem pelacakan pekerjaan (*Job Tracking*) secara *real-time* dengan riwayat yang jelas.   |
| Kesulitan rekonsiliasi kas dan stok          | Modul *Stock Opname* dan *Cash Reconciliation* bawaan yang memaksa validasi harian.         |
| Perhitungan pemakaian bahan baku tidak akurat| Sistem perhitungan stok berbasis dimensi/volume menggunakan mekanisme BOM multi-satuan.       |

### 4.2 Kemudahan Adopsi oleh Pengguna Akhir

Sistem dirancang untuk mengakomodasi 7 peran organisasi (Pemilik, Pramuniaga, Kasir, Desainer, Bagian Produksi Cetak, Staf Fotocopy & Print, dan Bagian Gudang). Penggunaan *Command Line Interface* (CLI) menimbulkan tantangan operasional utama:

- **Hambatan Adaptasi:** Antarmuka berbasis teks (CLI) tidak se-intuitif antarmuka visual (GUI), sehingga rentan terhadap kesalahan navigasi oleh karyawan baru.
- **Strategi Mitigasi Operasional:** Sistem CLI harus dibekali struktur navigasi hierarkis (berbasis pilihan menu angka), sistem penanganan kesalahan (*error handling*) yang kuat untuk mencegah aplikasi terhenti (*crash*), dan dilengkapi dengan *User Manual* serta prosedur orientasi karyawan (*onboarding*) yang jelas.

### 4.3 Kesimpulan Kelayakan Operasional

**LAYAK DENGAN CATATAN.** Fungsionalitas aplikasi sejalan 100% dengan kebutuhan operasional di lapangan. Keberhasilan implementasi bergantung pada seberapa intuitif antarmuka CLI dirancang dan seberapa disiplin karyawan menjalankan instruksi *Standard Operating Procedure* (SOP) dari manual pengguna.

---

## 5. Economic & Financial Feasibility

### 5.1 Analisis Biaya (*Cost Analysis*)

Proyek ini menonjol karena profil biayanya yang sangat rendah:

| Komponen Biaya                       | Estimasi               | Keterangan                                                         |
| ------------------------------------ | ---------------------- | ------------------------------------------------------------------ |
| **Lisensi Perangkat Lunak**          | Rp 0                   | Seluruh ekosistem bersifat gratis (*open-source*).                 |
| **Biaya Infrastruktur Server**       | Rp 0                   | *Deployment* lokal di atas *hardware* yang sudah ada.              |
| **Biaya Tenaga Kerja (*Development*)**| Rp 0                   | Dilakukan mandiri dengan dukungan agen AI tanpa biaya tambahan.    |
| **Biaya Infrastruktur Minor**        | Rp 500.000             | Anggaran pencegahan (kabel *network*, periferal kecil jika perlu). |
| **Biaya Modal Tidak Langsung (Waktu)**| Rp 5.000.000 / bulan   | *Opportunity cost* manajerial pemilik selama fase *development*.   |

**Total Biaya Langsung (*Direct Cost*) Maksimal: Rp 500.000.**

### 5.2 Analisis Manfaat (*Benefit Analysis*)

| Sumber Manfaat Ekonomis                                | Estimasi Penghematan/Pendapatan per Bulan |
| ------------------------------------------------------ | ----------------------------------------- |
| Efisiensi waktu manajerial & pencatatan admin          | Rp 3.000.000                              |
| Pencegahan selisih stok bahan baku & kesalahan HPP     | Rp 1.500.000                              |
| Peningkatan kapasitas penerimaan pesanan pelanggan     | Rp 2.000.000                              |
| **Total Proyeksi Manfaat per Bulan**                   | **Rp 6.500.000**                          |

### 5.3 Kesimpulan Kelayakan Ekonomi

**LAYAK.** Indikator kelayakan finansial sangat positif. Biaya investasi langsung nyaris nol. Tingkat Pengembalian Investasi (*Return on Investment* / ROI) akan segera tercapai di bulan pertama sejak aplikasi digunakan pada lingkungan produksi. Pengorbanan waktu pengembangan terkompensasi penuh oleh sistem yang mengamankan aset jangka panjang perusahaan.

---

## 6. Schedule Feasibility

### 6.1 Rencana Garis Waktu (*Timeline*)

Total durasi pengembangan sistem diproyeksikan memakan waktu **12 bulan**, mengikuti siklus kerja metodologi SDLC *Waterfall*:

| Tahapan SDLC                           | Periode        | Durasi   | Hasil (*Deliverables*) Utama                                    |
| -------------------------------------- | -------------- | -------- | --------------------------------------------------------------- |
| **1. Planning & Analysis**             | Bulan 1 — 2    | 2 bulan  | *Project Charter*, *Feasibility Study*, *Requirement Specs*.    |
| **2. Design**                          | Bulan 3        | 1 bulan  | Skema *Database* relasional, alur logika program, UX CLI.       |
| **3. Implementation (Modul Inti)**     | Bulan 4 — 7    | 4 bulan  | Percetakan, Retail, Stok, Kasir, dan Keuangan Dasar.            |
| **4. Implementation (Modul Lanjutan)** | Bulan 8 — 10   | 3 bulan  | SDM & *Payroll*, Layanan PPOB/Bank, Pinjaman, dan *Job Tracking*.|
| **5. Testing & UAT**                   | Bulan 11       | 1 bulan  | *Integration Test*, Penanganan *Bug*, dan Uji Penerimaan.       |
| **6. Deployment & Stabilisasi**        | Bulan 12       | 1 bulan  | Migrasi data dari Excel ke MySQL, *Go-Live*, dan Stabilisasi.   |

### 6.2 Evaluasi Jadwal

**Kekuatan:** Kolaborasi pengembangan bersama 6 agen AI dapat mengakselerasi penulisan kode (*coding*) yang masif. Strategi rilis bertahap (modul inti pada Bulan ke-7) menekan risiko kegagalan proyek di tahap akhir.
**Kelemahan:** Mengembangkan 20 modul fungsional oleh *solo programmer* sangat berisiko memicu keterlambatan jika tingkat integrasi antar-modul menjadi terlalu rumit.

### 6.3 Kesimpulan Kelayakan Jadwal

**LAYAK DENGAN MITIGASI.** Garis waktu 12 bulan cukup realistis dengan satu persyaratan ketat: implementasi manajemen *scope creep* yang keras (tidak ada penambahan fitur baru di luar *Project Charter* selama fase 12 bulan ini) dan komitmen waktu pemilik yang konsisten selama fase *Implementation*.

---

## 7. Risk and Mitigation Strategy

Identifikasi risiko tingkat tinggi (*high-level risk*) yang berpotensi menghambat kesuksesan proyek beserta mitigasinya:

| No. | Risiko                                                                                         | Probabilitas | Dampak     | Tingkat Risiko | Strategi Mitigasi                                                                                                          |
| --- | ---------------------------------------------------------------------------------------------- | ------------ | ---------- | -------------- | -------------------------------------------------------------------------------------------------------------------------- |
| R1  | **Kompleksitas Lingkup (*Scope*):** Volume 20 modul melebihi kapasitas eksekusi waktu normal.  | Sedang       | Tinggi     | **Kritis**     | Terapkan pengerjaan secara sekuensial: selesaikan fase Modul Inti (Bulan 4-7) terlebih dahulu. Tolak penambahan fitur.     |
| R2  | **Migrasi Data Kotor:** Data Excel yang berserakan menyebabkan struktur *database* awal cacat. | Tinggi       | Sedang     | **Tinggi**     | Bangun modul input data awal (*Migration Tool*); lakukan verifikasi manual 100% sebelum disimpan permanen ke MySQL.        |
| R3  | **Hambatan Pengguna:** Karyawan menolak menggunakan sistem akibat kurva belajar CLI yang curam.| Sedang       | Sedang     | **Sedang**     | Desain UI CLI yang sangat intuitif (mirip navigasi USSD), sertakan pesan *error* yang ramah, dan sediakan SOP yang padat.  |
| R4  | **Kegagalan Keamanan:** Kebocoran akses terhadap data finansial sensitif (tabungan, pinjaman). | Rendah       | Sangat Tinggi| **Tinggi**   | Implementasi autentikasi ketat via JWT (*JSON Web Token*) dan *Role-Based Access Control* (RBAC). Data kata sandi di-hash. |
| R5  | **Kalkulasi Stok Dimensi Keliru:** Kesalahan fatal perhitungan pemakaian bahan baku berukuran. | Sedang       | Tinggi     | **Tinggi**     | Prioritaskan pengujian logika *Bill of Materials* (BOM) multi-satuan di fase awal untuk memvalidasi algoritma matematika.  |

---

## 8. Conclusion & Recommendation

### 8.1 Ringkasan Evaluasi Kelayakan

| Dimensi Evaluasi       | Status Keputusan           |
| ---------------------- | -------------------------- |
| Kelayakan Teknis       | ✅ **Layak**                |
| Kelayakan Operasional  | ✅ **Layak (dengan catatan)**|
| Kelayakan Ekonomi      | ✅ **Layak**                |
| Kelayakan Jadwal       | ✅ **Layak (dengan mitigasi)**|
| Manajemen Risiko       | ⚠️ **Terkelola**            |

### 8.2 Keputusan Eksekutif

Berdasarkan validasi menyeluruh terhadap seluruh dimensi teknis dan bisnis, serta penyelarasan penuh dengan *Project Charter*, Proyek **AbuCom — Sistem Manajemen Usaha Percetakan Terpadu** dinyatakan secara resmi:

## **🟢 GO — PROYEK LAYAK DILANJUTKAN**

**Argumentasi Final:**
Proyek ini dikategorikan sebagai inisiatif **risiko investasi rendah dengan hasil bisnis yang masif** (*Low-Risk, High-Yield Initiative*). Urgensi sistem ini tidak dapat ditawar demi menyelamatkan operasional bisnis dari batasan kapabilitas manusia tunggal (*bottleneck*) dan inefisiensi pencatatan manual. Seluruh tantangan teknis dan operasional yang teridentifikasi telah memiliki rencana mitigasi yang memadai. Proyek dapat segera diteruskan ke fase *Requirements Analysis* dalam SDLC.

---

## 9. Riwayat Versi

| Versi | Tanggal    | Diubah Oleh                              | Keterangan                                                                                                                                           |
| ----- | ---------- | ---------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1.0.0 | 2026-05-11 | AI (Gemini — *Drafting* Awal)            | Penyusunan draf pertama hasil ekstraksi dokumen narasi dan *project charter*.                                                                        |
| 1.1.0 | 2026-05-11 | AI (Gemini — *Drafting* Lanjutan)        | Perbaikan format tabel dan penyesuaian kelengkapan substansi dokumen dasar.                                                                          |
| 1.2.0 | 2026-05-11 | AI (Claude — Validasi Dokumen Utama #4)  | Validasi komprehensif, penajaman analisa kelayakan, pengisian kekosongan data, perbaikan tata bahasa baku, penyelarasan struktural, dan finalisasi.  |

---

## Referensi Dokumen

- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
