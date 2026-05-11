# Stakeholder Register — Sistem Manajemen Usaha Percetakan "AbuCom"

## 1. Informasi Dokumen

| Atribut              | Detail                                                  |
| -------------------- | ------------------------------------------------------- |
| **Versi**            | 1.0.0                                                   |
| **Status**           | [done]                                                  |
| **Tanggal Dibuat**   | 2026-05-11                                              |
| **Tanggal Direvisi** | 2026-05-11                                              |
| **Disusun Oleh**     | Senior Project Manager & Senior Business Analyst (AI)   |

## 2. Pendahuluan
Dokumen Stakeholder Register ini disusun untuk mengidentifikasi seluruh pemangku kepentingan (stakeholder) yang terlibat dalam pengembangan dan operasional **Sistem Manajemen Usaha Percetakan "AbuCom"**. Tujuan dokumen ini adalah untuk memetakan peran, tingkat pengaruh (*power*), tingkat kepentingan (*interest*), serta ekspektasi dari masing-masing pemangku kepentingan guna menentukan strategi komunikasi dan manajemen yang efektif selama siklus hidup proyek (SDLC). 

## 3. Daftar Pemangku Kepentingan (Stakeholder Roster)

| Nama Lengkap | Jabatan/Peran | Departemen/Organisasi | Kontak (Email/No. HP) |
| --- | --- | --- | --- |
| [NAMA_TBA] | Pemilik Usaha / Kepala Percetakan / Junior Programmer | Internal (Manajemen & IT) | [KONTAK_TBA] |
| [NAMA_TBA] | Pramuniaga | Internal (Operasional) | [KONTAK_TBA] |
| [NAMA_TBA] | Kasir | Internal (Keuangan) | [KONTAK_TBA] |
| [NAMA_TBA] | Desainer | Internal (Produksi & Desain) | [KONTAK_TBA] |
| [NAMA_TBA] | Staf Produksi Cetak | Internal (Produksi & Desain) | [KONTAK_TBA] |
| [NAMA_TBA] | Staf Fotocopy & Print | Internal (Operasional) | [KONTAK_TBA] |
| [NAMA_TBA] | Staf Gudang | Internal (Gudang & Logistik) | [KONTAK_TBA] |
| [NAMA_TBA] | Pelanggan / Klien | Eksternal | [KONTAK_TBA] |
| [NAMA_TBA] | Supplier / Vendor Bahan Baku | Eksternal | [KONTAK_TBA] |
| [NAMA_TBA] | Kerabat / Keluarga (Pemberi Pinjaman) | Eksternal (Investor) | [KONTAK_TBA] |
| [NAMA_TBA] | Perwakilan Bank BRI | Eksternal (Kreditur) | [KONTAK_TBA] |
| [NAMA_TBA] | Perwakilan Bank Mandiri | Eksternal (Kreditur) | [KONTAK_TBA] |
| Tim Pengembang AI | AI Agents (Gemini, Claude, GPT-OSS) | Eksternal (Pengembang Sistem) | [KONTAK_TBA] |

## 4. Analisis Pemangku Kepentingan (Stakeholder Analysis)

| Nama/Peran | Tingkat Kepentingan (*Interest*) | Tingkat Pengaruh (*Power*) | Ekspektasi Utama/Kebutuhan | Strategi Manajemen/Komunikasi |
| --- | --- | --- | --- | --- |
| Pemilik Usaha / Kepala Percetakan | Tinggi | Tinggi | Otomatisasi proses bisnis, pengurangan beban kerja, laporan keuangan/stok akurat, dan skalabilitas sistem. | **Manage Closely**. Libatkan secara intensif sebagai pengambil keputusan utama (*Decision Maker*) dan narasumber utama untuk *requirement gathering*. |
| Pramuniaga | Sedang | Rendah | Kemudahan penggunaan sistem CLI untuk melayani pelanggan secara cepat; fitur kalkulasi harga dan kembalian yang akurat. | **Keep Informed**. Berikan pelatihan (SOP/Manual) yang jelas dan dengarkan umpan balik mengenai kemudahan antarmuka. |
| Kasir | Tinggi | Sedang | Pencatatan transaksi dan pelaporan keuangan harian yang presisi; kemudahan dalam proses rekonsiliasi uang fisik. | **Keep Satisfied**. Sediakan modul keuangan yang bebas dari *bug* dan berikan hak akses pelaporan yang memadai. |
| Desainer | Sedang | Rendah | Adanya fitur pengarsipan desain dan manajemen lokasi file pelanggan yang mudah dicari untuk cetak ulang. | **Keep Informed**. Pastikan alur kerja desain terdokumentasi dengan baik dalam sistem pelacakan pekerjaan (*job tracking*). |
| Staf Produksi Cetak | Sedang | Rendah | Manajemen antrian pesanan yang terstruktur dan fitur pencatatan limbah produksi (*waste management*) yang praktis. | **Keep Informed**. Pastikan visibilitas status *job tracking* (Antri -> Produksi) mudah diakses. |
| Staf Fotocopy & Print | Sedang | Rendah | Pencatatan transaksi dasar (print, fotocopy) yang instan dan kalkulasi poin insentif yang transparan. | **Keep Informed**. Optimalkan antarmuka CLI untuk *input* data yang cepat (meminimalkan *keystrokes*). |
| Staf Gudang | Tinggi | Sedang | Notifikasi stok minimum otomatis; kemudahan fitur *stock opname* dan konversi satuan bahan baku yang kompleks. | **Keep Satisfied**. Pastikan logika *Bill of Materials* (BOM) berfungsi sempurna agar data fisik gudang selalu akurat. |
| Pelanggan / Klien | Tinggi | Sedang | Pesanan selesai tepat waktu, riwayat desain tersimpan dengan aman, serta proses retur/pembatalan DP yang jelas. | **Keep Satisfied**. Pastikan modul CRM mencatat preferensi pelanggan dan *job tracking* menjamin ketepatan waktu layanan. |
| Supplier / Vendor | Rendah | Sedang | Pencatatan hutang usaha dan riwayat pembelian tercatat secara benar agar pembayaran tagihan tidak terlambat. | **Monitor**. Kelola data tagihan dan *supplier* dengan rapi pada modul Hutang Usaha. |
| Kerabat (Pemberi Pinjaman) | Sedang | Tinggi | Transparansi mutasi dana pinjaman (tanpa bunga) karena dana dapat ditarik sewaktu-waktu. | **Keep Satisfied**. Pastikan modul pinjaman memiliki *audit trail* yang dapat dipertanggungjawabkan kepada *stakeholder* terkait. |
| Bank BRI & Bank Mandiri | Tinggi | Tinggi | Pembayaran setoran pinjaman tepat waktu berdasarkan tenor dan riwayat jatuh tempo yang dikelola sistem. | **Manage Closely**. Buat fitur pengingat (*reminder*) otomatis untuk tanggal jatuh tempo kredit perbankan. |
| Tim Pengembang AI | Tinggi | Tinggi | Mendapatkan spesifikasi (*requirements*) yang sangat jelas, bebas ambiguitas, dan dokumen SDLC yang terstruktur rapi. | **Manage Closely**. Berikan instruksi teknis (*prompt*) yang eksplisit dan logis untuk meminimalkan halusinasi AI. |

## 5. Referensi
Dokumen ini disusun berdasarkan:
- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/01_planning/02_feasibility_study.md`
