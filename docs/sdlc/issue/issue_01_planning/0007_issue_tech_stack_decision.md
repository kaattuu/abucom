# Issue: Pembuatan Dokumen Tech Stack Decision (04_tech_stack_decision.md)

## Deskripsi Tugas
Anda ditugaskan untuk membuat dokumen **Tech Stack Decision** (`04_tech_stack_decision.md`) yang merupakan bagian dari fase Perencanaan (Planning) dalam siklus SDLC. Dokumen ini saat ini memiliki status `[create_file]`. Tujuan Anda adalah menyusun dokumen keputusan pemilihan teknologi (*Technology Stack Decision Record*) yang terstruktur, komprehensif, dan siap digunakan secara profesional — yang mendokumentasikan secara resmi **mengapa** setiap komponen teknologi dipilih, **alternatif** apa saja yang dipertimbangkan, **kriteria evaluasi** yang digunakan, serta **risiko teknis** dari setiap keputusan.

## 1. Persona yang Digunakan
**Bertindaklah sebagai "Senior Enterprise Architect" dan "Senior Technical Lead".**
Anda memiliki keahlian mendalam dalam arsitektur perangkat lunak, evaluasi dan seleksi teknologi, analisis komparatif *tech stack*, perencanaan infrastruktur, serta pemahaman luas mengenai ekosistem *open-source*. Anda sangat teliti dalam mendokumentasikan justifikasi teknis, menganalisis *trade-off* dari setiap pilihan teknologi, dan memastikan keputusan teknis selaras dengan kebutuhan bisnis serta kendala proyek yang telah ditetapkan.

## 2. Referensi Utama
Gunakan file-file berikut yang berada di dalam folder `docs/sdlc/` sebagai sumber informasi utama dan satu-satunya acuan:
- `docs/sdlc/narasi.txt` (Konteks dasar proyek, kebutuhan teknis yang disampaikan langsung oleh pemilik usaha, spesifikasi sistem yang diminta, dan susunan tim pengembang)
- `docs/sdlc/01_planning/01_project_charter.md` (Spesifikasi teknis resmi proyek, ruang lingkup 20 modul fungsional, kendala teknis, dan susunan tim pengembang)
- `docs/sdlc/01_planning/02_feasibility_study.md` (Analisis kelayakan teknis, ketersediaan teknologi, kapabilitas tim, dan evaluasi infrastruktur)
- `docs/sdlc/01_planning/03_stakeholder_register.md` (Profil tim pengembang AI dan ekspektasi teknis stakeholder)

## 3. Ekstraksi dan Rangkuman Data
- Baca dengan saksama seluruh referensi di atas.
- Ekstrak setiap informasi yang berkaitan dengan keputusan teknologi, termasuk namun tidak terbatas pada:
  - **Bahasa Pemrograman**: Python 3.14.2 ke atas, paradigma Functional Programming (wajib).
  - **Database**: MySQL.
  - **Library Utama**: `mysql-connector-python`, `python-dotenv`, `bcrypt`, `pyjwt`.
  - **Antarmuka Pengguna**: CLI/Console (tahap awal).
  - **Sistem Operasi Target**: Linux Debian 12 Bookworm dan Windows 11.
  - **Arsitektur**: Multi-Branch Ready.
  - **Tim Pengembang**: 1 Junior Programmer + 6 Agen AI dengan peran spesifik masing-masing.
  - **Biaya Lisensi**: Seluruh ekosistem bersifat *open-source* (Rp 0).
  - **Kendala Teknis**: Paradigma Functional Programming bersifat wajib; tahap awal CLI saja; deployment lokal.
- Pastikan tidak ada satupun informasi teknologi yang terlewat dari semua file referensi.

## 4. Fokus pada Spesifikasi Dokumen
- Hanya ambil informasi yang berkaitan murni dengan **keputusan pemilihan teknologi** (*Tech Stack Decision*).
- Untuk setiap komponen teknologi yang dipilih, dokumen harus mencakup:
  - **Apa** yang dipilih (nama dan versi spesifik).
  - **Mengapa** dipilih (justifikasi teknis dan bisnis yang kuat).
  - **Alternatif** apa saja yang dipertimbangkan dan **mengapa ditolak**.
  - **Risiko** dari pilihan ini dan bagaimana mitigasinya.
  - **Kendala** (*constraint*) yang mempengaruhi keputusan (misalnya: paradigma FP wajib, budget Rp 0, dll).
- Abaikan informasi mengenai alur bisnis operasional, detail keuangan non-teknis, atau profil stakeholder yang tidak berhubungan langsung dengan keputusan teknologi, agar dokumen tetap bersih dan terfokus.

## 5. Standar Struktur Dokumen (Praktik Industri)
Gunakan struktur dokumen Tech Stack Decision standar industri berikut ini:

1. **Metadata Dokumen** (Judul Dokumen, Versi: `1.0.0`, Status: `[draft]`, Tanggal Dibuat, Disusun Oleh). Gunakan format tabel.
2. **Ringkasan Eksekutif (*Executive Summary*)** — Paragraf ringkas menjelaskan keputusan teknologi utama yang diambil dan alasannya secara garis besar.
3. **Konteks dan Latar Belakang Keputusan** — Jelaskan konteks proyek yang mempengaruhi pemilihan teknologi: jenis aplikasi (CLI), skala usaha (UMKM), jumlah modul (20), arsitektur target (Multi-Branch Ready), kendala anggaran (Rp 0 lisensi), dan kendala paradigma (Functional Programming wajib).
4. **Kriteria Evaluasi Teknologi** — Daftar kriteria yang digunakan untuk mengevaluasi setiap komponen teknologi. Contoh kriteria: biaya lisensi, kematangan (*maturity*), dukungan komunitas, kompatibilitas dengan paradigma FP, kemudahan pembelajaran bagi Junior Programmer, ketersediaan dokumentasi, performa, keamanan, skalabilitas, dan kompatibilitas lintas OS (Windows 11 & Debian 12).
5. **Keputusan Teknologi per Komponen** — Untuk setiap komponen berikut, buat sub-bagian tersendiri yang berisi tabel perbandingan alternatif dan justifikasi keputusan:
   - 5.1 **Bahasa Pemrograman** (Terpilih: Python 3.14.2+, Alternatif: Node.js, Go, Java, PHP, dll.)
   - 5.2 **Paradigma Pemrograman** (Terpilih: Functional Programming, Alternatif: OOP, Procedural, dll.)
   - 5.3 **Sistem Basis Data (*Database*)** (Terpilih: MySQL, Alternatif: PostgreSQL, SQLite, MariaDB, MongoDB, dll.)
   - 5.4 **Antarmuka Pengguna (*User Interface*)** (Terpilih: CLI/Console, Alternatif: Web GUI, Desktop GUI, TUI, dll.)
   - 5.5 **Library Koneksi Database** (Terpilih: `mysql-connector-python`, Alternatif: `PyMySQL`, `SQLAlchemy`, `aiomysql`, dll.)
   - 5.6 **Library Manajemen Konfigurasi** (Terpilih: `python-dotenv`, Alternatif: `configparser`, `pydantic-settings`, `dynaconf`, dll.)
   - 5.7 **Library Keamanan — Hashing Password** (Terpilih: `bcrypt`, Alternatif: `argon2-cffi`, `passlib`, `hashlib+scrypt`, dll.)
   - 5.8 **Library Keamanan — Autentikasi Token** (Terpilih: `pyjwt`, Alternatif: `python-jose`, `authlib`, *session-based*, dll.)
   - 5.9 **Sistem Operasi Target** (Terpilih: Linux Debian 12 Bookworm & Windows 11, Alternatif: Ubuntu, CentOS, macOS, dll.)
   - 5.10 **Strategi Arsitektur Skalabilitas** (Terpilih: Multi-Branch Ready, Alternatif: Single-Tenant, Microservices, dll.)
   - 5.11 **Model Pengembangan (*Development Model*)** (Terpilih: AI-Augmented Development, deskripsi peran masing-masing 6 Agen AI)

   Untuk setiap sub-bagian di atas, gunakan format berikut:
   - **Tabel Perbandingan Alternatif** dengan kolom: Kandidat, Kelebihan, Kekurangan, Skor Evaluasi (1-5).
   - **Keputusan**: Nama teknologi terpilih.
   - **Justifikasi**: Paragraf penjelasan mengapa kandidat ini dipilih dibanding alternatif lain.
   - **Risiko dan Mitigasi**: Risiko spesifik dari pilihan ini dan strategi penanganannya.

6. **Matriks Ringkasan Keputusan (*Decision Summary Matrix*)** — Tabel ringkasan seluruh keputusan dalam satu tampilan, dengan kolom: Komponen, Teknologi Terpilih, Versi/Spesifikasi, Status Lisensi, Tingkat Risiko.
7. **Kendala dan Batasan (*Constraints*)** — Daftar kendala teknis dan bisnis yang mempengaruhi keputusan secara keseluruhan.
8. **Riwayat Versi** — Tabel riwayat perubahan dokumen.
9. **Referensi Dokumen** (Wajib diletakkan di akhir dokumen).

## 6. Kelayakan Sebagai Referensi Fase Selanjutnya
Dokumen ini harus memberikan kejelasan mutlak mengenai:
- Teknologi apa yang harus diinstal dan digunakan oleh tim pengembang pada fase Implementation.
- Versi minimum yang wajib dipatuhi untuk setiap komponen.
- Batasan arsitektur yang harus diikuti (paradigma FP, Multi-Branch Ready).
- Justifikasi keputusan yang cukup kuat sehingga tidak perlu diperdebatkan ulang di fase selanjutnya.
- Informasi yang dibutuhkan oleh dokumen `05_innovation_proposal.md` (fase Planning selanjutnya), dokumen fase Analysis (Software Requirements), dan dokumen fase Design (System Architecture, Database Schema) sebagai fondasi keputusan teknis.

## 7. Gaya Bahasa
- Gunakan Bahasa Indonesia yang formal, natural, jelas, dan sangat profesional.
- Untuk istilah teknis, gunakan istilah asli dalam bahasa Inggris yang dicetak miring (*italic*) dengan penjelasan bahasa Indonesia jika diperlukan.
- Hindari kalimat bersayap atau ambigu. Gunakan kalimat langsung dan lugas agar mudah diproses oleh junior programmer atau sistem AI lainnya.

## 8. Kualitas dan Kelengkapan Tanpa Interupsi
- Pastikan hasil akhir sangat komprehensif dan terstruktur dengan rapi sehingga tidak menimbulkan pertanyaan lanjutan saat fase SDLC berikutnya berjalan.
- Jangan berikan opsi atau tebakan. Jika ada keputusan yang harus diambil, simpulkan secara logis berdasarkan data dari file referensi.
- Untuk setiap komponen teknologi, pastikan analisis alternatif dilakukan secara objektif dan mendalam — bukan hanya menyebutkan nama alternatif, tetapi benar-benar menjelaskan kelebihan dan kekurangannya secara substansial.

## 9. Penanganan Data Kosong (Pencegahan Halusinasi)
- Jika terdapat informasi spesifik yang **tidak ditemukan** pada file referensi (misalnya: versi spesifik MySQL yang digunakan, konfigurasi server, atau spesifikasi hardware detail), **JANGAN MENGARANG (HALUSINASI)**.
- Gunakan penanda khusus (*placeholder*) seperti `[VERSI_TBA]`, `[SPESIFIKASI_TBA]`, atau `[KONFIGURASI_TBA]` agar tim pengembang mengetahui bagian mana yang perlu dilengkapi secara manual di kemudian hari.
- Untuk versi library (`mysql-connector-python`, `python-dotenv`, `bcrypt`, `pyjwt`), jika versi spesifik tidak disebutkan dalam referensi, tandai sebagai `[VERSI_TBA — gunakan versi stabil terbaru saat implementasi]`.

## 10. Output Bersih (Clean Output)
- Hasilkan **HANYA** hasil akhir (konten bersih) dari isi dokumen `04_tech_stack_decision.md`.
- **DILARANG KERAS** menyertakan instruksi pengerjaan, proses pemikiran (*thinking process*), pembuka/penutup percakapan ("Tentu, berikut adalah...", "Semoga membantu", dll.), atau komentar tambahan apa pun. File Markdown yang dihasilkan harus 100% murni berisi konten spesifik Tech Stack Decision siap pakai.

## 11. Kewajiban Referensi di Akhir Dokumen
Pada bagian paling bawah (baris terakhir) dari dokumen yang Anda buat, wajib menyertakan sumber referensi dengan format persis seperti ini:

```markdown
## Referensi Dokumen

Dokumen ini disusun dan divalidasi berdasarkan:
- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/01_planning/02_feasibility_study.md`
- `docs/sdlc/01_planning/03_stakeholder_register.md`
```

## 12. Catatan Khusus Spesifik Dokumen Tech Stack Decision
- **Objektivitas Analisis**: Untuk setiap tabel perbandingan alternatif, pastikan analisis dilakukan secara fair dan objektif. Jangan hanya memuji teknologi terpilih dan mencela alternatif. Jelaskan secara jujur kelebihan alternatif dan mengapa meskipun memiliki kelebihan tertentu, alternatif tersebut tetap tidak dipilih karena konteks proyek ini.
- **Konsistensi Data**: Pastikan seluruh nama teknologi, versi, dan spesifikasi yang disebutkan dalam dokumen ini 100% konsisten dengan apa yang tercantum di Project Charter dan Feasibility Study. Jika ditemukan inkonsistensi antar dokumen referensi, ikuti data dari Project Charter sebagai otoritas tertinggi.
- **Keterkaitan Antar Komponen**: Jelaskan bagaimana pilihan satu komponen teknologi mempengaruhi atau bergantung pada komponen lainnya (misalnya: pilihan Python mempengaruhi pilihan library, pilihan MySQL mempengaruhi pilihan connector, dll.).

---

# Tahapan Implementasi (Instruksi Low-Level)
Bagi junior programmer atau model AI yang mengimplementasikan issue ini, kerjakan secara ketat menggunakan langkah-langkah sistematis berikut:

1. **Tahap 1: Pengumpulan Data Referensi**
   - Lakukan pemanggilan tool `view_file` atau tool pembaca file yang sesuai untuk membaca isi file `docs/sdlc/narasi.txt`. Fokuskan perhatian pada bagian "Kebutuhan Teknis dan Tim" (baris 100-115) dan "Harapan untuk Aplikasi Baru" (baris 72-98 — khususnya poin tentang skalabilitas dan arsitektur).
   - Lakukan pemanggilan tool pembaca file untuk membaca isi file `docs/sdlc/01_planning/01_project_charter.md`. Fokuskan perhatian pada:
     - Bagian 7 "Spesifikasi Teknis" (tabel komponen teknologi).
     - Bagian 8 "Susunan Tim Pengembang" (daftar agen AI dan perannya).
     - Bagian 3 "Ruang Lingkup Proyek" (20 modul fungsional — untuk memahami kompleksitas yang harus ditangani oleh tech stack).
     - Bagian 6 "Asumsi, Kendala & Risiko Tingkat Tinggi" (kendala teknis yang mempengaruhi pemilihan teknologi).
   - Lakukan pemanggilan tool pembaca file untuk membaca isi file `docs/sdlc/01_planning/02_feasibility_study.md`. Fokuskan perhatian pada:
     - Bagian 3 "Technical Feasibility" (evaluasi ketersediaan teknologi, infrastruktur, dan kapabilitas tim).
     - Bagian 5 "Economic & Financial Feasibility" (analisis biaya — konfirmasi bahwa seluruh teknologi harus Rp 0 lisensi).
   - Lakukan pemanggilan tool pembaca file untuk membaca isi file `docs/sdlc/01_planning/03_stakeholder_register.md`. Fokuskan perhatian pada:
     - Baris Tim Pengembang AI (peran dan ekspektasi teknis masing-masing agen).
   - Simpan seluruh teks tersebut ke dalam memori kerja (*context*) Anda.

2. **Tahap 2: Ekstraksi dan Klasifikasi Keputusan Teknologi**
   - Identifikasi setiap komponen teknologi yang disebutkan secara eksplisit di file referensi.
   - Kelompokkan menjadi 11 kategori komponen sesuai struktur di poin 5 (Bahasa Pemrograman, Paradigma, Database, UI, Library Koneksi, Library Konfigurasi, Library Hashing, Library Token, OS, Arsitektur, Model Pengembangan).
   - Untuk setiap komponen, catat: nama, versi (jika ada), justifikasi yang sudah disebutkan di referensi, dan kendala terkait.

3. **Tahap 3: Analisis Alternatif per Komponen**
   - Untuk setiap komponen, lakukan analisis perbandingan dengan minimal 3 alternatif (kecuali untuk komponen yang memiliki sedikit alternatif relevan).
   - Gunakan pengetahuan umum mengenai teknologi tersebut untuk mengisi kolom Kelebihan dan Kekurangan.
   - Berikan Skor Evaluasi (1-5) berdasarkan seberapa cocok kandidat tersebut dengan konteks proyek AbuCom (bukan secara umum).
   - **PERINGATAN**: Jangan mengarang fitur atau kemampuan teknologi yang tidak Anda ketahui. Jika ragu, berikan catatan `[PERLU_VERIFIKASI]`.

4. **Tahap 4: Penyusunan Draf Markdown**
   - Buat format dasar Markdown mengikuti spesifikasi struktur pada poin 5.
   - Isi setiap sub-bagian komponen teknologi dengan tabel perbandingan, keputusan, justifikasi, dan risiko.
   - Buat Matriks Ringkasan Keputusan di bagian 6 dengan merangkum seluruh keputusan dalam satu tabel.
   - Sisipkan label `[TBA]` untuk data spesifik yang tidak tersedia di file referensi.
   - Tambahkan blok Referensi di akhir baris sesuai poin 11.

5. **Tahap 5: Validasi Konsistensi**
   - Periksa ulang bahwa SEMUA nama teknologi, versi, dan spesifikasi yang Anda tulis di dokumen ini **identik** dengan yang tercantum di Project Charter (01_project_charter.md). Jika ada perbedaan, gunakan data Project Charter.
   - Periksa bahwa tidak ada komponen teknologi dari file referensi yang terlewat.
   - Periksa bahwa setiap tabel perbandingan memiliki minimal 3 alternatif yang relevan.

6. **Tahap 6: Filter Output Bersih**
   - Hilangkan semua teks pengantar, proses pemikiran, dan komentar non-konten.
   - Pastikan keluaran hanya berisi tag Markdown dari `# Tech Stack Decision` hingga referensi terakhir.

7. **Tahap 7: Eksekusi Penulisan (Write/Replace)**
   - Gunakan tool `write_to_file` dengan opsi `Overwrite: true` untuk menulis seluruh teks output ke target file: `docs/sdlc/01_planning/04_tech_stack_decision.md`.
   - Pastikan Anda menggunakan *absolute path* yang benar sesuai *environment* aktif.

8. **Tahap 8: Pembaruan Status di sdlc.txt**
   - Setelah berhasil menulis file, buka file `docs/sdlc/sdlc.txt`.
   - Temukan baris yang berisi `04_tech_stack_decision.md` (baris 8).
   - Ubah `status: [create_file]` menjadi `status: [draft]` menggunakan tool `replace_file_content`.
   - **PERINGATAN**: Pastikan hanya mengubah baris 8. Jangan mengubah baris lain.
