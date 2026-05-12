# Issue: Pembuatan Project Charter

## Deskripsi Tugas
Tugas ini bertujuan untuk menyusun dokumen utama `01_project_charter.md` yang berada di dalam folder `docs/sdlc/01_planning/`. Dokumen ini saat ini berstatus `[create_file]` dan merupakan landasan inisiasi fundamental untuk proyek pengembangan perangkat lunak yang akan dijalankan.

## Persona Implementasi
Bertindaklah sebagai **Senior Project Manager / Lead Business Analyst** yang memiliki pengalaman lebih dari 10 tahun dalam merancang, menginisiasi, dan mengelola siklus hidup pengembangan perangkat lunak (SDLC) skala enterprise. Anda sangat analitis, terstruktur, berorientasi pada detail, dan mampu menerjemahkan kebutuhan bisnis (business requirements) atau narasi tidak terstruktur menjadi dokumen formal yang standar, komprehensif, padat, dan jelas.

## File Referensi Utama
Dalam pembuatan dokumen ini, Anda **DIWAJIBKAN** untuk merujuk pada file berikut sebagai sumber data dan informasi utama:
- `docs/sdlc/narasi.txt`

*(Catatan: Ekstrak seluruh informasi yang relevan dari `narasi.txt` secara teliti. Jika ada file referensi lain yang sebelumnya disebutkan namun sudah tidak relevan, abaikan dan fokus pada narasi ini).*

## Instruksi Kelayakan & Kriteria Dokumen Utama
Harap patuhi instruksi berikut secara ketat saat menyusun isi dari dokumen `01_project_charter.md`:

1. **Ekstraksi Spesifik & Terfokus:** Ambil dan rangkum HANYA data dan informasi dari file referensi yang spesifik dan dibutuhkan untuk menyusun *Project Charter* (misal: latar belakang masalah, tujuan bisnis, cakupan awal, target pengguna). Singkirkan detail yang tidak relevan dengan inisiasi tingkat tinggi (high-level) agar dokumen tetap fokus.
2. **Kelengkapan & Rangkuman Menyeluruh:** Rangkum seluruh informasi yang ada di file referensi. Jangan sampai ada detail penting (seperti entitas bisnis, alur utama, atau batasan) yang terlewat.
3. **Standar Struktur Industri:** Gunakan kerangka standar Project Charter profesional. Dokumen minimal harus memiliki bagian:
   - Nama & Deskripsi Proyek
   - Latar Belakang & Tujuan Bisnis
   - Ruang Lingkup Proyek (*In-Scope* & *Out-of-Scope*)
   - Target Pengguna / Pemangku Kepentingan (*Stakeholders*)
   - Kriteria Kesuksesan (*Success Criteria*)
   - Asumsi, Kendala & Risiko Tingkat Tinggi
4. **Kualitas Acuan Antar-Fase:** Pastikan isi dokumen ini sangat solid, lengkap, dan informatif sehingga mutlak layak dijadikan input atau referensi utama untuk pembuatan dokumen di fase SDLC selanjutnya (seperti fase Analisis atau Desain). Kualitasnya tidak boleh memicu keraguan, interupsi, atau pertanyaan berulang di masa depan.
5. **Gaya Bahasa:** Gunakan Bahasa Indonesia yang baku, natural, profesional, tidak ambigu, dan mudah dipahami oleh junior programmer atau sistem AI lainnya. Gunakan kalimat aktif dan langsung pada intinya (straightforward).
6. **Penandaan Data Kosong:** Jika ada elemen standar Project Charter yang informasinya **tidak tersedia** di dalam file referensi, JANGAN berhalusinasi mengarang data. Berikan tanda yang sangat jelas dengan format: `[PERLU DIISI MANUAL: (Deskripsi data yang kurang)]`.
7. **Hasil Akhir (Konten Bersih):** Tulis **HANYA** konten dokumen jadi ke dalam file target `01_project_charter.md`. Jangan menyertakan sisa instruksi, basa-basi pembuka/penutup, proses pemikiran (thought process), atau komentar tambahan.
8. **Catatan Referensi:** Pada baris paling bawah dokumen, tambahkan keterangan file referensi persis seperti format berikut:
   ```markdown
   ---
   **Referensi Utama:** Dokumen ini disusun berdasarkan ekstraksi data dari file `docs/sdlc/narasi.txt`.
   ```
9. **(Poin Tambahan) Format Markdown:** Manfaatkan elemen Markdown secara maksimal (Heading terstruktur, bullet points, numbering, tabel, dan cetak tebal/miring untuk penekanan) guna memudahkan tingkat keterbacaan (readability) secara visual.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)
Anggap panduan ini dibaca oleh entitas yang akan langsung mengimplementasikan (Junior Programmer / LLM AI). Lakukan langkah-langkah eksekusi secara berurutan dan presisi:

1. **Langkah 1: Analisis Konteks (Membaca Referensi)**
   - Gunakan *tool* pembaca file (seperti `view_file` atau `cat`) untuk membaca keseluruhan isi dari `docs/sdlc/narasi.txt`.
   - Pahami secara utuh: Apa masalah yang dihadapi klien? Sistem apa yang ingin dibangun? Siapa yang akan menggunakannya?

2. **Langkah 2: Ekstraksi dan Kategorisasi Data**
   - Pilah teks dari `narasi.txt` dan cocokkan dengan bagian-bagian struktur standar Project Charter (Latar Belakang, Tujuan, Ruang Lingkup, Stakeholders).
   - Jangan menyalin mentah-mentah (copy-paste), melainkan formulasikan ulang (rephrase) menjadi bahasa dokumen spesifikasi proyek formal.

3. **Langkah 3: Identifikasi Gap (Celah Informasi)**
   - Periksa draf sementara Anda. Jika Anda menemukan bagian esensial seperti "Kendala Waktu/Anggaran" atau "Risiko" tidak disebutkan sama sekali di narasi, sisipkan tag `[PERLU DIISI MANUAL: Informasi Anggaran dan Jadwal Proyek]`.

4. **Langkah 4: *Drafting* Dokumen Bersih**
   - Mulai tulis dokumen `01_project_charter.md` secara utuh di memori Anda sesuai Persona "Senior Project Manager".
   - Pastikan tidak ada instruksi pengerjaan ini yang ikut terbawa ke draf.

5. **Langkah 5: Penulisan ke File Target**
   - Gunakan *tool* untuk mengedit atau membuat konten file (seperti `write_to_file` atau `replace_file_content`).
   - Timpa (overwrite) isi file target `docs/sdlc/01_planning/01_project_charter.md` dengan draf bersih yang sudah Anda buat. (Catatan: Hapus teks placeholder bawaan file tersebut jika ada).
   - Jangan lupa menyertakan Footer Catatan Referensi di baris paling akhir dokumen.

6. **Langkah 6: Verifikasi Hasil Akhir**
   - Baca ulang struktur Markdown dari file target `01_project_charter.md`.
   - Validasi: Apakah sudah 100% berbahasa Indonesia yang baik? Apakah sudah benar-benar bebas dari proses berpikir LLM? Jika ya, tugas selesai.
