# Issue: Pembuatan Dokumen Workflow Diagram

## Deskripsi Tugas
Tugas ini bertujuan untuk menyusun dokumen utama `04_workflow_diagram.puml` yang berada di dalam folder `docs/sdlc/02_analysis/`. Dokumen ini saat ini berstatus `[create_file]` dan harus menjadi representasi alur kerja sistem yang akurat, lengkap, fokus, dan mudah dipahami untuk fase analisis. Workflow diagram ini harus menjelaskan arus proses bisnis dan arus interaksi sistem yang benar-benar penting, sehingga dapat dipakai sebagai acuan kuat untuk fase desain SDLC berikutnya.

## Persona Implementasi
Bertindaklah sebagai **Senior Business Process Analyst**, **Senior System Analyst**, dan **Senior UML Activity Diagram / PlantUML Specialist** yang sangat kuat dalam menerjemahkan kebutuhan bisnis dan kebutuhan sistem menjadi workflow diagram yang rapi, tidak ambigu, valid secara notasi, dan layak digunakan dalam praktik industri nyata. Anda harus mampu memilah mana alur yang benar-benar perlu dimodelkan, mana yang hanya detail implementasi teknis, dan mana yang harus diberi penanda klarifikasi agar tidak terjadi halusinasi.

## File Referensi Utama
Dalam pembuatan dokumen ini, Anda **DIWAJIBKAN** untuk merujuk pada file berikut sebagai sumber data dan informasi utama:
1. `docs/sdlc/02_analysis/01_business_requirements.md`
2. `docs/sdlc/02_analysis/02_software_requirements.md`
3. `docs/sdlc/02_analysis/03_use_case_diagram.puml`

Gunakan `docs/sdlc/narasi.txt` jika setelah membaca tiga referensi utama di atas masih diperlukan detail tambahan untuk memahami alur kerja operasional aktual, urutan kerja manual, perpindahan tanggung jawab antar peran, atau konteks langkah bisnis yang belum tergambar jelas. Untuk dokumen workflow diagram, `narasi.txt` cenderung relevan karena berisi rincian proses operasional harian. Namun, tetap gunakan secara selektif dan hanya ambil bagian yang benar-benar dibutuhkan oleh workflow diagram.

## Instruksi Kelayakan & Kriteria Dokumen Utama
Harap patuhi instruksi berikut secara ketat saat menyusun isi dari dokumen `04_workflow_diagram.puml`:

1. **Ekstraksi Alur Kerja Secara Presisi**: Identifikasi seluruh alur kerja yang benar-benar penting dari sudut pandang operasional dan sistem. Fokus pada alur yang bernilai tinggi bagi bisnis dan relevan sebagai landasan fase desain berikutnya.
2. **Hanya Ambil Informasi yang Relevan untuk Workflow Diagram**: Ambil dan rangkum HANYA data yang memang dibutuhkan untuk memetakan urutan aktivitas, percabangan keputusan, perpindahan status, interaksi antar peran, dan respons sistem. Jangan memasukkan detail yang lebih cocok untuk dokumen database, source code, konfigurasi environment, atau detail teknis implementasi rendah.
3. **Rangkum Seluruh Informasi Penting Tanpa Ada yang Terlewat**: Pastikan semua alur penting yang memang dibutuhkan untuk memahami proses inti sistem sudah tercakup. Jika ada alur penting yang jelas muncul di referensi tetapi tidak dimasukkan, hasil dianggap belum lengkap.
4. **Standar Struktur Diagram Praktik Industri**: Diagram harus memakai struktur workflow/activity diagram yang rapi, konsisten, dan mudah ditelusuri. Minimal harus memiliki titik awal, aktivitas, keputusan penting, aliran proses, dan titik akhir yang jelas jika memang relevan.
5. **Kelayakan Sebagai Acuan Fase SDLC Selanjutnya**: Workflow diagram ini harus layak dijadikan referensi utama bagi fase desain selanjutnya seperti database schema, system architecture, CLI interaction flow, access control matrix, dan dokumen implementasi. Karena itu, nama aktivitas, status, dan istilah domain wajib stabil dan konsisten dengan dokumen referensi.
6. **Bahasa Indonesia yang Natural dan Tegas**: Gunakan penamaan aktivitas, keputusan, dan label yang natural dalam Bahasa Indonesia, tidak ambigu, tidak membingungkan, dan mudah dipahami oleh junior programmer atau AI model yang lebih murah.
7. **Kelengkapan Tanpa Halusinasi**: Jangan mengarang langkah proses, keputusan, aktor, status, atau cabang alur jika tidak ada dasar yang cukup dari referensi. Jika ada bagian penting yang belum memiliki data kuat, beri penanda yang jelas untuk pengisian manual.
8. **Penandaan Data yang Belum Tersedia**: Jika ada nama aktivitas, keputusan, status, atau aturan transisi yang seharusnya ada tetapi belum cukup jelas dari referensi, tandai secara eksplisit menggunakan placeholder seperti `[PERLU_KLARIFIKASI_AKTIVITAS]`, `[PERLU_KLARIFIKASI_KEPUTUSAN]`, `[PERLU_KONFIRMASI_STATUS]`, atau `[PERLU_KONFIRMASI_TRANSISI]`.
9. **Aturan Output Konten Bersih**: Isi file `04_workflow_diagram.puml` harus berisi HANYA konten final diagram PlantUML yang bersih dan siap dipakai. Jangan menyisipkan instruksi kerja, analisis sementara, checklist, atau komentar non-esensial yang membuat file target bising.
10. **Pencantuman Referensi di Bagian Penutup**: Karena file target berformat PlantUML, cantumkan keterangan referensi yang digunakan dalam bentuk komentar PlantUML di bagian penutup diagram agar file tetap valid. Cantumkan hanya file yang benar-benar dipakai.
11. **Konsistensi Nama dengan Dokumen Referensi**: Nama aktivitas, status, layanan, modul, dan entitas harus mengikuti istilah yang sudah mapan pada BRD, SRS, dan Use Case Diagram. Jika ada istilah ganda yang mirip, pilih istilah yang paling kuat dan paling konsisten di referensi.
12. **Aturan Khusus Workflow Diagram**: Workflow diagram harus menampilkan alur kerja proses, urutan aktivitas, percabangan keputusan, dan perubahan status yang logis. Jangan mengubahnya menjadi use case diagram, ERD, sequence diagram, atau pseudo-source-code.
13. **Aturan Khusus PlantUML**: File HARUS valid sebagai PlantUML, minimal memiliki pembuka `@startuml` dan penutup `@enduml`. Gunakan sintaks activity/workflow yang benar agar dapat langsung dirender.
14. **(Poin Tambahan) Prioritaskan Alur Inti dan Alur Bernilai Tinggi**: Jika referensi memuat sangat banyak proses, prioritaskan alur yang paling kritis dan paling berdampak terhadap desain sistem berikutnya, misalnya transaksi percetakan, job tracking, pembayaran DP/pelunasan, pengurangan stok, retur/pembatalan, serta alur yang melibatkan validasi penting.
15. **(Poin Tambahan) Pisahkan Alur Jika Terlalu Padat**: Jika satu diagram menjadi terlalu penuh, kelompokkan alur secara masuk akal dalam diagram yang tetap satu file namun terstruktur jelas, misalnya per domain proses atau per modul utama, tanpa menghilangkan keterhubungan logis.
16. **(Poin Tambahan) Bedakan Aktivitas Manual vs Respons Sistem Jika Memang Penting**: Jika referensi cukup kuat, bedakan langkah yang dilakukan pengguna/peran dengan langkah yang dieksekusi sistem, agar diagram lebih informatif untuk fase desain dan implementasi berikutnya.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)
Anggap panduan ini akan dibaca oleh junior programmer atau AI model yang lebih murah dan akan langsung mengimplementasikan file target. Lakukan langkah-langkah berikut secara berurutan tanpa deviasi:

1. **Langkah 1: Baca Semua Referensi Wajib Sampai Tuntas**
   - Baca keseluruhan isi `docs/sdlc/02_analysis/01_business_requirements.md`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/02_software_requirements.md`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/03_use_case_diagram.puml`.
   - Jangan mulai menulis diagram sebelum tiga file ini selesai dibaca penuh.

2. **Langkah 2: Tentukan Apakah `narasi.txt` Masih Diperlukan**
   - Evaluasi apakah BRD, SRS, dan Use Case Diagram sudah cukup untuk menjawab hal berikut:
     - urutan kerja proses yang perlu dimodelkan,
     - perpindahan status yang relevan,
     - keputusan/cabang proses yang penting,
     - pihak yang menjalankan langkah tertentu,
     - interaksi sistem yang wajib muncul.
   - Jika masih ada kekosongan konteks operasional, baca `docs/sdlc/narasi.txt`.
   - Jika ternyata semua informasi sudah cukup dari tiga referensi utama, jangan gunakan `narasi.txt`.

3. **Langkah 3: Tentukan Cakupan Workflow Diagram**
   - Jangan mencoba memasukkan seluruh isi bisnis ke dalam satu alur yang kacau.
   - Identifikasi alur mana yang paling layak dimodelkan sebagai workflow utama pada fase analisis.
   - Minimal pertimbangkan alur-alur yang paling kuat disebut pada referensi, seperti:
     - transaksi percetakan,
     - pembayaran DP dan pelunasan,
     - job tracking dari antri sampai diambil,
     - pengurangan stok/HPP jika relevan secara proses,
     - pembatalan pesanan atau retur bila alurnya cukup jelas.
   - Jika suatu alur tidak memiliki urutan langkah yang cukup jelas, jangan dipaksakan masuk tanpa placeholder klarifikasi.

4. **Langkah 4: Ekstraksi Aktivitas Kandidat**
   - Buat daftar aktivitas dari referensi dengan urutan logis.
   - Gunakan nama aktivitas berbasis tindakan yang jelas, misalnya "Mencatat Pesanan", "Memvalidasi Pembayaran DP", "Memperbarui Status Pesanan", "Mencatat Pengambilan Barang".
   - Jangan gunakan nama aktivitas yang terlalu teknis seperti nama tabel, nama fungsi internal, atau nama variabel program.

5. **Langkah 5: Ekstraksi Keputusan dan Kondisi Penting**
   - Cari percabangan proses yang benar-benar punya dasar kuat dari referensi.
   - Contoh keputusan yang mungkin relevan jika didukung referensi:
     - apakah pembayaran DP atau lunas,
     - apakah status pesanan sudah masuk tahap tertentu,
     - apakah pembatalan masih boleh diproses,
     - apakah retur masih dalam batas waktu,
     - apakah saldo akun di bawah ambang minimum.
   - Jangan membuat node keputusan hanya untuk mempercantik diagram. Setiap keputusan harus bermakna.

6. **Langkah 6: Tentukan Status dan Transisi yang Konsisten**
   - Untuk proses pesanan percetakan, cek status yang sudah disebut eksplisit pada referensi, seperti `Antri`, `Proses Desain`, `Produksi`, `Selesai`, `Diambil`.
   - Jangan mengubah nama status tanpa alasan kuat.
   - Jika ada kebutuhan status antara yang belum jelas dari referensi, gunakan placeholder klarifikasi.

7. **Langkah 7: Petakan Peran atau Swimlane Jika Memang Diperlukan**
   - Tentukan apakah diagram perlu memisahkan aktivitas berdasarkan pelaku, misalnya Pemilik, Karyawan, atau Sistem.
   - Jika pemisahan pelaku membuat alur lebih jelas dan referensi cukup kuat, gunakan pendekatan yang sesuai dalam PlantUML.
   - Jika referensi tidak cukup untuk memetakan setiap aktivitas ke pelaku tertentu, jangan mengarang. Lebih aman gunakan alur proses umum daripada swimlane palsu.

8. **Langkah 8: Susun Urutan Alur Utama Terlebih Dahulu**
   - Tulis dulu satu alur utama dari awal sampai akhir.
   - Pastikan urutannya logis, tidak melompat, dan tidak ada langkah yang bertentangan dengan referensi.
   - Setelah alur utama stabil, baru tambahkan cabang alternatif seperti pembatalan, retur, atau kondisi khusus lainnya.

9. **Langkah 9: Saring Detail yang Tidak Relevan**
   - Hapus detail yang lebih cocok untuk dokumen lain, misalnya:
     - struktur tabel database,
     - detail JWT/bcrypt,
     - parameter library,
     - detail query SQL,
     - detail implementasi fungsi Python.
   - Pertahankan hanya detail yang membantu pembaca memahami bagaimana proses bisnis dan sistem berjalan.

10. **Langkah 10: Tentukan Bentuk Diagram PlantUML yang Paling Tepat**
   - Gunakan sintaks PlantUML yang valid untuk activity/workflow diagram.
   - Pastikan diagram memiliki titik mulai yang jelas.
   - Pastikan setiap cabang keputusan kembali ke alur yang logis atau berakhir dengan jelas.
   - Pastikan diagram memiliki titik akhir yang jelas untuk tiap jalur utama yang selesai.

11. **Langkah 11: Tulis Konten Final ke File PlantUML**
   - Isi file `docs/sdlc/02_analysis/04_workflow_diagram.puml` dengan konten PlantUML final.
   - File harus dimulai dengan `@startuml`.
   - Tulis alur utama, aktivitas, keputusan, dan transisi secara rapi.
   - Jika perlu, tambahkan judul diagram dan pengelompokan visual yang tetap valid dalam PlantUML.
   - Tambahkan keterangan referensi yang digunakan dalam komentar PlantUML di bagian penutup sebelum `@enduml`.
   - File harus diakhiri dengan `@enduml`.

12. **Langkah 12: Validasi Kelengkapan Alur**
   - Cocokkan kembali workflow diagram dengan BRD, SRS, dan Use Case Diagram.
   - Pastikan alur yang dibuat benar-benar merepresentasikan proses penting yang menjadi fokus dokumen ini.
   - Pastikan tidak ada langkah penting yang hilang pada alur utama.

13. **Langkah 13: Validasi Konsistensi Terminologi**
   - Periksa nama aktivitas, keputusan, status, dan label satu per satu.
   - Pastikan penamaan konsisten dengan istilah yang sudah ada di BRD, SRS, dan Use Case Diagram.
   - Jika ada istilah ganda yang berbeda tapi maknanya sama, pilih satu istilah yang paling mapan lalu gunakan konsisten.

14. **Langkah 14: Validasi Anti-Halusinasi**
   - Tinjau setiap aktivitas dan setiap cabang.
   - Untuk setiap elemen, tanyakan: "Apakah ini punya dasar kuat dari referensi?"
   - Jika jawabannya ragu, hapus elemen itu atau ganti dengan placeholder klarifikasi yang eksplisit.

15. **Langkah 15: Validasi Kebersihan Output**
   - Pastikan file target hanya berisi isi diagram final yang bersih.
   - Jangan tinggalkan instruksi kerja, checklist, hasil analisis mentah, atau komentar diskusi internal.
   - Hasil akhir harus siap dipakai secara profesional sebagai referensi fase SDLC berikutnya.

16. **Langkah 16: Validasi Kelayakan untuk Dokumen Turunan**
   - Pastikan workflow diagram cukup kuat untuk dijadikan acuan oleh dokumen fase berikutnya.
   - Secara khusus, cek apakah diagram ini akan membantu penyusunan:
     - `database schema`,
     - `system architecture`,
     - `CLI interaction flow`,
     - `access control matrix`,
     - spesifikasi implementasi modul transaksi dan job tracking.
   - Jika belum cukup informatif untuk dokumen turunan tersebut, revisi sampai alur utama dan keputusan penting benar-benar jelas.
