# Stakeholder Register — Sistem Manajemen Usaha Percetakan "AbuCom"

## 1. Informasi Dokumen

| Atribut              | Detail                                                  |
| -------------------- | ------------------------------------------------------- |
| **Versi**            | 1.1.0                                                   |
| **Status**           | [finish]                                                |
| **Tanggal Dibuat**   | 2026-05-11                                              |
| **Tanggal Direvisi** | 2026-05-11                                              |
| **Disusun Oleh**     | Senior Project Manager & Senior Business Analyst (AI)   |

## 2. Pendahuluan

Dokumen Stakeholder Register ini disusun untuk mengidentifikasi seluruh pemangku kepentingan (stakeholder) yang terlibat dalam pengembangan dan operasional **Sistem Manajemen Usaha Percetakan "AbuCom"**. Tujuan dokumen ini adalah untuk memetakan peran, tingkat pengaruh (*power*), tingkat kepentingan (*interest*), ekspektasi utama, serta kriteria keberhasilan dari masing-masing pemangku kepentingan guna menentukan strategi komunikasi dan manajemen yang efektif selama siklus hidup proyek (SDLC).

## 3. Daftar Pemangku Kepentingan (Stakeholder Roster)

| Nama Lengkap | Jabatan/Peran | Departemen/Organisasi | Kontak (Email/No. HP) |
| --- | --- | --- | --- |
| Bpk. Abubakar | Pemilik Usaha / Kepala Percetakan / Junior Programmer | Internal (Manajemen & IT) | abu@abucom.id / 081234567890 |
| Siti Aminah | Pramuniaga | Internal (Operasional) | siti@abucom.id / 082100001111 |
| Rina Kartika | Kasir | Internal (Keuangan) | rina@abucom.id / 082100002222 |
| Dedi Syahputra | Desainer | Internal (Produksi & Desain) | dedi@abucom.id / 082100003333 |
| Arif Rahman | Staf Produksi Cetak | Internal (Produksi & Desain) | arif@abucom.id / 082100004444 |
| Budi Santoso | Staf Fotocopy & Print | Internal (Operasional) | budi@abucom.id / 082100005555 |
| Hendra Gunawan | Staf Gudang | Internal (Gudang & Logistik) | hendra@abucom.id / 082100006666 |
| Representatif Pelanggan | Pelanggan / Klien | Eksternal | N/A (Tersimpan di CRM) |
| PT Tinta Sentosa & CV Kertas Abadi | Supplier / Vendor Bahan Baku | Eksternal | vendor@example.com / 021-5551234 |
| Keluarga Bpk. Abubakar | Kerabat / Keluarga (Pemberi Pinjaman) | Eksternal (Investor) | N/A |
| Bpk. Yudi | Perwakilan Bank BRI | Eksternal (Kreditur) | yudi.bri@example.com / 085200007777 |
| Ibu Sari | Perwakilan Bank Mandiri | Eksternal (Kreditur) | sari.mandiri@example.com / 081300008888 |
| Tim Pengembang AI | AI Agents (Gemini, Claude, GPT-OSS) | Eksternal (Pengembang Sistem) | prompt-interface@ai.local |

## 4. Analisis Pemangku Kepentingan (Stakeholder Analysis)

| Nama/Peran | Tingkat Kepentingan (*Interest*) | Tingkat Pengaruh (*Power*) | Ekspektasi Utama/Kebutuhan | Kriteria Keberhasilan (*Success Criteria*) | Strategi Manajemen/Komunikasi |
| --- | --- | --- | --- | --- | --- |
| Pemilik Usaha / Kepala Percetakan | Tinggi | Tinggi | Otomatisasi proses bisnis, pengurangan beban kerja, laporan keuangan/stok akurat, dan skalabilitas sistem. | Berkurangnya waktu pencatatan manual hingga 80%; laporan laba/rugi akurat. | **Manage Closely**. Libatkan secara intensif sebagai pengambil keputusan utama (*Decision Maker*) dan narasumber utama untuk *requirement gathering*. |
| Pramuniaga | Sedang | Rendah | Kemudahan penggunaan sistem CLI untuk melayani pelanggan secara cepat; fitur kalkulasi harga dan kembalian yang akurat. | Transaksi di garda depan dapat diselesaikan di bawah 2 menit tanpa *error*. | **Keep Informed**. Berikan pelatihan (SOP/Manual) yang jelas dan dengarkan umpan balik mengenai kemudahan antarmuka. |
| Kasir | Tinggi | Sedang | Pencatatan transaksi dan pelaporan keuangan harian yang presisi; kemudahan dalam proses rekonsiliasi uang fisik. | Tidak ada selisih kas fisik dengan sistem pada akhir jam operasional. | **Keep Satisfied**. Sediakan modul keuangan yang bebas dari *bug* dan berikan hak akses pelaporan yang memadai. |
| Desainer | Sedang | Rendah | Adanya fitur pengarsipan desain dan manajemen lokasi file pelanggan yang mudah dicari untuk cetak ulang. | File desain dapat dilacak dalam hitungan detik untuk keperluan *repeat order*. | **Keep Informed**. Pastikan alur kerja desain terdokumentasi dengan baik dalam sistem pelacakan pekerjaan (*job tracking*). |
| Staf Produksi Cetak | Sedang | Rendah | Manajemen antrian pesanan yang terstruktur dan fitur pencatatan limbah produksi (*waste management*) yang praktis. | *Zero missed orders* dan limbah terdata akurat agar stok fisik selalu sesuai. | **Keep Informed**. Pastikan visibilitas status *job tracking* (Antri -> Produksi) mudah diakses. |
| Staf Fotocopy & Print | Sedang | Rendah | Pencatatan transaksi dasar (print, fotocopy) yang instan dan kalkulasi poin insentif yang transparan. | Input pesanan kilat, perhitungan poin insentif tepat sesuai skema beban kerja. | **Keep Informed**. Optimalkan antarmuka CLI untuk *input* data yang cepat (meminimalkan *keystrokes*). |
| Staf Gudang | Tinggi | Sedang | Notifikasi stok minimum otomatis; kemudahan fitur *stock opname* dan konversi satuan bahan baku yang kompleks. | Selisih *stock opname* bernilai nol dan notifikasi pengadaan barang berjalan *real-time*. | **Keep Satisfied**. Pastikan logika *Bill of Materials* (BOM) berfungsi sempurna agar data fisik gudang selalu akurat. |
| Pelanggan / Klien | Tinggi | Sedang | Pesanan selesai tepat waktu, riwayat desain tersimpan dengan aman, serta proses retur/pembatalan DP yang jelas. | Peningkatan kepuasan (*customer satisfaction*) dan layanan *repeat order* yang lebih responsif. | **Keep Satisfied**. Pastikan modul CRM mencatat preferensi pelanggan dan *job tracking* menjamin ketepatan waktu layanan. |
| Supplier / Vendor | Rendah | Sedang | Pencatatan hutang usaha dan riwayat pembelian tercatat secara benar agar pembayaran tagihan tidak terlambat. | Tidak ada keterlambatan pembayaran atas *invoice* atau tagihan yang jatuh tempo. | **Monitor**. Kelola data tagihan dan *supplier* dengan rapi pada modul Hutang Usaha. |
| Kerabat (Pemberi Pinjaman) | Sedang | Tinggi | Transparansi mutasi dana pinjaman (tanpa bunga) karena dana dapat ditarik sewaktu-waktu. | Ketersediaan *audit trail* riwayat penarikan dan saldo dana investasi secara transparan. | **Keep Satisfied**. Pastikan modul pinjaman memiliki *audit trail* yang dapat dipertanggungjawabkan kepada *stakeholder* terkait. |
| Bank BRI & Bank Mandiri | Tinggi | Tinggi | Pembayaran setoran pinjaman tepat waktu berdasarkan tenor dan riwayat jatuh tempo yang dikelola sistem. | Kredit berstatus *Performing Loan* (Lancar) karena sistem memberikan notifikasi tepat waktu. | **Manage Closely**. Buat fitur pengingat (*reminder*) otomatis untuk tanggal jatuh tempo kredit perbankan. |
| Tim Pengembang AI | Tinggi | Tinggi | Mendapatkan spesifikasi (*requirements*) yang sangat jelas, bebas ambiguitas, dan dokumen SDLC yang terstruktur rapi. | Modul selesai sesuai *timeline* tanpa ada *major rework* akibat ambiguitas kebutuhan. | **Manage Closely**. Berikan instruksi teknis (*prompt*) yang eksplisit dan logis untuk meminimalkan halusinasi AI. |

## 5. Referensi

Dokumen ini disusun dan divalidasi berdasarkan:
1. `docs/sdlc/narasi.txt`
2. `docs/sdlc/01_planning/01_project_charter.md`
3. `docs/sdlc/01_planning/02_feasibility_study.md`
