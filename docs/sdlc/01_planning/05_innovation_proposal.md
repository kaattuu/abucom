# Innovation Proposal

## 1. Metadata Dokumen

| Atribut | Detail |
|---|---|
| **Judul Dokumen** | Innovation Proposal |
| **Versi** | 1.0.0 |
| **Status** | [draft] |
| **Tanggal Dibuat** | 2026-05-12 |
| **Disusun Oleh** | Senior Innovation Strategist & Senior Industry Analyst (AI) |

## 2. Ringkasan Eksekutif (Executive Summary)

Dokumen ini merumuskan dan mendokumentasikan usulan peningkatan teknis serta alur kerja sistem sebagai bagian dari pemenuhan Mandat Inovasi yang diwajibkan oleh pemilik usaha. Dokumen ini merekomendasikan **5 (lima)** usulan inovasi utama yang meliputi area Keamanan Data, Efisiensi Operasional, Kualitas Data, dan Manajemen Risiko Bisnis. Seluruh inovasi ini diklasifikasikan berdasarkan prioritas (Tinggi, Sedang, Rendah) untuk diintegrasikan secara terpadu ke dalam Sistem Manajemen Usaha Percetakan "AbuCom" tanpa mengubah cakupan utama dan tumpukan teknologi yang telah disepakati.

## 3. Konteks dan Mandat Inovasi

Usulan inovasi ini dilandasi oleh mandat langsung dari pemilik usaha seperti yang tertuang dalam file sumber narasi kebutuhan bisnis:

- **Kutipan Mandat Inovasi:** "...Saya mewajibkan tim AI pengembang untuk secara aktif melakukan analisis terhadap standar industri percetakan dan retail modern. Jika ditemukan fitur, logika alur kerja, atau metode keamanan yang belum saya sebutkan namun secara signifikan dapat meningkatkan kualitas sistem, efisiensi operasional, atau perlindungan data, maka tim AI **wajib** mengusulkannya dan memasukkannya ke dalam setiap dokumen perencanaan..." (Kutipan dari `narasi.txt` baris 98).
- **Kewajiban Modul:** Penyusunan proposal ini merupakan pemenuhan secara eksplisit atas Modul ke-20 pada *Project Charter* ("Inovasi & Best Practice Industri"), yang mewajibkan tim AI untuk melakukan analisis dan pengusulan fitur-fitur bernilai tambah.
- **Batasan Teknis:** Seluruh usulan inovasi yang terlampir wajib dan dipastikan dapat diimplementasikan di dalam batasan arsitektur sistem awal, yaitu: *Command Line Interface* (CLI) lokal, ditulis secara eksklusif menggunakan *Functional Programming* (FP) di Python, pangkalan data MySQL terpusat, dan struktur data yang siap untuk ekspansi cabang jamak (*Multi-Branch Ready*).
- **Batasan Cakupan:** Inovasi-inovasi berikut ini sangat berhati-hati untuk tidak melampaui batasan *Out-of-Scope* dari Project Charter (tidak mengusulkan integrasi web antarmuka grafis, API pihak ketiga, perdagangan daring, dan layanan berbasis awan).

## 4. Metodologi Analisis

Pendekatan yang digunakan untuk mengidentifikasi dan memvalidasi peluang inovasi adalah sebagai berikut:

- **Analisis Celah (*Gap Analysis*):** Melakukan pemeriksaan kritis antara alur kerja manual harian dengan cakupan solusi 20 modul dasar untuk menemukan ceruk otomatisasi lebih jauh (seperti kurangnya penamaan standar dalam penyimpanan arsip pelanggan).
- **Studi Perbandingan (*Benchmarking*):** Mengidentifikasi praktik unggul dari industri bisnis retail terstruktur maupun ERP skala menengah, dan menurunkannya ke format arsitektur CLI untuk diaplikasikan ke skala UMKM tanpa penambahan beban biaya.
- **Analisis Risiko Operasional:** Memverifikasi mitigasi untuk setiap kerentanan kritis yang tercatat di dokumen *Feasibility Study*, utamanya untuk pencegahan penyalahgunaan sistem secara internal serta pengamanan kedaulatan data.
- **Evaluasi Ekspektasi Stakeholder:** Menganalisis *Stakeholder Register* guna menangkap dan menyediakan solusi bagi kebutuhan implisit yang belum terpenuhi langsung oleh fungsionalitas dasar sistem, seperti transparansi penuh audit historis tanpa risiko kelalaian staf.

## 5. Daftar Usulan Inovasi

### 5.1 Otomatisasi Pencadangan Database Lokal Terenkripsi (Automated Local Encrypted Database Backup)

| Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan |
|---|---|---|---|---|
| A. Inovasi Keamanan & Integritas Data | Tinggi | Rendah | 17. Keamanan & Audit | Penyelesaian desain awal tabel basis data |

- **Deskripsi:** Merupakan skrip utilitas berjalan terpisah yang dieksekusi secara periodik melalui penjadwal otomatis sistem operasi (*cron job* di Linux atau *Task Scheduler* di Windows) setiap penutupan operasional toko. Skrip ini menarik salinan absolut pangkalan data MySQL, memampatkannya sebagai berkas arsip dengan perlindungan enkripsi sandi lokal, lalu memindahkannya ke direktori pencadangan yang aman. Terdapat alur penghapusan otomatis terhadap arsip berusia melampaui rentang `[DURASI_RETENSI_TBA]` hari demi efisiensi kapasitas disk.
- **Justifikasi & Standar Industri:** Menjawab secara definitif kebutuhan mitigasi risiko (Risiko Tinggi - *Disaster Recovery*) terkait kerusakan perangkat keras atau basis data korup (ransomware/pemadaman mendadak), tanpa membutuhkan solusi penyimpanan berbasis *cloud* (Sesuai parameter bebas-awan/Open Source lokal).
- **Spesifikasi Teknis Awal:** Berbasis FP menggunakan *standard library* Python (`subprocess`, `shutil`) mengeksekusi `mysqldump` utilitas. Tanpa ada dependensi *class*. Pemanggilan parameter kata sandi dibungkus aman melaui `python-dotenv`.
- **Dampak Operasional:** Membebaskan kepala percetakan dari kewajiban mem-backup pangkalan data secara manual, menjamin ketersediaan pelaporan keuangan bila *server* utama mengalami malfungsi.

### 5.2 Pemblokiran Brute-Force & Sesi Kedaluwarsa CLI (Idle Auto-Logout & Brute-Force Protection)

| Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan |
|---|---|---|---|---|
| A. Inovasi Keamanan & Integritas Data | Sedang | Sedang | 17. Keamanan & Audit | Modul Keamanan Dasar |

- **Deskripsi:** Antarmuka CLI yang terus menyala akan secara dinamis dilengkapi sensor inaktivitas ketukan *keyboard*. Bila CLI dibiarkan terbuka dan tidak menerima Input/Output apa pun melebihi jeda waktu `[KONFIGURASI_TIMEOUT_TBA]` menit, sistem merespons dengan memusnahkan JSON Web Token (JWT) dari sirkuit memori lokal, memaksa pengguna yang berada di depannya untuk melakukan *login* ulang. Terdapat pula perlindungan penguncian akun seketika bila ada pihak lain yang mencoba *login* salah menekan sandi hingga lebih dari `[NILAI_MAKSIMAL_GAGAL_TBA]` kali berturut-turut.
- **Justifikasi & Standar Industri:** Hal ini penting di operasional UMKM karena sistem terminal CLI akan diletakkan di ruang ganti/kasir tempat *pramuniaga* sering kali dipanggil meninggalkan komputernya. Praktik *idle-timeout* mutlak diharuskan oleh standar industri manajemen informasi keamanan (NIST Framework) di sektor jasa retail terpusat.
- **Spesifikasi Teknis Awal:** Implementasi penanda waktu (`time.time()`) yang disisipkan murni di dalam *event loop* CLI. Pemblokiran akun dilancarkan melalui fungsi perhitungan iterasi yang tidak melibatkan OOP tambahan, sekadar mengubah `is_locked` dalam baris data staf bersangkutan.
- **Dampak Operasional:** Pencegahan akses ilegal atau curang terhadap informasi krusial (termasuk transfer bank nominal besar) jika sang kasir sedang tidak menjaga meja kerjanya.

### 5.3 Generator Tata Nama File Desain Standar (Standardized Design File Naming Generator)

| Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan |
|---|---|---|---|---|
| B. Inovasi Efisiensi Operasional | Sedang | Rendah | 1. Manajemen Produk Percetakan, 9. Manajemen Antrian & Pelacakan Pesanan | Ketersediaan modul percetakan dasar |

- **Deskripsi:** Sejalan dengan tahap pesanan yang masuk ke status Proses Desain dalam *Job Tracking*, sistem akan mencetak parameter *string* ke layar yang merupakan penamaan standar (*Standard Naming Convention*). Struktur direkomendasikan seperti `[TANGGAL]_[KODE_ORDER]_[NAMA_PELANGGAN]_[ITEM]`. Desainer cukup mengambil/kopi teks ringkas ini dan menggunakannya saat menamakan berkas desain di *hard disk* tanpa harus menebak tata nama.
- **Justifikasi & Standar Industri:** Keluhan pemilik di narasi menyebutkan data pelanggan yang tak mudah ditelusuri. Penamaan baku merupakan pilar Manajemen Aset Digital (*Digital Asset Management*) termurah dan terefektif yang mempersingkat pencarian cetak ulang (repeat order). Hal ini meningkatkan pelayanan konsumen di dalam payung *Customer Experience* berbiaya nol.
- **Spesifikasi Teknis Awal:** Eksekusi fungsi *pure formatter* (`lambda` atau `format()`) yang mengubah tupel aliran transaksi pesanan menjadi sebuah *string* cetakan terminal tanpa *overhead database* sama sekali.
- **Dampak Operasional:** Produksi desain akan bertambah pesat tanpa beban administrasi di pihak desain kreatif dan mencegah keributan antar divisi akibat berkas yang hilang/salah ganti di dalam pangkalan data fisik komputer.

### 5.4 Kerangka Penanda Soft Delete (Soft Delete Data Retention Framework)

| Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan |
|---|---|---|---|---|
| C. Inovasi Kualitas Data & Pelaporan | Tinggi | Sedang | Seluruh Tabel (17. Keamanan & Audit) | Penetapan DDL awal |

- **Deskripsi:** Mengamanatkan secara terpadu bahwa semua tipe entitas (*Record* penjualan harian, karyawan, maupun stok) dilarang dihapus dengan perintah klausa keras (`DELETE`). Mekanisme yang terjadi bila pengguna memerintahkan sistem CLI untuk "menghapus" hanyalah mengubah parameter tersamar di MySQL (*contoh: `is_deleted` bernilai benar (1)*).
- **Justifikasi & Standar Industri:** Merupakan esensi mutlak atas kebutuhan *Audit Trail* (Rekam Jejak Aktivitas). Penghapusan keras meniadakan bukti sejarah operasional secara permanen. Dalam kerangka kerja sistem ERP mutakhir manapun, *soft deletion* wajib hukumnya untuk transparansi forensik bila timbul anomali antara kas fisik dan pelaporan tanpa merusak referensial *Bill of Materials* historis.
- **Spesifikasi Teknis Awal:** FP berfungsi sebagai penyaring data elegan. Seluruh modul pembacaan tabel (*read query/fetching function*) diinstruksikan menolak data di mana `is_deleted == 1`. Operasi *write/delete* hanya mengubah bendera bit ke 1 di MySQL melalui MySQL Connector `execute` ringan.
- **Dampak Operasional:** Memastikan stabilitas keamanan historis selamanya; jika terjadi pengembalian pesanan secara ekstrem atau manipulasi pencatatan uang, aktivitas kasir nakal yang mencoba menghapus slip elektronik tetap ditelusuri sistem.

### 5.5 Validasi PIN Transaksi Finansial Mencurigakan (Suspicious Transaction PIN Authorization)

| Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan |
|---|---|---|---|---|
| E. Inovasi Manajemen Risiko Bisnis | Tinggi | Sedang | 4. Manajemen Jasa Keuangan, 13. Manajemen Keuangan & Pelaporan | Pemilihan algoritma sandi bcrypt |

- **Deskripsi:** Merupakan palang pengaman bersyarat (kondisional) di *backend* pemrosesan data, khususnya untuk layanan pengiriman maupun tarik tunai perbankan. Ketika kasir mendepositkan/mengeluarkan nilai setara mata uang nyata yang melebih batasan *threshold* wajar per satu siklus transaksi yakni `[NOMINAL_BATAS_AMAN_TBA]`, layar CLI menangguhkan komitmen data dan mendadak memaksa penyisipan PIN Rahasia dari Pemilik sebagai syarat otorisasi sekunder.
- **Justifikasi & Standar Industri:** Pemilik AbuCom turut memutarkan dana investasi sahabat/orang tua (pinjaman tanpa bunga). Mekanisme *Dual-Control* atau *Two-Step Approval* menjadi fondasi dasar aplikasi finansial kelas korporasi (*Maker-Checker*) yang berfungsi mencegah pencurian nilai sangat masif oleh karyawan ke satu tujuan dompet yang dipalsukan.
- **Spesifikasi Teknis Awal:** Percabangan kode FP di mana fungsi pendaftaran uang menyadari angka lebih besar daripada *limit*. Sandi disandingkan ke rekaman *bcrypt* PIN Pemilik tanpa menghapus JWT kasir bersangkutan.
- **Dampak Operasional:** Memberikan rasa tentram secara psikologis kepada Pemilik atas keamanan simpanan uang giral di agen pembayaran *digital*, seraya membudayakan transparansi operasional untuk transfer bernilai sangat strategis.

## 6. Matriks Ringkasan Inovasi (Innovation Summary Matrix)

| No | Judul Inovasi | Kategori | Prioritas | Kompleksitas | Modul Terdampak |
|---|---|---|---|---|---|
| 1 | Otomatisasi Pencadangan Database Lokal Terenkripsi | A. Inovasi Keamanan & Integritas Data | Tinggi | Rendah | 17. Keamanan & Audit |
| 2 | Pemblokiran Brute-Force & Sesi Kedaluwarsa CLI | A. Inovasi Keamanan & Integritas Data | Sedang | Sedang | 17. Keamanan & Audit |
| 3 | Generator Tata Nama File Desain Standar | B. Inovasi Efisiensi Operasional | Sedang | Rendah | 1. Manajemen Produk Percetakan, 9. Manajemen Antrian & Pelacakan Pesanan |
| 4 | Kerangka Penanda Soft Delete | C. Inovasi Kualitas Data & Pelaporan | Tinggi | Sedang | 17. Keamanan & Audit (Semua Tabel MySQL) |
| 5 | Validasi PIN Transaksi Finansial Mencurigakan | E. Inovasi Manajemen Risiko Bisnis | Tinggi | Sedang | 4. Manajemen Jasa Keuangan, 13. Manajemen Keuangan & Pelaporan |

## 7. Peta Ketergantungan Inovasi (Innovation Dependency Map)

Urutan rekomendasi tahapan implementasi sejalan dengan aliran pembangunan logis di SDLC:
1. **Kerangka Penanda Soft Delete:** Mengikat kuat sebelum Fase Implementasi Kode berjalan (Desain *Database* MySQL harus selesai di awal).
2. **Generator Tata Nama File Desain Standar:** Bebas dan terintegrasi mulus ketika Modul Percetakan dan Pelacakan Pesanan sedang diinisiasi.
3. **Validasi PIN Transaksi Finansial Mencurigakan:** Dilaksanakan saat pengembangan lapisan Transaksi Uang (Modul Jasa Keuangan), bersamaan selesainya perbekalan kriptografi token otentikasi.
4. **Pemblokiran Brute-Force & Sesi Kedaluwarsa CLI:** Bergabung masuk menjelang akhir integrasi modul-modul ketika *loop* utama (*Main CLI Loop/Terminal Prompt*) distabilkan.
5. **Otomatisasi Pencadangan Database Lokal Terenkripsi:** Skrip periferal ini ditempatkan terlepas mandiri di saat keseluruhan ekosistem siap rilis final (*Go-Live*).

## 8. Dampak terhadap Fase SDLC Selanjutnya

Adanya dokumen ini membawa konsekuensi modifikasi fungsional untuk tahap mendatang di dalam proses siklus SDLC:
- **Analisis Kebutuhan Bisnis / Software (Analysis):** Mengharuskan konsultasi lanjutan ke pemilik bisnis terhadap beberapa variabel krusial: penetapan jadwal *cron* pemeliharaan, berapa menit angka *timeout* yang layak untuk mencegah staf CLI frustrasi, dan berapakah angka nominal (Rp) rupiah yang sah untuk menghidupkan *trigger* otorisasi PIN di dalam transfer perbankan.
- **Rancangan Skema Database (Design):** Tiap cetak biru *Entity Relationship Diagram* (ERD) MySQL kini secara universal wajib diperluas dengan deklarasi bit `is_deleted TINYINT(1) DEFAULT 0` dan struktur penyimpanan untuk preferensi batas limit nominal keuangan.
- **Implementasi (Implementation):** Tuntutan kepatuhan *Functional Programming* sangat ketat pada arsitektur baca kueri (filter status *delete*) secara iteratif di setiap *view function*.

## 9. Riwayat Versi

| Versi | Tanggal | Diubah Oleh | Keterangan |
|---|---|---|---|
| 1.0.0 | 2026-05-12 | Senior Innovation Strategist & Senior Industry Analyst (AI) | Pembuatan draf dokumen proposal inovasi yang selaras dengan spesifikasi proyek dan batasan FP CLI Murni untuk pemenuhan Mandat Inovasi AbuCom. |

## Referensi Dokumen
Dokumen ini disusun berdasarkan analisis komprehensif terhadap:
- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/01_planning/02_feasibility_study.md`
- `docs/sdlc/01_planning/03_stakeholder_register.md`
- `docs/sdlc/01_planning/04_tech_stack_decision.md`
