# BOM & HPP Design — Sistem Manajemen Usaha Percetakan AbuCom

## Metadata Dokumen

| Atribut | Detail |
| :--- | :--- |
| **Versi** | 1.0.0 |
| **Status** | [draft] |
| **Tanggal** | 2026-05-16 |
| **Disusun Oleh** | Senior Manufacturing Engineer & Senior Cost Accounting Architect (AI) |

---

## 1. Pendahuluan & Tujuan

Dokumen ini mendefinisikan rancangan teknis untuk sistem *Bill of Materials* (BOM) dan mekanisme kalkulasi *Harga Pokok Penjualan* (HPP) pada aplikasi AbuCom. Tujuan utamanya adalah memastikan setiap transaksi produk percetakan memiliki nilai modal yang akurat, otomatis, dan presisi tinggi, serta terintegrasi secara *real-time* dengan manajemen stok dan pelaporan laba rugi.

Ruang lingkup dokumen ini mencakup:
- Struktur data BOM dan relasi antar entitas.
- Katalog komposisi bahan baku untuk produk unggulan.
- Strategi konversi satuan ukur (Unit of Measure) lintas dimensi dan volume.
- Algoritma perhitungan HPP menggunakan metode *Average Cost*.
- Alur integrasi dengan modul Transaksi, Gudang, dan *Waste Management*.

---

## 2. Definisi Struktur BOM

Sistem AbuCom menggunakan konsep BOM satu level di mana satu produk akhir dapat terdiri dari banyak komponen bahan baku.

### 2.1. Konsep Relasi
Relasi antar tabel dalam basis data didefinisikan sebagai berikut:
- **`products_services` (1) ← (N) `bom`**: Satu produk (tipe 'Percetakan') memiliki satu atau lebih baris komposisi bahan.
- **`bom` (N) → (1) `materials`**: Setiap baris BOM merujuk ke satu material spesifik di gudang.

### 2.2. Penjelasan Kolom Kunci
- **`bom.required_qty`**: Menyimpan jumlah kebutuhan bahan per satu satuan produk (misal: 1 pcs stempel membutuhkan 2.5 ml tinta). Data disimpan dalam `DECIMAL(15,4)` untuk presisi tinggi.
- **`materials.cost_per_unit`**: Harga modal rata-rata per satuan ukur material yang digunakan sebagai basis pengali HPP.

---

## 3. Katalog Contoh BOM Produk Percetakan

Berikut adalah daftar contoh komposisi bahan baku untuk minimal 6 produk percetakan AbuCom:

| Nama Produk | Bahan Penyusun (Material) | Satuan (UoM) | Kebutuhan (Req Qty) | Harga Modal / Satuan (Cost/Unit) |
| :--- | :--- | :--- | :--- | :--- |
| **Stempel Flash** | Gagang Stempel | pcs | 1.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Karet Flash | cm² | 15.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Tinta Stempel | ml | 2.5000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Kertas Buffalo (Ganjal) | cm² | 10.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| **Cetak Foto (4R)** | Kertas Foto Glossy | cm² | 152.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Tinta Printer (CMYK) | ml | 1.2000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Plastik Foto | pcs | 1.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| **Buku Yasin** | Isi Buku Yasin (Blangko) | pcs | 1.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Cover Yasin (Hardcover) | pcs | 1.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Lem Panas | gram | 5.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Pita Pembatas | cm | 20.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| **Undangan Pernikahan** | Kertas BC / Tik | lembar | 1.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Tinta Printer | ml | 0.8000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Plastik OPP | pcs | 1.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Label Nama (103) | pcs | 0.0833 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| **Cetak Baliho** | Bahan Flexi 280gr | m² | 1.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Tinta Solvent | ml | 15.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Mata Ayam (Mata Ikan) | pcs | 4.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| **Cetak Stiker A3+** | Kertas Stiker Bontax | lembar | 1.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Tinta Laser / Toner | ml | 0.5000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| **Nama Dada (Name Tag)** | Akrilik / PVC | cm² | 16.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Resin (A+B) | ml | 5.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |
| | Peniti / Magnet | pcs | 1.0000 | `[PERLU DIISI MANUAL: harga beli aktual dari supplier]` |

---

## 4. Strategi Konversi Satuan Ukur (UoM)

Sistem menangani konversi antar kategori satuan secara matematis untuk memastikan pengurangan stok yang akurat.

| Kategori | Satuan Utama | Satuan Dasar | Rasio Konversi |
| :--- | :--- | :--- | :--- |
| **Diskrit** | pcs, unit, buah | pcs | 1 : 1 |
| **Lembaran** | rim | lembar | 1 rim = 500 lembar |
| **Dimensi (Luas)** | m² | cm² | 1 m² = 10,000 cm² |
| **Volume** | liter | ml | 1 liter = 1,000 ml |
| **Berat** | kg | gram | 1 kg = 1,000 gram |

### Mekanisme Kalkulasi Luas:
Untuk produk berbasis dimensi (seperti baliho atau stiker kustom):
`Luas_Terpakai (cm²) = Panjang (cm) × Lebar (cm) × Jumlah_Pesanan`

---

## 5. Formula Kalkulasi HPP

### 5.1. Formula Matematis
1. **HPP per Unit (Produk Percetakan):**
   $$HPP_{unit} = \sum_{i=1}^{n} (Required\_Qty_{i} \times Cost\_Per\_Unit_{i})$$
   *di mana $i$ adalah bahan baku penyusun dalam BOM.*

2. **Total HPP Transaksi Baris:**
   $$Item\_HPP = HPP_{unit} \times Quantity_{pesanan}$$

3. **Total HPP Transaksi Keseluruhan:**
   $$Total\_HPP = \sum Item\_HPP$$

### 5.2. Contoh Perhitungan Nyata

#### Contoh 1: Stempel Flash (1 Unit)
- Gagang Stempel: 1 pcs × Rp 5.000 = Rp 5.000
- Karet Flash: 15 cm² × Rp 100 = Rp 1.500
- Tinta Stempel: 2.5 ml × Rp 400 = Rp 1.000
- Kertas Buffalo: 10 cm² × Rp 20 = Rp 200
- **Total HPP per Unit = Rp 7.700**

#### Contoh 2: Cetak Baliho (Ukuran 2m x 3m, 1 pcs)
- Luas = 200 cm × 300 cm = 60,000 cm² (atau 6 m²)
- Bahan Flexi: 6 m² × Rp 15.000 = Rp 90.000
- Tinta Solvent: 6 m² × 15 ml × Rp 100 = Rp 9.000
- Mata Ayam: 4 pcs × Rp 500 = Rp 2.000
- **Total HPP Item = Rp 101.000**

---

## 6. Alur Integrasi BOM-HPP ke Transaksi Kasir

1. **Input**: Kasir memilih produk, memasukkan kuantitas (atau dimensi PxL), dan memilih pelanggan.
2. **Lookup BOM**: Sistem mengambil daftar bahan dari tabel `bom` berdasarkan `product_id`.
3. **Validasi Stok**:
   - Hitung `Kebutuhan_Total = Required_Qty × Qty_Pesanan`.
   - Cek `materials.stock_quantity >= Kebutuhan_Total`.
   - Jika satu saja bahan tidak cukup, tampilkan error "Stok [Material] tidak mencukupi" dan hentikan proses.
4. **Kalkulasi & Execution**:
   - Hitung HPP per unit dan total.
   - Kurangi `materials.stock_quantity`.
   - Catat mutasi di `audit_trail`.
   - Masukkan data ke `transaction_items` (termasuk kolom `item_hpp`).
5. **Commit**: Simpan seluruh transaksi secara atomik (ACID).

---

## 7. Strategi Cross-Usage Stok Retail/ATK ke Produksi

Beberapa item (seperti Kertas HVS) tersedia di tabel `products_services` (untuk dijual retail) dan tabel `materials` (sebagai bahan baku).
- **Aturan Prioritas**: Sistem akan selalu memotong stok dari tabel `materials` terlebih dahulu.
- **Sinkronisasi**: Jika stok di `materials` habis, sistem dapat melakukan "Internal Transfer" dari stok retail (`products_services`) ke `materials` secara otomatis sebelum transaksi dilanjutkan, dengan mencatat log transfer stok.

---

## 8. Integrasi Waste Management

Setiap bahan yang rusak (salah cetak/cacat) harus dicatat melalui modul `production_waste`:
- **Input**: `material_id`, `waste_quantity`, `waste_reason`.
- **Dampak**: Stok `materials.stock_quantity` berkurang secara otomatis.
- **Akuntansi**: Nilai kerugian limbah akan diakumulasikan dalam laporan laba rugi sebagai pengurang laba kotor di luar HPP transaksi normal.

---

## 9. Integrasi HPP ke Pelaporan Laba Rugi

Laporan laba rugi dihitung dengan rumus:
`Laba_Kotor = Total_Penjualan - Total_HPP - Total_Nilai_Waste`
- Data HPP diambil dari kolom `transactions.total_hpp`.
- Memungkinkan analisis profitabilitas: `Margin_Per_Produk = (Harga_Jual - HPP_Unit) / Harga_Jual`.

---

## 10. Skenario Edge Case dan Validasi

- **Produk Tanpa BOM**: Produk tipe ATK, PPOB, atau Jasa Teknis. HPP diambil langsung dari `cost_per_unit` di tabel `products_services` atau dianggap 0 untuk jasa murni.
- **Material Habis di Tengah Proses**: Transaksi di-rollback total untuk menjaga integritas data.
- **Pembatalan Transaksi**: Stok material yang sudah dipotong wajib dikembalikan (*restock*) secara otomatis saat status transaksi berubah menjadi 'Dibatalkan'.
- **Retur Barang**: Jika retur dilakukan, stok material tidak dikembalikan secara otomatis (karena barang sudah menjadi produk jadi/rusak), namun harus dicatat sebagai *waste* jika tidak bisa dijual kembali.

---

## 11. Skema Harga Bertingkat dan HPP

Sesuai BR-08, harga jual (Retail, Grosir, Mitra) bersifat dinamis, namun HPP bersifat statis (berdasarkan modal).
- **Margin Check**: Sistem memberikan peringatan jika `unit_price` (setelah diskon tier) < `HPP_per_unit`.
- **Profitabilitas**: Laporan keuangan akan menunjukkan margin yang berbeda untuk setiap tier pelanggan meski HPP-nya sama.

---

## 12. Strategi Versioning Harga (Average Cost)

Untuk menangani perubahan harga beli material dari supplier:
- Sistem menggunakan metode **Average Cost (Rata-Rata Tertimbang)**.
- Saat restock: `Cost_Baru = ((Stok_Lama × Cost_Lama) + (Qty_Baru × Harga_Beli_Baru)) / (Stok_Lama + Qty_Baru)`.
- Nilai `cost_per_unit` diperbarui otomatis di tabel `materials`.

---

## 13. Tabel Mapping Entitas BOM-HPP

| Entitas | Peran dalam Ekosistem BOM-HPP |
| :--- | :--- |
| `materials` | Sumber data stok bahan baku dan harga modal (`cost_per_unit`). |
| `bom` | Jembatan resep komposisi bahan untuk setiap produk. |
| `products_services` | Master data produk yang merujuk ke resep BOM. |
| `transaction_items` | Menyimpan `item_hpp` historis saat transaksi terjadi. |
| `production_waste` | Mencatat pengurangan stok akibat kerusakan (biaya non-HPP). |
| `audit_trail` | Rekam jejak mutasi stok dan perubahan harga modal. |

---

## 14. Referensi Dokumen

- `docs/sdlc/03_design/01_database_schema.sql`
- `docs/sdlc/02_analysis/05_data_dictionary.md`
- `docs/sdlc/02_analysis/01_business_requirements.md`
- `docs/sdlc/02_analysis/02_software_requirements.md`
- `docs/sdlc/03_design/03_system_architecture.md`
- `docs/sdlc/narasi.txt`
