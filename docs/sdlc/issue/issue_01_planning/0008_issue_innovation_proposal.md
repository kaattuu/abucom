# Issue: Pembuatan Dokumen Innovation Proposal (05_innovation_proposal.md)

## Deskripsi Tugas
Anda ditugaskan untuk membuat dokumen **Innovation Proposal** (`05_innovation_proposal.md`) yang merupakan bagian dari fase Perencanaan (Planning) dalam siklus SDLC. Dokumen ini saat ini memiliki status `[create_file]`. Tujuan Anda adalah menyusun dokumen proposal inovasi (*Innovation & Best Practice Proposal*) yang terstruktur, komprehensif, dan siap digunakan secara profesional — yang mendokumentasikan secara resmi seluruh **usulan fitur tambahan, perbaikan alur kerja, dan penerapan standar industri** yang belum disebutkan secara eksplisit oleh pemilik usaha namun secara signifikan dapat meningkatkan kualitas sistem, efisiensi operasional, dan perlindungan data.

Dokumen ini merupakan pemenuhan **Mandat Inovasi** yang tercantum pada narasi pemilik usaha (baris 98 narasi.txt) dan Modul ke-20 pada Project Charter (Modul "Inovasi & Best Practice Industri"), yang mewajibkan tim AI pengembang untuk secara aktif menganalisis standar industri percetakan dan retail modern, kemudian mengusulkan peningkatan yang relevan.

## 1. Persona yang Digunakan
**Bertindaklah sebagai "Senior Innovation Strategist" dan "Senior Industry Analyst" di bidang percetakan dan retail UMKM.**
Anda memiliki keahlian mendalam dalam analisis tren industri percetakan dan retail modern, identifikasi peluang inovasi proses bisnis, evaluasi *best practice* operasional UMKM, perancangan fitur teknologi informasi yang meningkatkan efisiensi, serta pemahaman luas mengenai standar keamanan data, *customer experience*, dan strategi skalabilitas bisnis. Anda sangat teliti dalam memvalidasi bahwa setiap usulan inovasi benar-benar memberikan nilai tambah (*value-add*) nyata dan bukan fitur kosmetik yang tidak berdampak pada operasional.

## 2. Referensi Utama
Gunakan file-file berikut yang berada di dalam folder `docs/sdlc/` sebagai sumber informasi utama dan satu-satunya acuan:
- `docs/sdlc/narasi.txt` (Konteks lengkap operasional bisnis, harapan pemilik, mandat inovasi pada baris 98, detail alur kerja manual saat ini, serta seluruh kebutuhan bisnis yang sudah disampaikan secara eksplisit)
- `docs/sdlc/01_planning/01_project_charter.md` (Ruang lingkup 20 modul fungsional, spesifikasi teknis, kendala proyek, sasaran SMART, kriteria kesuksesan, dan daftar risiko tingkat tinggi)
- `docs/sdlc/01_planning/02_feasibility_study.md` (Analisis kelayakan teknis, operasional, ekonomi, jadwal, serta identifikasi risiko dan strategi mitigasi)
- `docs/sdlc/01_planning/03_stakeholder_register.md` (Profil stakeholder, ekspektasi utama, kriteria keberhasilan per stakeholder, dan strategi manajemen komunikasi)
- `docs/sdlc/01_planning/04_tech_stack_decision.md` (Keputusan arsitektur teknologi, paradigma FP, pilihan database MySQL 8.4, library terpilih beserta versinya, arsitektur Multi-Branch Ready, dan model pengembangan AI-Augmented)

## 3. Ekstraksi dan Rangkuman Data
- Baca dengan saksama **seluruh** isi dari setiap file referensi di atas.
- Ekstrak setiap informasi yang berkaitan dengan peluang inovasi, termasuk namun tidak terbatas pada:
  - **Dari narasi.txt:**
    - Mandat inovasi eksplisit dari pemilik (baris 98): "...tim AI **wajib** mengusulkannya dan memasukkannya ke dalam setiap dokumen perencanaan..."
    - Detail alur kerja manual saat ini (baris 49-70) — identifikasi celah efisiensi dan otomatisasi yang belum tercakup.
    - Harapan spesifik pemilik (baris 72-98) — identifikasi fitur yang sudah diminta vs fitur tambahan yang belum disebut.
    - Kondisi operasional saat ini (baris 26-43) — identifikasi *pain points* yang bisa diatasi dengan inovasi.
    - Detail layanan digital PPOB dan jasa keuangan (baris 55-62) — identifikasi peluang optimasi pengelolaan multi-akun.
    - Administrasi pinjaman dan SDM (baris 64-67) — identifikasi peluang otomatisasi lebih lanjut.
    - Pekerjaan administratif lainnya (baris 69-70) — identifikasi fitur tambahan yang relevan.
  - **Dari 01_project_charter.md:**
    - Daftar 20 modul fungsional (bagian 3.1) — identifikasi area yang bisa ditingkatkan di luar cakupan dasar.
    - Kriteria kesuksesan (bagian 5) — identifikasi fitur pendukung untuk memenuhi kriteria ini.
    - Risiko tingkat tinggi (bagian 6.3) — identifikasi inovasi yang bisa menjadi mitigasi tambahan.
    - Out-of-Scope saat ini (bagian 3.2) — catat sebagai referensi agar tidak mengusulkan fitur yang sudah dikecualikan.
  - **Dari 02_feasibility_study.md:**
    - Analisis risiko (bagian 7) — identifikasi inovasi mitigasi tambahan.
    - Celah operasional yang teridentifikasi (bagian 4.1) — identifikasi solusi inovatif tambahan.
  - **Dari 03_stakeholder_register.md:**
    - Ekspektasi per stakeholder (kolom "Ekspektasi Utama/Kebutuhan") — identifikasi fitur inovatif yang mendukung ekspektasi mereka.
    - Kriteria keberhasilan per stakeholder — identifikasi metrik atau fitur tambahan.
  - **Dari 04_tech_stack_decision.md:**
    - Kemampuan dan batasan teknologi terpilih — identifikasi inovasi yang layak diimplementasikan dalam batasan tech stack.
    - Paradigma FP dan arsitektur Multi-Branch Ready — identifikasi pola desain inovatif yang selaras.
- **KRITIS**: Pastikan Anda memahami dengan jelas batas antara **fitur yang SUDAH diminta oleh pemilik** (tercantum di narasi.txt dan project charter) dan **fitur BARU yang Anda usulkan**. Dokumen ini HANYA berisi **usulan baru** yang belum tercantum di mana pun. Jangan mengulang fitur yang sudah ada.

## 4. Fokus pada Spesifikasi Dokumen
- Hanya ambil dan hasilkan informasi yang berkaitan murni dengan **usulan inovasi dan penerapan best practice** yang belum disebutkan secara eksplisit oleh pemilik usaha.
- Untuk setiap usulan inovasi, dokumen harus mencakup:
  - **Judul Inovasi** — Nama singkat dan deskriptif dari inovasi yang diusulkan.
  - **Kategori** — Pengelompokan inovasi (misalnya: Efisiensi Operasional, Keamanan Data, *Customer Experience*, Kualitas Data, Manajemen Risiko, Analitik Bisnis, dll.).
  - **Deskripsi** — Penjelasan detail tentang apa yang diusulkan dan bagaimana cara kerjanya.
  - **Justifikasi/Dasar Pertimbangan** — Mengapa inovasi ini diusulkan? Standar industri apa yang mendukung? Masalah apa yang dicegah/diselesaikan?
  - **Modul Terdampak** — Modul mana dari 20 modul yang akan terpengaruh oleh inovasi ini.
  - **Prioritas** — Tingkat prioritas (Tinggi / Sedang / Rendah) berdasarkan dampak terhadap operasional bisnis.
  - **Kompleksitas Implementasi** — Estimasi tingkat kesulitan (Rendah / Sedang / Tinggi) dalam konteks paradigma FP dan tech stack yang sudah dipilih.
  - **Ketergantungan** — Apakah inovasi ini bergantung pada modul atau inovasi lain yang harus diselesaikan terlebih dahulu.
- **PENTING**: Abaikan dan JANGAN usulkan fitur yang sudah masuk dalam daftar Out-of-Scope project charter (GUI/Web/Mobile, API pihak ketiga, e-commerce, aplikasi mobile, cloud deployment). Semua usulan harus dapat diimplementasikan dalam batasan: CLI, Python FP, MySQL, lokal deployment.
- Abaikan informasi yang tidak berkaitan langsung dengan inovasi atau peningkatan sistem, agar dokumen tetap bersih dan terfokus.

## 5. Standar Struktur Dokumen (Praktik Industri)
Gunakan struktur dokumen Innovation Proposal standar industri berikut ini:

1. **Metadata Dokumen** (Judul Dokumen, Versi: `1.0.0`, Status: `[draft]`, Tanggal Dibuat: `2026-05-12`, Disusun Oleh: `Senior Innovation Strategist & Senior Industry Analyst (AI)`). Gunakan format tabel.
2. **Ringkasan Eksekutif (*Executive Summary*)** — Paragraf ringkas menjelaskan tujuan dokumen ini, konteks mandat inovasi dari pemilik, jumlah total inovasi yang diusulkan, dan klasifikasi prioritasnya.
3. **Konteks dan Mandat Inovasi** — Jelaskan secara eksplisit:
   - Kutipan mandat inovasi dari narasi.txt (baris 98).
   - Penegasan bahwa Modul ke-20 pada Project Charter ("Inovasi & Best Practice Industri") mewajibkan analisis dan proposal ini.
   - Batasan teknis yang harus dipatuhi (CLI, Python FP, MySQL, lokal, Multi-Branch Ready).
   - Batasan cakupan (tidak boleh mengusulkan fitur Out-of-Scope dari Project Charter).
4. **Metodologi Analisis** — Jelaskan secara singkat pendekatan yang digunakan untuk mengidentifikasi inovasi:
   - Analisis celah (*gap analysis*) antara alur kerja manual saat ini vs solusi yang sudah dirancang.
   - Studi perbandingan (*benchmarking*) terhadap standar industri percetakan dan retail modern.
   - Analisis risiko operasional untuk mengidentifikasi area yang memerlukan perlindungan tambahan.
   - Evaluasi ekspektasi stakeholder untuk mengidentifikasi kebutuhan implisit yang belum terpenuhi.
5. **Daftar Usulan Inovasi** — Untuk setiap inovasi, buat sub-bagian tersendiri dengan format berikut:
   - **5.X [Judul Inovasi]**
   - Tabel ringkasan: Kategori | Prioritas | Kompleksitas | Modul Terdampak | Ketergantungan
   - **Deskripsi**: Penjelasan detail tentang fitur/proses yang diusulkan.
   - **Justifikasi & Standar Industri**: Alasan mengapa ini penting, referensi ke standar industri yang mendukung.
   - **Spesifikasi Teknis Awal**: Bagaimana fitur ini bisa diimplementasikan dalam konteks Python FP + MySQL + CLI.
   - **Dampak Operasional**: Bagaimana inovasi ini meningkatkan efisiensi, keamanan, atau kualitas layanan.

   Kategorikan usulan inovasi ke dalam kelompok berikut (jika relevan):
   - **A. Inovasi Keamanan & Integritas Data**
   - **B. Inovasi Efisiensi Operasional**
   - **C. Inovasi Kualitas Data & Pelaporan**
   - **D. Inovasi Customer Experience**
   - **E. Inovasi Manajemen Risiko Bisnis**
   - **F. Inovasi Analitik & Kecerdasan Bisnis**

6. **Matriks Ringkasan Inovasi (*Innovation Summary Matrix*)** — Tabel ringkasan seluruh inovasi dalam satu tampilan, dengan kolom: No | Judul Inovasi | Kategori | Prioritas | Kompleksitas | Modul Terdampak.
7. **Peta Ketergantungan Inovasi (*Innovation Dependency Map*)** — Jelaskan urutan implementasi yang direkomendasikan berdasarkan ketergantungan antar inovasi.
8. **Dampak terhadap Fase SDLC Selanjutnya** — Jelaskan bagaimana dokumen ini mempengaruhi dokumen-dokumen pada fase Analysis (Business Requirements, Software Requirements), fase Design (Database Schema, System Architecture), dan fase Implementation.
9. **Riwayat Versi** — Tabel riwayat perubahan dokumen.
10. **Referensi Dokumen** (Wajib diletakkan di akhir dokumen).

## 6. Kelayakan Sebagai Referensi Fase Selanjutnya
Dokumen ini harus memberikan kejelasan mutlak mengenai:
- Fitur-fitur tambahan apa saja yang wajib dimasukkan ke dalam dokumen *Business Requirements* (fase Analysis).
- Spesifikasi teknis tambahan apa yang harus dipertimbangkan dalam *Software Requirements* (fase Analysis).
- Entitas data atau tabel database tambahan apa yang perlu dirancang dalam *Database Schema* (fase Design).
- Komponen arsitektur tambahan apa yang perlu dipertimbangkan dalam *System Architecture* (fase Design).
- Standar keamanan atau pola desain tambahan apa yang harus diimplementasikan dalam kode (fase Implementation).
- Skenario pengujian tambahan apa yang harus disiapkan dalam *Test Plan* (fase Testing).

## 7. Gaya Bahasa
- Gunakan Bahasa Indonesia yang formal, natural, jelas, dan sangat profesional.
- Untuk istilah teknis, gunakan istilah asli dalam bahasa Inggris yang dicetak miring (*italic*) dengan penjelasan bahasa Indonesia jika diperlukan.
- Hindari kalimat bersayap atau ambigu. Gunakan kalimat langsung dan lugas agar mudah diproses oleh junior programmer atau sistem AI lainnya.

## 8. Kualitas dan Kelengkapan Tanpa Interupsi
- Pastikan hasil akhir sangat komprehensif dan terstruktur dengan rapi sehingga tidak menimbulkan pertanyaan lanjutan saat fase SDLC berikutnya berjalan.
- Jangan berikan opsi atau tebakan. Jika ada keputusan yang harus diambil, simpulkan secara logis berdasarkan data dari file referensi.
- Untuk setiap inovasi yang diusulkan, pastikan justifikasinya substansial — bukan hanya menyebutkan bahwa "ini best practice", tetapi benar-benar menjelaskan **mengapa** praktik tersebut relevan untuk konteks UMKM percetakan AbuCom secara spesifik.
- Pastikan setiap inovasi yang diusulkan **BELUM tercakup** di dalam fitur yang sudah diminta oleh pemilik di narasi.txt maupun modul di project charter. Jika ada fitur yang sudah diminta, jangan ulangi — fokuslah hanya pada fitur **baru** yang merupakan hasil analisis Anda.

## 9. Penanganan Data Kosong (Pencegahan Halusinasi)
- Jika terdapat informasi spesifik yang **tidak dapat ditentukan** tanpa konsultasi lebih lanjut dengan pemilik usaha (misalnya: nilai ambang batas spesifik, frekuensi backup yang diinginkan, atau parameter konfigurasi detail), **JANGAN MENGARANG (HALUSINASI)**.
- Gunakan penanda khusus (*placeholder*) seperti `[NILAI_TBA]`, `[PARAMETER_TBA]`, atau `[KONFIGURASI_TBA]` agar tim pengembang mengetahui bagian mana yang perlu dikonfirmasi secara manual di kemudian hari.
- Untuk estimasi angka (seperti durasi retensi log, batas maksimum percobaan login, dll.), jika tidak ditemukan di referensi, berikan rekomendasi dengan catatan `[REKOMENDASI — konfirmasi dengan pemilik]`.

## 10. Output Bersih (Clean Output)
- Hasilkan **HANYA** hasil akhir (konten bersih) dari isi dokumen `05_innovation_proposal.md`.
- **DILARANG KERAS** menyertakan instruksi pengerjaan, proses pemikiran (*thinking process*), pembuka/penutup percakapan ("Tentu, berikut adalah...", "Semoga membantu", dll.), atau komentar tambahan apa pun. File Markdown yang dihasilkan harus 100% murni berisi konten spesifik Innovation Proposal siap pakai.

## 11. Kewajiban Referensi di Akhir Dokumen
Pada bagian paling bawah (baris terakhir) dari dokumen yang Anda buat, wajib menyertakan sumber referensi dengan format persis seperti ini:

```markdown
## Referensi Dokumen

Dokumen ini disusun berdasarkan analisis komprehensif terhadap:
- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/01_planning/02_feasibility_study.md`
- `docs/sdlc/01_planning/03_stakeholder_register.md`
- `docs/sdlc/01_planning/04_tech_stack_decision.md`
```

## 12. Catatan Khusus Spesifik Dokumen Innovation Proposal
- **Batas Tegas Fitur Baru vs Fitur Lama**: Sebelum menulis setiap inovasi, lakukan pengecekan silang (*cross-check*) terhadap narasi.txt (baris 72-98) dan daftar 20 modul di project charter (bagian 3.1). Jika fitur tersebut sudah diminta atau sudah tercakup — meskipun dengan kata-kata berbeda — maka fitur itu BUKAN inovasi baru dan TIDAK BOLEH dimasukkan.
- **Relevansi Konteks UMKM**: Setiap inovasi harus realistis untuk skala UMKM percetakan. Hindari mengusulkan fitur yang hanya relevan untuk perusahaan besar (misalnya: *machine learning* prediktif untuk demand forecasting, *real-time analytics dashboard* berbasis web, dll.). Semua harus bisa dijalankan via CLI di komputer lokal.
- **Konsistensi Teknis**: Pastikan setiap spesifikasi teknis awal yang disebut dalam inovasi **konsisten** dengan keputusan di 04_tech_stack_decision.md (Python 3.14.2+, FP murni, MySQL 8.4 LTS, CLI, `branch_id` di setiap tabel, tidak ada `class` untuk logika bisnis).
- **Tidak Duplikasi Risiko**: Beberapa inovasi mungkin berfungsi sebagai mitigasi tambahan untuk risiko yang sudah teridentifikasi di Feasibility Study (bagian 7). Jika demikian, sebutkan secara eksplisit risiko mana yang dimitigasi, namun tetap pastikan inovasi tersebut membawa nilai tambah baru di luar mitigasi yang sudah direncanakan.
- **Keterkaitan dengan Modul Existing**: Setiap inovasi harus secara jelas menyebutkan modul mana dari 20 modul yang terpengaruh, menggunakan nama dan nomor modul persis seperti yang tercantum di Project Charter bagian 3.1.

---

# Tahapan Implementasi (Instruksi Low-Level)
Bagi junior programmer atau model AI yang mengimplementasikan issue ini, kerjakan secara ketat menggunakan langkah-langkah sistematis berikut:

1. **Tahap 1: Pengumpulan Data Referensi**
   - Lakukan pemanggilan tool `view_file` atau tool pembaca file yang sesuai untuk membaca isi file `docs/sdlc/narasi.txt`. Baca **seluruh** isi file (115 baris). Fokuskan perhatian secara khusus pada:
     - Baris 98 — Mandat inovasi eksplisit: "...Saya mewajibkan tim AI pengembang untuk secara aktif melakukan analisis terhadap standar industri percetakan dan retail modern..."
     - Baris 49-70 — Detail alur kerja manual saat ini (untuk mengidentifikasi celah efisiensi).
     - Baris 72-98 — Harapan pemilik (untuk memastikan Anda TIDAK mengulang fitur yang sudah diminta).
   - Lakukan pemanggilan tool pembaca file untuk membaca isi file `docs/sdlc/01_planning/01_project_charter.md`. Baca **seluruh** isi file (254 baris). Fokuskan perhatian pada:
     - Bagian 3.1 "Dalam Cakupan" (daftar 20 modul — ini adalah **batas** fitur yang sudah ada, JANGAN diulang).
     - Bagian 3.2 "Di Luar Cakupan" (ini adalah **larangan** — JANGAN usulkan fitur yang masuk di sini).
     - Bagian 5 "Kriteria Kesuksesan" (identifikasi kriteria yang bisa ditunjang oleh inovasi tambahan).
     - Bagian 6.3 "Risiko Tingkat Tinggi" (identifikasi inovasi yang bisa menjadi mitigasi tambahan).
   - Lakukan pemanggilan tool pembaca file untuk membaca isi file `docs/sdlc/01_planning/02_feasibility_study.md`. Baca **seluruh** isi file (234 baris). Fokuskan perhatian pada:
     - Bagian 4 "Operational Feasibility" (celah operasional yang teridentifikasi).
     - Bagian 7 "Risk and Mitigation Strategy" (risiko yang bisa dimitigasi lebih lanjut oleh inovasi).
   - Lakukan pemanggilan tool pembaca file untuk membaca isi file `docs/sdlc/01_planning/03_stakeholder_register.md`. Baca **seluruh** isi file (58 baris). Fokuskan perhatian pada:
     - Bagian 4 "Analisis Pemangku Kepentingan" — kolom "Ekspektasi Utama/Kebutuhan" dan "Kriteria Keberhasilan" untuk setiap stakeholder (identifikasi kebutuhan implisit).
   - Lakukan pemanggilan tool pembaca file untuk membaca isi file `docs/sdlc/01_planning/04_tech_stack_decision.md`. Baca **seluruh** isi file (288 baris). Fokuskan perhatian pada:
     - Seluruh keputusan teknologi (untuk memastikan inovasi yang diusulkan kompatibel).
     - Bagian "Kendala dan Batasan" (untuk memastikan inovasi tidak melanggar batasan).
     - Aturan teknis FP (tidak ada `class`, pure functions, immutable data).
   - Simpan seluruh teks tersebut ke dalam memori kerja (*context*) Anda.

2. **Tahap 2: Identifikasi Fitur yang SUDAH Ada (Exclusion List)**
   - Buat daftar lengkap semua fitur yang **sudah diminta** oleh pemilik di narasi.txt (baris 72-98).
   - Buat daftar lengkap semua fitur yang **sudah tercakup** di 20 modul project charter (bagian 3.1).
   - Buat daftar semua fitur yang **sudah dikecualikan** di Out-of-Scope project charter (bagian 3.2).
   - Daftar ini adalah **Exclusion List** — Anda DILARANG mengusulkan fitur apa pun yang masuk dalam daftar ini.

3. **Tahap 3: Analisis Celah dan Identifikasi Inovasi**
   - Bandingkan alur kerja manual saat ini (narasi baris 49-70) dengan solusi yang sudah dirancang (20 modul project charter). Identifikasi celah yang belum tercakup.
   - Analisis standar industri percetakan dan retail modern. Identifikasi *best practice* yang relevan untuk skala UMKM dan dapat diimplementasikan via CLI + Python FP + MySQL.
   - Analisis risiko yang sudah teridentifikasi di Feasibility Study. Identifikasi mitigasi tambahan yang bisa diusulkan sebagai inovasi.
   - Analisis ekspektasi stakeholder. Identifikasi kebutuhan implisit yang belum terpenuhi oleh 20 modul yang ada.
   - Untuk setiap kandidat inovasi, lakukan pengecekan terhadap **Exclusion List** dari Tahap 2. Jika sudah ada — buang.
   - Untuk setiap kandidat inovasi yang lolos, validasi bahwa inovasi tersebut:
     - Dapat diimplementasikan dalam batasan CLI + Python FP murni + MySQL 8.4 + lokal deployment.
     - Realistis untuk skala UMKM percetakan (bukan fitur enterprise-grade yang berlebihan).
     - Memberikan nilai tambah nyata yang terukur.

4. **Tahap 4: Penyusunan Draf Markdown**
   - Buat format dasar Markdown mengikuti spesifikasi struktur pada poin 5.
   - Isi setiap sub-bagian inovasi dengan deskripsi, justifikasi, spesifikasi teknis, dan dampak operasional.
   - Kelompokkan inovasi ke dalam kategori yang sesuai (A-F).
   - Buat Matriks Ringkasan Inovasi di bagian 6 dengan merangkum seluruh inovasi dalam satu tabel.
   - Buat Peta Ketergantungan Inovasi di bagian 7.
   - Sisipkan label `[TBA]` untuk data spesifik yang tidak dapat ditentukan.
   - Tambahkan blok Referensi di akhir baris sesuai poin 11.

5. **Tahap 5: Validasi Konsistensi**
   - Periksa ulang bahwa TIDAK ADA satu pun inovasi yang sudah tercakup di narasi.txt atau 20 modul project charter. Lakukan pengecekan kata per kata jika perlu.
   - Periksa bahwa seluruh spesifikasi teknis yang disebutkan **konsisten** dengan 04_tech_stack_decision.md. Tidak ada inovasi yang memerlukan library baru di luar tech stack yang sudah diputuskan (kecuali dari Python Standard Library).
   - Periksa bahwa tidak ada inovasi yang melanggar batasan Out-of-Scope (GUI/Web/Mobile, API pihak ketiga, e-commerce, cloud).
   - Periksa bahwa setiap inovasi mencantumkan modul terdampak dengan nama dan nomor yang tepat sesuai Project Charter bagian 3.1.
   - Periksa bahwa setiap inovasi memiliki justifikasi yang substansial — bukan generik.

6. **Tahap 6: Filter Output Bersih**
   - Hilangkan semua teks pengantar, proses pemikiran, dan komentar non-konten.
   - Pastikan keluaran hanya berisi tag Markdown dari `# Innovation Proposal` hingga referensi terakhir.

7. **Tahap 7: Eksekusi Penulisan (Write/Replace)**
   - Gunakan tool `write_to_file` dengan opsi `Overwrite: true` untuk menulis seluruh teks output ke target file: `docs/sdlc/01_planning/05_innovation_proposal.md`.
   - Pastikan Anda menggunakan *absolute path* yang benar sesuai *environment* aktif.

8. **Tahap 8: Pembaruan Status di sdlc.txt**
   - Setelah berhasil menulis file, buka file `docs/sdlc/sdlc.txt`.
   - Temukan baris yang berisi `05_innovation_proposal.md` (baris 9).
   - Ubah `status: [create_file]` menjadi `status: [draft]` menggunakan tool `replace_file_content`.
   - **PERINGATAN**: Pastikan hanya mengubah baris 9. Jangan mengubah baris lain.
