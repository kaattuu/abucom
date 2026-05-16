# Issue #0031: Pembuatan Dokumen BOM & HPP Design

## Deskripsi Tugas

Menyusun dokumen utama `05_bom_hpp_design.md` di folder `docs/sdlc/03_design/`. File ini berstatus `[create_file]`. Dokumen ini adalah dokumen rancangan teknis yang mendefinisikan secara lengkap arsitektur Bill of Materials (BOM) dan mekanisme kalkulasi Harga Pokok Penjualan (HPP) untuk seluruh produk dan layanan percetakan AbuCom — mencakup struktur komposisi bahan baku, formula perhitungan HPP presisi tinggi berbasis desimal, strategi pemotongan stok multi-satuan (dimensi, volume, lembar), integrasi cross-usage stok retail/ATK ke produksi, serta alur integrasi BOM-HPP ke modul transaksi kasir.

---

## Persona Implementasi

Bertindaklah sebagai **Senior Manufacturing Engineer** dan **Senior Cost Accounting Architect** yang memiliki keahlian mendalam dalam:

- Perancangan struktur Bill of Materials (BOM) multi-level untuk industri manufaktur dan percetakan.
- Kalkulasi Harga Pokok Penjualan (HPP / COGS) berbasis komposisi bahan baku presisi tinggi.
- Strategi konversi satuan ukur (Unit of Measure) lintas dimensi: luas (cm², m²), volume (ml, liter), berat (gram, kg), dan unit diskrit (pcs, lembar, rim).
- Pemodelan data BOM dalam basis data relasional (tabel `bom`, `materials`, `products_services`).
- Integrasi alur HPP ke dalam siklus transaksi kasir dan pelaporan laba rugi.
- Penerapan prinsip akuntansi biaya (Cost Accounting) untuk UMKM percetakan.

---

## File Referensi Utama

1. `docs/sdlc/03_design/01_database_schema.sql` — **REFERENSI UTAMA #1**: Berisi struktur DDL lengkap. Rangkum spesifik:
   - Tabel `bom`: Kolom `product_id` (FK ke `products_services`), `material_id` (FK ke `materials`), `required_qty` DECIMAL(15,4) — jumlah bahan per 1 satuan cetak produk.
   - Tabel `materials`: Kolom `material_name`, `stock_quantity` DECIMAL(15,4), `unit_of_measure` VARCHAR(20) (rim, cm2, ml, dll), `cost_per_unit` DECIMAL(15,4), `min_stock_alert` DECIMAL(15,4), `vendor_id` FK ke `vendors`.
   - Tabel `products_services`: Kolom `service_type` ENUM('Percetakan','ATK','PPOB','Jasa Keuangan','Jasa Teknis'), `base_price` DECIMAL(15,4), `stock_quantity` DECIMAL(15,4), `unit_of_measure` VARCHAR(20).
   - Tabel `transaction_items`: Kolom `item_hpp` DECIMAL(15,4) — HPP per baris keranjang.
   - Tabel `transactions`: Kolom `total_hpp` DECIMAL(15,4) — total HPP transaksi.
   - Tabel `production_waste`: Kolom `waste_quantity` DECIMAL(15,4) — bahan rusak/terbuang.
   - Tabel `stock_opname`: Kolom `system_qty`, `actual_qty`, `difference_qty` — rekonsiliasi stok.

2. `docs/sdlc/02_analysis/05_data_dictionary.md` — **REFERENSI UTAMA #2**: Berisi definisi detail setiap entitas. Rangkum spesifik:
   - Entitas `bom` (Bagian 4.3 #22): Menyimpan resep komposisi material. HPP = SUM(required_qty × cost_per_unit).
   - Entitas `materials` (Bagian 4.1 #8): Inventaris bahan baku, satuan ukur presisi tinggi.
   - Entitas `products_services` (Bagian 4.1 #7): Semua produk/jasa dengan harga dasar.
   - Entitas `transaction_items` (Bagian 4.2 #12): Detail keranjang dengan HPP per item.
   - Entitas `production_waste` (Bagian 4.2 #15): Pencatatan limbah bahan baku.
   - Relasi: `bom.product_id` → `products_services.id`, `bom.material_id` → `materials.id`.

3. `docs/sdlc/02_analysis/01_business_requirements.md` — **REFERENSI UTAMA #3**: Berisi aturan bisnis. Rangkum spesifik:
   - BR-06: Bahan rusak harus direkam sebagai limbah (waste), bukan dihapus. Neraca stok material harus seimbang.
   - BR-07: Pembayaran DP minimal 50% dari total tagihan.
   - BR-08: Harga grosir berlaku untuk pembelian minimal 50 pcs. Harga mitra berlaku untuk agen aktif ≥ 3 bulan.
   - Bagian 3 poin 3: HPP otomatis berdasarkan BOM. Pengurangan stok mendukung UoM berbasis dimensi, volume, dan jumlah lembar dengan desimal presisi. Cross-usage stok retail untuk produksi.
   - Bagian 6 poin 2: Kriteria penerimaan — HPP valid di tingkat desimal saat memperhitungkan bahan baku dengan satuan luas (dimensi) maupun volume cairan (tinta).

4. `docs/sdlc/02_analysis/02_software_requirements.md` — **REFERENSI UTAMA #4**: Berisi spesifikasi teknis modul. Rangkum spesifik:
   - F-03: Modul Gudang dan HPP berbasis BOM — input ID produk BOM, besaran pemakaian. Fungsi reduksi menerima data BOM dan melakukan mapping pemotongan bahan penyusun menggunakan desimal presisi tinggi. Mendukung cross-usage stok retail/ATK. HPP dikalkulasi langsung dan dikembalikan ke fungsi pemanggil. Output: nilai HPP final dan sisa stok setelah reduksi.
   - F-02: Modul Transaksi — kalkulasi BOM & HPP untuk pesanan percetakan, potong stok, catat item_hpp.

5. `docs/sdlc/03_design/03_system_architecture.md` — **REFERENSI UTAMA #5**: Berisi arsitektur sistem. Rangkum spesifik:
   - Bagian 7.2 Alur Transaksi Kasir: Langkah 3 — Service Layer mengambil data BOM, fungsi reduksi menghitung kebutuhan pemotongan stok berdasarkan persentase desimal, menghasilkan nilai HPP.
   - Bagian 12 Pemetaan Modul: Modul (7) HPP & BOM → tabel utama `bom`, `materials`, tabel pendukung `products_services`, `transaction_items`.
   - Pola FP: pure functions, immutable data, state passing.
   - Layered Architecture: inventory_service.py menangani Gudang Stok, BOM, HPP Produksi, Waste Management.

6. `docs/sdlc/narasi.txt` — **REFERENSI PENDUKUNG**: Berisi konteks bisnis pemilik. Rangkum spesifik:
   - Baris 95: Sistem HPP dan BOM — aplikasi harus menghitung HPP otomatis berdasarkan komposisi BOM. Satu stempel terdiri dari gagang, tinta, kertas buffalo, dan karet flash. Bahan lembaran/cairan harus dihitung berdasarkan satuan dimensi (panjang × lebar) atau volume. Stok retail (ATK) bisa diambil untuk kebutuhan produksi.
   - Baris 96: Manajemen Satuan — berbagai jenis UoM (kertas dalam rim/lembar/dimensi, tinta dalam volume/warna/berat). Stok fleksibel dan mendukung angka desimal.
   - Baris 87: Waste management — catat bahan rusak/salah cetak agar selisih stok akurat.

---

## Instruksi Kelayakan & Kriteria Dokumen Utama

1. **Struktur Dokumen Markdown**: Dokumen harus menggunakan format Markdown (.md) yang rapi, dengan heading hierarkis (H1 untuk judul, H2 untuk bagian utama, H3 untuk sub-bagian), tabel, dan daftar bernomor/bullet.

2. **Metadata Dokumen**: Sertakan tabel metadata di awal: Versi (1.0.0), Status ([create_file]), Tanggal, Persona penyusun.

3. **Cakupan Isi Dokumen yang Wajib Ada**:

   **a. Pendahuluan & Tujuan**: Jelaskan tujuan dokumen BOM & HPP Design, ruang lingkup, dan hubungannya dengan modul lain (transaksi kasir, gudang, waste management, pelaporan laba rugi).

   **b. Definisi Struktur BOM**: Definisikan struktur BOM secara detail:
   - Konsep BOM: satu produk (products_services) memiliki banyak baris komposisi bahan (bom), setiap baris merujuk ke satu material (materials).
   - Relasi tabel: `products_services` ← (1:N) → `bom` ← (N:1) → `materials`.
   - Penjelasan kolom `required_qty`: jumlah bahan yang dibutuhkan per 1 satuan produk/jasa.

   **c. Katalog Contoh BOM Produk Percetakan AbuCom**: Buat tabel contoh BOM untuk MINIMAL 6 produk percetakan nyata berdasarkan narasi (Stempel Flash, Cetak Foto, Buku Yasin, Undangan Pernikahan, Cetak Baliho, Cetak Stiker, Nama Dada). Setiap produk harus memiliki daftar bahan penyusun lengkap dengan:
   - Nama bahan (material_name)
   - Satuan ukur (unit_of_measure)
   - Jumlah kebutuhan per 1 unit produk (required_qty)
   - Harga modal per satuan (cost_per_unit) — **tandai `[PERLU DIISI MANUAL: harga beli aktual dari supplier]`** jika data tidak tersedia di file referensi.

   **d. Strategi Konversi Satuan Ukur (UoM)**: Jelaskan secara detail bagaimana sistem menangani berbagai satuan ukur:
   - Satuan diskrit: pcs, unit, buah
   - Satuan lembaran: lembar, rim (1 rim = 500 lembar)
   - Satuan dimensi/luas: cm², m² (panjang × lebar). Contoh: kertas A4 = 21.0 × 29.7 = 623.7 cm². Jika stok kertas disimpan dalam cm², maka pemotongan stok = luas per lembar × jumlah lembar.
   - Satuan volume: ml, liter. Contoh: tinta per cetak foto = 2.5 ml.
   - Satuan berat: gram, kg.
   - Sertakan tabel konversi referensi untuk setiap kategori satuan yang digunakan.

   **e. Formula Kalkulasi HPP**: Definisikan formula HPP secara matematis dan berikan contoh perhitungan nyata:
   - Formula dasar: `HPP_per_unit = SUM(required_qty[i] × cost_per_unit[i])` untuk semua bahan i dalam BOM produk.
   - Formula total: `HPP_total = HPP_per_unit × quantity_pesanan`.
   - `item_hpp` pada `transaction_items` = HPP_total per baris keranjang.
   - `total_hpp` pada `transactions` = SUM(item_hpp) semua baris keranjang.
   - Sertakan MINIMAL 2 contoh perhitungan lengkap step-by-step dengan angka nyata.

   **f. Alur Integrasi BOM-HPP ke Transaksi Kasir**: Jelaskan alur step-by-step bagaimana BOM dan HPP terintegrasi ke dalam proses transaksi:
   - Kasir input ID produk percetakan dan qty.
   - Sistem lookup BOM berdasarkan product_id.
   - Sistem iterasi setiap baris BOM: hitung kebutuhan bahan = required_qty × qty pesanan.
   - Sistem validasi ketersediaan stok setiap material (stock_quantity >= kebutuhan).
   - Jika stok cukup: hitung HPP, potong stok material, catat item_hpp.
   - Jika stok tidak cukup: tampilkan peringatan, batalkan transaksi (rollback).
   - Catat total_hpp pada tabel transactions.

   **g. Strategi Cross-Usage Stok Retail/ATK ke Produksi**: Jelaskan mekanisme ketika bahan baku produksi diambil dari stok retail ATK:
   - Contoh: Kertas HVS A4 dijual retail dan juga dipakai untuk produksi fotocopy/print.
   - Bagaimana sistem mengurangi stok di `products_services.stock_quantity` (retail) ATAU `materials.stock_quantity` (bahan baku) — atau keduanya jika item yang sama terdaftar di kedua tabel.
   - Aturan prioritas pengambilan stok.

   **h. Integrasi Waste Management dengan BOM**: Jelaskan bagaimana pencatatan limbah (production_waste) mempengaruhi neraca stok:
   - Bahan rusak dicatat ke `production_waste` dengan `waste_quantity` dan `waste_reason`.
   - Stok `materials.stock_quantity` dikurangi sesuai waste_quantity.
   - Dampak pada akurasi HPP dan stock opname.

   **i. Integrasi HPP ke Pelaporan Laba Rugi**: Jelaskan bagaimana data HPP digunakan dalam laporan keuangan:
   - Laba kotor = total_amount - total_hpp.
   - Analisis profitabilitas per produk/layanan.
   - Margin keuntungan per kategori service_type.

   **j. Skenario Edge Case dan Validasi**: Dokumentasikan skenario khusus:
   - Produk tanpa BOM (ATK retail, PPOB, Jasa Keuangan, Jasa Teknis) — HPP = 0 atau HPP = cost_per_unit langsung dari products_services.
   - Material habis di tengah transaksi multi-item.
   - Perubahan cost_per_unit material setelah restock dari supplier baru.
   - Pembatalan transaksi: stok material harus dikembalikan (rollback).
   - Retur barang: dampak pada stok material dan HPP yang sudah tercatat.

   **k. Skema Harga Bertingkat dan HPP**: Jelaskan hubungan antara pricing_tiers (Retail, Grosir, Mitra) dengan HPP:
   - HPP tidak berubah meskipun harga jual berubah.
   - Margin = unit_price (dari tier) - HPP_per_unit.
   - Peringatan jika margin negatif (harga jual < HPP).

4. **Bahasa Indonesia**: Seluruh isi dokumen menggunakan Bahasa Indonesia yang natural, tidak ambigu, dan mudah dipahami.

5. **Tandai Data Kosong**: Jika ada data yang tidak tersedia di file referensi (terutama harga beli aktual bahan baku dari supplier), tandai dengan `[PERLU DIISI MANUAL: deskripsi]`.

6. **Referensi di Akhir**: Cantumkan daftar file referensi di bagian paling akhir dokumen.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)

### Langkah 1: Baca Semua Referensi Wajib Sampai Tuntas

- Baca keseluruhan isi `docs/sdlc/03_design/01_database_schema.sql` — catat struktur tabel `bom` (baris 368-376), `materials` (baris 140-152), `products_services` (baris 123-134), `transaction_items` (baris 208-219), `transactions` (baris 189-202), `production_waste` (baris 253-263), dan `stock_opname` (baris 351-362). Perhatikan semua kolom DECIMAL(15,4) dan relasi FK.
- Baca keseluruhan isi `docs/sdlc/02_analysis/05_data_dictionary.md` — catat definisi entitas `bom` (Bagian 4.3 #22), `materials` (#8), `products_services` (#7), `transaction_items` (#12), `production_waste` (#15). Catat catatan implementasi HPP di entitas `bom`.
- Baca keseluruhan isi `docs/sdlc/02_analysis/01_business_requirements.md` — catat BR-06 (limbah), BR-07 (DP 50%), BR-08 (harga grosir/mitra), dan Bagian 3 poin 3 (HPP BOM cross-usage).
- Baca keseluruhan isi `docs/sdlc/02_analysis/02_software_requirements.md` — catat F-03 (Gudang dan HPP) dan F-02 (integrasi HPP ke transaksi kasir).
- Baca keseluruhan isi `docs/sdlc/03_design/03_system_architecture.md` — catat Bagian 7.2 (alur transaksi kasir langkah 3: BOM & HPP), Bagian 12 (pemetaan modul HPP & BOM).
- Baca baris 87, 95, 96 dari `docs/sdlc/narasi.txt` — catat contoh komposisi stempel (gagang, tinta, kertas buffalo, karet flash), strategi satuan dimensi/volume, dan waste management.
- **JANGAN** mulai menulis dokumen sebelum semua file referensi selesai dibaca dan dipahami.

### Langkah 2: Tulis Metadata dan Pendahuluan

- Buka file `docs/sdlc/03_design/05_bom_hpp_design.md`.
- Hapus konten placeholder yang ada.
- Tulis tabel metadata: Judul "BOM & HPP Design — Sistem Manajemen Usaha Percetakan AbuCom", Versi 1.0.0, Status [create_file], Tanggal (hari ini), Disusun Oleh (Senior Manufacturing Engineer & Senior Cost Accounting Architect (AI)).
- Tulis bagian Pendahuluan yang menjelaskan tujuan dokumen, ruang lingkup, dan hubungannya dengan modul transaksi, gudang, waste management, dan pelaporan.

### Langkah 3: Tulis Definisi Struktur BOM

- Jelaskan konsep BOM: relasi 1 produk → N bahan via tabel `bom`.
- Gambarkan relasi tabel: `products_services` ← `bom` → `materials`.
- Jelaskan setiap kolom `bom`: `product_id`, `material_id`, `required_qty`.
- Jelaskan bahwa `required_qty` = jumlah bahan per 1 satuan produk.

### Langkah 4: Tulis Katalog Contoh BOM

- Buat tabel BOM untuk minimal 6 produk percetakan berdasarkan narasi.txt baris 6: Stempel Flash, Cetak Foto, Buku Yasin, Undangan Pernikahan, Cetak Baliho, Cetak Stiker, Nama Dada.
- Untuk setiap produk, daftarkan semua bahan penyusun beserta satuan ukur dan required_qty.
- Harga modal (cost_per_unit) yang tidak diketahui ditandai `[PERLU DIISI MANUAL: harga beli aktual dari supplier]`.
- Pastikan contoh mencakup variasi satuan: pcs (gagang stempel), cm2 (kertas), ml (tinta), lembar (kertas foto).

### Langkah 5: Tulis Strategi Konversi Satuan Ukur

- Buat tabel konversi referensi untuk setiap kategori satuan.
- Jelaskan mekanisme konversi saat pemotongan stok: contoh kertas A4 dalam cm², tinta dalam ml.
- Jelaskan mengapa DECIMAL(15,4) diperlukan untuk presisi.

### Langkah 6: Tulis Formula Kalkulasi HPP

- Tulis formula matematis HPP_per_unit dan HPP_total.
- Buat minimal 2 contoh perhitungan step-by-step lengkap dengan angka.
- Contoh 1: Stempel Flash (multi-material: gagang + tinta + kertas buffalo + karet flash).
- Contoh 2: Cetak Foto (material dimensi/volume: kertas foto cm² + tinta ml).
- Tunjukkan bagaimana item_hpp dan total_hpp dihitung.

### Langkah 7: Tulis Alur Integrasi BOM-HPP ke Transaksi

- Tulis alur step-by-step dari input kasir hingga commit database.
- Sertakan validasi stok, rollback jika stok kurang.
- Jelaskan pola FP: pure functions, state passing, ACID transaction.

### Langkah 8: Tulis Cross-Usage, Waste, dan Pelaporan

- Jelaskan mekanisme cross-usage stok retail/ATK ke produksi.
- Jelaskan integrasi waste management dengan neraca stok.
- Jelaskan penggunaan HPP dalam laporan laba rugi dan analisis profitabilitas.

### Langkah 9: Tulis Edge Cases dan Skema Harga

- Dokumentasikan semua skenario edge case (produk tanpa BOM, material habis, perubahan harga, pembatalan, retur).
- Jelaskan hubungan pricing_tiers dengan HPP dan margin.

### Langkah 10: Tulis Referensi dan Validasi

- Cantumkan daftar file referensi di bagian akhir dokumen.
- Validasi kelengkapan: pastikan semua bagian (a-k) dari Instruksi Kelayakan sudah tercakup.
- Pastikan tidak ada instruksi kerja atau komentar proses yang tertinggal di dokumen.
- Pastikan bahasa Indonesia natural dan tidak ambigu.
- Pastikan semua data kosong ditandai `[PERLU DIISI MANUAL]`.

### Langkah 11: Update Status di sdlc.txt

- Setelah dokumen selesai ditulis dan divalidasi, buka file `docs/sdlc/sdlc.txt`.
- Cari baris yang berisi `05_bom_hpp_design.md` (baris 26).
- Ubah `status: [create_file]` menjadi `status: [done]`.
- Pastikan HANYA baris 26 yang berubah, tidak ada baris lain yang termodifikasi.

---

## Poin Tambahan Spesifik untuk BOM & HPP Design

1. **Presisi Desimal Wajib**: Seluruh kalkulasi HPP dan pemotongan stok WAJIB menggunakan DECIMAL(15,4). Jangan pernah menggunakan tipe data float/double biasa karena akan menghasilkan pembulatan yang tidak akurat untuk kalkulasi finansial.

2. **BOM Hanya untuk Produk Percetakan**: Produk dengan service_type selain 'Percetakan' (yaitu ATK, PPOB, Jasa Keuangan, Jasa Teknis) TIDAK memiliki BOM. HPP untuk ATK bisa langsung diambil dari harga beli (cost_per_unit) tanpa melalui tabel BOM.

3. **Atomicity Pemotongan Stok**: Seluruh pemotongan stok material dalam satu transaksi HARUS bersifat atomik (semua berhasil atau semua gagal). Jika salah satu material tidak mencukupi, seluruh transaksi harus di-rollback.

4. **Audit Trail pada Mutasi Stok**: Setiap perubahan pada `materials.stock_quantity` (baik karena transaksi, waste, maupun restock) WAJIB dicatat di `audit_trail` dengan detail perubahan sebelum dan sesudah.

5. **Peringatan Stok Minimum**: Setelah pemotongan stok material, sistem harus memeriksa apakah `stock_quantity` sudah di bawah `min_stock_alert`. Jika ya, tampilkan peringatan ke kasir.

6. **Versioning Harga Bahan Baku**: Dokumen harus menjelaskan strategi ketika `cost_per_unit` berubah setelah restock: apakah menggunakan metode FIFO, LIFO, atau Average Cost. Rekomendasikan metode Average Cost (Rata-Rata Tertimbang) untuk kesederhanaan UMKM.

7. **Tabel Ringkasan Mapping Entitas BOM-HPP**: Sertakan tabel yang memetakan setiap entitas database yang terlibat dalam ekosistem BOM-HPP beserta perannya.

---

## Checklist Penerimaan (Definition of Done)

- [ ] File `docs/sdlc/03_design/05_bom_hpp_design.md` berisi dokumen rancangan BOM & HPP lengkap
- [ ] Metadata dokumen lengkap (versi, status, tanggal, persona)
- [ ] Definisi struktur BOM dengan relasi tabel tervisualisasi
- [ ] Katalog contoh BOM untuk minimal 6 produk percetakan AbuCom
- [ ] Strategi konversi satuan ukur (dimensi, volume, lembar, berat, diskrit) terdokumentasi
- [ ] Formula kalkulasi HPP terdefinisi secara matematis
- [ ] Minimal 2 contoh perhitungan HPP step-by-step dengan angka nyata
- [ ] Alur integrasi BOM-HPP ke transaksi kasir terdokumentasi step-by-step
- [ ] Mekanisme cross-usage stok retail/ATK ke produksi terdokumentasi
- [ ] Integrasi waste management dengan neraca stok terdokumentasi
- [ ] Integrasi HPP ke pelaporan laba rugi terdokumentasi
- [ ] Skenario edge case terdokumentasi (tanpa BOM, stok habis, perubahan harga, pembatalan, retur)
- [ ] Hubungan pricing_tiers dengan HPP dan margin terdokumentasi
- [ ] Strategi versioning harga bahan baku (Average Cost) terdokumentasi
- [ ] Tabel mapping entitas BOM-HPP tersedia
- [ ] Bahasa Indonesia natural dan tidak ambigu
- [ ] Data kosong ditandai dengan `[PERLU DIISI MANUAL]`
- [ ] Referensi dokumen tercantum di bagian akhir
- [ ] Dokumen bersih tanpa instruksi kerja atau komentar proses
- [ ] Status di sdlc.txt berubah dari [create_file] ke [done]
