# Issue #0022 — Validasi & Perbaikan Dokumen Access Control Matrix

## 1. Metadata Issue

| Atribut              | Detail                                                                 |
| -------------------- | ---------------------------------------------------------------------- |
| **ID Issue**         | 0022                                                                   |
| **Judul**            | Validasi & Perbaikan Dokumen Access Control Matrix                     |
| **Prioritas**        | Tinggi                                                                 |
| **Fase SDLC**        | 02_analysis                                                            |
| **Dokumen Target**   | `docs/sdlc/02_analysis/06_access_control_matrix.md`                   |
| **Status Dokumen**   | [draft]                                                                |
| **Tanggal Dibuat**   | 2026-05-14                                                             |
| **Dibuat Oleh**      | Senior Information Security Analyst & Senior Business Analyst          |

---

## 2. Tujuan Issue

Dokumen `06_access_control_matrix.md` saat ini berstatus `[draft]`. Issue ini bertujuan untuk memastikan bahwa dokumen tersebut telah **divalidasi secara ketat, lengkap, dan layak** untuk dijadikan acuan teknis oleh dokumen-dokumen pada fase berikutnya (03_design, 04_implementation, dst.), sebelum statusnya diubah menjadi `[finish]`.

---

## 3. Persona yang Harus Diterapkan

> **WAJIB DIBACA SEBELUM MENGERJAKAN ISSUE INI**

Sebelum memulai pekerjaan, adopsi persona gabungan berikut selama seluruh proses validasi:

```
Kamu adalah seorang gabungan dari:
1. Senior Information Security Analyst (10+ tahun), yang memahami RBAC, Least Privilege,
   Separation of Duties, dan standar keamanan informasi (ISO 27001, OWASP).
2. Senior Business Analyst (8+ tahun), yang memahami alur bisnis operasional percetakan
   konvensional (kasir, gudang, produksi, HRD, keuangan) dan mampu menilai apakah
   kebijakan akses selaras dengan kebutuhan bisnis nyata.
3. Senior Technical Writer, yang mampu menilai kualitas bahasa, struktur dokumen,
   kelengkapan informasi, dan kesiapan dokumen sebagai referensi teknis untuk
   junior programmer atau model AI lain yang lebih murah.

Kamu WAJIB bersikap skeptis, teliti, dan kritis. Jangan pernah mengasumsikan bahwa
dokumen sudah benar hanya karena terlihat lengkap. Verifikasi setiap klaim dengan
mencocokkannya ke file referensi yang tersedia.
```

---

## 4. File yang Terlibat

### 4.1. Dokumen Target (yang akan divalidasi dan diperbaiki)
- `docs/sdlc/02_analysis/06_access_control_matrix.md`

### 4.2. File Referensi Wajib (harus dibaca semua sebelum validasi dimulai)
Baca seluruh file berikut secara lengkap dan simpan pemahamannya sebelum membandingkan:

1. `docs/sdlc/02_analysis/01_business_requirements.md` — Sumber kebenaran utama kebutuhan bisnis. Periksa setiap Business Rule (BR-XX) apakah telah dipetakan dengan benar ke kebijakan akses.
2. `docs/sdlc/02_analysis/02_software_requirements.md` — Spesifikasi fungsional dan non-fungsional. Pastikan setiap fitur (FR-XX) dan persyaratan keamanan (NFR-XX) tercermin dalam ACM.
3. `docs/sdlc/02_analysis/03_use_case_diagram.puml` — Seluruh Use Case dan aktor (Pemilik / Karyawan) yang ada di sana harus terpetakan di Seksi 9 dokumen target.
4. `docs/sdlc/02_analysis/04_workflow_diagram.puml` — Alur kerja operasional yang menggambarkan siapa melakukan apa; digunakan untuk memvalidasi logika akses pada level modul.
5. `docs/sdlc/02_analysis/05_data_dictionary.md` — Daftar lengkap semua entitas/tabel database beserta atributnya. Setiap entitas yang ada di Data Dictionary HARUS muncul di Seksi 7 dokumen target.

### 4.3. File Referensi Tambahan (periksa jika tersedia)
- `docs/narasi.txt` — Jika file ini ada, baca dan gunakan sebagai konteks bisnis operasional tambahan untuk memperkuat validasi logika akses.

---

## 5. Tahapan Implementasi (Low-Level Instructions)

Ikuti tahapan berikut **secara berurutan**. Jangan melompat ke tahap berikutnya sebelum tahap sebelumnya selesai sepenuhnya.

---

### TAHAP 1: Persiapan — Baca Semua File

**Langkah 1.1** — Buka dan baca secara penuh file dokumen target:
- `docs/sdlc/02_analysis/06_access_control_matrix.md`

**Langkah 1.2** — Buka dan baca secara penuh semua file referensi wajib (lihat Seksi 4.2). Catat setiap hal penting:
- Daftar semua Business Rule (BR-XX) dari BRD.
- Daftar semua Functional Requirement (FR-XX) dan Non-Functional Requirement (NFR-XX) dari SRS.
- Daftar semua Use Case ID dan nama dari use_case_diagram.puml.
- Daftar semua nama entitas/tabel dari data_dictionary.md.
- Daftar semua alur kerja utama dari workflow_diagram.puml.

**Langkah 1.3** — Periksa apakah file `docs/narasi.txt` ada. Jika ada, baca secara penuh dan gunakan sebagai konteks bisnis tambahan.

> ⛔ **STOP**: Jangan lanjutkan ke Tahap 2 sebelum semua file di atas telah selesai dibaca.

---

### TAHAP 2: Komparasi Mendalam — ACM vs. File Referensi

**Tujuan**: Menemukan gap, inkonsistensi, atau data yang hilang antara dokumen target dan file referensi.

**Langkah 2.1 — Validasi Kelengkapan Business Rules (BRD)**
- Buat daftar semua Business Rule (BR-XX) dari `01_business_requirements.md`.
- Untuk setiap BR-XX yang berhubungan dengan akses, peran, atau keamanan data, verifikasi apakah sudah dipetakan secara eksplisit di dalam dokumen target (khususnya di Seksi 6, 7, 8, atau 11).
- Contoh yang harus dipastikan: `BR-10` (restriksi data sensitif finansial) — apakah sudah tertulis di Seksi 8 dan Seksi 7.3?
- Tandai setiap BR-XX yang **belum** dipetakan atau dipetakan secara tidak lengkap.

**Langkah 2.2 — Validasi Kelengkapan Functional Requirements (SRS)**
- Buat daftar semua FR-XX dari `02_software_requirements.md`.
- Untuk setiap FR-XX yang menyebutkan modul fungsional atau peran pengguna, verifikasi apakah modul tersebut sudah ada di Seksi 6 (Matriks Akses per Modul Fungsional).
- Pastikan tidak ada modul yang disebut di SRS tetapi tidak muncul di Seksi 6.
- Pastikan tidak ada modul di Seksi 6 yang tidak memiliki rujukan ke SRS (dokumen ini harus bersih dan berbasis fakta).

**Langkah 2.3 — Validasi Kelengkapan Use Case (UC)**
- Buat daftar semua Use Case ID dari `03_use_case_diagram.puml` (format: `UC_NamaUseCase`).
- Bandingkan dengan tabel di Seksi 9 dokumen target.
- Pastikan setiap Use Case yang ada di file `.puml` tercatat di Seksi 9.
- Pastikan kolom "Akses Pemilik" dan "Akses Karyawan" di Seksi 9 konsisten dengan aktor yang ada di diagram.
- Pastikan kolom "Referensi Relasi" (misalnya: *Include*, *Extend*, atau *Aktor Karyawan*) sudah benar.

**Langkah 2.4 — Validasi Kelengkapan Entitas Data (Data Dictionary)**
- Buat daftar semua nama entitas/tabel dari `05_data_dictionary.md`.
- Bandingkan satu per satu dengan entitas yang ada di Seksi 7 (Sub-seksi 7.1, 7.2, 7.3) dokumen target.
- Untuk setiap entitas yang ada di Data Dictionary tetapi **tidak ada** di Seksi 7: ini adalah **gap kritis** — harus ditambahkan.
- Untuk setiap entitas yang ada di Seksi 7 tetapi **tidak ada** di Data Dictionary: ini adalah **anomali** — harus diverifikasi apakah entitas ini seharusnya ada atau salah nama.
- Pastikan pengelompokan entitas (Master Data / Transaksi Operasional / Pendukung & Keamanan) sudah logis dan konsisten.

**Langkah 2.5 — Validasi Konsistensi Alur Kerja (Workflow)**
- Baca `04_workflow_diagram.puml` dan identifikasi setiap titik pengambilan keputusan yang melibatkan peran (Pemilik vs Karyawan).
- Verifikasi apakah logika akses di Seksi 6 dan Seksi 7 sudah konsisten dengan alur kerja yang tergambar.
- Contoh: Jika workflow menunjukkan bahwa hanya Pemilik yang melakukan rekonsiliasi kas akhir hari, pastikan `cash_reconciliation` di Seksi 7 dan `F-09` di Seksi 6 memang menunjukkan akses `✗` untuk Karyawan.

---

### TAHAP 3: Validasi Spesifik Dokumen ACM

**Tujuan**: Memastikan dokumen ACM ini memenuhi standar kualitas khusus sebagai dokumen keamanan dan akses kontrol.

**Langkah 3.1 — Fokus Konten (Clean Content Check)**
- Periksa apakah ada informasi di dalam dokumen yang **tidak relevan** dengan Access Control Matrix.
- ACM harus bersih dan hanya berisi: definisi role, prinsip keamanan, matriks akses per modul, matriks akses per entitas data, daftar data sensitif, pemetaan use case, aturan audit trail, dan aturan keamanan arsitektur.
- Hapus atau pindahkan konten yang tidak sesuai scope ACM.

**Langkah 3.2 — Validasi Logika Akses (Access Logic Audit)**
- Periksa setiap baris di Seksi 6 dan Seksi 7. Untuk setiap hak akses Karyawan yang diset `✓` atau `C,R,U,D`, pastikan ada justifikasi logis bisnis yang bisa diverifikasi ke BRD atau SRS.
- Periksa setiap hak akses Karyawan yang diset `✗`, pastikan pembatasan ini selaras dengan prinsip Least Privilege, Separation of Duties, atau BR-10.
- Khusus untuk akses bertipe `Terbatas`, pastikan kolom "Catatan" sudah menjelaskan kondisi pembatasan secara spesifik dan tidak ambigu (contoh: "hanya record milik dirinya sendiri" harus disebutkan dengan jelas, bukan sekadar "Terbatas").

**Langkah 3.3 — Validasi Kelengkapan Prinsip Keamanan (Seksi 4)**
- Periksa apakah tiga prinsip utama (Least Privilege, Separation of Duties, Data Classification) sudah sesuai dengan standar industri keamanan informasi.
- Jika ada prinsip keamanan lain yang relevan dan diterapkan secara implisit di dokumen (misalnya: *Defense in Depth*, *Fail-Safe Defaults*, *Complete Mediation*), tambahkan ke Seksi 4 sebagai butir baru.

**Langkah 3.4 — Validasi Seksi Audit Trail (Seksi 10)**
- Periksa apakah seluruh operasi kritis yang ada di Seksi 7 sudah tercakup oleh aturan Audit Trail di Seksi 10.
- Pastikan tidak ada entitas transaksi sensitif (seperti `loans`, `asset_savings`, `payroll`) yang lolos dari pencatatan audit.
- Periksa apakah mekanisme audit trail (forced logging oleh backend, bukan manual user) sudah dijabarkan dengan cukup jelas untuk diimplementasikan oleh developer.

**Langkah 3.5 — Validasi Seksi Aturan Keamanan Arsitektur (Seksi 11)**
- Periksa apakah 4 aturan di Seksi 11 sudah cukup detail untuk diimplementasikan oleh junior programmer.
- Contoh celah yang harus diperiksa:
  - Apakah ada spesifikasi **Rate Limiting** atau **Brute Force Protection** untuk login CLI?
  - Apakah ada kebijakan **Session Invalidation** saat logout atau timeout?
  - Apakah ada spesifikasi tentang **penanganan error** yang aman (tidak membocorkan detail internal sistem)?
- Jika ada celah keamanan arsitektur yang relevan namun belum tercantum, tambahkan sebagai butir baru di Seksi 11.

---

### TAHAP 4: Validasi Standar Dokumen

**Tujuan**: Memastikan dokumen memenuhi standar kualitas dokumen industri SDLC profesional.

**Langkah 4.1 — Validasi Struktur Dokumen**
- Periksa apakah urutan seksi sudah logis dan mengikuti alur pikir yang natural:
  `Metadata → Pendahuluan → Legenda → Prinsip → Role → Matriks Modul → Matriks Data → Data Sensitif → UC Mapping → Audit Trail → Aturan Keamanan → Referensi`
- Jika ada seksi yang hilang, tidak terurut dengan baik, atau judulnya kurang informatif, perbaiki.

**Langkah 4.2 — Validasi Kualitas Bahasa Indonesia**
- Baca ulang seluruh dokumen dari awal sampai akhir.
- Pastikan:
  - Tidak ada kalimat yang ambigu atau multitafsir.
  - Tidak ada kalimat yang terlalu panjang hingga membingungkan pembaca.
  - Istilah teknis dalam bahasa Inggris (CRUD, RBAC, JWT, dll.) dipertahankan tetapi dijelaskan saat pertama kali muncul.
  - Istilah Indonesia yang digunakan konsisten di seluruh dokumen (contoh: jangan campur antara "pengguna" dan "user" secara acak tanpa standarisasi).
  - Tidak ada typo atau kesalahan tanda baca yang signifikan.

**Langkah 4.3 — Validasi Kelayakan sebagai Referensi Fase Berikutnya**
- Simulasikan diri Anda sebagai **developer fase 03_design** yang akan membuat `01_database_schema.sql` dan `06_security_design.md`. Ajukan pertanyaan-pertanyaan ini:
  - "Apakah saya tahu persis tabel mana yang harus saya proteksi di level SQL?"
  - "Apakah saya tahu atribut apa saja yang termasuk data sensitif?"
  - "Apakah saya tahu cara mengimplementasikan role filtering di query database?"
  - "Apakah saya tahu token JWT harus mengandung field apa?"
- Jika ada pertanyaan yang tidak bisa dijawab dari dokumen ini, informasi yang hilang itu harus ditambahkan.

**Langkah 4.4 — Validasi Tidak Ada Data Kosong atau Placeholder**
- Scan seluruh dokumen untuk mencari:
  - Sel tabel yang kosong atau berisi tanda `-` tanpa penjelasan.
  - Kalimat yang menggunakan placeholder seperti `[TBD]`, `[TODO]`, `[sesuaikan]`, atau sejenisnya.
  - Referensi ke dokumen atau seksi lain yang tidak ada atau belum dibuat.
- Jika ditemukan, isi dengan data yang tepat dan relevan sesuai konteks dokumen.

---

### TAHAP 5: Penulisan Hasil — Perbaikan Dokumen

**Tujuan**: Menuangkan semua temuan dari Tahap 2, 3, dan 4 ke dalam dokumen target.

**Langkah 5.1 — Buat Daftar Temuan Sebelum Mengedit**
Sebelum mengedit file, buat daftar internal (di memori atau scratch) yang berisi:
- Daftar gap/inkonsistensi yang ditemukan (per tahap, per seksi).
- Daftar tambahan yang perlu ditulis (entitas baru di Seksi 7, prinsip baru di Seksi 4, aturan baru di Seksi 11, dst.).
- Daftar kalimat atau frasa yang perlu diperbaiki bahasanya.

**Langkah 5.2 — Edit Dokumen Target Secara Langsung**
- Buka file `docs/sdlc/02_analysis/06_access_control_matrix.md`.
- Terapkan semua perbaikan hasil temuan dari Tahap 2, 3, dan 4.
- Tambahkan baris atau sub-seksi baru jika diperlukan.
- Jangan menghapus konten yang sudah benar, hanya perbaiki yang salah atau lengkapi yang kurang.

**Langkah 5.3 — Update Versi Dokumen di Metadata**
- Buka tabel metadata di Seksi 1 dokumen target.
- Update field **Versi** mengikuti aturan berikut:
  - Jika ada penambahan/penghapusan seksi atau perubahan struktur besar → naikkan versi **minor** (contoh: `1.0.0` → `1.1.0`).
  - Jika hanya perbaikan typo, bahasa, atau isian data kecil → naikkan versi **patch** (contoh: `1.0.0` → `1.0.1`).
  - Jika ada restrukturisasi total dokumen → naikkan versi **major** (contoh: `1.0.0` → `2.0.0`).
- Update field **Tanggal Dibuat** menjadi tanggal hari ini saat perbaikan dilakukan.
- **JANGAN** ubah field **Status** menjadi `[finish]`. Status hanya diubah oleh manusia (author) setelah review manual.

**Langkah 5.4 — Tambahkan Referensi Baru (Jika Ada)**
- Jika selama proses validasi Anda menggunakan atau merujuk file yang belum ada di Seksi 12 (Referensi Dokumen), tambahkan file tersebut sebagai butir baru di bagian **paling bawah** Seksi 12.
- Format penambahan: `N. \`path/relatif/ke/file\``
- Contoh: Jika `docs/narasi.txt` digunakan sebagai referensi, tambahkan: `6. \`docs/narasi.txt\``

---

### TAHAP 6: Verifikasi Akhir (Self-Check)

Sebelum menyatakan pekerjaan selesai, lakukan pemeriksaan akhir dengan membaca dokumen yang telah diperbaiki dari awal hingga akhir dan jawab checklist berikut:

| No | Pertanyaan Verifikasi                                                                                              | Jawaban |
|----|-------------------------------------------------------------------------------------------------------------------|---------|
| 1  | Apakah semua Business Rules (BR-XX) yang berhubungan dengan akses sudah dipetakan?                               | Ya/Tidak |
| 2  | Apakah semua Use Case dari `03_use_case_diagram.puml` sudah tercatat di Seksi 9?                                 | Ya/Tidak |
| 3  | Apakah semua entitas dari `05_data_dictionary.md` sudah ada di Seksi 7?                                          | Ya/Tidak |
| 4  | Apakah tidak ada modul di Seksi 6 yang tidak memiliki dasar di BRD/SRS?                                          | Ya/Tidak |
| 5  | Apakah semua akses `Terbatas` memiliki penjelasan kondisi yang spesifik di kolom Catatan?                        | Ya/Tidak |
| 6  | Apakah Seksi 10 (Audit Trail) sudah mencakup semua operasi kritis pada entitas sensitif?                        | Ya/Tidak |
| 7  | Apakah Seksi 11 (Aturan Keamanan) sudah cukup detail untuk diimplementasikan junior developer?                  | Ya/Tidak |
| 8  | Apakah seluruh dokumen bebas dari placeholder, sel kosong, dan kalimat ambigu?                                   | Ya/Tidak |
| 9  | Apakah versi dokumen sudah diperbarui sesuai aturan di Langkah 5.3?                                              | Ya/Tidak |
| 10 | Apakah semua file referensi yang digunakan sudah tercantum di Seksi 12?                                          | Ya/Tidak |

> Jika ada jawaban **"Tidak"** pada checklist di atas, kembali ke tahap yang relevan dan perbaiki sebelum menyatakan selesai.

---

## 6. Batasan & Larangan (Constraints)

> ⛔ **DILARANG** melakukan hal-hal berikut:

1. **JANGAN** mengubah status dokumen dari `[draft]` menjadi `[finish]`. Perubahan status adalah hak prerogatif manusia (author).
2. **JANGAN** menghapus konten yang sudah benar hanya karena ingin menyederhanakan. Tambahkan, perbaiki, atau lengkapi — jangan hapus tanpa alasan yang kuat.
3. **JANGAN** membuat asumsi tentang aturan akses tanpa dasar yang bisa ditelusuri ke file referensi. Jika tidak ditemukan dasar di BRD/SRS/Use Case, catat sebagai catatan ketidakpastian di bagian akhir dokumen target.
4. **JANGAN** mengubah file referensi (BRD, SRS, Use Case, Workflow, Data Dictionary). File-file itu hanya untuk dibaca.
5. **JANGAN** mengubah nama atau path file dokumen target.
6. **JANGAN** membuat file baru selain mengubah dokumen target yang sudah ditentukan.

---

## 7. Output yang Diharapkan

Setelah issue ini diimplementasikan, output yang dihasilkan adalah:

1. **File `docs/sdlc/02_analysis/06_access_control_matrix.md` yang telah diperbaiki** dengan:
   - Versi dokumen yang telah dinaikkan (minimal `1.0.1` atau lebih tinggi).
   - Semua gap, inkonsistensi, dan data yang hilang telah dilengkapi.
   - Seluruh entitas dari Data Dictionary terpetakan di Seksi 7.
   - Seluruh Use Case dari use_case_diagram terpetakan di Seksi 9.
   - Seksi 11 yang lebih detail mencakup aspek keamanan arsitektur yang hilang.
   - Bahasa Indonesia yang natural, konsisten, dan tidak ambigu.
   - Seksi 12 yang mencantumkan semua file referensi yang digunakan.

2. **Dokumen yang layak** dijadikan sebagai input utama untuk:
   - `docs/sdlc/03_design/01_database_schema.sql`
   - `docs/sdlc/03_design/06_security_design.md`

---

## 8. Referensi Issue Terkait

- **Issue #0021** — `0021_issue_access_control_matrix.md` (Implementasi awal dokumen ACM)
- **Issue #0019** — `0019_issue_data_dictionary.md` (Implementasi Data Dictionary — sumber entitas untuk Seksi 7)
- **Issue #0015** — `0015_issue_use_case_diagram.md` (Implementasi Use Case Diagram — sumber UC untuk Seksi 9)
