# Business Requirements Document (BRD) — Sistem Manajemen Usaha Percetakan "AbuCom"

## 1. Pendahuluan dan Tujuan Dokumen

**Tujuan Dokumen**
Dokumen ini disusun untuk mendefinisikan kebutuhan bisnis secara menyeluruh untuk proyek pengembangan Sistem Manajemen Usaha Percetakan "AbuCom". Dokumen ini menjabarkan proses operasional bisnis saat ini, kondisi yang diharapkan, serta spesifikasi fungsional dan aturan bisnis (*business rules*) yang harus dipenuhi oleh sistem. Tujuannya adalah untuk memberikan panduan yang jelas dan tidak ambigu bagi fase perancangan sistem dan pengembangan selanjutnya.

**Latar Belakang Bisnis**
Usaha percetakan AbuCom adalah bisnis UMKM yang dikelola secara mandiri oleh pemiliknya. Usaha ini melayani lima lini utama: produksi cetak, penjualan retail (ATK), layanan digital (PPOB), jasa keuangan, dan jasa teknis. Saat ini, seluruh operasional dicatat secara manual menggunakan Microsoft Excel yang datanya tersebar di beberapa file. Hal ini mengakibatkan beban kerja yang berlebihan, pencatatan yang kurang presisi, dan pelaporan yang tidak akurat, sehingga menghambat fokus pemilik pada strategi pengembangan usaha. Oleh karena itu, diperlukan sistem terpadu untuk mengotomatisasi proses operasional tersebut.

---

## 2. Deskripsi Proses Bisnis Saat Ini (As-Is) vs Harapan (To-Be)

| Proses Bisnis | Kondisi Saat Ini (As-Is) | Kondisi yang Diharapkan (To-Be) |
| --- | --- | --- |
| **Pencatatan Pesanan & Produksi** | Pencatatan transaksi, pengurangan bahan baku, dan pengingat stok dilakukan secara manual di Excel. File desain pelanggan tersebar tanpa lokasi pasti. | Pencatatan otomatis terpadu. Sistem memiliki fitur *Job Tracking* (Antri → Desain → Produksi → Selesai → Diambil), mencatat kerusakan (*waste management*), dan mendata lokasi logis arsip file desain pelanggan. |
| **Penjualan ATK (Retail)** | Pengecekan harga, total, kembalian, dan update stok dilakukan secara manual oleh pemilik. | Proses transaksi otomatis. Penyesuaian harga jual dapat dilakukan berdasarkan harga beli terbaru dan stok berkurang otomatis secara presisi. |
| **Layanan PPOB & Jasa Keuangan** | Pencatatan manual saldo multi-akun. Pemilik harus mengecek saldo fisik/digital secara manual setiap saat dan mencatat manual setiap transaksi untuk mutasi. | Sistem melacak saldo masing-masing akun secara digital. Menginformasikan peringatan batas saldo minimum secara otomatis dan mencatat seluruh histori mutasi. |
| **Manajemen SDM & Penggajian** | Data pelamar, kasbon, dan penggajian belum terstruktur secara sistematis. Belum ada sistem penentuan gaji otomatis (tetap vs persentase). | Sistem otomatis untuk pelacakan absensi, penggajian pintar (menentukan skema berdasarkan target pendapatan), pemotongan kasbon otomatis, dan pemberian insentif poin. |
| **Manajemen Stok & HPP** | Tidak ada perhitungan Harga Pokok Penjualan (HPP) otomatis berdasarkan komposisi (*Bill of Materials*). Perhitungan pemakaian bahan baku dengan multi-satuan ukur (dimensi, volume) cukup menyulitkan di Excel. | HPP dihitung secara instan dan otomatis menggunakan BOM. Pengurangan stok mendukung multi-satuan ukur dan desimal yang sangat presisi. |
| **Laporan Keuangan & Laba Rugi** | Rekonsiliasi kas (fisik laci vs pencatatan) dan perhitungan profitabilitas per layanan sangat lambat, tidak terpusat, dan rawan kesalahan manusia. | Laporan keuangan dibuat otomatis dan tersedia secara periodik (harian hingga tahunan). Tersedia alat bantu *stock opname* dan fitur rekonsiliasi kas, serta analisis profitabilitas per layanan. |

---

## 3. Kebutuhan Bisnis Fungsional Utama (High-level Functional Requirements)

Sistem harus memfasilitasi fungsionalitas bisnis utama berikut:

1. **Manajemen Transaksi Multi-Lini Terpadu**
   Sistem harus mampu menangani transaksi lintas layanan (Percetakan, Penjualan Retail, Layanan PPOB, Jasa Keuangan, dan Jasa Teknis) dalam satu alur yang kohesif.
2. **Manajemen Harga & Skema Pembayaran**
   Sistem harus memfasilitasi struktur harga berlapis: Harga Retail, Harga Grosir (berdasarkan kuantitas), dan Harga Spesial Mitra. Sistem juga mengakomodasi pembayaran Uang Muka (DP) dan pelunasan saat barang diambil, serta penanganan pembatalan pesanan (pengembalian DP) dan retur barang.
3. **Manajemen Gudang, Stok Presisi, dan HPP Berbasis BOM**
   Sistem harus mampu menghitung HPP otomatis berdasarkan komposisi *Bill of Materials* (BOM). Pengurangan stok bahan baku mendukung *Unit of Measure* (UoM) berbasis dimensi, volume, dan jumlah lembar dengan perhitungan desimal yang sangat presisi, termasuk penggunaan stok retail untuk kebutuhan produksi (*cross-usage*).
4. **Sistem *Job Tracking* & Manajemen Limbah Produksi**
   Sistem harus menyediakan pelacakan status pesanan percetakan (Antri, Proses Desain, Produksi, Selesai, Diambil) untuk mencegah pesanan terlupakan, serta mencatat file lokasi desain dan log kerusakan bahan produksi (*waste management*).
5. **Manajemen SDM, Insentif Poin, & Penggajian Pintar**
   Sistem mengakomodasi pengelolaan data karyawan, penilaian kinerja, absensi, hingga penggajian. Skema penggajian berjalan pintar (menggunakan skema gaji tetap vs persentase pendapatan), ditambah insentif poin kerja, serta memotong otomatis tagihan pinjaman karyawan (kasbon).
6. **Manajemen Multi-Akun & Jasa Keuangan**
   Sistem memantau dan mencatat saldo pada berbagai akun bank digital/PPOB (Mandiri, Dana, Gopay, OVO, LinkAja, ShopeePay) untuk membantu pemilihan jalur transaksi termurah bagi pelanggan. Tersedia pengingat deposit saldo minimum.
7. **Database Entitas Usaha (CRM & Supplier)**
   Sistem memiliki kemampuan pencatatan kontak pelanggan, riwayat transaksi untuk promosi, serta manajemen vendor pemasok untuk membandingkan harga beli termurah dan mencatat status hutang usaha.
8. **Kesiapan Ekspansi Multi-Cabang**
   Arsitektur fungsional bisnis mewajibkan pelabelan ID cabang pada setiap entitas data (transaksi, aset, hutang, karyawan) agar aplikasi siap untuk dioperasikan dalam mode pusat cabang di masa depan.

---

## 4. Kebutuhan Non-Fungsional dari Sisi Bisnis

1. **Keamanan & Pemisahan Akses Data**
   - Hak Akses dibedakan secara tegas berbasis peran (RBAC): Pemilik memiliki akses penuh (termasuk akses ke data tabungan pengadaan aset dan pinjaman bank), sedangkan Karyawan terbatas hanya pada kebutuhan operasionalnya.
   - Sistem memiliki *Audit Trail* mutlak untuk melacak "siapa, melakukan apa, dan kapan" guna menghindari dan melacak kecurangan internal (*fraud*).
2. **Kinerja & Keakuratan Operasional**
   - Transaksi harus segera disinkronkan ke pelaporan kas dan inventaris guna menunjang fitur rekonsiliasi kas dan *stock opname* yang akurat.
3. **Perlindungan Aset Data & Kelangsungan**
   - Rekam jejak *database* (termasuk riwayat pinjaman keluarga tanpa bunga dan bank) harus terjamin integritasnya tanpa manipulasi di luar alur sistem.

---

## 5. Aturan Bisnis (*Business Rules*)

| ID Aturan | Deskripsi Aturan Bisnis |
| --- | --- |
| **BR-01** | Karyawan diwajibkan bekerja dengan budaya *cross-functional* (saling melengkapi lintas posisi jika salah satu divisi sedang mengalami kepadatan antrian). |
| **BR-02** | Akun PPOB harus dilakukan deposit dana minimal sebesar Rp 500.000 ketika saldo di dalam akun tersebut menyentuh batas Rp 150.000. |
| **BR-03** | Penentuan gaji menggunakan skema pendapatan: Jika batas target pendapatan tercapai `[PERLU DIISI MANUAL: Nominal Target Pendapatan Bersih]`, berlaku gaji bulanan tetap `[PERLU DIISI MANUAL: Nominal Gaji Tetap]`. Jika target tidak tercapai, berlaku skema bagi hasil `[PERLU DIISI MANUAL: Persentase Gaji dari Pendapatan Bersih]`. |
| **BR-04** | Pemberian tambahan insentif berbasis poin: 1 Poin = Rp 500 (Transaksi rutin), 3 Poin = Rp 1.500 (Jasa dasar), 5 Poin = Rp 2.500 (Produk kustom), dan 10 Poin = Rp 5.000 (Pekerjaan berat/teknis). |
| **BR-05** | Untuk transaksi Jasa Keuangan (Transfer antar bank/Tarik Tunai), pemilihan platform digital yang digunakan didasarkan sepenuhnya pada opsi yang memiliki biaya admin termurah bagi pelanggan. |
| **BR-06** | Bahan baku yang mengalami kegagalan proses/rusak tidak boleh dikurangi melalui manipulasi penghapusan transaksi. Harus direkam sebagai limbah produksi (*waste*) agar neraca stok material tetap seimbang. |
| **BR-07** | Pembayaran pesanan pelanggan dapat diangsur berupa Uang Muka (DP) `[PERLU DIISI MANUAL: Minimal Persentase/Nominal DP]`. Pelunasan tagihan sisa dibayarkan saat produk selesai dan diambil oleh pelanggan. |
| **BR-08** | Penetapan skema harga khusus (Grosir dan Mitra) harus diatur berdasarkan volume. `[PERLU DIISI MANUAL: Detail kuantitas minimum batas harga grosir dan kriteria spesifik harga mitra]`. |
| **BR-09** | Pembatalan pesanan dan prosedur retur barang dikenakan aturan baku perusahaan `[PERLU DIISI MANUAL: Syarat pengembalian DP batal dan ketentuan penukaran retur barang rusak]`. |
| **BR-10** | Karyawan sama sekali tidak diperkenankan melihat laporan finansial terkait data pinjaman bank berbunga (kewajiban bayar bulanan bank) dan tabungan kas pengadaan alat baru pemilik. |

---

## 6. Kriteria Penerimaan (*Acceptance Criteria* Tingkat Bisnis)

1. **Efektivitas Otomatisasi Beban Kerja:** Sistem harus secara drastis mengambil alih kebutuhan pencatatan manual harian yang dilakukan pemilik.
2. **Kesesuaian HPP Multi-Komposisi:** Perhitungan Harga Pokok Penjualan wajib terbukti valid di tingkat desimal saat memperhitungkan bahan baku dengan satuan luas (dimensi) maupun volume cairan (tinta) yang memotong dari stok inventaris besar.
3. **Rekonsiliasi Kas Presisi:** Sistem mampu menghadirkan fungsi pencocokan jumlah lembar fisik uang di laci dengan saldo akhir sistem pada penutupan setiap *shift* atau hari kerja harian.
4. **Alur Validasi Pesanan Lengkap:** Seluruh status produksi dari mulai tahap 'Antri' hingga 'Diambil' berjalan terstruktur, dengan lampiran pelacakan letak arsip desain agar dapat ditemukan saat ada re-order dari pelanggan lama di masa depan.
5. **Transparansi Gaji Karyawan:** Penerbitan slip gaji bulanan mengkalkulasi secara instan dan komprehensif seluruh instrumen: Poin Insentif, Skema Gaji Capaian/Tetap, dan Pemotongan Pinjaman Karyawan secara valid tanpa anomali data.

---
**Referensi Utama:** Dokumen ini disusun berdasarkan ekstraksi data dari file `docs/sdlc/narasi.txt` dan `docs/sdlc/01_planning/01_project_charter.md`.
