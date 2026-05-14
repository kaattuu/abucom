# Issue 0020: Validasi Data Dictionary

## Metadata
- **Dokumen Utama**: `05_data_dictionary.md`
- **Folder Tahapan**: `02_analysis/`
- **Status Saat Ini**: [draft]
- **Versi Dokumen**: 1.0.0 (draft)
- **Tanggal Issue Dibuat**: 2026-05-14
- **Prioritas**: High
- **Estimasi Waktu**: 3-4 jam

## Deskripsi Issue
Issue ini dibuat untuk memvalidasi dokumen utama `05_data_dictionary.md` yang saat ini masih berstatus [draft]. Validasi diperlukan untuk memastikan dokumen ini memenuhi standar kualitas, kelengkapan, dan kesiapan untuk digunakan sebagai referensi utama dalam perancangan database schema, ERD, dan seluruh dokumen teknis turunan pada fase SDLC selanjutnya (03_design).

---

## Persona yang Direkomendasikan
**Senior Data Analyst & Senior Database Architect dengan spesialisasi Business Domain Modeling**
- Memiliki pengalaman minimal 5 tahun dalam perancangan skema data dan data dictionary untuk sistem manajemen bisnis
- Menguasai teknik normalisasi database, entity-relationship modeling, dan constraint definition
- Familiar dengan standar industri untuk Data Dictionary (ISO/IEC 11179 atau setara)
- Memahami domain bisnis percetakan: alur transaksi, manajemen bahan baku (BOM), penggajian, PPOB, dan multi-cabang
- Teliti, detail-oriented, mampu mendeteksi inkonsistensi antar entitas, dan mampu menilai kelayakan data sebagai acuan fase design
- Mampu menulis dalam Bahasa Indonesia teknis yang natural, presisi, dan tidak ambigu

---

## File yang Wajib Dibuka Sebelum Memulai
Buka dan pelajari seluruh isi file berikut SEBELUM melakukan validasi apapun. Jangan lewatkan satu pun.

1. **File target (dokumen utama)**: `docs/sdlc/02_analysis/05_data_dictionary.md`
2. **File referensi wajib**:
   - `docs/sdlc/02_analysis/01_business_requirements.md`
   - `docs/sdlc/02_analysis/02_software_requirements.md`
   - `docs/sdlc/02_analysis/03_use_case_diagram.puml`
   - `docs/sdlc/02_analysis/04_workflow_diagram.puml`
   - `docs/sdlc/narasi.txt`

---

## Instruksi Low-Level untuk Implementasi

Kerjakan setiap tahap secara berurutan. Jangan melompati tahap. Catat semua temuan sebelum melakukan perubahan.

---

### Tahap 0: Persiapan dan Pemahaman Konteks

**Langkah-langkah konkret:**
1. Baca seluruh isi `05_data_dictionary.md` dari baris pertama hingga baris terakhir tanpa melewatkan satu pun baris.
2. Baca seluruh isi setiap file referensi yang disebutkan di atas.
3. Buat catatan mental atau catatan tertulis sementara tentang:
   - Modul bisnis apa saja yang ada (Percetakan, ATK, PPOB, Jasa Keuangan, Penggajian, Multi-Cabang, dll.)
   - Aktor sistem apa saja yang disebutkan (Pemilik, Karyawan, Pelanggan, Vendor)
   - Fitur utama apa saja yang tercantum di business requirements dan software requirements

---

### Tahap 1: Komparasi Mendalam — Kelengkapan Entitas vs. File Referensi

**Tujuan**: Memastikan tidak ada entitas data penting yang terlewat dari file referensi.

**Langkah-langkah konkret:**
1. Dari `01_business_requirements.md`, ekstrak semua kebutuhan data bisnis. Contoh: pencatatan pesanan, pembayaran, stok, karyawan, dll.
2. Dari `02_software_requirements.md`, ekstrak semua kebutuhan fungsional yang memerlukan penyimpanan data.
3. Dari `03_use_case_diagram.puml`, identifikasi semua use case dan aktor — setiap use case pada umumnya membutuhkan setidaknya satu entitas data.
4. Dari `04_workflow_diagram.puml`, identifikasi data yang berpindah antar proses (data yang masuk dan keluar dari setiap langkah workflow).
5. Dari `narasi.txt`, cari penyebutan data atau informasi bisnis yang belum tertuang secara eksplisit di empat file sebelumnya.
6. Untuk setiap item yang ditemukan di langkah 1-5, periksa apakah sudah ada entitas atau atribut yang merepresentasikannya di `05_data_dictionary.md`.
7. Catat setiap item yang BELUM tercakup → ini adalah **gap kelengkapan** yang harus ditambahkan atau dijustifikasi alasan tidak disertakan.

**Checklist spesifik untuk Data Dictionary percetakan:**
- [ ] Apakah ada representasi data untuk setiap kategori layanan: Percetakan, ATK, PPOB, Jasa Keuangan, Jasa Teknis?
- [ ] Apakah pengelolaan multi-cabang (`branch_id`) sudah konsisten hadir di semua entitas yang membutuhkannya?
- [ ] Apakah alur DP (uang muka) dan pelunasan sudah terwakili di entitas `payments`?
- [ ] Apakah sistem poin insentif karyawan sudah terdefinisi dengan jelas di entitas `incentive_points`?
- [ ] Apakah pencatatan kasbon karyawan (`employee_loans`) sudah ada dan terhubung ke `payroll`?
- [ ] Apakah fitur rekonsiliasi kas (`cash_reconciliation`) sudah ada?
- [ ] Apakah entitas untuk pelacakan pekerjaan cetak (`orders_job_tracking`) sudah ada?
- [ ] Apakah entitas untuk BOM (`bom`) sudah ada dan terhubung ke produk dan material?
- [ ] Apakah entitas untuk audit trail (`audit_trail`) sudah ada untuk mendukung keamanan sistem?

---

### Tahap 2: Komparasi Mendalam — Relevansi dan Fokus Entitas

**Tujuan**: Memastikan tidak ada atribut atau entitas yang keluar dari scope Data Dictionary fase Analysis.

**Langkah-langkah konkret:**
1. Baca kembali setiap definisi entitas di `05_data_dictionary.md` satu per satu.
2. Untuk setiap atribut di setiap entitas, tanyakan:
   - **Apakah atribut ini memang dibutuhkan oleh sistem ini?** Jika tidak ada referensi di file manapun, tandai sebagai kandidat penghapusan.
   - **Apakah atribut ini sudah berada di level yang tepat?** Data Dictionary fase Analysis seharusnya mendefinisikan atribut logis bisnis, bukan detail teknis implementasi (seperti query hints, index hints, dll.).
3. Periksa apakah ada atribut yang seharusnya ada di entitas lain (misalnya: atribut yang duplikat antara dua entitas berbeda).
4. Periksa apakah ada entitas yang seharusnya digabung atau dipecah berdasarkan prinsip normalisasi (3NF minimal).
5. Catat semua temuan.

**Catatan penting**: Jangan hapus atribut tanpa memeriksa apakah ada referensi di file lain. Jika ragu, tambahkan komentar justifikasi, jangan hapus.

---

### Tahap 3: Validasi Standar Struktur Dokumen Data Dictionary

**Tujuan**: Memastikan dokumen mengikuti standar struktur Data Dictionary industri yang lengkap dan informatif.

**Langkah-langkah konkret:**
1. Periksa apakah setiap entitas memiliki elemen berikut secara lengkap:
   - **Nama entitas** (nama tabel dalam format `snake_case`)
   - **Deskripsi entitas** (satu kalimat yang jelas menjelaskan apa yang disimpan entitas ini)
   - **Tabel atribut** dengan kolom: `Nama Atribut`, `Tipe Data`, `Constraints`, `Nilai Default`, `Deskripsi`
   - **Catatan Relasi** (FK apa mereferensikan ke tabel apa)
2. Periksa apakah kolom `Nilai Default` tidak ada yang kosong tanpa alasan — jika memang tidak ada default, isi dengan tanda `-` atau kosongkan secara eksplisit dengan catatan.
3. Periksa apakah kolom `Deskripsi` setiap atribut cukup informatif. Deskripsi yang baik menjelaskan TUJUAN atribut, bukan sekadar mengulang nama atribut.
   - **Buruk**: `id` → "ID" (tidak informatif)
   - **Baik**: `id` → "ID unik auto-increment sebagai primary key tabel ini"
4. Periksa apakah Constraints sudah lengkap dan tidak ambigu:
   - Apakah semua PK sudah diberi `AUTO_INCREMENT`?
   - Apakah semua FK sudah diberi label FK?
   - Apakah constraint `UNIQUE`, `NOT NULL` sudah diterapkan di tempat yang sesuai?
5. Periksa apakah Bagian 5 (Ringkasan Relasi Antar Entitas) mencantumkan SEMUA relasi FK yang ada di seluruh entitas — tidak ada yang terlewat.
6. Periksa apakah metadata dokumen (Bagian `## Metadata Dokumen`) sudah lengkap dan akurat.

---

### Tahap 4: Validasi Kelayakan sebagai Referensi Fase Design (03_design)

**Tujuan**: Memastikan dokumen ini cukup lengkap untuk dijadikan input utama pembuatan database schema SQL, ERD, dan system architecture.

**Langkah-langkah konkret:**
1. Bayangkan dirimu adalah database engineer yang bertugas membuat `01_database_schema.sql` menggunakan HANYA file `05_data_dictionary.md` ini sebagai panduan.
2. Tanyakan untuk setiap entitas:
   - **Bisakah kamu langsung menulis `CREATE TABLE` statement dari tabel atribut yang ada?** Jika ada informasi yang kurang, catat.
   - **Bisakah kamu langsung menentukan `FOREIGN KEY REFERENCES` dari bagian Catatan Relasi?** Jika tidak jelas, catat.
   - **Bisakah kamu menentukan urutan pembuatan tabel** (tabel mana yang harus dibuat lebih dulu karena menjadi referensi FK tabel lain)?
3. Periksa apakah ada ENUM domain yang sudah didefinisikan — ini penting karena ENUM di MySQL tidak bisa diubah sembarangan setelah produksi.
4. Periksa apakah ada tipe data yang tidak konsisten (misalnya: satu kolom `id` menggunakan INT, kolom lain menggunakan BIGINT tanpa alasan jelas).
5. Periksa apakah penggunaan `DECIMAL(15,4)` sudah konsisten untuk semua atribut finansial dan kuantitas.
6. Catat semua temuan yang akan menjadi hambatan bagi database engineer.

---

### Tahap 5: Validasi Bahasa Indonesia — Natural, Jelas, Tidak Ambigu

**Tujuan**: Memastikan setiap kalimat di dokumen ini dapat dipahami oleh junior programmer atau AI model lain tanpa kebingungan.

**Langkah-langkah konkret:**
1. Baca ulang seluruh **Deskripsi Entitas** di setiap entitas. Untuk setiap deskripsi:
   - Apakah kalimatnya menggunakan Bahasa Indonesia baku dan natural?
   - Apakah ada kata yang ambigu atau bisa ditafsirkan lebih dari satu cara?
   - Apakah subjek kalimat jelas (siapa yang menyimpan apa)?
2. Baca ulang seluruh **Deskripsi Atribut** di setiap baris tabel. Untuk setiap deskripsi atribut:
   - Apakah jelas apa yang disimpan di kolom ini?
   - Apakah ada istilah teknis yang perlu penjelasan tambahan?
   - Apakah satuan ukuran (jika ada) disebutkan dengan jelas?
3. Baca ulang **Catatan Relasi** di setiap entitas:
   - Apakah relasi ditulis dalam format yang konsisten?
   - Apakah arah relasi (mana yang Many, mana yang One) bisa dipahami?
4. Periksa bagian **Pendahuluan** (Bagian 1) dan **Konvensi Penamaan** (Bagian 2):
   - Apakah penjelasan cukup untuk dipahami tanpa membuka dokumen lain?
   - Apakah ada konvensi yang digunakan di tabel entitas tetapi tidak dijelaskan di bagian ini?
5. Perbaiki semua kalimat yang kaku, ambigu, atau tidak natural.

---

### Tahap 6: Validasi Anti-Interupsi — Mencegah Pertanyaan dari Fase Selanjutnya

**Tujuan**: Memastikan dokumen ini bisa menjawab sendiri pertanyaan-pertanyaan yang biasanya muncul saat fase design.

**Langkah-langkah konkret:**
1. Buat daftar pertanyaan yang mungkin diajukan oleh database engineer saat membaca dokumen ini. Contoh pertanyaan umum:
   - "Apa format data yang harus disimpan di kolom ini?"
   - "Apa maksud nilai default ini?"
   - "Kenapa kolom ini NULLABLE?"
   - "Bagaimana cara menghitung kolom ini?"
   - "Apa perbedaan antara dua entitas yang terlihat mirip?"
2. Untuk setiap pertanyaan yang ditemukan, jawab langsung di dalam dokumen di tempat yang relevan (tambahkan keterangan di kolom Deskripsi, atau tambahkan catatan di bawah tabel entitas).
3. Periksa secara spesifik apakah area berikut sudah dijawab dengan jelas di dokumen:
   - **Bagaimana HPP dikalkulasi?** Apakah relasi antara `bom`, `materials`, dan `transaction_items` sudah cukup jelas?
   - **Bagaimana skema gaji Persentase bekerja?** Apakah formula atau referensi perhitungannya ada?
   - **Bagaimana poin insentif dikonversi ke uang?** Apakah ada penjelasan konversi di `incentive_points` atau `payroll`?
   - **Apa yang terjadi saat saldo PPOB di bawah `min_balance`?** Apakah ada catatan behavior di `ppob_accounts`?
   - **Bagaimana sistem menentukan tier harga pelanggan secara otomatis?** Apakah relasi `customers` → `pricing_tiers` sudah cukup menjelaskan ini?
4. Jika pertanyaan-pertanyaan di atas tidak terjawab di dokumen ini, tambahkan catatan/keterangan yang sesuai.

---

### Tahap 7: Identifikasi dan Pengisian Data Kosong

**Tujuan**: Memastikan tidak ada placeholder atau bagian kosong yang belum diisi.

**Langkah-langkah konkret:**
1. Scan seluruh dokumen untuk mencari:
   - Teks seperti `[TBD]`, `[TODO]`, `[FILL]`, `?`, atau `...`
   - Sel tabel yang kosong tanpa alasan (bukan memang sengaja dikosongkan)
   - Deskripsi yang hanya berisi tanda `-` padahal seharusnya ada penjelasan
   - Kolom `Nilai Default` yang kosong — tentukan apakah memang tidak ada default atau harus diisi
2. Untuk setiap data kosong yang ditemukan:
   - Tentukan nilai yang tepat berdasarkan konteks entitas dan file referensi
   - Isi dengan data yang sesuai
   - Jika tidak bisa ditentukan, isi dengan asumsi yang masuk akal dan tambahkan catatan `*(Asumsi: [alasan])*` di bawahnya
3. Periksa secara khusus:
   - Apakah metadata dokumen (versi, status, tanggal, disusun oleh) sudah lengkap dan akurat?
   - Apakah ada entitas yang `Deskripsi Entitas`-nya masih terlalu singkat atau generik?
   - Apakah kolom `Deskripsi` di tabel atribut ada yang masih kosong?

---

### Tahap 8: Poin Tambahan Spesifik Data Dictionary

Selain poin di atas, periksa hal-hal berikut yang merupakan ciri khas dokumen Data Dictionary:

1. **Konsistensi penamaan FK**: Setiap kolom FK harus dinamai `[nama_tabel_referensi_singular]_id`. Contoh: FK ke tabel `branches` → kolom `branch_id`. Pastikan semua FK mengikuti konvensi ini tanpa pengecualian.
2. **Konsistensi tipe data PK**: Semua primary key `id` harus menggunakan tipe data yang sama (`INT` atau `BIGINT`). Jika ada perbedaan, dokumentasikan alasannya.
3. **Kelengkapan ENUM domain**: Setiap atribut bertipe `ENUM` harus mendefinisikan semua kemungkinan nilai domain. Periksa apakah ada nilai ENUM yang terlewat berdasarkan konteks bisnis.
   - Contoh: `payment_status ENUM('Belum Bayar', 'DP', 'Lunas')` — apakah ada status lain seperti 'Batal' atau 'Refund' yang dibutuhkan?
   - Contoh: `service_type ENUM(...)` — apakah semua kategori layanan percetakan sudah tercakup?
4. **Validasi urutan entitas**: Pastikan urutan entitas di Bagian 4 mengikuti urutan yang logis — entitas master lebih dulu, lalu transaksi, lalu pendukung. Jika ada entitas yang salah posisi, pindahkan.
5. **Kelengkapan Bagian 5 (Ringkasan Relasi)**: Pastikan SETIAP FK yang didefinisikan di seluruh entitas tercantum di Bagian 5. Tidak boleh ada FK yang terdefinisi di tabel entitas tetapi tidak muncul di ringkasan relasi.
6. **Kesesuaian kardinalitas**: Untuk setiap relasi di Bagian 5, verifikasi apakah kardinalitas (Many-to-One, One-to-One, dll.) sudah benar berdasarkan logika bisnis.
   - Contoh: `employees` → `users` harus One-to-One (opsional) karena tidak semua karyawan punya akun login.
   - Contoh: `orders_job_tracking` → `transactions` harus One-to-One karena satu transaksi hanya punya satu job tracking.
7. **Tidak ada circular dependency**: Pastikan tidak ada dua entitas yang saling mereferensikan satu sama lain sebagai FK wajib (NOT NULL) — ini akan menyebabkan masalah saat pembuatan tabel di database.

---

### Tahap 9: Implementasi Semua Temuan ke File

**Tujuan**: Menuangkan semua hasil temuan dari Tahap 1-8 ke file `05_data_dictionary.md`.

**Langkah-langkah konkret:**
1. Buka file `docs/sdlc/02_analysis/05_data_dictionary.md` untuk diedit.
2. Implementasikan semua perubahan yang sudah dicatat dari setiap tahap secara berurutan:
   - Tambahkan entitas atau atribut yang kurang (dari Tahap 1)
   - Hapus atau pindahkan atribut yang tidak relevan (dari Tahap 2)
   - Lengkapi kolom tabel yang kosong atau tidak informatif (dari Tahap 3 dan 7)
   - Tambahkan catatan/keterangan untuk menjawab potensi pertanyaan (dari Tahap 6)
   - Perbaiki kalimat yang ambigu (dari Tahap 5)
   - Perbaiki inkonsistensi penamaan, tipe data, ENUM, dan relasi (dari Tahap 8)
   - Perbarui Bagian 5 (Ringkasan Relasi) jika ada entitas atau FK baru yang ditambahkan
3. **Update versi dokumen**: Di bagian `## Metadata Dokumen`, ubah versi dari `1.0.0` menjadi `1.1.0` sebagai tanda dokumen telah mengalami perbaikan.
4. **Jangan ubah status**: Status tetap `[draft]` sampai ada instruksi lain dari issue berikutnya. Perubahan status akan dilakukan terpisah setelah validasi selesai.

---

### Tahap 10: Perbarui Bagian Referensi Dokumen

**Tujuan**: Memastikan semua file yang dijadikan referensi selama proses validasi dicantumkan di bagian akhir dokumen.

**Langkah-langkah konkret:**
1. Buka Bagian `## 6. Referensi Dokumen` di file `05_data_dictionary.md`.
2. Periksa daftar referensi yang sudah ada.
3. Jika selama proses validasi kamu membuka atau merujuk file lain yang BELUM tercantum di daftar referensi, tambahkan file tersebut di bagian paling bawah daftar referensi dengan format:
   ```
   - `docs/sdlc/[path/ke/file]`
   ```
4. Pastikan semua file yang kamu buka di Tahap 0 sudah tercantum di daftar referensi. Jika ada yang belum, tambahkan.

---

### Tahap 11: Final Review Sebelum Selesai

**Langkah-langkah konkret:**
1. Baca ulang seluruh file `05_data_dictionary.md` dari awal hingga akhir setelah semua perubahan diimplementasikan.
2. Periksa:
   - Tidak ada typo atau kesalahan pengetikan
   - Tidak ada baris tabel yang rusak formatnya (kolom tabel markdown harus lurus)
   - Nomor entitas di Bagian 4 masih berurutan dan konsisten dengan daftar di Bagian 3
   - Versi sudah diperbarui di metadata
3. Lakukan konsistensi check terakhir:
   - Jumlah entitas di daftar Bagian 3 harus sama dengan jumlah entitas yang didefinisikan di Bagian 4
   - Jumlah baris di Bagian 5 (Ringkasan Relasi) harus mencakup SEMUA FK yang ada di seluruh Bagian 4
4. Simpan file.

---

## Deliverables
1. File `docs/sdlc/02_analysis/05_data_dictionary.md` yang telah divalidasi, diperbaiki, dan dilengkapi
2. Versi dokumen diperbarui dari `1.0.0` menjadi `1.1.0` di metadata
3. Semua entitas memiliki deskripsi yang jelas dan informatif
4. Semua atribut memiliki deskripsi yang tidak ambigu
5. Bagian Ringkasan Relasi (Bagian 5) sudah lengkap dan akurat
6. Bagian Referensi Dokumen (Bagian 6) sudah mencantumkan semua file referensi yang digunakan
7. Status dokumen tetap `[draft]` (perubahan status diurus oleh issue terpisah)

---

## Success Criteria
1. Tidak ada entitas atau atribut penting dari file referensi yang terlewat
2. Semua atribut FK konsisten penamaannya (`[tabel_singular]_id`)
3. Semua domain ENUM lengkap dan sesuai konteks bisnis
4. Seluruh Bagian 5 mencakup semua relasi FK yang ada di Bagian 4
5. Setiap baris deskripsi (entitas maupun atribut) dapat dipahami oleh junior programmer tanpa kebingungan
6. Tidak ada data kosong yang tidak terisi tanpa justifikasi
7. Dokumen dapat langsung dijadikan panduan menulis `CREATE TABLE` SQL tanpa pertanyaan tambahan
8. Versi dokumen sudah diperbarui ke `1.1.0`

---

## Catatan Penting untuk Implementor
- **Kerjakan secara berurutan, Tahap 0 hingga Tahap 11.** Jangan melompat ke tahap selanjutnya sebelum tahap sebelumnya selesai.
- **Jangan menghapus atribut atau entitas** tanpa memeriksa terlebih dulu apakah ada referensinya di file lain.
- **Jangan mengubah nama tabel atau nama kolom** yang sudah ada kecuali ada alasan kuat dari hasil validasi — perubahan nama akan berdampak ke seluruh dokumen fase design selanjutnya.
- **Jangan ubah status dokumen** di `sdlc.txt` — perubahan status adalah scope issue terpisah.
- **Fokus pada kualitas, bukan kecepatan.** Dokumen ini adalah fondasi dari database schema, ERD, dan seluruh fase design. Kesalahan di sini akan berdampak ke seluruh fase SDLC selanjutnya.
- Jika ada ketidaksesuaian antar file referensi, catat ketidaksesuaian tersebut sebagai catatan di dalam dokumen dan pilih sumber yang paling relevan berdasarkan konteks.
