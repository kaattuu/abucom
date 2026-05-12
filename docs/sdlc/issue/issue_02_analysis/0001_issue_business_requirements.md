# Issue: Pembuatan Business Requirements Document (BRD)

## Deskripsi Tugas
Tugas ini bertujuan untuk menyusun dokumen utama `01_business_requirements.md` yang berada di dalam folder `docs/sdlc/02_analysis/`. Dokumen ini saat ini berstatus `[create_file]` dan merupakan landasan analisis bisnis untuk proyek pengembangan perangkat lunak yang akan dijalankan.

## Persona Implementasi
Bertindaklah sebagai **Senior Business Analyst / Lead System Analyst** yang memiliki pengalaman mendalam dalam menganalisis kebutuhan bisnis, menerjemahkan visi klien menjadi kebutuhan sistemik, dan merancang spesifikasi bisnis skala enterprise. Anda sangat analitis, terstruktur, berorientasi pada detail, dan mampu mengekstrak informasi kompleks dari narasi atau dokumen tingkat tinggi (high-level) menjadi Business Requirements Document (BRD) formal yang standar, komprehensif, padat, dan jelas.

## File Referensi Utama
Dalam pembuatan dokumen ini, Anda **DIWAJIBKAN** untuk merujuk pada file berikut sebagai sumber data dan informasi utama:
1. `docs/sdlc/narasi.txt`
2. `docs/sdlc/01_planning/01_project_charter.md`

*(Catatan: Ekstrak seluruh informasi yang relevan dari dokumen di atas secara teliti. Jika ada file referensi lain yang sebelumnya disebutkan namun sudah tidak relevan, abaikan dan fokus pada referensi ini).*

## Instruksi Kelayakan & Kriteria Dokumen Utama
Harap patuhi instruksi berikut secara ketat saat menyusun isi dari dokumen `01_business_requirements.md`:

1. **Ekstraksi Spesifik & Terfokus:** Ambil dan rangkum HANYA data dan informasi dari file referensi yang spesifik dan dibutuhkan untuk menyusun *Business Requirements Document* (misal: proses bisnis saat ini, kebutuhan proses bisnis baru, aturan bisnis/business rules, fungsionalitas utama yang diharapkan, dan Key Performance Indicators (KPI)). Singkirkan detail teknis implementasi (seperti bahasa pemrograman atau skema database) agar dokumen tetap fokus pada domain bisnis.
2. **Kelengkapan & Rangkuman Menyeluruh:** Rangkum seluruh data dan informasi yang ada di file referensi. Jangan sampai ada detail penting setiap entitas, fitur operasional, atau aturan fungsional yang terlewat.
3. **Standar Struktur Industri:** Gunakan kerangka standar *Business Requirements Document* (BRD) profesional. Dokumen minimal harus memiliki bagian:
   - Pendahuluan dan Tujuan Dokumen
   - Deskripsi Proses Bisnis Saat Ini (As-Is) vs Harapan (To-Be)
   - Kebutuhan Bisnis Fungsional Utama (High-level Functional Requirements)
   - Kebutuhan Non-Fungsional dari sisi Bisnis (Keamanan, Kinerja, Skalabilitas)
   - Aturan Bisnis (*Business Rules*)
   - Kriteria Penerimaan (*Acceptance Criteria* Tingkat Bisnis)
4. **Kualitas Acuan Antar-Fase:** Pastikan isi dokumen ini sangat solid, lengkap, dan informatif sehingga mutlak layak dijadikan input atau referensi utama untuk pembuatan dokumen di fase SDLC selanjutnya (seperti Software Requirements atau Use Case Diagram). Kualitas kelengkapan isinya tidak boleh dipertanyakan, tidak ambigu, dan tidak memicu interupsi pengerjaan fase berikutnya.
5. **Gaya Bahasa:** Gunakan struktur Bahasa Indonesia yang baku, natural, profesional, tidak ambigu, tidak membingungkan, dan mudah dipahami oleh junior programmer atau sistem AI lainnya. Gunakan kalimat yang spesifik dan terukur.
6. **Penandaan Data Kosong:** Jika ada elemen spesifik yang informasinya **tidak tersedia** di dalam file referensi (misalnya ada fitur yang disebutkan tapi aturannya tidak dijelaskan), JANGAN berhalusinasi mengarang data. Berikan tanda yang sangat jelas dengan format: `[PERLU DIISI MANUAL: (Deskripsi data yang kurang/harus dikonfirmasi ke stakeholder)]`.
7. **Hasil Akhir (Konten Bersih):** Tulis **HANYA** konten akhir dokumen yang bersih ke dalam file target `01_business_requirements.md`. Jangan menyertakan sisa instruksi pengerjaan, proses pemikiran (thought process), atau komentar tambahan agar dokumen siap digunakan secara profesional.
8. **Catatan Referensi:** Pada bagian akhir di baris paling bawah dokumen, tambahkan keterangan file referensi yang digunakan persis seperti format berikut:
   ```markdown
   ---
   **Referensi Utama:** Dokumen ini disusun berdasarkan ekstraksi data dari file `docs/sdlc/narasi.txt` dan `docs/sdlc/01_planning/01_project_charter.md`.
   ```
9. **(Poin Tambahan) Penggunaan Visual/Tabel:** Gunakan tabel untuk mendaftar *Business Rules* atau matriks perbandingan *As-Is* vs *To-Be* agar lebih mudah dibaca dan dipetakan oleh tim pengembang selanjutnya. Manfaatkan format Markdown sebaik-baiknya.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)
Anggap panduan ini dibaca oleh entitas yang akan langsung mengimplementasikan (Junior Programmer / LLM AI). Lakukan langkah-langkah eksekusi secara berurutan dan presisi tanpa halusinasi:

1. **Langkah 1: Analisis Konteks (Membaca Referensi)**
   - Gunakan *tool* pembaca file (seperti `view_file`) untuk membaca keseluruhan isi dari `docs/sdlc/narasi.txt` dan `docs/sdlc/01_planning/01_project_charter.md`.
   - Analisis secara mendalam masalah bisnis yang diselesaikan, entitas bisnis yang terlibat, dan fungsionalitas aplikasi yang disebutkan.

2. **Langkah 2: Ekstraksi, Filter, dan Kategorisasi Data**
   - Kumpulkan dan pisahkan informasi bisnis dari informasi teknis/manajemen proyek.
   - Kategorikan informasi bisnis ke dalam struktur BRD standar (Proses Bisnis, Kebutuhan Fungsional, Business Rules, dsb).
   - Pastikan informasi diekstrak menyeluruh, tidak ada fitur atau aturan operasional dari narasi yang terbuang.

3. **Langkah 3: Identifikasi Gap Informasi**
   - Periksa draf sementara Anda. Jika Anda menemukan bagian esensial seperti "Aturan Diskon" atau "Sanksi" tidak memiliki detail nominal/persentase di narasi, sisipkan tag `[PERLU DIISI MANUAL: Detail persentase/aturan pasti]`.

4. **Langkah 4: *Drafting* Dokumen Bersih**
   - Mulai tulis dokumen `01_business_requirements.md` secara utuh di memori Anda sesuai Persona "Senior Business Analyst".
   - Terapkan struktur Markdown yang rapi (headings, bullet points, tabel).
   - Pastikan instruksi atau proses berpikir Anda sendiri tidak masuk ke dalam hasil draf.

5. **Langkah 5: Penulisan ke File Target**
   - Gunakan *tool* untuk mengedit atau membuat konten file (seperti `write_to_file` atau `replace_file_content`).
   - Tulis (overwrite) isi file target `docs/sdlc/02_analysis/01_business_requirements.md` dengan draf akhir yang sudah Anda susun.
   - Jangan lupa menambahkan Footer Catatan Referensi di baris paling bawah.

6. **Langkah 6: Verifikasi Hasil Akhir**
   - Baca ulang struktur Markdown dari file target `01_business_requirements.md`.
   - Validasi: Apakah bahasanya sudah natural? Apakah bebas dari instruksi LLM? Apakah informasinya sudah akurat dari narasi saja? Jika ya, tugas implementasi selesai.
