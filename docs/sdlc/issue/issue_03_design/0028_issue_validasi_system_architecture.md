# Issue #0028 — Validasi & Perbaikan Dokumen System Architecture

## Metadata Issue

| Atribut         | Detail                                                                 |
|-----------------|------------------------------------------------------------------------|
| **Nomor Issue** | 0028                                                                   |
| **Judul**       | Validasi & Perbaikan Dokumen System Architecture                       |
| **Fase SDLC**   | 03_design                                                              |
| **Dokumen Target** | `docs/sdlc/03_design/03_system_architecture.md`                   |
| **Status Dokumen** | [draft]                                                            |
| **Prioritas**   | Tinggi                                                                 |
| **Dibuat Oleh** | Senior Software Architect & Senior System Designer (AI)                |
| **Tanggal**     | 2026-05-15                                                             |

---

## Persona yang Harus Digunakan

Kamu adalah **Senior Software Architect** sekaligus **Technical Documentation Reviewer** berpengalaman lebih dari 15 tahun dalam merancang sistem enterprise berbasis Python dengan paradigma Functional Programming. Kamu memiliki keahlian mendalam dalam:
- Merancang arsitektur berlapis (Layered Architecture) untuk aplikasi CLI monolitik.
- Menilai kelayakan dokumen arsitektur sebagai referensi implementasi nyata.
- Memvalidasi konsistensi teknis antar dokumen dalam satu siklus SDLC.
- Mendeteksi kekosongan data, ambiguitas bahasa, dan inkonsistensi teknis dalam dokumen.
- Memastikan dokumen mengikuti standar industri software engineering.

Kamu **tidak boleh berasumsi, berhenti di tengah jalan, atau melewatkan satu poin pun** dari instruksi ini. Kamu bekerja secara sistematis, teliti, dan bertanggung jawab penuh atas hasil akhir dokumen.

---

## Tujuan Issue

Melakukan **pemeriksaan, analisis, dan validasi menyeluruh** terhadap dokumen utama `03_system_architecture.md` yang masih berstatus `[draft]`, lalu **menuangkan semua perbaikan langsung ke dalam file dokumen tersebut**, sehingga dokumen ini layak naik status dan siap dijadikan referensi utama untuk fase SDLC berikutnya.

---

## File yang Harus Dibaca Sebelum Mulai

Baca dan pahami **seluruh isi** file-file berikut sebelum melakukan satu pun perubahan. Jangan melewatkan satu file pun:

1. **Dokumen Target (yang akan diperbaiki):**
   - `docs/sdlc/03_design/03_system_architecture.md`

2. **File Referensi Utama:**
   - `docs/sdlc/narasi.txt` — narasi kebutuhan bisnis asli dari pemilik usaha
   - `docs/sdlc/01_planning/01_project_charter.md`
   - `docs/sdlc/01_planning/04_tech_stack_decision.md`
   - `docs/sdlc/01_planning/05_innovation_proposal.md`
   - `docs/sdlc/02_analysis/02_software_requirements.md`
   - `docs/sdlc/02_analysis/06_access_control_matrix.md`
   - `docs/sdlc/03_design/01_database_schema.sql`
   - `docs/sdlc/03_design/02_erd_database.puml`

> **PERINGATAN:** Jangan mulai menulis atau mengubah apapun sebelum selesai membaca semua file di atas. Catat semua temuan dulu di memori kerja kamu, baru kemudian eksekusi perbaikan secara menyeluruh dalam satu langkah penulisan.

---

## Tahapan Pelaksanaan (Wajib Diikuti Secara Berurutan)

### TAHAP 1 — Komparasi Mendalam dengan Semua File Referensi

**Langkah 1.1 — Baca `narasi.txt`**
- Baca seluruh isi `narasi.txt`.
- Catat semua elemen bisnis yang disebut: jenis layanan, jenis karyawan, skema gaji, sistem poin, kebutuhan multi-cabang, keamanan, dsb.
- Tandai: apakah setiap elemen bisnis ini sudah terefleksi dalam arsitektur di dokumen target?

**Langkah 1.2 — Baca semua file referensi teknis**
- Baca `project_charter.md`, `tech_stack_decision.md`, `innovation_proposal.md`, `software_requirements.md`, `access_control_matrix.md`, `database_schema.sql`, `erd_database.puml`.
- Untuk setiap file, catat poin teknis penting yang relevan bagi dokumen arsitektur sistem:
  - Library, versi Python, OS target dari `tech_stack_decision.md`
  - Inovasi teknis dari `innovation_proposal.md` (pastikan semua 5 inovasi tercakup)
  - Role dan permission dari `access_control_matrix.md`
  - Nama tabel, kolom kunci, relasi dari `database_schema.sql` dan `erd_database.puml`

**Langkah 1.3 — Buat daftar temuan gap**
- Buat daftar mental (atau sementara di memori) berisi:
  - Data/informasi yang ada di referensi tapi **tidak ada** di dokumen target → tandai sebagai `[MISSING]`
  - Data yang ada di dokumen target tapi **tidak didukung** oleh referensi manapun → tandai sebagai `[ORPHAN]`
  - Data yang ada di dokumen target tapi **tidak akurat/berbeda** dari referensi → tandai sebagai `[INACCURATE]`

---

### TAHAP 2 — Validasi Kelengkapan Konten

**Langkah 2.1 — Periksa apakah semua aspek arsitektur sudah tercakup:**
Untuk setiap poin di bawah ini, verifikasi apakah dokumen sudah menjelaskannya secara memadai:

- [ ] Deskripsi setiap lapisan arsitektur (Presentation, Service, Data Access, Security, Utility) dengan tanggung jawab yang jelas dan tidak tumpang tindih
- [ ] Diagram Mermaid arsitektur berlapis — apakah arah panah sudah benar dan konsisten dengan aturan komunikasi lapisan?
- [ ] Struktur direktori lengkap — apakah semua modul dari `project_charter.md` sudah dipetakan ke file/service yang tepat?
- [ ] Semua 20 modul fungsional dari Project Charter sudah tercakup dalam pemetaan tabel (Bagian 10)
- [ ] Semua 5 inovasi dari `innovation_proposal.md` sudah disebutkan dan dijelaskan teknis implementasinya
- [ ] Alur autentikasi JWT sudah mencakup: login, session, timeout 10 menit, lockout ke-5 percobaan salah
- [ ] Alur transaksi kasir sudah mencakup: pemilihan item, kalkulasi tier harga (grosir/mitra), BOM & HPP, pengurangan stok, audit trail
- [ ] Alur penggajian sudah mencakup: trigger, hitung pendapatan, skema gaji (Rp 3.000.000 jika ≥ Rp 15.000.000, atau 15% jika tidak), poin insentif, kasbon, slip gaji
- [ ] Strategi koneksi database FP: stateless, ACID, tuple immutable, branch_id injection
- [ ] Strategi keamanan: JWT HS256, RBAC dari payload JWT, Soft Delete, PIN finansial (limit Rp 5.000.000), audit trail imutabel
- [ ] Strategi error handling: stack trace hiding, pesan ramah, rollback otomatis
- [ ] Strategi multi-branch: branch_id di semua tabel transaksional, injeksi dari JWT
- [ ] Standar FP: pure functions, immutable data, tanpa class (kecuali frozen dataclass), higher-order functions

**Langkah 2.2 — Periksa kedalaman penjelasan teknis:**
- Apakah setiap bagian menjelaskan **BAGAIMANA** cara implementasinya, bukan hanya **APA** yang dilakukan?
- Apakah ada bagian yang hanya menyebut nama konsep tanpa penjelasan teknis konkret?
- Contoh yang harus dipastikan konkret: cara `branch_id` diinjeksikan ke query, cara JWT payload diekstrak untuk RBAC, cara BOM direduksi ke HPP.

---

### TAHAP 3 — Validasi Relevansi dan Fokus Dokumen

**Langkah 3.1 — Periksa apakah semua konten memang milik dokumen System Architecture:**
- Dokumen ini harus fokus pada: struktur teknis, arsitektur berlapis, alur data antar komponen, pola komunikasi antar lapisan, strategi database, keamanan arsitektural, dan strategi multi-branch.
- **Bukan milik dokumen ini:** detail logika bisnis per transaksi, aturan bisnis spesifik, detail UI CLI, detail DDL tabel database.
- Tandai dan pertimbangkan untuk memindahkan atau meringkas bagian yang terlalu masuk ke domain dokumen lain (misal: detail alur bisnis yang terlalu rinci → lebih cocok di `software_requirements.md`).

**Langkah 3.2 — Pastikan tidak ada duplikasi yang tidak perlu:**
- Periksa apakah ada paragraf yang mengulang informasi yang sudah dijelaskan di bagian lain dokumen yang sama.
- Jika ada duplikasi, gabungkan atau hapus redundansi.

---

### TAHAP 4 — Validasi Standar Struktur Dokumen Industri

**Langkah 4.1 — Periksa kelengkapan struktur dokumen:**
Dokumen System Architecture yang standar dalam industri software engineering harus memiliki:

- [ ] **Metadata dokumen** — versi, status, tanggal, penulis ✓ (sudah ada, verifikasi kelengkapannya)
- [ ] **Pendahuluan/Overview** — tujuan dokumen, scope, batasan, audience ✓ (ada, periksa apakah cukup)
- [ ] **Arsitektur Berlapis** — dengan diagram dan penjelasan aturan komunikasi ✓
- [ ] **Struktur Direktori** — dengan keterangan setiap file/folder ✓
- [ ] **Alur Data (Data Flow)** — minimal 3 skenario kritis ✓
- [ ] **Strategi Database** — koneksi, transaksi, pola query ✓
- [ ] **Arsitektur Keamanan** — autentikasi, otorisasi, audit ✓
- [ ] **Penanganan Error** — strategi dan pola ✓
- [ ] **Strategi Multi-Branch** — isolasi data antar cabang ✓
- [ ] **Pemetaan Modul ke Database** — tabel yang digunakan per modul ✓
- [ ] **Standar Coding** — aturan FP yang wajib diterapkan ✓
- [ ] **Panduan Eksekusi** — entry point, state passing, komposisi fungsi ✓
- [ ] **Riwayat Versi** ✓
- [ ] **Referensi Dokumen** ✓
- [ ] **[PERIKSA]** Apakah ada bagian yang **hilang** atau **perlu ditambahkan** berdasarkan standar industri yang relevan untuk proyek ini?

**Langkah 4.2 — Bagian yang kemungkinan perlu ditambahkan:**
Periksa apakah bagian-bagian berikut perlu ada dan belum ada:
- **Dependency Map** — library dan versi yang digunakan per lapisan (misal: bcrypt di Security Layer, mysql-connector di Data Layer)
- **Constraint & Batasan Teknis** — batasan yang mutlak tidak boleh dilanggar (misal: no OOP, no global state, no ORM)
- **Non-Functional Requirements Coverage** — bagaimana arsitektur ini menjawab NFR seperti performance, maintainability, security
- **Deployment Context** — OS target (Linux Debian 12 / Windows 11), cara menjalankan aplikasi
- **Glossary/Istilah** — penjelasan singkat istilah teknis FP yang digunakan

---

### TAHAP 5 — Validasi Kelayakan sebagai Referensi Fase Berikutnya

**Langkah 5.1 — Simulasikan sebagai pembaca dari fase SDLC berikutnya:**
Bayangkan kamu adalah junior programmer yang akan mengerjakan dokumen-dokumen berikut menggunakan `03_system_architecture.md` sebagai referensi utama:
- `04_cli_interaction_flow.puml` (alur interaksi CLI)
- `05_bom_hpp_design.md` (desain BOM dan HPP)
- `06_security_design.md` (desain keamanan)
- `04_implementation/01_coding_standard.md` (standar kode)
- `04_implementation/03_module_structure.md` (struktur modul)

**Langkah 5.2 — Untuk setiap dokumen fase berikutnya, periksa:**
- Apakah `03_system_architecture.md` sudah memberikan informasi yang cukup sebagai landasan?
- Apakah masih ada pertanyaan teknis yang akan muncul saat mengerjakan dokumen berikutnya yang seharusnya sudah dijawab di sini?
- Catat semua gap ini dan tambahkan ke dokumen target.

---

### TAHAP 6 — Validasi Bahasa Indonesia

**Langkah 6.1 — Periksa kualitas bahasa:**
- Baca seluruh dokumen dari awal hingga akhir dengan fokus pada bahasa.
- Tandai kalimat yang:
  - Terlalu panjang dan bertele-tele (lebih dari 3 baris) → pecah menjadi kalimat lebih pendek
  - Menggunakan bahasa yang terlalu puitis/metaforis yang bisa membingungkan junior programmer
  - Menggunakan istilah teknis tanpa penjelasan kontekstual
  - Ambigu (bisa diinterpretasikan lebih dari satu cara)
  - Sulit dipahami oleh seseorang yang baru belajar software engineering

**Langkah 6.2 — Standar bahasa yang harus dipenuhi:**
- Gunakan kalimat aktif yang langsung dan jelas.
- Istilah teknis dalam bahasa Inggris boleh dipertahankan tapi harus diikuti penjelasan dalam bahasa Indonesia.
- Hindari kata-kata yang berlebihan seperti: "mengenyahkan", "mengharamkan", "dibasmi", "digebrak" — ganti dengan padanan profesional: "melarang", "tidak menggunakan", "menghapus", "memanggil".
- Setiap poin atau langkah harus bisa dipahami tanpa harus membaca ulang.

---

### TAHAP 7 — Validasi Data Kosong dan Kelengkapan

**Langkah 7.1 — Periksa semua bagian untuk data kosong:**
- Periksa apakah ada sel tabel yang kosong, placeholder, atau keterangan "TBD/TODO/menyusul".
- Periksa apakah diagram Mermaid sudah lengkap dan benar secara sintaks.
- Periksa apakah semua referensi file di bagian "Referensi Dokumen" benar-benar ada dan pathnya valid.

**Langkah 7.2 — Isi semua data yang kosong:**
- Jika ada data yang kosong, isi dengan data yang sesuai, relevan, dan masih dalam ruang lingkup dokumen ini.
- Jangan mengisi data dengan asumsi — gunakan data dari file referensi yang sudah kamu baca di Tahap 1.
- Jika data memang tidak tersedia dari referensi manapun, beri keterangan eksplisit kenapa kosong.

---

### TAHAP 8 — Eksekusi Perbaikan ke Dokumen Target

> **PENTING:** Semua perbaikan harus dituangkan langsung ke file `docs/sdlc/03_design/03_system_architecture.md`. Jangan membuat file baru atau file sementara.

**Langkah 8.1 — Tulis ulang atau tambahkan konten yang diperbaiki:**
- Terapkan semua temuan dari Tahap 1–7 langsung ke dokumen.
- Jika ada bagian yang perlu ditulis ulang, tulis ulang seluruh bagian tersebut, bukan hanya satu kalimat.
- Jika ada bagian baru yang perlu ditambahkan, sisipkan di posisi yang paling logis dalam alur dokumen.
- Jika ada bagian yang perlu dipindahkan atau dihapus, lakukan dengan konsisten.

**Langkah 8.2 — Update versi dokumen:**
- Ubah versi dokumen dari `1.0.0` menjadi `1.1.0` (minor version bump karena perbaikan konten, bukan perubahan arsitektur fundamental).
- Update tabel Riwayat Versi dengan menambahkan baris baru:

  | Versi | Tanggal | Diubah Oleh | Keterangan |
  |-------|---------|-------------|------------|
  | 1.1.0 | [tanggal hari ini] | [nama persona kamu] | Validasi menyeluruh: perbaikan bahasa, pengisian data kosong, penambahan bagian yang hilang, komparasi dengan semua file referensi, peningkatan kelayakan sebagai referensi fase implementasi. |

**Langkah 8.3 — Update metadata status (JANGAN ubah status dokumen):**
- Status dokumen **tetap `[draft]`** — perubahan status adalah wewenang pemilik proyek, bukan tugasmu.
- Hanya ubah versi dan tambahkan entri riwayat versi.

**Langkah 8.4 — Tambahkan referensi baru jika ada:**
- Jika dalam proses perbaikan kamu menggunakan file referensi yang belum tercantum di bagian "Referensi Dokumen" di dokumen target, tambahkan file tersebut di bagian paling bawah daftar referensi.
- Format penambahan referensi: `- \`path/ke/file.md\``

---

### TAHAP 9 — Verifikasi Akhir Setelah Perbaikan

Setelah semua perbaikan diterapkan, lakukan verifikasi akhir dengan membaca ulang dokumen dari awal hingga akhir:

**Checklist Verifikasi Akhir:**
- [ ] Tidak ada kalimat yang ambigu atau membingungkan
- [ ] Tidak ada data yang kosong, TBD, atau placeholder
- [ ] Semua 20 modul fungsional terpetakan
- [ ] Semua 5 inovasi teknis dari `innovation_proposal.md` tercakup
- [ ] Diagram Mermaid valid dan konsisten dengan narasi
- [ ] Struktur direktori konsisten dengan nama file di `tech_stack_decision.md`
- [ ] Versi dokumen sudah diupdate ke `1.1.0`
- [ ] Riwayat versi sudah ditambahkan
- [ ] Referensi baru (jika ada) sudah ditambahkan di bagian Referensi Dokumen
- [ ] Bahasa Indonesia profesional, bersih dari kata-kata berlebihan/puitis
- [ ] Tidak ada duplikasi konten yang tidak perlu
- [ ] Dokumen layak dijadikan referensi untuk: `04_cli_interaction_flow.puml`, `05_bom_hpp_design.md`, `06_security_design.md`, dan semua dokumen fase implementasi

---

## Poin Tambahan Spesifik untuk Dokumen System Architecture

Selain poin-poin umum di atas, khusus untuk dokumen System Architecture pada proyek AbuCom, periksa juga:

**A. Konsistensi Nama File dan Modul:**
- Nama file di struktur direktori (Bagian 4) harus konsisten dengan nama yang digunakan di bagian lain dokumen ini dan di `tech_stack_decision.md`.
- Contoh: jika di Bagian 4 disebut `hr_payroll_service.py`, maka di Bagian 10 juga harus mengacu pada modul yang sama.

**B. Kelengkapan Pemetaan Modul (Bagian 10):**
- Verifikasi setiap baris tabel pemetaan modul ke tabel database menggunakan nama tabel yang **benar-benar ada** di `database_schema.sql`.
- Jika ada nama tabel yang tidak cocok, perbaiki sesuai nama tabel aktual di schema.

**C. Kejelasan Batasan FP:**
- Pastikan ada contoh kode pseudocode sederhana (bukan kode lengkap) yang menunjukkan pola yang **diizinkan** vs **dilarang** dalam FP. Ini sangat penting agar junior programmer tidak salah interpretasi.
- Contoh yang harus ada:
  ```python
  # DILARANG (OOP):
  # class TransactionService:
  #     def calculate(self): ...

  # WAJIB (FP):
  # def calculate_transaction(conn, branch_id, items) -> tuple:
  #     ...
  ```

**D. Penjelasan State Passing:**
- Bagian "Pola State Passing" harus disertai contoh konkret: bagaimana tuple state diteruskan dari satu fungsi ke fungsi lain. Tanpa contoh ini, junior programmer akan kesulitan memahami konsep ini.

**E. Dokumentasi Library per Lapisan:**
- Tambahkan tabel atau daftar yang memetakan: setiap lapisan arsitektur → library Python yang digunakan → fungsi spesifik library tersebut dalam lapisan itu.

---

## Output yang Diharapkan

Setelah issue ini selesai diimplementasikan:

1. **File `docs/sdlc/03_design/03_system_architecture.md`** sudah diperbarui dengan:
   - Versi `1.1.0`
   - Semua perbaikan bahasa diterapkan
   - Semua data kosong terisi
   - Semua bagian yang hilang ditambahkan
   - Referensi baru (jika ada) ditambahkan di akhir

2. **Tidak ada file baru** yang dibuat selain perubahan pada file target di atas.

3. **Tidak ada perubahan pada file referensi** — file referensi hanya dibaca, tidak dimodifikasi.

---

## Referensi Issue Ini

- `docs/sdlc/03_design/03_system_architecture.md` — dokumen target
- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/01_planning/04_tech_stack_decision.md`
- `docs/sdlc/01_planning/05_innovation_proposal.md`
- `docs/sdlc/02_analysis/02_software_requirements.md`
- `docs/sdlc/02_analysis/06_access_control_matrix.md`
- `docs/sdlc/03_design/01_database_schema.sql`
- `docs/sdlc/03_design/02_erd_database.puml`
