# Issue: Pembuatan Dokumen Use Case Diagram

## Deskripsi Tugas
Tugas ini bertujuan untuk menyusun dokumen utama `03_use_case_diagram.puml` yang berada di dalam folder `docs/sdlc/02_analysis/`. Dokumen ini saat ini berstatus `[create_file]` dan harus menjadi representasi visual yang akurat, lengkap, serta mudah dipahami mengenai interaksi aktor terhadap sistem pada fase analisis.

## Persona Implementasi
Bertindaklah sebagai **Senior System Analyst**, **Senior Business Analyst**, dan **Senior UML/PlantUML Specialist** yang sangat kuat dalam pemetaan kebutuhan bisnis menjadi diagram use case yang presisi, rapi, tidak ambigu, dan layak pakai pada lingkungan proyek industri nyata. Anda harus mampu memilah informasi bisnis dan perangkat lunak, lalu mengubahnya menjadi use case diagram yang bersih, konsisten, dan valid secara notasi UML.

## File Referensi Utama
Dalam pembuatan dokumen ini, Anda **DIWAJIBKAN** untuk merujuk pada file berikut sebagai sumber data dan informasi utama:
1. `docs/sdlc/02_analysis/01_business_requirements.md`
2. `docs/sdlc/02_analysis/02_software_requirements.md`

Gunakan `docs/sdlc/narasi.txt` **hanya jika** setelah membaca dua referensi utama di atas masih ada detail aktor, tujuan interaksi, atau konteks operasional yang belum cukup jelas untuk memetakan use case secara akurat. Jika seluruh informasi sudah memadai dari BRD dan SRS, maka `narasi.txt` tidak perlu dipakai.

## Instruksi Kelayakan & Kriteria Dokumen Utama
Harap patuhi instruksi berikut secara ketat saat menyusun isi dari dokumen `03_use_case_diagram.puml`:

1. **Ekstraksi Aktor dan Tujuan Interaksi Secara Presisi**: Identifikasi seluruh aktor yang benar-benar berinteraksi dengan sistem berdasarkan referensi. Fokus pada pihak yang memiliki tujuan penggunaan sistem, seperti peran internal dan entitas eksternal yang relevan. Jangan menambahkan aktor yang tidak memiliki dasar jelas pada referensi.
2. **Hanya Ambil Informasi yang Relevan untuk Use Case Diagram**: Ambil dan rangkum HANYA data yang memang dibutuhkan untuk memetakan aktor, tujuan aktor, layanan sistem, relasi antar use case, serta batas sistem. Jangan memasukkan detail implementasi teknis tingkat rendah seperti struktur database, parameter library, konfigurasi environment, atau algoritma internal yang bukan ranah use case diagram.
3. **Rangkum Seluruh Informasi Penting Tanpa Ada yang Terlewat**: Pastikan semua kapabilitas sistem yang penting dari perspektif aktor tercermin di diagram. Jika ada fitur bisnis atau sistem yang penting namun tidak muncul di diagram, maka hasil dianggap belum lengkap.
4. **Standar Struktur Diagram Praktik Industri**: Diagram harus memakai struktur UML use case yang rapi, dengan komponen minimal berupa aktor, system boundary, use case bernama jelas, serta relasi yang tepat (`association`, `include`, `extend`) bila memang ada dasar yang kuat dari referensi.
5. **Kelayakan Sebagai Acuan Fase SDLC Selanjutnya**: Diagram ini harus layak dijadikan referensi utama bagi fase desain berikutnya, terutama untuk workflow diagram, system architecture, access control matrix, dan dokumen desain lainnya. Oleh karena itu, penamaan aktor dan use case wajib konsisten, stabil, dan tidak multitafsir.
6. **Bahasa Indonesia yang Natural dan Tegas**: Gunakan nama use case dan keterangan yang natural dalam Bahasa Indonesia, jelas, lugas, dan mudah dipahami oleh junior programmer atau AI model lain yang lebih murah. Hindari istilah yang kabur, terlalu umum, atau bercampur antara istilah bisnis dan istilah teknis secara sembarangan.
7. **Kelengkapan Tanpa Halusinasi**: Jangan mengarang aktor, skenario, atau relasi `include`/`extend` jika tidak ada dasar yang cukup pada referensi. Bila ada kebutuhan diagram yang penting namun informasinya tidak tersedia, beri penanda yang jelas untuk pengisian manual.
8. **Penandaan Data yang Belum Tersedia**: Jika ada aktor, nama proses, atau relasi yang seharusnya ada tetapi belum cukup jelas dari referensi, tandai secara eksplisit menggunakan placeholder yang mudah dikenali, misalnya: `[PERLU_KLARIFIKASI_AKTOR]`, `[PERLU_KLARIFIKASI_USE_CASE]`, atau `[PERLU_KONFIRMASI_RELASI]`.
9. **Aturan Output Konten Bersih**: Isi file `03_use_case_diagram.puml` harus berisi HANYA konten final diagram PlantUML yang bersih dan siap dipakai. Jangan menyisipkan instruksi kerja, catatan diskusi, proses berpikir, atau komentar non-esensial yang membuat file menjadi bising.
10. **Pencantuman Referensi di Bagian Penutup**: Karena file target berformat PlantUML, cantumkan keterangan referensi yang digunakan dalam bentuk komentar PlantUML di bagian penutup diagram agar file tetap valid. Tuliskan daftar file referensi yang benar-benar dipakai.
11. **Konsistensi Nama dengan Dokumen Referensi**: Nama aktor, layanan, dan istilah domain harus mengikuti istilah yang sudah mapan di BRD dan SRS. Jika ada dua istilah yang mirip, pilih yang paling dominan dan paling eksplisit disebut dalam referensi, lalu gunakan secara konsisten di seluruh diagram.
12. **Aturan Khusus Use Case Diagram**: Use case diagram harus menggambarkan tujuan pengguna terhadap sistem, bukan urutan langkah detail proses. Jadi, jangan menurunkan diagram menjadi pseudo-workflow atau pseudo-flowchart.
13. **Aturan Khusus PlantUML**: File HARUS valid sebagai PlantUML, minimal memiliki pembuka `@startuml` dan penutup `@enduml`. Gunakan deklarasi aktor, batas sistem, dan elemen use case secara sintaksis benar agar dapat langsung dirender tanpa perbaikan manual besar.
14. **(Poin Tambahan) Pengelompokan Use Case yang Masuk Akal**: Jika jumlah use case cukup banyak, kelompokkan penamaan dan penempatannya secara logis agar diagram tetap terbaca. Kelompokkan berdasarkan domain besar yang memang tercermin dalam referensi, misalnya transaksi, inventaris, keuangan, SDM, pelaporan, atau administrasi.
15. **(Poin Tambahan) Relasi Include/Extend Harus Konservatif**: Gunakan `include` hanya bila suatu use case memang selalu menjadi bagian wajib dari use case lain. Gunakan `extend` hanya bila sebuah perilaku benar-benar bersifat kondisi/opsional. Jika ragu dan referensi tidak cukup kuat, lebih aman gunakan asosiasi biasa daripada mengarang relasi khusus.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)
Anggap panduan ini akan dibaca oleh junior programmer atau AI model yang lebih murah dan akan langsung mengimplementasikan file target. Lakukan langkah-langkah berikut secara berurutan tanpa deviasi:

1. **Langkah 1: Baca Semua Referensi Wajib**
   - Baca keseluruhan isi `docs/sdlc/02_analysis/01_business_requirements.md`.
   - Baca keseluruhan isi `docs/sdlc/02_analysis/02_software_requirements.md`.
   - Jangan mulai menggambar diagram sebelum dua file ini selesai dianalisis penuh.

2. **Langkah 2: Tentukan Apakah `narasi.txt` Masih Diperlukan**
   - Evaluasi apakah BRD dan SRS sudah cukup untuk menjawab tiga hal berikut:
     - siapa saja aktor yang berinteraksi dengan sistem,
     - tujuan utama masing-masing aktor,
     - layanan sistem apa saja yang benar-benar dibutuhkan.
   - Jika masih ada kekosongan konteks, baru baca `docs/sdlc/narasi.txt`.
   - Jika BRD dan SRS sudah cukup, jangan gunakan `narasi.txt` agar referensi tetap fokus dan tidak melebar.

3. **Langkah 3: Ekstraksi Aktor**
   - Buat daftar seluruh aktor yang benar-benar menggunakan atau berinteraksi dengan sistem.
   - Pisahkan aktor internal dan aktor eksternal.
   - Jangan otomatis menjadikan semua entitas bisnis sebagai aktor. Suatu entitas hanya boleh menjadi aktor jika ia benar-benar memiliki interaksi/tujuan terhadap sistem.
   - Jika suatu peran tampak mirip dengan peran lain, cek apakah perlu digabung atau dipisah berdasarkan referensi. Jangan memecah aktor tanpa dasar.

4. **Langkah 4: Ekstraksi Kandidat Use Case**
   - Dari BRD dan SRS, kumpulkan semua layanan sistem yang dinyatakan sebagai kebutuhan atau kemampuan sistem.
   - Ubah layanan tersebut menjadi nama use case yang berbasis tujuan aktor, misalnya menggunakan pola frasa kerja yang jelas seperti "Mencatat Transaksi", "Mengelola Stok", "Memantau Saldo PPOB", atau padanan lain yang lebih akurat sesuai referensi.
   - Hindari nama use case yang terlalu teknis seperti nama tabel, nama modul internal, atau istilah implementasi yang tidak dimengerti pengguna bisnis.

5. **Langkah 5: Saring dan Fokuskan Use Case**
   - Periksa kembali setiap kandidat use case.
   - Hapus item yang sebenarnya hanya sub-langkah teknis, validasi internal, detail UI/CLI, atau detail algoritmik.
   - Pertahankan hanya interaksi bernilai bisnis/sistem yang memang relevan untuk diagram use case.

6. **Langkah 6: Petakan Relasi Aktor ke Use Case**
   - Hubungkan setiap aktor ke use case yang memang menjadi tujuannya.
   - Pastikan setiap hubungan memiliki dasar eksplisit atau implisit yang kuat dari referensi.
   - Jangan menghubungkan semua aktor ke semua use case. Hubungan harus selektif dan logis.

7. **Langkah 7: Tentukan `include` dan `extend` dengan Disiplin**
   - Cek apakah ada use case yang selalu membutuhkan use case lain agar selesai. Jika ya, pertimbangkan `include`.
   - Cek apakah ada perilaku tambahan yang hanya muncul pada kondisi tertentu. Jika ya, pertimbangkan `extend`.
   - Jika hubungan khusus ini tidak benar-benar jelas dari referensi, jangan dipaksakan. Gunakan asosiasi biasa.

8. **Langkah 8: Susun Batas Sistem**
   - Buat satu system boundary yang mewakili aplikasi yang sedang dianalisis.
   - Tempatkan seluruh use case di dalam boundary tersebut.
   - Tempatkan aktor di luar boundary.
   - Beri nama system boundary dengan nama sistem yang konsisten dengan BRD/SRS.

9. **Langkah 9: Susun Struktur Diagram yang Terbaca**
   - Kelompokkan use case berdasarkan domain besar agar diagram tidak berantakan.
   - Atur posisi elemen agar relasi tidak saling bertumpuk berlebihan.
   - Jika diagram menjadi terlalu padat, tetap prioritaskan keterbacaan tanpa menghilangkan use case penting.

10. **Langkah 10: Tulis Konten Final ke File PlantUML**
   - Isi file `docs/sdlc/02_analysis/03_use_case_diagram.puml` dengan konten PlantUML final.
   - File harus dimulai dengan `@startuml`.
   - Definisikan aktor, system boundary, use case, dan relasi secara valid.
   - File harus diakhiri dengan `@enduml`.
   - Tambahkan keterangan referensi dalam komentar PlantUML di bagian penutup sebelum `@enduml`, hanya berisi file yang benar-benar digunakan.

11. **Langkah 11: Validasi Kelengkapan Konten**
   - Cocokkan kembali diagram dengan BRD dan SRS.
   - Pastikan seluruh area kebutuhan penting telah terwakili, minimal mencakup domain yang memang disebut kuat pada referensi seperti transaksi, stok/inventaris, job tracking, keuangan/PPOB, SDM/penggajian, pelaporan, hak akses, dan data entitas jika memang muncul sebagai interaksi aktor.
   - Jika ada domain yang jelas ada di referensi tetapi belum terwakili, revisi diagram.

12. **Langkah 12: Validasi Kualitas Bahasa dan Notasi**
   - Periksa nama aktor dan use case satu per satu.
   - Pastikan tidak ada istilah ambigu, tidak ada campuran istilah yang inkonsisten, dan tidak ada penamaan yang terlalu teknis untuk use case.
   - Pastikan sintaks PlantUML valid dan tidak ada elemen yang rusak.

13. **Langkah 13: Validasi Anti-Halusinasi**
   - Tinjau setiap aktor, use case, dan relasi.
   - Untuk setiap elemen, tanyakan: "Apakah elemen ini punya dasar dari referensi?"
   - Jika jawabannya tidak yakin, hapus atau ganti dengan placeholder klarifikasi yang jelas.

14. **Langkah 14: Final Check Output Bersih**
   - Pastikan file target hanya berisi isi diagram final.
   - Jangan tinggalkan checklist kerja, komentar instruksi, hasil analisis sementara, atau catatan diskusi internal.
   - Hasil akhir harus siap dijadikan referensi profesional untuk fase SDLC berikutnya tanpa perlu dibersihkan ulang.
