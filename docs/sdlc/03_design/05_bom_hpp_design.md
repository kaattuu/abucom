# BOM & HPP Design — Sistem Manajemen Usaha Percetakan AbuCom

## Metadata Dokumen

| Atribut | Detail |
| :--- | :--- |
| **Versi** | 1.1.0 |
| **Status** | [finish] |
| **Tanggal** | 2026-05-17 |
| **Disusun Oleh** | Senior Manufacturing Engineer & Senior Cost Accounting Architect (AI) |

---

## 1. Pendahuluan & Tujuan

Dokumen ini mendefinisikan rancangan teknis untuk sistem *Bill of Materials* (BOM) dan mekanisme kalkulasi Harga Pokok Penjualan (HPP) pada aplikasi AbuCom. Tujuan utamanya adalah memastikan setiap transaksi produk percetakan memiliki nilai modal yang akurat, otomatis, dan presisi tinggi, serta terintegrasi secara *real-time* dengan manajemen stok dan pelaporan laba rugi.

Ruang lingkup dokumen ini mencakup:
- Struktur data BOM dan relasi antar entitas.
- Katalog komposisi bahan baku untuk produk unggulan beserta harga modal referensi.
- Strategi konversi satuan ukur (*Unit of Measure*) lintas dimensi dan volume.
- Algoritma perhitungan HPP menggunakan metode *Average Cost* (Rata-Rata Tertimbang).
- Alur integrasi dengan modul Transaksi Kasir, Gudang Inventaris, dan *Waste Management*.
- Penanganan skenario *edge case* terkait kalkulasi modal.

---

## 2. Definisi Struktur BOM

Sistem AbuCom menggunakan konsep BOM satu level di mana satu produk akhir dapat terdiri dari banyak komponen bahan baku. Semua tipe data kuantitas dan harga menggunakan `DECIMAL(15,4)` untuk mengakomodasi presisi yang sangat tinggi.

### 2.1. Konsep Relasi
Relasi antar tabel dalam basis data didefinisikan secara konseptual sebagai berikut:
- **`products_services` (1) ← (N) `bom`**: Satu produk (khususnya tipe layanan 'Percetakan') memiliki satu atau lebih baris komposisi bahan baku di tabel `bom`.
- **`bom` (N) → (1) `materials`**: Setiap baris BOM merujuk pada satu spesifik material fisik di tabel persediaan bahan baku utama (`materials`).

### 2.2. Penjelasan Kolom Kunci
- **`bom.required_qty`**: Menyimpan jumlah kebutuhan mutlak bahan baku per satu satuan produk pesanan (misalnya: 1 pcs stempel membutuhkan 2.5000 ml tinta).
- **`materials.cost_per_unit`**: Menyimpan harga modal beli rata-rata (*Average Cost*) per satu satuan ukur material. Nilai ini menjadi basis pengali utama dalam proses perhitungan HPP.
- **`materials.stock_quantity`**: Menyimpan sisa stok fisik yang akan dipotong oleh sistem.
- **`transaction_items.item_hpp`**: Menyimpan total beban HPP secara permanen untuk baris transaksi tersebut sebagai riwayat historis pelaporan laba rugi.

---

## 3. Katalog BOM Produk Percetakan Utama

Berikut adalah daftar komposisi bahan baku untuk produk unggulan percetakan AbuCom. Harga modal (`cost_per_unit`) diisi berdasarkan acuan nilai wajar pasaran di Indonesia sebagai parameter simulasi dan referensi implementasi awal.

| Nama Produk | Bahan Penyusun (Material) | Satuan (UoM) | Kebutuhan (`required_qty`) | Harga Modal (`cost_per_unit`) |
| :--- | :--- | :--- | :--- | :--- |
| **Stempel Flash** | Gagang Stempel | pcs | 1.0000 | Rp 5.000 |
| | Karet Flash | cm² | 15.0000 | Rp 100 |
| | Tinta Stempel | ml | 2.5000 | Rp 400 |
| | Kertas Buffalo (Ganjal) | cm² | 10.0000 | Rp 20 |
| **Cetak Foto (4R)** | Kertas Foto Glossy | cm² | 150.0000 | Rp 4 |
| | Tinta Printer (CMYK) | ml | 1.2000 | Rp 400 |
| | Plastik Foto | pcs | 1.0000 | Rp 100 |
| **Buku Yasin** | Isi Buku Yasin (Blangko) | pcs | 1.0000 | Rp 5.000 |
| | Cover Yasin (Hardcover) | pcs | 1.0000 | Rp 8.000 |
| | Lem Panas | gram | 5.0000 | Rp 20 |
| | Pita Pembatas | cm | 20.0000 | Rp 10 |
| **Undangan Pernikahan** | Kertas BC / Tik | lembar | 1.0000 | Rp 800 |
| | Tinta Printer | ml | 0.8000 | Rp 400 |
| | Plastik OPP | pcs | 1.0000 | Rp 50 |
| | Label Nama (103) | pcs | 0.0833 | Rp 10 |
| **Cetak Baliho** | Bahan Flexi 280gr | m² | 1.0000 | Rp 15.000 |
| | Tinta Solvent | ml | 15.0000 | Rp 100 |
| | Mata Ayam (Mata Ikan) | pcs | 4.0000 | Rp 500 |
| **Cetak Stiker A3+** | Kertas Stiker Bontax | lembar | 1.0000 | Rp 3.000 |
| | Tinta Laser / Toner | ml | 0.5000 | Rp 500 |
| **Nama Dada (Name Tag)** | Akrilik / PVC | cm² | 16.0000 | Rp 100 |
| | Resin (A+B) | ml | 5.0000 | Rp 400 |
| | Peniti / Magnet | pcs | 1.0000 | Rp 2.000 |

---

## 4. Strategi Konversi Satuan Ukur (UoM)

Sistem wajib menangani konversi antar kategori satuan secara matematis di *Service Layer* sebelum eksekusi kueri pengurangan stok agar integritas data persediaan mutlak presisi.

| Kategori | Satuan Utama | Satuan Dasar | Rasio Konversi |
| :--- | :--- | :--- | :--- |
| **Diskrit** | pcs, unit, buah | pcs | 1 : 1 |
| **Lembaran** | rim | lembar | 1 rim = 500 lembar |
| **Dimensi (Luas)** | m² | cm² | 1 m² = 10,000 cm² |
| **Volume** | liter | ml | 1 liter = 1,000 ml |
| **Berat** | kg | gram | 1 kg = 1,000 gram |

### Penanganan Produk Dimensi Kustom:
Sistem harus mengakomodasi kalkulasi kebutuhan luasan material dinamis (contoh: baliho cetak meteran atau stiker kustom). Input kasir meminta data **Panjang** dan **Lebar**.
- Formula Luas: `Luas_Terpakai (cm²) = Panjang (cm) × Lebar (cm) × Jumlah_Pesanan`
- Di dalam resep tabel `bom`, nilai `required_qty` untuk material dimensi m² atau cm² didefinisikan sebagai basis satuan (yakni 1.0000). Saat transaksi berlangsung, jumlah luas terpakai inilah yang bertindak sebagai *multiplier* atas `required_qty`.

---

## 5. Formula Kalkulasi HPP

Sistem wajib menjalankan kalkulasi dan menetapkan HPP langsung di memori sesaat sebelum eksekusi komit transaksi. Nilai HPP harus disimpan dengan tingkat pembulatan presisi desimal 4 angka di belakang koma (`DECIMAL(15,4)`) pada basis data.

### 5.1. Formula Matematis
1. **HPP per Unit (Produk Percetakan):**
   $$HPP_{unit} = \sum_{i=1}^{n} (Required\_Qty_{i} \times Cost\_Per\_Unit_{i})$$
   *di mana $i$ adalah bahan baku penyusun yang ditarik dari relasi tabel `bom` dan `materials`.*

2. **Total HPP Transaksi Baris (`item_hpp`):**
   $$Item\_HPP = HPP_{unit} \times Quantity_{pesanan}$$

3. **Total HPP Transaksi Keseluruhan (`total_hpp`):**
   $$Total\_HPP = \sum Item\_HPP$$

### 5.2. Contoh Perhitungan Nyata

#### Contoh 1: Stempel Flash (1 pcs)
- Gagang Stempel: 1.0000 pcs × Rp 5.000 = Rp 5.000
- Karet Flash: 15.0000 cm² × Rp 100 = Rp 1.500
- Tinta Stempel: 2.5000 ml × Rp 400 = Rp 1.000
- Kertas Buffalo: 10.0000 cm² × Rp 20 = Rp 200
- **HPP per Unit = Rp 7.700**

#### Contoh 2: Cetak Baliho Kustom (Ukuran 2m x 3m, 1 pcs)
- Luas Aktual = 200 cm × 300 cm = 60,000 cm² (6 m²)
- Bahan Flexi 280gr: 6.0000 m² × Rp 15.000 = Rp 90.000
- Tinta Solvent: (6.0000 m² × 15.0000 ml/m²) × Rp 100 = Rp 9.000
- Mata Ayam: 4.0000 pcs × Rp 500 = Rp 2.000
- **Total `item_hpp` = Rp 101.000**

---

## 6. Alur Integrasi BOM-HPP ke Transaksi Kasir

Alur kerja fungsional dalam menangani transaksi berbasis BOM harus mengikuti urutan ketat berikut:

1. **Input Data**: Pengguna kasir memilih produk (ID `products_services`), memasukkan jumlah (atau ukuran dimensi PxL untuk produk baliho/stiker), dan memilih ID pelanggan untuk validasi tingkatan harga (*pricing tier*).
2. **Lookup BOM**: Sistem memuat daftar komposisi bahan dari tabel `bom` di mana kondisi `product_id = ?`.
3. **Kalkulasi & Validasi Stok (Critical Query)**:
   - Hitung variabel sementara: `Kebutuhan_Total_Material = required_qty × order_qty`.
   - Sistem wajib memeriksa kondisi ketersediaan logistik melalui kueri tunggal murni: `SELECT stock_quantity, material_name FROM materials WHERE id = ?`.
   - Kondisi keamanan blokir eksekusi diuji: `stock_quantity >= Kebutuhan_Total_Material`.
   - Jika terdapat satu saja kriteria bahan tidak terpenuhi, sistem **wajib** segera membatalkan seluruh operasi dengan memunculkan pesan *error* "Peringatan: Stok bahan [Nama Material] tidak mencukupi."
4. **Eksekusi Pengurangan & Pencatatan**:
   - Jika validasi lolos, panggil `connection.start_transaction()`.
   - Update tabel material `UPDATE materials SET stock_quantity = stock_quantity - ? WHERE id = ?`.
   - Kalkulasi nilai `item_hpp` berdasarkan data historis material `cost_per_unit`.
   - Simpan entitas penjualan pada `transactions` (termasuk kolom `total_hpp`) dan keranjang rincian pada `transaction_items` (termasuk kolom `item_hpp`).
5. **Commit/Rollback**: Seluruh pembaruan diakhiri dengan `connection.commit()` agar menjamin properti *Atomicity*. Apabila di tengah pemrosesan kode terjadi pengecualian/gangguan sistem, program **wajib** melempar fungsi `connection.rollback()`.

---

## 7. Penanganan HPP untuk Layanan Non-Percetakan

Sistem harus menghitung nilai beban modal secara berbeda ketika item transaksi tidak bersumber dari produk jenis *Percetakan* yang memiliki resep BOM:

- **Produk ATK (Retail)**: HPP didapatkan murni dari selisih perkalian nilai `cost_per_unit` barang retail (jika tersinkronisasi) atau nilai setara pembagian rata-rata stok awal di tabel persediaan terkait.
- **Layanan PPOB**: HPP merupakan beban transfer aktual, yakni tagihan nominal asli ke platform *biller* / penyedia layanan PPOB sebelum margin laba (fee).
- **Jasa Teknis (Service & Install)**: Beban HPP dianggap nol (`0`), kecuali proses reparasi menggunakan suku cadang, di mana HPP adalah harga modal suku cadang tersebut.
- **Jasa Keuangan (Transfer)**: HPP merupakan modal bersih tagihan pokok uang yang dikirimkan.

---

## 8. Skenario Edge Case dan Validasi

- **Pembatalan Transaksi**: Transaksi percetakan dapat dibatalkan sewaktu-waktu. Apabila status berubah menjadi "Dibatalkan" dan desain belum memasuki proses cetak fisik, maka skrip pemulihan sistem wajib merekonstruksi kembali (*restock*) persediaan ke tabel `materials`. Namun bila proses desain/produksi sudah berjalan, *DP hangus* dan bahan tak tergantikan akan dicatat sebagai *production_waste*.
- **Retur Barang / Komplain Selesai**: Pengembalian uang 100% diizinkan bila retur cacat produk terjadi maksimal 1x24 jam sejak diterima. Bahan cetakan tidak dikembalikan sebagai sisa stok, melainkan diteruskan ke laporan `production_waste`.
- **Material Habis di Tengah Proses**: Apabila ada interupsi di tengah proses transaksi, seluruh mutasi logistik harus dibatalkan seketika dengan `rollback()`.
- **Produk Tanpa BOM**: Sistem tidak boleh mengeluarkan *exception* bila sebuah produk jasa/ATK tidak ditemukan ID-nya di dalam tabel `bom`. Kasus ini berlanjut pada prosedur Penanganan Non-Percetakan (Bagian 7).

---

## 9. Skema Harga Bertingkat dan Dampaknya ke HPP

Sesuai BR-08, AbuCom mengaplikasikan aturan penetapan harga berjenjang (Retail, Grosir, Mitra). Meskipun `unit_price` turun (diskon kuantitas), modal awal perhitungan HPP bersifat statis dari harga bahan `cost_per_unit`.
- **Margin Check Alert**: Sistem wajib mengeluarkan laporan visibilitas pencegahan saat `unit_price < item_hpp`. Jika kasir memberi diskon hingga melewati ambang batas modal barang, *prompt* akan menolak penerusan proses ke *Commit*.
- **Profitabilitas Variabel**: Metrik perhitungan di laporan laba rugi akan menunjukkan varian margin berbeda bagi pelanggan Retail dan Mitra meskipun barang yang disajikan memiliki wujud dan `item_hpp` yang sama persis.

---

## 10. Strategi Restock Harga dan Average Cost

Sistem mengakomodasi pergerakan dinamis harga material suplai. Pembaruan harga gudang memakai aturan *Average Cost (Rata-Rata Tertimbang)*:

- **Kalkulasi Restock Otomatis**: Setiap kali fitur manajemen stok menambah kuantitas material baru (`qty_baru`) pada tabel `materials` yang dibeli dengan harga nominal modal baru (`harga_beli_baru`), sistem **wajib** mengubah nilai atribut dasar `cost_per_unit`.
- **Formula Restock (Trigger/Fungsional)**:
  `Cost_Baru = ((Stok_Lama × Cost_Lama) + (Qty_Baru × Harga_Beli_Baru)) / (Stok_Lama + Qty_Baru)`
- Fungsi *backend* wajib menjalankan prosedur `UPDATE materials SET stock_quantity = stock_quantity + ?, cost_per_unit = ? WHERE id = ?`.

---

## 11. Integrasi Waste Management

Sistem menyertakan fitur akomodasi kerugian bahan produksi (kesalahan desain, salah potong, dll):
- **Alur Kerja**: Kasir/Karyawan menginput kerusakan melalui menu terpisah, lalu mendaftarkan referensi *Material ID*, *Kuantitas*, dan *Alasan* (seperti "Tinta meluber", "Kertas macet").
- **Tindakan Otomatis**: Sistem langsung mendepresiasi *state* jumlah `stock_quantity` di tabel `materials`. Catatan ditambahkan pada tabel pelaporan `production_waste`.
- **Konsekuensi Akuntansi**: Pembuangan material tidak diakumulasikan sebagai nilai `total_hpp` di modul transaksi penjualan. Limbah menjadi akun pengurang laba kotor sebagai pos biaya "Rugi Barang Cacat" saat pencetakan rekap Laba Rugi akhir bulan.

---

## 12. Integrasi HPP ke Pelaporan Laba Rugi

Pembuatan laporan pelacakan performa bisnis dieksekusi secara periodik (harian, bulanan) dengan rujukan data yang difilter dan digabungkan secara fungsional.
- **Kalkulasi Laba Kotor Berjalan**:
  `Laba_Kotor = Total_Penjualan (dari total_amount) - Total_HPP (dari total_hpp) - Total_Nilai_Waste`
- Metrik Profitabilitas: Memungkinkan analitik evaluasi laba per unit (`Margin_Per_Produk = (unit_price - item_hpp) / unit_price`) untuk menemukan produk percetakan yang efisien atau merugi secara laten.

---

## 13. Strategi Cross-Usage Stok Retail/ATK ke Produksi

Beberapa inventaris ritel dalam tabel `products_services` (misalnya: kertas HVS, amplop) dapat ditarik fungsinya menjadi benda persediaan baku.
- **Aturan Prioritas**: Bila ada irisan fungsi, sistem wajib melakukan referensi pemotongan pertama ke dalam tabel inventaris baku (`materials`).
- **Sinkronisasi Internal Transfer**: Bila cadangan logistik internal habis, sistem memfasilitasi "Internal Transfer". Prosedur ini menarik kuota dari `stock_quantity` di tabel `products_services`, menambahkannya otomatis ke tabel `materials`, sambil mencatat bukti riwayat *Internal Stock Movement* dalam tabel pencatatan `audit_trail`.

---

## 14. Alur Kelola BOM (CLI Interface)

Pemilik atau Karyawan berotorisasi memiliki modul mandiri Kelola BOM.
- **Tambah/Ubah Bahan**: Modul meminta ID Produk Utama, ID Material Baku, dan `required_qty` presisi desimal. Sistem menyimpan data ke tabel `bom`.
- **Hapus Bahan**: Menghapus ikatan relasi tunggal baris tertentu pada tabel BOM.

---

## 15. Tabel Mapping Entitas BOM-HPP

Tabel berikut menunjukkan peran ekosistem entitas yang tergabung dalam kalkulasi desain operasional BOM dan HPP.

| Entitas Target | Peran dalam Ekosistem BOM-HPP |
| :--- | :--- |
| `materials` | Sumber data primer ketersediaan stok fisik riil bahan baku dan acuan dasar perhitungan modal berjalan rata-rata (`cost_per_unit`). |
| `bom` | Jembatan relasi resep takaran kebutuhan pasti (komposisi baku presisi `required_qty`) bagi tiap pembuatan produk. |
| `products_services` | Master data katalog katalog layanan dan produk yang menunjuk pada resep rujukan dasar di BOM. |
| `transaction_items` | Lapisan persistensi riwayat barisan transaksi historis (`item_hpp`) yang diamankan guna perlindungan dari potensi distorsi pembukuan bila kelak `cost_per_unit` barang berubah. |
| `production_waste` | Perekam beban nilai pengurang kerugian produk (biaya non-HPP, langsung mengurangi margin performa akhir laci). |
| `audit_trail` | Modul mutlak peninjau jejak aktivitas penyesuaian/restock material, konversi internal transfer, serta perubahan mutasi. |

---

## 16. Referensi Dokumen

- `docs/sdlc/narasi.txt`
- `docs/sdlc/02_analysis/01_business_requirements.md`
- `docs/sdlc/02_analysis/02_software_requirements.md`
- `docs/sdlc/02_analysis/05_data_dictionary.md`
- `docs/sdlc/03_design/01_database_schema.sql`
- `docs/sdlc/03_design/02_erd_database.puml`
- `docs/sdlc/03_design/03_system_architecture.md`
