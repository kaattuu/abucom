# Innovation Proposal

## 1. Metadata Dokumen

| Atribut | Detail |
|---|---|
| **Judul Dokumen** | Innovation Proposal |
| **Versi** | 1.1.0 |
| **Status** | [finish] |
| **Tanggal Dibuat** | 2026-05-12 |
| **Disusun Oleh** | Senior Innovation Strategist & Senior Industry Analyst (AI) |
| **Divalidasi Oleh** | Senior Enterprise Architect & Senior Quality Assurance Specialist (AI) |

## 2. Ringkasan Eksekutif (Executive Summary)

Dokumen ini merumuskan dan mendokumentasikan usulan peningkatan teknis serta alur kerja sistem sebagai bagian dari pemenuhan Mandat Inovasi yang diwajibkan oleh pemilik usaha. Dokumen ini merekomendasikan **5 (lima)** usulan inovasi utama yang meliputi area Keamanan Data, Efisiensi Operasional, Kualitas Data, dan Manajemen Risiko Bisnis. Seluruh inovasi ini diklasifikasikan berdasarkan prioritas (Tinggi, Sedang, Rendah) dan wajib diintegrasikan secara terpadu ke dalam Sistem Manajemen Usaha Percetakan "AbuCom" tanpa mengubah cakupan utama dan tumpukan teknologi yang telah disepakati, yaitu CLI Python berbasis Functional Programming (FP) murni dengan pangkalan data MySQL lokal.

## 3. Konteks dan Mandat Inovasi

Usulan inovasi ini dilandasi oleh mandat langsung dari pemilik usaha seperti yang tertuang dalam file sumber narasi kebutuhan bisnis:

- **Kutipan Mandat Inovasi:** "...Saya mewajibkan tim AI pengembang untuk secara aktif melakukan analisis terhadap standar industri percetakan dan retail modern. Jika ditemukan fitur, logika alur kerja, atau metode keamanan yang belum saya sebutkan namun secara signifikan dapat meningkatkan kualitas sistem, efisiensi operasional, atau perlindungan data, maka tim AI **wajib** mengusulkannya dan memasukkannya ke dalam setiap dokumen perencanaan..." (Kutipan dari `narasi.txt` baris 98).
- **Kewajiban Modul:** Penyusunan proposal ini merupakan pemenuhan secara eksplisit atas Modul ke-20 pada *Project Charter* ("Inovasi & Best Practice Industri"), yang mewajibkan tim AI untuk melakukan analisis dan pengusulan fitur-fitur bernilai tambah.
- **Batasan Teknis:** Seluruh usulan inovasi yang terlampir wajib dan dipastikan dapat diimplementasikan di dalam batasan arsitektur sistem yang telah ditetapkan, yaitu: antarmuka *Command Line Interface* (CLI) lokal, ditulis secara eksklusif menggunakan *Functional Programming* (FP) di Python tanpa penggunaan `class`, pangkalan data MySQL terpusat, dan struktur data yang siap untuk ekspansi cabang jamak (*Multi-Branch Ready*).
- **Batasan Cakupan:** Seluruh inovasi berikut ini secara ketat tidak melampaui batasan *Out-of-Scope* dari Project Charter. Artinya, tidak ada satu pun inovasi yang mengusulkan integrasi antarmuka web, antarmuka grafis (GUI), API pihak ketiga, perdagangan daring, maupun layanan berbasis awan (*cloud*).

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

- **Deskripsi:** Merupakan skrip utilitas mandiri (terpisah dari aplikasi utama) yang dieksekusi secara periodik melalui penjadwal otomatis sistem operasi (`cron job` di Linux atau *Task Scheduler* di Windows) setiap penutupan operasional toko. Skrip ini memanggil utilitas `mysqldump` via `subprocess` untuk mengekstrak salinan absolut pangkalan data MySQL, memampatkannya sebagai berkas arsip terenkripsi sandi lokal, lalu memindahkannya ke direktori pencadangan yang aman. Terdapat alur penghapusan otomatis terhadap arsip berusia melampaui **30 hari** demi menjaga efisiensi kapasitas disk.
- **Justifikasi & Standar Industri:** Menjawab secara definitif kebutuhan mitigasi risiko (Risiko Tinggi - *Disaster Recovery*) terkait kerusakan perangkat keras atau basis data korup akibat ransomware maupun pemadaman mendadak. Solusi ini sepenuhnya berbasis lokal dan tidak membutuhkan layanan penyimpanan berbasis *cloud*, sesuai parameter bebas-awan dan Open Source lokal yang telah ditetapkan.
- **Spesifikasi Teknis Awal (FP Murni):** Diimplementasikan sebagai kumpulan fungsi Python murni menggunakan *standard library* (`subprocess`, `shutil`, `os`, `datetime`). Tidak ada definisi `class` sama sekali. Satu fungsi memanggil `mysqldump`, satu fungsi mengompresi hasilnya, satu fungsi memindahkan ke direktori tujuan, dan satu fungsi membersihkan arsip lama. Kredensial kata sandi diambil aman dari *environment variable* melalui `python-dotenv`.
- **Dampak Operasional:** Membebaskan kepala percetakan dari kewajiban mem-backup pangkalan data secara manual setiap hari, serta menjamin ketersediaan data pemulihan jika server utama mengalami kegagalan mendadak.

### 5.2 Pemblokiran Brute-Force & Sesi Kedaluwarsa CLI (Idle Auto-Logout & Brute-Force Protection)

| Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan |
|---|---|---|---|---|
| A. Inovasi Keamanan & Integritas Data | Sedang | Sedang | 17. Keamanan & Audit | Modul Keamanan Dasar |

- **Deskripsi:** Pada *event loop* utama CLI, setiap iterasi menjalankan fungsi pemeriksa selisih waktu (`time.time()`) antara aktivitas terakhir pengguna dengan waktu sekarang. Bila tidak ada masukan apapun selama **10 menit**, sistem merespons dengan menghapus JSON Web Token (JWT) dari memori sesi lokal, lalu mencetak pesan ke layar CLI dan memaksa pengguna melakukan *login* ulang. Di sisi lain, setiap percobaan *login* yang gagal direkam oleh fungsi penghitung iterasi. Bila jumlah kegagalan melebihi **5 kali** secara berturut-turut, fungsi pembaruan data staf mengubah kolom `is_locked` menjadi `1` di MySQL, sehingga akun terkunci secara otomatis dan hanya dapat dibuka oleh administrator.
- **Justifikasi & Standar Industri:** Hal ini kritis di operasional UMKM karena terminal CLI diletakkan di area kasir yang sering ditinggal karyawan untuk melayani pelanggan. Penerapan *idle-timeout* adalah praktik keamanan wajib yang direkomendasikan oleh NIST Cybersecurity Framework untuk sistem informasi di lingkungan layanan retail terpusat.
- **Spesifikasi Teknis Awal (FP Murni):** Seluruh logika ditulis sebagai fungsi-fungsi komposabel tanpa `class`. Fungsi `check_idle(last_activity_ts, timeout_seconds)` mengembalikan nilai `True` atau `False`. Fungsi `increment_failed_attempts(staff_id, db_conn)` menjalankan kueri `UPDATE` untuk menaikkan penghitung. Fungsi `lock_account(staff_id, db_conn)` menjalankan kueri `UPDATE` untuk mengubah `is_locked = 1`. Tidak ada atribut instansi maupun pewarisan.
- **Dampak Operasional:** Mencegah akses ilegal terhadap data keuangan sensitif (termasuk saldo rekening dan nominal transfer besar) ketika kasir meninggalkan meja kerjanya dalam keadaan CLI masih terbuka.

### 5.3 Generator Tata Nama File Desain Standar (Standardized Design File Naming Generator)

| Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan |
|---|---|---|---|---|
| B. Inovasi Efisiensi Operasional | Sedang | Rendah | 1. Manajemen Produk Percetakan, 9. Manajemen Antrian & Pelacakan Pesanan | Ketersediaan modul percetakan dasar |

- **Deskripsi:** Ketika status suatu pesanan diperbarui menjadi "Proses Desain" pada modul *Job Tracking*, sistem secara otomatis mencetak satu baris teks ke layar CLI berupa string nama file yang telah diformat secara baku. Struktur format yang direkomendasikan adalah: `[TANGGAL]_[KODE_ORDER]_[NAMA_PELANGGAN]_[ITEM]`. Staf desainer cukup menyalin teks tersebut dan langsung menggunakannya untuk menamakan berkas desain di *hard disk*, tanpa perlu menebak ataupun membuat sendiri konvensi penamaannya.
- **Justifikasi & Standar Industri:** Keluhan pemilik dalam narasi menyebutkan sulitnya menelusuri data desain pelanggan lama. Penamaan file yang baku (*Standard Naming Convention*) adalah pilar *Digital Asset Management* (DAM) yang paling murah dan efektif, terbukti mempersingkat waktu pencarian saat pelanggan melakukan *repeat order* tanpa biaya tambahan apapun.
- **Spesifikasi Teknis Awal (FP Murni):** Diimplementasikan sebagai satu fungsi *pure formatter* yang menerima tupel data pesanan (tanggal, kode order, nama pelanggan, item) sebagai parameter masukan dan mengembalikan satu string terformat sebagai keluaran. Contoh: `def generate_design_filename(order_date, order_code, customer_name, item_name) -> str`. Fungsi ini tidak memiliki efek samping, tidak mengakses database, dan tidak memodifikasi state manapun.
- **Dampak Operasional:** Mempercepat alur produksi desain, mencegah kekacauan antar divisi akibat berkas yang hilang atau salah simpan, serta mendukung fitur Arsip Desain Pelanggan yang diinginkan pemilik.

### 5.4 Kerangka Penanda Soft Delete (Soft Delete Data Retention Framework)

| Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan |
|---|---|---|---|---|
| C. Inovasi Kualitas Data & Pelaporan | Tinggi | Sedang | Seluruh Tabel (17. Keamanan & Audit) | Penetapan DDL awal |

- **Deskripsi:** Mengamanatkan secara universal bahwa semua entitas data dalam sistem (rekaman penjualan, data karyawan, stok barang) dilarang dihapus menggunakan klausa `DELETE` yang bersifat permanen. Satu-satunya mekanisme "penghapusan" yang diizinkan hanyalah memanggil fungsi pembaruan yang mengubah nilai kolom penanda `is_deleted` di MySQL menjadi `1`. Data dengan `is_deleted = 1` diperlakukan sebagai tidak aktif dan disaring secara otomatis oleh setiap fungsi pembacaan data di seluruh modul.
- **Justifikasi & Standar Industri:** Merupakan fondasi mutlak untuk kebutuhan *Audit Trail* (Rekam Jejak Aktivitas) yang diminta pemilik. Penghapusan keras (`DELETE`) meniadakan bukti historis secara permanen dan tidak dapat dipulihkan. Dalam kerangka kerja ERP modern manapun, *soft deletion* adalah standar wajib untuk menjaga transparansi forensik dan integritas referensial data historis (*Bill of Materials*) bila terjadi anomali antara kas fisik dan laporan digital.
- **Spesifikasi Teknis Awal (FP Murni):** Setiap modul yang membaca data menggunakan fungsi pembaca terpusat (misalnya `fetch_active_records(table, db_conn)`) yang secara otomatis menambahkan klausa `WHERE is_deleted = 0` pada setiap kueri `SELECT`. Fungsi "hapus" di setiap modul hanya menjalankan satu kueri `UPDATE ... SET is_deleted = 1 WHERE id = ?`. Tidak ada pemanggilan `DELETE` di seluruh basis kode.
- **Dampak Operasional:** Menjamin keamanan historis data selamanya. Bila terjadi anomali kas atau dugaan manipulasi pencatatan, aktivitas staf yang mencoba "menghapus" slip transaksi tetap dapat ditelusuri sepenuhnya melalui modul Audit Trail.

### 5.5 Validasi PIN Transaksi Finansial Mencurigakan (Suspicious Transaction PIN Authorization)

| Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan |
|---|---|---|---|---|
| E. Inovasi Manajemen Risiko Bisnis | Tinggi | Sedang | 4. Manajemen Jasa Keuangan, 13. Manajemen Keuangan & Pelaporan | Pemilihan algoritma sandi bcrypt |

- **Deskripsi:** Merupakan palang pengaman kondisional yang tertanam di dalam fungsi pemrosesan transaksi finansial, khususnya untuk layanan transfer uang antar bank dan tarik tunai. Ketika nilai nominal transaksi yang dimasukkan kasir melebihi batas aman yang telah ditetapkan yaitu **Rp 5.000.000**, fungsi pemrosesan menangguhkan komitmen data ke database (`COMMIT` tertunda) dan mencetak perintah ke layar CLI yang meminta penyisipan PIN Rahasia Pemilik. PIN yang dimasukkan kemudian diverifikasi oleh fungsi pemeriksaan kriptografi `bcrypt.checkpw()` terhadap hash PIN yang tersimpan. Hanya jika PIN valid, fungsi `commit_transaction()` dieksekusi; jika tidak valid, transaksi dibatalkan secara otomatis.
- **Justifikasi & Standar Industri:** Pemilik AbuCom mengelola dana pinjaman dari kerabat dan bank. Mekanisme *Dual-Control* atau *Two-Step Approval* (dikenal sebagai pola *Maker-Checker*) adalah fondasi standar aplikasi finansial kelas korporasi yang berfungsi mencegah pencurian nilai besar oleh karyawan tanpa sepengetahuan pemilik.
- **Spesifikasi Teknis Awal (FP Murni):** Logika percabangan ditulis sepenuhnya sebagai komposisi fungsi. Fungsi `is_high_value_transaction(amount, threshold)` mengembalikan `True` atau `False`. Jika `True`, fungsi `request_owner_pin_verification(db_conn)` dipanggil, yang di dalamnya memanggil `bcrypt.checkpw(input_pin, stored_hash)`. Fungsi `commit_transaction(data, db_conn)` hanya dipanggil jika verifikasi berhasil. Tidak ada `class`, tidak ada atribut instansi. JWT sesi kasir tidak terganggu selama proses ini.
- **Dampak Operasional:** Memberikan keamanan berlapis bagi pemilik atas pengelolaan dana di akun agen pembayaran digital, sekaligus membudayakan transparansi dan akuntabilitas operasional untuk setiap transfer bernilai strategis tinggi.

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
1. **Kerangka Penanda Soft Delete:** Wajib diimplementasikan pertama kali, sebelum Fase Implementasi Kode berjalan (Desain DDL MySQL harus selesai di awal agar kolom `is_deleted` sudah ada sejak awal).
2. **Generator Tata Nama File Desain Standar:** Bebas dan terintegrasi mulus saat Modul Percetakan dan Modul Pelacakan Pesanan diinisiasi.
3. **Validasi PIN Transaksi Finansial Mencurigakan:** Diimplementasikan saat pengembangan lapisan Transaksi Uang (Modul Jasa Keuangan), bersamaan selesainya integrasi kriptografi token autentikasi `bcrypt`.
4. **Pemblokiran Brute-Force & Sesi Kedaluwarsa CLI:** Diintegrasikan menjelang akhir, ketika *main event loop* CLI sudah terstabilkan dan seluruh modul sudah tersambung.
5. **Otomatisasi Pencadangan Database Lokal Terenkripsi:** Skrip utilitas periferal ini ditempatkan terpisah dan mandiri, diaktifkan pada saat keseluruhan ekosistem siap rilis final (*Go-Live*).

## 8. Dampak terhadap Fase SDLC Selanjutnya

Adanya dokumen ini membawa konsekuensi modifikasi fungsional untuk tahap mendatang di dalam proses siklus SDLC:
- **Analisis Kebutuhan (Analysis):** Mengharuskan konsultasi lanjutan ke pemilik bisnis untuk menetapkan beberapa parameter konfigurasi krusial, yaitu: jadwal eksekusi *cron job* backup, berapa menit angka *idle-timeout* yang ideal bagi staf CLI, batas jumlah gagal *login* sebelum akun dikunci, serta nilai nominal (Rp) yang menjadi pemicu otorisasi PIN dalam transfer perbankan.
- **Rancangan Skema Database (Design):** Setiap cetak biru *Entity Relationship Diagram* (ERD) MySQL kini secara universal wajib diperluas dengan penambahan dua kolom: `is_deleted TINYINT(1) NOT NULL DEFAULT 0` pada setiap tabel entitas, dan satu tabel konfigurasi sistem untuk menyimpan nilai batas nominal transaksi (`transaction_limit_owner_pin`) serta pengaturan sistem lainnya.
- **Implementasi (Implementation):** Kepatuhan terhadap *Functional Programming* sangat ketat: setiap fungsi pembacaan data wajib memfilter `is_deleted = 0` secara eksplisit, dan tidak ada satu pun penggunaan `class` di dalam basis kode.

## 9. Riwayat Versi

| Versi | Tanggal | Diubah Oleh | Keterangan |
|---|---|---|---|
| 1.0.0 | 2026-05-12 | Senior Innovation Strategist & Senior Industry Analyst (AI) | Pembuatan draf dokumen proposal inovasi yang selaras dengan spesifikasi proyek dan batasan FP CLI Murni untuk pemenuhan Mandat Inovasi AbuCom. |
| 1.1.0 | 2026-05-12 | Senior Enterprise Architect & Senior Quality Assurance Specialist (AI) | Validasi dokumen: pengisian seluruh placeholder (retensi backup 30 hari, idle-timeout 10 menit, batas gagal login 5 kali, threshold PIN Rp 5.000.000), perbaikan redaksi agar lugas dan bebas ambiguitas OOP, penguatan spesifikasi teknis FP Murni pada kelima inovasi, penambahan kolom `is_deleted` pada skema DDL, pembaruan status dari `[draft]` menjadi `[finish]`. |

## Referensi Dokumen
Dokumen ini disusun berdasarkan analisis komprehensif terhadap:
- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/01_planning/02_feasibility_study.md`
- `docs/sdlc/01_planning/03_stakeholder_register.md`
- `docs/sdlc/01_planning/04_tech_stack_decision.md`
- NIST Cybersecurity Framework (CSF) v2.0 — *Govern, Protect, Detect* Functions (referensi untuk inovasi idle-timeout & brute-force protection)
- ISO/IEC 27002:2022 — Information Security Controls (referensi untuk backup terenkripsi & kontrol akses)
- Martin Fowler — *Patterns of Enterprise Application Architecture* (referensi untuk pola Soft Delete & Audit Trail)
