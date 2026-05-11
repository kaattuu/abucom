# Feasibility Study — Sistem Manajemen Usaha Percetakan "AbuCom"

## Metadata Dokumen

| Atribut              | Detail                                                    |
| -------------------- | --------------------------------------------------------- |
| **Versi**            | 1.0.0                                                     |
| **Status**           | Draft                                                     |
| **Tanggal Dibuat**   | 2026-05-11                                                |
| **Disusun Oleh**     | Senior Business Analyst & Enterprise Architect (AI Review) |

---

## 1. Executive Summary

Dokumen ini menyajikan evaluasi kelayakan menyeluruh terhadap proyek **AbuCom — Sistem Manajemen Usaha Percetakan Terpadu**, sebuah aplikasi berbasis CLI (Python, Functional Programming) yang dirancang untuk mengotomatisasi seluruh operasional usaha percetakan UMKM ke dalam satu platform terpusat.

Evaluasi dilakukan terhadap lima dimensi kelayakan: **teknis, operasional, ekonomi/finansial, jadwal, dan risiko**. Berdasarkan analisis yang dilakukan, berikut adalah ringkasan temuan:

- **Kelayakan Teknis**: **Layak.** Seluruh teknologi yang dibutuhkan (Python 3.14.2, MySQL, library open-source) tersedia secara gratis dan matang. Tim pengembang terdiri dari satu Junior Programmer yang dibantu oleh enam agen AI dengan spesialisasi berbeda, yang secara kolektif mampu menangani kompleksitas 20 modul fungsional.
- **Kelayakan Operasional**: **Layak dengan catatan.** Sistem secara langsung menjawab permasalahan kritis yang dialami pemilik usaha (beban kerja berlebihan, pencatatan manual, data berserakan). Namun, adopsi CLI oleh karyawan non-teknis memerlukan panduan pengguna yang komprehensif.
- **Kelayakan Ekonomi**: **Layak.** Dengan estimasi biaya langsung Rp 0 — Rp 500.000 (seluruh teknologi open-source), investasi yang diperlukan sangat minimal dibandingkan manfaat otomatisasi yang dihasilkan.
- **Kelayakan Jadwal**: **Layak dengan mitigasi.** Timeline 12 bulan yang ditetapkan cukup realistis dengan pendekatan bertahap (modul inti 6 bulan pertama), meskipun kompleksitas 20 modul memerlukan disiplin pengembangan yang ketat.
- **Risiko**: Teridentifikasi 6 risiko tingkat tinggi dengan mitigasi yang telah dirancang untuk masing-masing risiko.

**Rekomendasi: GO** — Proyek layak dilanjutkan ke fase berikutnya dengan memperhatikan strategi mitigasi risiko yang telah diidentifikasi.

---

## 2. Project Background & Objective

### 2.1 Latar Belakang

Pemilik usaha merupakan pelaku UMKM di bidang layanan jasa percetakan yang mengelola dan menjalankan seluruh operasional secara mandiri. Usaha ini memiliki lima lini layanan utama:

1. **Produk Percetakan** — cetak stempel flash, cetak foto, buku yasin, undangan, baliho, fotocopy, pengetikan, print data, stiker, nama dada, dan percetakan kustom lainnya.
2. **Penjualan ATK (Retail)** — kertas HVS, kertas foto, tinta, pulpen, map, lakban, dan perlengkapan kantor lainnya.
3. **Layanan Digital & PPOB** — pulsa HP, token listrik, paket data, dan pembayaran tagihan listrik.
4. **Jasa Keuangan** — transfer uang antar bank dan tarik tunai melalui multi-akun digital (Agen Bank Mandiri, Dana, Gopay, LinkAja, ShopeePay, OVO).
5. **Jasa Teknis** — perbaikan printer dan instalasi ulang sistem operasi komputer/laptop.

Seluruh pencatatan operasional saat ini dilakukan secara manual menggunakan Microsoft Excel dengan data yang tersebar di berbagai file, menimbulkan permasalahan kritis berupa beban kerja berlebihan, pencatatan tidak akurat, data berserakan, serta tekanan mental (stres dan burnout) pada pemilik.

### 2.2 Tujuan Proyek

| No. | Tujuan                                                                                         |
| --- | ---------------------------------------------------------------------------------------------- |
| 1   | Mengotomatisasi seluruh proses operasional usaha percetakan ke dalam satu aplikasi terpadu.    |
| 2   | Menghasilkan laporan keuangan dan stok yang akurat secara otomatis.                            |
| 3   | Mendukung pengelolaan multi-karyawan dengan sistem SDM, penggajian, dan insentif terintegrasi. |
| 4   | Menyediakan analisis laba/rugi per layanan untuk pengambilan keputusan bisnis.                 |
| 5   | Mempersiapkan arsitektur yang skalabel untuk ekspansi multi-cabang di masa depan.              |

---

## 3. Technical Feasibility

### 3.1 Ketersediaan Teknologi

| Komponen               | Teknologi              | Ketersediaan | Keterangan                                                                 |
| ---------------------- | ---------------------- | ------------ | -------------------------------------------------------------------------- |
| Bahasa Pemrograman     | Python 3.14.2+         | ✅ Tersedia   | Open-source, komunitas besar, ekosistem library yang matang.               |
| Paradigma              | Functional Programming | ✅ Tersedia   | Python mendukung penuh paradigma FP melalui fitur bawaan dan library.      |
| Database               | MySQL                  | ✅ Tersedia   | Open-source, stabil, dan mampu menangani volume data UMKM dengan baik.     |
| Library DB Connector   | mysql-connector-python | ✅ Tersedia   | Library resmi Oracle untuk koneksi Python-MySQL.                           |
| Konfigurasi Lingkungan | python-dotenv          | ✅ Tersedia   | Manajemen variabel lingkungan yang sederhana dan aman.                     |
| Keamanan (Hashing)     | bcrypt                 | ✅ Tersedia   | Standar industri untuk hashing password.                                   |
| Keamanan (Token)       | pyjwt                  | ✅ Tersedia   | Implementasi JSON Web Token untuk autentikasi berbasis peran.              |
| Antarmuka              | CLI/Console            | ✅ Tersedia   | Tidak memerlukan framework UI tambahan pada tahap awal.                    |

### 3.2 Ketersediaan Infrastruktur

Sistem dirancang untuk berjalan secara lokal pada infrastruktur yang sudah dimiliki pemilik usaha:

- **Sistem Operasi**: Linux Debian 12 Bookworm dan Windows 11 — keduanya sudah tersedia dan kompatibel dengan seluruh stack teknologi.
- **Perangkat Keras**: Komputer/laptop yang ada diasumsikan sudah mendukung Python 3.14.2 dan MySQL, tanpa memerlukan upgrade signifikan.
- **Deployment**: Berjalan lokal pada tahap awal — tidak memerlukan biaya cloud server.

### 3.3 Kapabilitas Tim Pengembang

Tim pengembang terdiri dari 7 anggota dengan pembagian peran yang jelas:

| No. | Anggota                           | Peran Utama                          |
| --- | --------------------------------- | ------------------------------------ |
| 0   | Junior Programmer (Pemilik Usaha) | Koordinator proyek & implementasi    |
| 1   | Gemini 3.1 Pro (High)             | Arsitektur kompleks & logika berat   |
| 2   | Gemini 3.1 Pro (Low)              | Pengerjaan rutin & dokumentasi       |
| 3   | Gemini 3 Flash                    | Review cepat & debugging ringan      |
| 4   | Claude Sonnet 4.6 (Thinking)      | Deep coding & refactoring            |
| 5   | Claude Opus 4.6 (Thinking)        | Strategi sistem & keamanan           |
| 6   | GPT-OSS 120B (Medium)             | Pembuatan boilerplate & data dummy   |

Kombinasi satu Junior Programmer sebagai koordinator dengan enam agen AI yang memiliki spesialisasi berbeda memberikan kapasitas pengembangan yang memadai untuk menangani 20 modul fungsional secara bertahap.

### 3.4 Kesimpulan Kelayakan Teknis

**LAYAK.** Seluruh teknologi, infrastruktur, dan kapabilitas tim tersedia tanpa hambatan signifikan. Stack teknologi yang seluruhnya open-source mengeliminasi risiko ketergantungan lisensi. Arsitektur CLI pada tahap awal menyederhanakan kompleksitas pengembangan UI.

---

## 4. Operational Feasibility

### 4.1 Penyelesaian Masalah Bisnis

| Masalah Saat Ini                             | Solusi yang Diberikan Sistem                                                                |
| -------------------------------------------- | ------------------------------------------------------------------------------------------- |
| Beban kerja berlebihan pada satu orang       | Otomatisasi pencatatan, perhitungan stok, HPP, penggajian, dan pelaporan.                   |
| Pencatatan manual di Excel tidak akurat      | Database terpusat dengan validasi data otomatis dan audit trail.                             |
| Data berserakan di berbagai file Excel       | Satu database MySQL terpusat dengan modul input data awal (migrasi).                        |
| Tidak ada pelacakan pesanan                  | Sistem job tracking dengan status: Antri → Proses Desain → Produksi → Selesai → Diambil.   |
| Rekonsiliasi kas dan stok manual             | Fitur rekonsiliasi kas (uang fisik vs sistem) dan stock opname (stok fisik vs sistem).      |
| Tidak ada analisis profitabilitas per layanan | Modul laporan laba/rugi per layanan secara otomatis.                                        |
| Stres dan burnout pemilik                    | Delegasi operasional ke karyawan dengan sistem SDM, penggajian, dan hak akses terintegrasi. |

### 4.2 Kemudahan Adopsi oleh End-User

**Pengguna Utama:**

Sistem dirancang untuk 7 peran operasional (Kepala Percetakan, Pramuniaga, Kasir, Desainer, Bagian Produksi Cetak, Staf Fotocopy & Print, Bagian Gudang) dengan hak akses berbasis peran yang membatasi kompleksitas tampilan sesuai kebutuhan masing-masing.

**Tantangan Adopsi:**

- **Antarmuka CLI** memiliki kurva pembelajaran yang lebih tinggi dibandingkan GUI, terutama bagi karyawan non-teknis. Mitigasi: pembuatan navigasi menu terstruktur dan panduan pengguna yang komprehensif.
- **Budaya cross-functional** yang sudah diterapkan dalam organisasi mendukung fleksibilitas adopsi — karyawan terbiasa membantu di berbagai bagian, sehingga kemampuan menggunakan berbagai modul menjadi kebutuhan natural.

### 4.3 Kesimpulan Kelayakan Operasional

**LAYAK DENGAN CATATAN.** Sistem secara langsung dan komprehensif menjawab seluruh permasalahan operasional yang teridentifikasi. Penggunaan CLI sebagai antarmuka awal merupakan tantangan adopsi yang dapat dimitigasi dengan panduan pengguna yang baik dan menu navigasi yang intuitif. Rencana rekrutmen karyawan oleh pemilik usaha memperkuat kebutuhan sistem ini untuk mendukung operasional multi-pengguna.

---

## 5. Economic / Financial Feasibility

### 5.1 Estimasi Biaya Pengembangan

| Kategori Biaya                       | Estimasi               | Keterangan                                                         |
| ------------------------------------ | ---------------------- | ------------------------------------------------------------------ |
| Lisensi Perangkat Lunak              | Rp 0                   | Seluruh teknologi open-source (Python, MySQL, library).            |
| Biaya Infrastruktur Minor            | Rp 0 — Rp 500.000     | Jika diperlukan untuk kebutuhan infrastruktur lokal tambahan.      |
| Biaya Cloud/Server                   | Rp 0                   | Deployment lokal pada tahap awal.                                  |
| Biaya Tenaga Kerja Pengembang        | Rp 0                   | Pemilik usaha sebagai Junior Programmer; AI sebagai tim pengembang tanpa biaya tenaga kerja konvensional. |
| **Total Estimasi Biaya Langsung**    | **Rp 0 — Rp 500.000** |                                                                    |

> **Catatan:** Biaya tidak langsung seperti waktu pemilik usaha yang dialokasikan untuk pengembangan (opportunity cost) tidak dihitung secara eksplisit dalam estimasi ini. [ESTIMASI OPPORTUNITY COST WAKTU PEMILIK PERLU DIISI MANUAL JIKA DIPERLUKAN]

### 5.2 Estimasi Manfaat

| No. | Manfaat                                                                                 | Dampak                  |
| --- | --------------------------------------------------------------------------------------- | ----------------------- |
| 1   | Pengurangan waktu pencatatan manual harian > 80%                                        | Efisiensi waktu tinggi  |
| 2   | Akurasi laporan keuangan dan stok meningkat signifikan                                  | Mengurangi kerugian     |
| 3   | Kemampuan analisis laba/rugi per layanan                                                | Pengambilan keputusan   |
| 4   | Delegasi operasional ke karyawan melalui sistem terintegrasi                            | Skalabilitas bisnis     |
| 5   | Pencegahan kecurangan melalui audit trail dan hak akses                                 | Keamanan finansial      |
| 6   | Arsitektur multi-cabang siap untuk ekspansi bisnis                                      | Pertumbuhan jangka panjang |
| 7   | Pengurangan stres dan burnout pemilik, memungkinkan fokus pada strategi pengembangan     | Kualitas hidup pemilik  |

### 5.3 Analisis Biaya vs Manfaat

Dengan total estimasi biaya langsung yang sangat rendah (Rp 0 — Rp 500.000) dan manfaat yang mencakup otomatisasi menyeluruh seluruh operasional usaha, **Return on Investment (ROI) proyek ini sangat positif**. Bahkan jika hanya memperhitungkan penghematan waktu pencatatan manual, manfaat yang diperoleh sudah jauh melebihi investasi yang dikeluarkan.

[ESTIMASI NILAI RUPIAH PENGHEMATAN WAKTU PER BULAN PERLU DIISI MANUAL]
[ESTIMASI NILAI RUPIAH PENGURANGAN KERUGIAN AKIBAT KESALAHAN PENCATATAN PERLU DIISI MANUAL]

### 5.4 Kesimpulan Kelayakan Ekonomi

**LAYAK.** Investasi yang diperlukan sangat minimal karena seluruh teknologi bersifat open-source dan deployment berjalan lokal. Manfaat otomatisasi yang dihasilkan secara kualitatif jauh melebihi biaya yang dikeluarkan.

---

## 6. Schedule Feasibility

### 6.1 Timeline yang Diamanatkan

Total durasi pengembangan diestimasi **12 bulan** dengan pembagian sebagai berikut:

| Fase                                   | Periode        | Durasi   | Keterangan                                                      |
| -------------------------------------- | -------------- | -------- | --------------------------------------------------------------- |
| Planning & Analysis                    | Bulan 1 — 2    | 2 bulan  | Penyusunan seluruh dokumen perencanaan dan analisis kebutuhan.  |
| Design                                 | Bulan 3        | 1 bulan  | Perancangan arsitektur sistem, database, dan alur interaksi.    |
| Implementation — Modul Inti            | Bulan 4 — 7    | 4 bulan  | Percetakan, ATK, Stok, Keuangan (modul prioritas utama).       |
| Implementation — Modul Lanjutan        | Bulan 8 — 10   | 3 bulan  | SDM, Penggajian, Poin, Pinjaman, Aset, CRM, Keamanan, dll.     |
| Testing & UAT                          | Bulan 11       | 1 bulan  | Pengujian menyeluruh dan User Acceptance Testing.               |
| Deployment & Stabilisasi               | Bulan 12       | 1 bulan  | Deployment lokal, migrasi data awal, dan stabilisasi sistem.    |

### 6.2 Evaluasi Kewajaran Jadwal

**Faktor Pendukung:**

- Pendekatan bertahap (modul inti terlebih dahulu) mengurangi risiko kegagalan total.
- Tim AI yang tersedia 24/7 mempercepat siklus pengembangan dibandingkan tim manusia konvensional.
- Tidak ada ketergantungan pada pihak ketiga (API, vendor lisensi) yang dapat menyebabkan keterlambatan.
- Arsitektur CLI menyederhanakan pengembangan dibandingkan GUI/Web.

**Faktor Risiko:**

- 20 modul fungsional merupakan cakupan yang sangat besar untuk timeline 12 bulan.
- Koordinasi antara Junior Programmer dan 6 agen AI memerlukan manajemen yang disiplin.
- Fase Testing & UAT hanya 1 bulan untuk menguji 20 modul — cukup ketat.
- Perubahan kebutuhan bisnis (scope creep) dapat menggeser jadwal.

### 6.3 Kesimpulan Kelayakan Jadwal

**LAYAK DENGAN MITIGASI.** Timeline 12 bulan cukup realistis dengan syarat: (a) prioritisasi modul inti pada 6 bulan pertama dipatuhi secara disiplin, (b) scope creep dikendalikan melalui mekanisme change request yang terstruktur, dan (c) pengujian dilakukan secara paralel selama fase implementasi, bukan hanya pada bulan ke-11.

---

## 7. Risk and Mitigation Strategy

### 7.1 Matriks Risiko

| No. | Risiko                                                                                    | Probabilitas | Dampak     | Level   | Strategi Mitigasi                                                                                                           |
| --- | ----------------------------------------------------------------------------------------- | ------------ | ---------- | ------- | --------------------------------------------------------------------------------------------------------------------------- |
| R1  | Kompleksitas sistem (20+ modul) melebihi kapasitas tim pengembang.                        | Sedang       | **Tinggi** | **Kritis** | Prioritaskan modul inti (percetakan, ATK, stok, keuangan) terlebih dahulu. Kembangkan modul lainnya secara bertahap sesuai milestone. |
| R2  | Kesalahan input data awal dari Excel menyebabkan data tidak konsisten.                    | Tinggi       | Sedang     | **Tinggi** | Sediakan fitur validasi data pada modul input awal. Lakukan verifikasi bertahap per modul dengan melibatkan pemilik usaha.  |
| R3  | Kurva pembelajaran CLI terlalu tinggi bagi karyawan non-teknis.                           | Sedang       | Sedang     | **Sedang** | Buat panduan pengguna yang komprehensif dan antarmuka CLI intuitif dengan navigasi menu terstruktur dan pesan error yang jelas. |
| R4  | Scope creep — perubahan kebutuhan bisnis di tengah pengembangan.                          | Sedang       | Sedang     | **Sedang** | Dokumentasi kebutuhan yang solid pada fase analisis. Terapkan mekanisme change request formal yang terstruktur.              |
| R5  | Keamanan data sensitif (pinjaman, tabungan) terancam jika implementasi hak akses gagal.   | Rendah       | **Tinggi** | **Tinggi** | Terapkan enkripsi data sensitif (bcrypt), autentikasi JWT, hak akses berbasis peran, dan uji penetrasi pada modul keamanan. |
| R6  | Ketergantungan pada satu orang (pemilik) sebagai satu-satunya sumber kebutuhan bisnis.    | Tinggi       | Sedang     | **Tinggi** | Dokumentasikan seluruh kebutuhan secara komprehensif dalam narasi.txt dan project charter. Validasi melalui review berkala.  |

### 7.2 Strategi Mitigasi Umum

1. **Pendekatan Iteratif dalam Waterfall**: Meskipun menggunakan metodologi Waterfall, lakukan review dan validasi di setiap akhir fase untuk memastikan tidak ada akumulasi kesalahan yang besar.
2. **Pengujian Berkelanjutan**: Integrasikan pengujian unit selama fase implementasi, tidak hanya mengandalkan fase testing di bulan ke-11.
3. **Dokumentasi Komprehensif**: Setiap fase SDLC menghasilkan dokumen yang lengkap dan tervalidasi sebagai fondasi fase berikutnya.
4. **Manajemen Ekspektasi**: Komunikasikan secara transparan kepada pemilik usaha bahwa modul inti akan tersedia di bulan ke-6, sedangkan modul lanjutan di bulan ke-10.

---

## 8. Conclusion & Recommendation (Go / No-Go)

### 8.1 Ringkasan Evaluasi

| Dimensi Kelayakan      | Status                   | Catatan                                                              |
| ---------------------- | ------------------------ | -------------------------------------------------------------------- |
| Kelayakan Teknis       | ✅ **Layak**              | Seluruh teknologi open-source tersedia dan matang.                   |
| Kelayakan Operasional  | ✅ **Layak (dg catatan)** | Adopsi CLI memerlukan panduan; sistem menjawab kebutuhan langsung.   |
| Kelayakan Ekonomi      | ✅ **Layak**              | Biaya minimal (Rp 0–500rb); ROI sangat positif.                     |
| Kelayakan Jadwal       | ✅ **Layak (dg mitigasi)**| 12 bulan realistis dengan pendekatan bertahap dan disiplin.          |
| Risiko                 | ⚠️ **Terkelola**          | 6 risiko teridentifikasi dengan mitigasi yang telah dirancang.       |

### 8.2 Rekomendasi

## **🟢 GO — Proyek Layak Dilanjutkan**

Berdasarkan evaluasi kelayakan dari seluruh dimensi yang dianalisis, proyek **AbuCom — Sistem Manajemen Usaha Percetakan Terpadu** dinyatakan **layak untuk dilanjutkan** ke fase berikutnya dalam siklus SDLC (Requirements Analysis & Design).

**Alasan Utama:**

1. **Kebutuhan bisnis nyata dan mendesak** — Pemilik usaha mengalami stres, burnout, dan inefisiensi operasional yang signifikan akibat pengelolaan manual satu orang.
2. **Biaya pengembangan sangat rendah** — Seluruh teknologi bersifat open-source dan deployment berjalan lokal, sehingga investasi finansial minimal.
3. **Teknologi tersedia dan matang** — Tidak ada hambatan teknis yang signifikan; seluruh komponen stack telah terbukti stabil.
4. **Tim pengembang memadai** — Kombinasi Junior Programmer dengan 6 agen AI memberikan kapasitas yang cukup untuk menangani kompleksitas proyek.
5. **Manfaat langsung dan terukur** — Pengurangan waktu pencatatan manual > 80%, akurasi laporan meningkat, dan kemampuan analisis bisnis yang sebelumnya tidak tersedia.

**Syarat Keberhasilan:**

- Disiplin dalam mengikuti prioritisasi modul inti pada 6 bulan pertama.
- Penerapan mekanisme change request untuk mengendalikan scope creep.
- Penyusunan panduan pengguna CLI yang komprehensif sebelum deployment.
- Pengujian berkelanjutan selama fase implementasi, bukan hanya di akhir.

---

**Referensi Dokumen:**
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/narasi.txt`
