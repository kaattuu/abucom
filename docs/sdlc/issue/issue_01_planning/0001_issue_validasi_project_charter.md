# Issue: Validasi Dokumen Utama - 01 Project Charter

## Deskripsi Issue
Dokumen `01_project_charter.md` saat ini memiliki status `[validasi]`. Issue ini bertujuan untuk melakukan pemeriksaan, analisa, dan validasi yang ketat terhadap dokumen tersebut sebelum dapat diproses ke fase tahapan SDLC selanjutnya. Pekerjaan ini menuntut ketelitian tinggi, pemahaman konteks bisnis, serta kemampuan menghasilkan dokumen standar industri yang berkualitas.

## Instruksi Perencanaan (Planning)

Terapkan instruksi berikut secara berurutan dan menyeluruh:

1. **Persona**: Terapkan persona sebagai seorang **Senior IT Project Manager** dan **System Analyst** yang berpengalaman, teliti, kritis, dan berorientasi pada kualitas. Anda bertanggung jawab penuh atas kelayakan Project Charter ini sebagai fondasi utama keseluruhan proyek.
2. **Komparasi Mendalam**: Lakukan komparasi mendalam antara dokumen `docs/sdlc/01_planning/01_project_charter.md` dengan file referensi utama, khususnya `docs/sdlc/narasi.txt`.
3. **Pemeriksaan Kelengkapan Data**: Periksa, analisa, dan validasi kembali apakah dokumen ini sudah merangkum semua data dan informasi penting yang ada di dalam file referensi. Pastikan tidak ada detail krusial yang terlewat.
4. **Fokus dan Relevansi (Separation of Concern)**: Pastikan dokumen ini hanya mengambil dan merangkum data dan informasi yang memang dibutuhkan spesifik untuk Project Charter. Buang informasi teknis atau detail operasional yang tidak relevan agar dokumen tetap bersih dan fokus pada tujuan utamanya (High-level overview).
5. **Standar Industri**: Pastikan struktur dokumen `01_project_charter.md` sesuai dengan standar dokumen praktik industri sesungguhnya (Lengkap, sistematis, dan informatif).
6. **Kelayakan sebagai Referensi SDLC**: Validasi apakah isi dokumen ini sudah layak dan solid untuk dijadikan acuan pasti (input utama) bagi dokumen-dokumen di fase tahapan SDLC selanjutnya.
7. **Kualitas Bahasa**: Gunakan struktur Bahasa Indonesia yang natural, baku, tidak ambigu, tidak membingungkan, dan mudah dipahami, sehingga dapat diimplementasikan dengan mudah oleh junior programmer atau dieksekusi oleh LLM model AI lain yang lebih murah tanpa misinterpretasi.
8. **Kejelasan Absolut**: Pastikan kualitas kelengkapan isi dari Project Charter ini bersifat final dan tegas, sehingga tidak akan menimbulkan pertanyaan berulang atau interupsi yang dapat menghambat proses SDLC di tahap berikutnya.
9. **Pengisian Data Kosong**: Analisa apakah ada bagian data yang masih kosong, tidak tersedia, atau mengandalkan pengisian manual (misalnya placeholder seperti `[ISI_DISINI]`). Jika ada, **isilah data tersebut** dengan informasi yang sesuai, masuk akal, dan relevan, selama masih berada dalam ruang lingkup dokumen Project Charter.
10. **Eksekusi dan Versioning**: Tuangkan semua hasil temuan dan perbaikan secara langsung ke dalam file `docs/sdlc/01_planning/01_project_charter.md` yang berstatus `[validasi]`. Pastikan Anda merubah/menaikkan versi dokumen di dalam isinya sebagai tanda bahwa dokumen ini telah melalui proses revisi dan validasi.
11. **Daftar Referensi**: Jika dalam perbaikan ini Anda menggunakan file referensi (seperti `narasi.txt`), pastikan file referensi tersebut ditambahkan di bagian akhir/baris paling bawah dari dokumen `01_project_charter.md`.

**Instruksi Tambahan (Spesifik untuk Project Charter):**
12. **Elemen Kunci Charter**: Validasi secara khusus keberadaan dan kejelasan elemen kunci Project Charter: Tujuan Proyek (Project Purpose), Sasaran Proyek (Objectives/SMART Goals), Ruang Lingkup Level Tinggi (High-level Scope), Pemangku Kepentingan Utama (Key Stakeholders), Asumsi dan Kendala (Assumptions and Constraints), serta Estimasi Anggaran/Waktu level tinggi.
13. **Keselarasan Bisnis**: Pastikan Business Case dan objektif yang tertulis sangat selaras dengan masalah atau kebutuhan bisnis yang dijabarkan dalam `narasi.txt`.

---

## Tahapan Implementasi (Low-Level Execution Steps)
*(Bagian ini ditujukan sebagai panduan eksekusi step-by-step bagi Junior Programmer atau LLM Agent yang lebih murah)*

**Langkah 1: Inisialisasi dan Penyerapan Konteks**
- Aktifkan persona (System prompt) Anda sebagai Senior IT Project Manager.
- Buka dan baca dengan saksama seluruh isi file referensi `docs/sdlc/narasi.txt`. Pahami tujuan bisnis, masalah yang ingin dipecahkan, dan ruang lingkup utamanya.

**Langkah 2: Audit Dokumen Saat Ini**
- Buka dan baca secara penuh isi file `docs/sdlc/01_planning/01_project_charter.md`.
- Bandingkan setiap bagian di Project Charter dengan informasi dari `narasi.txt`.
- Lakukan inspeksi visual: cari placeholder kosong (seperti `<isi disini>`, `[...]`, `TBD`).

**Langkah 3: Revisi Konten (Drafting Perbaikan)**
- Modifikasi isi dari file `01_project_charter.md`.
- Hapus kalimat ambigu, perbaiki tata bahasa agar sesuai EYD baku bahasa Indonesia yang formal.
- Apabila menemukan data kosong atau placeholder, analisis `narasi.txt` untuk mendapatkan nilainya. Jika detail spesifik tidak ada di `narasi.txt`, hasilkan data dummy yang paling logis dan realistis menyesuaikan konteks, lalu lengkapi.
- Validasi apakah bagian "Tujuan", "Ruang Lingkup", dan "Stakeholders" sudah sangat jelas batasannya.

**Langkah 4: Restrukturisasi dan Formatting (Standar Industri)**
- Pastikan penggunaan hierarki heading (Markdown `#`, `##`, `###`) konsisten.
- Gunakan format tabel atau list (bullet) untuk data terstruktur agar mudah dipindai oleh pembaca.
- Ubah versi dokumen pada bagian metadata atau history dokumen (misalnya naikkan versinya dan perbarui tanggal rilis menjadi saat validasi dilakukan).

**Langkah 5: Penambahan Referensi dan Finalisasi**
- Arahkan ke baris paling bawah dari file `01_project_charter.md`.
- Tambahkan bagian referensi baru dengan format:
  ```markdown
  ## Referensi Dokumen
  - `docs/sdlc/narasi.txt`
  ```
- Timpa (overwrite) isi file `docs/sdlc/01_planning/01_project_charter.md` secara keseluruhan dengan hasil revisi akhir. Pastikan Anda tidak mengubah atau merusak file lain dalam proses ini.
