# Software Requirements Specification (SRS) — Sistem Manajemen Usaha Percetakan "AbuCom"

## 1. Pendahuluan

**Tujuan Dokumen**
Dokumen *Software Requirements Specification* (SRS) ini bertujuan untuk mendefinisikan seluruh spesifikasi kebutuhan perangkat lunak untuk Sistem Manajemen Usaha Percetakan "AbuCom". Dokumen ini merupakan turunan langsung dari *Business Requirements Document* (BRD) dan berfungsi sebagai pedoman utama bagi tim pengembang dalam fase desain arsitektur, basis data, dan alur aplikasi Command Line Interface (CLI).

**Ruang Lingkup Perangkat Lunak**
Perangkat lunak ini adalah sebuah aplikasi mandiri berbasis terminal CLI yang dibangun sepenuhnya menggunakan paradigma *Functional Programming* (FP). Aplikasi ini memfasilitasi fungsionalitas operasional bisnis terpadu, termasuk manajemen transaksi kasir (multi-lini layanan), manajemen inventaris dengan *Bill of Materials* (BOM), pelacakan status pesanan (*job tracking*), pencatatan layanan PPOB dan mutasi jasa keuangan, manajemen SDM dan penggajian cerdas, serta pelaporan keuangan komprehensif.

---

## 2. Deskripsi Keseluruhan

**Perspektif Sistem**
Aplikasi ini beroperasi murni di atas terminal eksekusi perintah (CLI). Logika bisnis dibangun menggunakan sekumpulan *pure functions* yang memproses dan mengembalikan *immutable data structures*. Data dipertahankan di dalam basis data relasional MySQL 8.4 LTS, dengan komunikasi data (*state passing*) yang difasilitasi oleh `mysql-connector-python`. Setiap entitas data di dalam sistem mengusung arsitektur *Multi-Branch Ready* yang ditandai dengan identifikasi `branch_id`.

**Karakteristik Pengguna**
1. **Pemilik**: Memiliki akses tertinggi untuk menjalankan seluruh perintah (*commands*), mengeksekusi semua *pure functions* sistem, melihat audit trail, dan mengakses seluruh laporan finansial (termasuk mutasi tabungan pribadi dan riwayat hutang bank).
2. **Karyawan**: Memiliki izin eksekusi perintah terbatas pada modul operasional harian (kasir, gudang, produksi). Mereka secara ketat tidak diberikan hak otorisasi untuk menampilkan data finansial sensitif pada antarmuka CLI.

**Lingkungan Operasi**
- **Sistem Operasi**: Linux Debian 12 Bookworm dan Windows 11 24H2.
- **Runtime**: Python 3.14.2+ (Terminal/Console standar).
- **Backend Database**: MySQL 8.4 LTS Community Edition (Lokal).

**Asumsi dan Ketergantungan**
- Server MySQL beroperasi secara stabil di *localhost* dengan konfigurasi kredensial yang tersimpan dengan aman pada file `.env`.
- Perangkat keras memiliki kapasitas komputasi yang mencukupi untuk menjalankan komputasi hashing algoritma `bcrypt` dengan toleransi respons yang masih masuk akal pada *prompt* CLI.

---

## 3. Kebutuhan Antarmuka Eksternal

**Antarmuka Pengguna (CLI)**
Seluruh interaksi pengguna dilakukan melalui terminal teks murni. Navigasi modul diimplementasikan melalui sistem menu berbasis angka atau perintah teks (*commands*). Parameter atau argumen fungsi akan diminta melalui *prompt input keyboard* berurutan. Sistem wajib menggunakan antarmuka baris perintah standar tanpa implementasi *library windowing* atau Graphical User Interface (GUI). Output akan ditampilkan sebagai tabel ASCII atau teks terstruktur pada *stdout*.

**Antarmuka Perangkat Lunak/Sistem**
Konektivitas ke basis data MySQL dijalankan secara fungsional dengan melakukan *query string passing* menggunakan `mysql-connector-python`. Hasil eksekusi *query* dikembalikan dalam bentuk `tuple` atau susunan data dasar (FP), bukan melalui mekanisme representasi objek (tanpa Object-Relational Mapping / ORM).

---

## 4. Kebutuhan Fungsional (Detail System Features)

Berikut merupakan jabaran fitur sistem, memetakan kebutuhan input (*arguments*), proses (eksekusi fungsi fungsional murni), dan output pada layar terminal:

### F-01: Modul Autentikasi dan Otorisasi
- **Input**: *Prompt* meminta string `username` dan `password` dari input keyboard.
- **Proses**: Fungsi autentikasi murni akan membandingkan input hash `bcrypt` (dengan *rounds*=12) dari database. Jika sesuai, sistem men-generate token JWT dengan waktu kadaluarsa (*exp*) 8 jam dan memuat data `user_id`, `role`, serta `branch_id`.
- **Output**: *Stdout* menampilkan status login ("Berhasil" atau "Gagal"). Jika berhasil, layar dibersihkan (*clear screen*) dan menu utama dirender sesuai otorisasi token pengguna.

### F-02: Modul Transaksi Multi-Lini Terpadu (Kasir)
- **Input**: Perintah pemilihan tipe layanan (1. Percetakan, 2. ATK, 3. PPOB, 4. Jasa), ID Barang/Layanan, Kuantitas, serta Argumen status pembayaran (1. DP, 2. Lunas). Jika DP, minta nominal setoran.
- **Proses**: Fungsi kalkulasi akan menghitung subtotal menggunakan prinsip *pure function* tanpa memanipulasi referensi harga awal. Logika memeriksa status volume: menerapkan skema harga grosir (jika kuantitas >= 50 pcs) atau harga spesial mitra (jika riwayat aktif pembeli >= 3 bulan). Sistem kemudian memetakan (*mapping*) transaksi ini untuk memanggil fungsi pemotongan stok fungsional.
- **Output**: Menampilkan struk digital pada CLI berisi rincian *item*, harga, nilai diskon/harga khusus, tagihan DP, tagihan sisa, dan status produksi pesanan.

### F-03: Modul Manajemen Gudang dan HPP berbasis BOM
- **Input**: Perintah pembaruan inventaris, ID produk BOM, dan besaran pemakaian dimensi/volume produk.
- **Proses**: Fungsi reduksi akan menerima data *Bill of Materials* dan melakukan *mapping* pemotongan terhadap bahan penyusunnya menggunakan tipe data desimal presisi tinggi (*floats* yang aman untuk finansial, atau `Decimal`). Fungsi akan memperbarui *tuple state* persediaan bahan (mendukung *cross-usage* stok retail/ATK). HPP akan dikalkulasi langsung dan dikembalikan ke fungsi pemanggil.
- **Output**: Menampilkan nilai perhitungan HPP final pada *stdout* beserta laporan sisa stok inventaris setelah reduksi kalkulatif bahan penyusun.

### F-04: Modul Manajemen Pesanan (*Job Tracking*)
- **Input**: Argumen ID Transaksi, status tahapan progres (Antri, Proses Desain, Produksi, Selesai, Diambil), dan string letak jalur file (direktori *path*) arsip desain.
- **Proses**: Fungsi murni memperbarui status alur pesanan pada tabel yang sesuai dan mengikat referensi *path* file ke data pelanggan.
- **Output**: Menampilkan ringkasan pelacakan status terbaru per pelanggan di terminal.

### F-05: Modul Pencatatan Limbah Produksi (*Waste Management*)
- **Input**: Perintah input limbah, ID Bahan Baku, nominal/besaran pemakaian (dimensi/volume/lembar), dan alasan pembuangan.
- **Proses**: Fungsi mencatat pengurangan *state* bahan di basis data dengan penandaan sebagai limbah (bukan transaksi penjualan) untuk menyeimbangkan neraca *stock opname*.
- **Output**: *Prompt* konfirmasi pencatatan berhasil beserta tabel kecil menampilkan sisa bahan di gudang aktual.

### F-06: Modul Manajemen SDM dan Penggajian Cerdas
- **Input**: ID Karyawan untuk transaksi kasbon, log kehadiran masuk/keluar, dan parameter perintah komputasi *payroll* di akhir bulan.
- **Proses**: Fungsi kalkulator gaji mengomputasi data mentah total pemasukan operasional. Jika nilai pendapatan >= Rp 15.000.000 bersih, fungsi menetapkan *return value* komponen gaji dasar sebesar Rp 3.000.000. Jika kurang, dikembalikan rasio pembagian komisi sebesar 15% dari pendapatan bersih. Setelah itu, fungsi mengakumulasi jumlah nilai poin (*filter* aktivitas: rutin 1 Poin=Rp 500, dasar 3 Poin=Rp 1500, kustom 5 Poin=Rp 2500, teknis berat 10 Poin=Rp 5000), dikurangi saldo nilai kasbon aktif.
- **Output**: Menampilkan slip gaji dalam wujud teks terminal terstruktur berisi rincian: (1) Pendapatan Dasar/Bagi Hasil, (2) Bonus Poin Insentif Kerja, (3) Potongan Kasbon, dan (4) Gaji Bersih yang Dibayarkan.

### F-07: Modul Jasa Keuangan & PPOB
- **Input**: Jenis transaksi (pulsa, token, mutasi bank), jumlah nominal mutasi, ID platform asal/tujuan (Mandiri, Dana, LinkAja, dll).
- **Proses**: *Pure function* validasi saldo akan menghitung apakah nilai transaksi valid. Selain itu, fungsi `filter` akan memeriksa seluruh nilai sisa saldo PPOB digital; jika mendeteksi saldo < Rp 150.000, sistem menandai entitas akun tersebut.
- **Output**: Pencatatan riwayat transaksi keuangan pada tabel CLI dan mencetak *stderr/stdout warning message*: "PERINGATAN: Saldo [Nama_Akun] berada di bawah ambang batas minimum. Lakukan deposit setidaknya Rp 500.000 segera."

### F-08: Modul CRM (Pelanggan & Vendor)
- **Input**: Perintah pendataan entitas baru (pelanggan/supplier), Nama Lengkap, Nomor Kontak (WA), dan harga penawaran supplier (jika entitas=vendor).
- **Proses**: Penambahan representasi data baru secara kekal (*immutable log* insertion) pada basis data ke dalam pengawasan `branch_id` yang sesuai.
- **Output**: Memunculkan respons "*Data entitas berhasil direkam dalam log database*".

---

## 5. Kebutuhan Non-Fungsional

**Kinerja (*Performance*)**
- Respon waktu eksekusi interaksi *prompt* dasar hingga render output terminal tidak boleh melebihi `[MASUKKAN_NILAI_MAKSIMAL_LATENCY_CLI]` milidetik (ms) untuk menghindari latensi operasional bagi kasir yang tengah menghadapi antrean fisik.
- Penggunaan memori perangkat lunak tidak lebih dari `[MASUKKAN_BATAS_MAKSIMAL_RAM]` MB saat komputasi kalkulasi fungsi HPP dengan ribuan baris rekaman material.

**Keamanan (*Security*)**
- **Otentikasi & Otorisasi**: Akses operasional sistem dikendalikan ketat menggunakan validasi RBAC dari ekstraksi *payload* token JWT pada tiap eksekusi menu.
- **Enkripsi Kredensial**: Password diproses ke dalam satu fungsi searah (*one-way pure function hashing*) memanfaatkan kapabilitas komputasi `bcrypt`.
- ***Audit Trail***: Seluruh eksekusi fungsi krusial wajib menulis log ke dalam modul *audit trail* yang mencatat string informasi identitas operator, jenis perintah aksi, serta waktu (*timestamp*), demi memitigasi kemungkinan pengubahan/kecurangan data.

**Keandalan (*Reliability*)**
- *State mutation* di tingkat persediaan basis data dikoordinasikan penuh melalui integritas sistem transaksional MySQL (ACID) — seluruh rangkaian manipulasi data harus dalam ikatan blok *commit* yang akan memicu eksekusi pemulihan data (*rollback*) ke *state* awal sekiranya ada satu proses fungsional yang gagal atau melempar eksepsi.

---

## 6. Referensi

- `docs/sdlc/02_analysis/01_business_requirements.md`
- `docs/sdlc/01_planning/04_tech_stack_decision.md`
- `docs/sdlc/narasi.txt`
