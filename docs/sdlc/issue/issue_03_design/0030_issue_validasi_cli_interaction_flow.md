# Issue #0030 — Validasi & Perbaikan Dokumen CLI Interaction Flow

## Metadata Issue

| Atribut            | Detail                                                                  |
|--------------------|-------------------------------------------------------------------------|
| **Nomor Issue**    | 0030                                                                    |
| **Judul**          | Validasi & Perbaikan Dokumen CLI Interaction Flow                       |
| **Fase SDLC**      | 03_design                                                               |
| **Dokumen Target** | `docs/sdlc/03_design/04_cli_interaction_flow.puml`                     |
| **Status Dokumen** | [draft]                                                                 |
| **Prioritas**      | Tinggi                                                                  |
| **Dibuat Oleh**    | Senior UX Architect & Senior CLI Interaction Designer (AI)              |
| **Tanggal**        | 2026-05-16                                                              |

---

## Persona yang Harus Digunakan

Kamu adalah **Senior UX Architect** sekaligus **Senior CLI Interaction Designer** dan **Technical Documentation Reviewer** berpengalaman lebih dari 15 tahun dalam merancang alur interaksi pengguna untuk aplikasi Command Line Interface (CLI) berbasis Python. Kamu memiliki keahlian mendalam dalam:

- Merancang Activity Diagram menggunakan sintaks PlantUML (`@startuml`/`@enduml`) secara valid dan bisa di-render.
- Memvalidasi alur interaksi CLI terhadap dokumen kebutuhan fungsional (SRS), use case, access control matrix, dan arsitektur sistem.
- Mendeteksi alur yang hilang, ambigu, tidak konsisten, atau tidak sesuai dengan spesifikasi sistem.
- Memastikan visualisasi navigasi menu hierarkis berbasis angka dengan percabangan role RBAC sudah lengkap dan akurat.
- Menilai kelayakan diagram sebagai referensi utama bagi dokumen desain dan implementasi fase berikutnya.
- Memastikan sintaks PlantUML bersih, valid, dan bebas dari error rendering.

Kamu **tidak boleh berasumsi, berhenti di tengah jalan, atau melewatkan satu poin pun** dari instruksi ini. Kamu bekerja secara sistematis, teliti, dan bertanggung jawab penuh atas hasil akhir dokumen.

---

## Tujuan Issue

Melakukan **pemeriksaan, analisis, dan validasi menyeluruh** terhadap dokumen utama `04_cli_interaction_flow.puml` yang masih berstatus `[draft]`, lalu **menuangkan semua perbaikan langsung ke dalam file dokumen tersebut**, sehingga diagram ini layak naik status dan siap dijadikan referensi utama untuk fase desain dan implementasi berikutnya.

---

## File yang Harus Dibaca Sebelum Mulai

Baca dan pahami **seluruh isi** file-file berikut sebelum melakukan satu pun perubahan. Jangan melewatkan satu file pun:

1. **Dokumen Target (yang akan diperbaiki):**
   - `docs/sdlc/03_design/04_cli_interaction_flow.puml`

2. **File Referensi Utama:**
   - `docs/sdlc/narasi.txt` — narasi kebutuhan bisnis asli dari pemilik usaha (baca dan periksa relevansinya)
   - `docs/sdlc/02_analysis/02_software_requirements.md` — kebutuhan fungsional F-01 s.d F-09 dan antarmuka CLI
   - `docs/sdlc/02_analysis/03_use_case_diagram.puml` — daftar use case dan relasi aktor
   - `docs/sdlc/02_analysis/06_access_control_matrix.md` — matriks RBAC per modul dan per entitas
   - `docs/sdlc/02_analysis/04_workflow_diagram.puml` — alur kerja transaksi, pembatalan, dan retur
   - `docs/sdlc/03_design/03_system_architecture.md` — arsitektur berlapis, alur data, strategi keamanan, pola state passing

> **PERINGATAN:** Jangan mulai menulis atau mengubah apapun sebelum selesai membaca semua file di atas. Catat semua temuan dulu di memori kerja kamu, baru kemudian eksekusi perbaikan secara menyeluruh dalam satu langkah penulisan.

---

## Tahapan Pelaksanaan (Wajib Diikuti Secara Berurutan)

### TAHAP 1 — Komparasi Mendalam dengan Semua File Referensi

**Langkah 1.1 — Baca `narasi.txt`**
- Baca seluruh isi `docs/sdlc/narasi.txt`.
- Catat semua elemen bisnis yang disebut: jenis layanan, jenis karyawan, alur kerja harian, kebutuhan keamanan, dsb.
- Tandai: apakah setiap elemen bisnis ini sudah terefleksi dalam alur interaksi CLI di dokumen target?
- Jika `narasi.txt` sudah sepenuhnya tercakup oleh file referensi teknis lain, catat kesimpulan tersebut dan lanjutkan. Jangan melewatkan langkah ini.

**Langkah 1.2 — Baca `02_software_requirements.md`**
- Baca seluruh kebutuhan fungsional F-01 s.d F-09.
- Untuk setiap fitur (F-01 hingga F-09), catat:
  - Input apa yang harus diberikan pengguna via CLI?
  - Validasi apa yang harus dilakukan sistem?
  - Output apa yang harus ditampilkan ke layar?
  - Pesan error apa yang harus muncul jika terjadi kesalahan?
- Bandingkan setiap poin dengan alur yang ada di `04_cli_interaction_flow.puml`. Tandai yang hilang, tidak lengkap, atau tidak akurat.

**Langkah 1.3 — Baca `03_use_case_diagram.puml`**
- Catat semua use case dan aktornya (Pemilik, Karyawan).
- Verifikasi: apakah setiap use case sudah memiliki alur interaksi CLI yang merepresentasikannya di diagram target?
- Catat use case yang belum terwakili atau representasinya kurang lengkap.

**Langkah 1.4 — Baca `06_access_control_matrix.md`**
- Catat matriks akses: modul mana yang boleh diakses Karyawan, modul mana yang eksklusif Pemilik.
- Verifikasi: apakah RBAC filtering di Menu Utama dan di setiap sub-menu sudah sesuai persis dengan matriks ini?
- Catat ketidaksesuaian akses yang ditemukan.

**Langkah 1.5 — Baca `04_workflow_diagram.puml`**
- Catat alur transaksi utama, alur pembatalan, dan alur retur.
- Verifikasi: apakah alur di Partition 3 (Transaksi Kasir) sudah konsisten dan selaras dengan `04_workflow_diagram.puml`?
- Catat perbedaan atau ketidakkonsistenan yang ditemukan.

**Langkah 1.6 — Baca `03_system_architecture.md`**
- Catat arsitektur berlapis khususnya Presentation Layer (Bagian CLI).
- Catat alur data Login, Transaksi, Penggajian (Bagian 7).
- Catat aturan keamanan: JWT payload (user_id, role, branch_id, exp 8 jam), idle timeout 10 menit, brute-force 5x, PIN Rp 5.000.000.
- Catat pola State Passing: db_conn, jwt_payload, branch_id diteruskan sebagai argumen fungsi.
- Verifikasi: apakah semua mekanisme keamanan ini sudah tervisualisasi di diagram target?

**Langkah 1.7 — Buat Daftar Temuan Gap**
- Buat daftar temuan di memori kerja kamu berisi:
  - `[MISSING]` — alur/data yang ada di referensi tapi tidak ada di diagram target
  - `[INACCURATE]` — alur yang ada di diagram target tapi berbeda dari referensi
  - `[ORPHAN]` — alur yang ada di diagram target tapi tidak didukung referensi manapun
  - `[SYNTAX_ERROR]` — bagian sintaks PlantUML yang tidak valid atau berpotensi gagal di-render

---

### TAHAP 2 — Validasi Kelengkapan Alur Interaksi CLI

**Langkah 2.1 — Periksa apakah semua alur interaksi berikut sudah ada dan lengkap:**

- [ ] **Alur Login (Partition 1):** prompt username → prompt password → bcrypt verify → gagal: increment counter → gagal >= 5: lock akun → berhasil: generate JWT (user_id, role, branch_id, exp 8 jam) → simpan ke `login_sessions` → catat audit trail "LOGIN" → clear screen → render menu utama
- [ ] **Alur Rendering Menu Utama (Partition 2):** ekstrak role dari JWT → cek validitas JWT → render Menu Pemilik (13 menu + logout) vs Menu Karyawan (7 menu + logout) — menu manajerial TIDAK di-render untuk Karyawan
- [ ] **Alur Idle Timeout dalam loop menu:** deteksi idle >= 10 menit → invalidasi JWT → hapus sesi → tampilkan pesan → kembali ke prompt login
- [ ] **Alur F-02 Transaksi Kasir:** sub-menu (Buat/Batal/Retur) → pilih tipe layanan (Percetakan/ATK/PPOB/Jasa Keuangan/Jasa Teknis) → input ID produk → validasi → input qty → validasi → cek harga grosir/mitra → subtotal → percabangan Percetakan (DP/Lunas → HPP BOM → potong stok → struk → status "Antri") vs non-Percetakan → audit trail → commit
- [ ] **Alur Pembatalan:** input ID transaksi → cek status (>= Proses Desain: DP hangus) vs (< Proses Desain: kembalikan DP) → konfirmasi
- [ ] **Alur Retur:** input ID transaksi → cek 1x24 jam & kelalaian internal → setuju/tolak
- [ ] **Alur F-03 Gudang & BOM (Partition 4):** sub-menu (Lihat Stok/Update Stok/Kelola BOM-Pemilik/Hitung HPP) → masing-masing input/output sesuai SRS F-03
- [ ] **Alur F-04 Job Tracking (Partition 5):** sub-menu (Lihat/Update Status/Arsip Desain) → input ID transaksi → pilih status (Antri/Proses Desain/Produksi/Selesai/Diambil) → input path arsip
- [ ] **Alur F-05 Limbah Produksi (Partition 6):** input ID bahan → input besaran → input alasan → konfirmasi → kurangi stok → tampilkan sisa stok
- [ ] **Alur F-06 SDM & Penggajian (Partition 7):** sub-menu berbeda untuk Pemilik (Absensi/Kasbon/Payroll/Slip Gaji Semua) vs Karyawan (Absensi/Slip Gaji Sendiri) → logika payroll: >= Rp 15.000.000 → Rp 3.000.000, atau 15% pendapatan bersih
- [ ] **Alur F-07 PPOB & Jasa Keuangan (Partition 8):** pilih jenis (Pulsa/Token/Mutasi Bank) → input nominal → cek > Rp 5.000.000: minta PIN Pemilik (bcrypt) → input ID platform → validasi saldo → proses mutasi → peringatan saldo < Rp 150.000
- [ ] **Alur F-08 CRM (Partition 9):** sub-menu Pemilik (Pelanggan/Vendor) vs Karyawan (Pelanggan saja) → input data → simpan
- [ ] **Alur F-09 Pelaporan (Partition 10, Pemilik only):** sub-menu (Laba Rugi/Rekonsiliasi Kas/Data Finansial Sensitif) → input rentang tanggal (DD-MM-YYYY) → validasi format → agregasi data → tabel ASCII
- [ ] **Alur Logout Manual & Idle Timeout (Partition 11):** logout manual pilih [0] → hapus sesi → audit trail "LOGOUT" → kembali ke prompt login; idle >= 10 menit → invalidasi JWT → hapus sesi → kembali ke prompt login

**Langkah 2.2 — Periksa Detail Input/Output setiap Modul:**
- Apakah setiap prompt input sudah menampilkan teks yang jelas? Contoh: `"Masukkan ID Produk:"` bukan hanya `"Input ID"`.
- Apakah setiap output sudah disebutkan jenis tampilannya? (Struk Digital, Tabel ASCII, konfirmasi teks, dsb.)
- Apakah setiap skenario error sudah memiliki pesan error yang ramah dan spesifik?

---

### TAHAP 3 — Validasi Relevansi dan Fokus Dokumen

**Langkah 3.1 — Periksa apakah semua konten memang milik diagram CLI Interaction Flow:**
- Diagram ini harus fokus pada: alur navigasi menu, prompt input pengguna, respons sistem di layar, percabangan berdasarkan role/kondisi, alur error/validation, dan alur keamanan yang terlihat di sisi CLI.
- **Bukan milik dokumen ini:** detail logika bisnis internal (kalkulasi BOM di dalam fungsi), detail DDL database, detail arsitektur kelas/fungsi Python.
- Jika ada elemen yang terlalu masuk ke domain dokumen lain, sederhanakan menjadi label yang cukup informatif tanpa over-detail.

**Langkah 3.2 — Periksa konsistensi penomoran menu:**
- Nomor menu harus konsisten di seluruh diagram.
- Menu Karyawan: [1] s.d [7] + [0] Logout.
- Menu Pemilik: [1] s.d [13] + [0] Logout.
- Setiap sub-menu harus memiliki [0] sebagai opsi "Kembali ke Menu Utama".
- Pastikan referensi ke nomor menu di dalam diagram (misal: "Arahkan ke alur Logout (Partition 11)") konsisten dengan nomor partition aktual.

---

### TAHAP 4 — Validasi Standar Struktur Dokumen PlantUML

**Langkah 4.1 — Periksa kelengkapan elemen struktur diagram:**

- [ ] **Metadata di komentar:** Judul, Versi, Status, Tanggal, Disusun Oleh
- [ ] **Konfigurasi skinparam:** `defaultTextAlignment`, `ArrowColor`, `ActivityBackgroundColor`, `ActivityBorderColor`
- [ ] **Deklarasi swimlane:** `|Pengguna|` dan `|Sistem|` dideklarasikan sebelum partition pertama
- [ ] **Setiap partition** memiliki label yang jelas menyebut nomor partisi, nama modul, dan kode fungsional (F-xx)
- [ ] **start** ada di partition pertama dan **stop** ada di titik-titik akhir yang benar
- [ ] **Tabel Mapping** di komentar akhir: menghubungkan setiap alur CLI dengan modul SRS (F-01 s.d F-09) dan Use Case terkait
- [ ] **Daftar Referensi Dokumen** di komentar paling akhir sebelum `@enduml`
- [ ] **`@enduml`** ada di baris terakhir

**Langkah 4.2 — Validasi sintaks PlantUML secara teliti:**
- Periksa setiap blok `if/else/endif` — pastikan setiap `if` memiliki pasangan `endif` yang tepat.
- Periksa setiap blok `partition` — pastikan semua aksi di dalamnya berada di dalam kurung kurawal yang benar.
- Periksa penggunaan karakter khusus dalam label: karakter `<`, `>`, `&` harus di-escape atau dibungkus dengan `"`.
- Periksa format `repeat/repeat while` — pastikan sintaksnya valid untuk PlantUML Activity Diagram.
- Pastikan tidak ada aksi yang "menggantung" tanpa koneksi ke aksi berikutnya.
- Pastikan swimlane switch (`|Pengguna|` / `|Sistem|`) tidak muncul di dalam blok kondisi yang tidak didukung sintaks PlantUML.

---

### TAHAP 5 — Validasi Kelayakan sebagai Referensi Fase Berikutnya

**Langkah 5.1 — Simulasikan sebagai pembaca dari fase SDLC berikutnya:**
Bayangkan kamu adalah junior programmer yang akan mengerjakan dokumen-dokumen berikut menggunakan `04_cli_interaction_flow.puml` sebagai referensi utama:
- `03_design/05_bom_hpp_design.md` — desain BOM dan HPP
- `03_design/06_security_design.md` — desain keamanan
- `04_implementation/01_coding_standard.md` — standar kode
- `04_implementation/03_module_structure.md` — struktur modul CLI (`cli/menus.py`, `cli/handlers.py`)

**Langkah 5.2 — Untuk setiap dokumen fase berikutnya, periksa:**
- Apakah diagram sudah memberikan informasi yang cukup sebagai landasan untuk membuat kode CLI?
- Apakah masih ada pertanyaan teknis yang tidak terjawab oleh diagram ini? Misal: "Input apa yang harus ada di prompt PPOB?", "Bagaimana format struk digital di CLI?"
- Catat semua gap ini dan tambahkan alur/detail yang kurang ke diagram target.

---

### TAHAP 6 — Validasi Bahasa Indonesia dan Label Diagram

**Langkah 6.1 — Periksa kualitas label dalam diagram:**
- Baca semua label aksi (`:...*;`), label kondisi (`if (...)`), dan label partition.
- Tandai label yang:
  - Terlalu singkat sehingga ambigu (misal: "Input data" → harus spesifik: "Input nama pelanggan & nomor WA")
  - Terlalu panjang sehingga diagram menjadi sesak (pecah menjadi dua aksi berurutan)
  - Menggunakan bahasa campuran Inggris-Indonesia yang tidak konsisten
  - Menggunakan singkatan tanpa penjelasan yang membingungkan

**Langkah 6.2 — Standar label yang harus dipenuhi:**
- Gunakan kalimat aktif singkat: `"Tampilkan [konten]"`, `"Prompt [pertanyaan]:"`, `"Validasi [kondisi]"`, `"Simpan ke [tabel]"`.
- Istilah teknis (JWT, RBAC, bcrypt, BOM, HPP) boleh digunakan apa adanya — sudah menjadi istilah baku proyek ini.
- Nomor menu dalam label harus menggunakan format konsisten: `[1]`, `[2]`, `[0]`.
- Setiap aksi sistem yang menghasilkan output ke layar harus dimulai dengan kata `"Tampilkan"`.
- Setiap aksi sistem yang meminta input harus dimulai dengan kata `"Prompt"`.

---

### TAHAP 7 — Validasi Data Kosong dan Kelengkapan

**Langkah 7.1 — Periksa semua bagian untuk data yang tidak lengkap:**
- Apakah ada aksi dalam diagram yang hanya berisi placeholder seperti `"..."`, `"[TBD]"`, atau `"dst."`?
- Apakah ada modul fungsional yang hanya disebutkan nama partitionnya tanpa alur detail di dalamnya?
- Apakah tabel mapping di komentar sudah mencakup semua alur interaksi yang ada di diagram?
- Apakah daftar referensi dokumen di komentar akhir sudah lengkap dan path-nya valid?

**Langkah 7.2 — Isi semua data yang kosong:**
- Jika ada aksi yang tidak lengkap, lengkapi berdasarkan data dari file referensi yang sudah dibaca di Tahap 1.
- Jangan mengisi data dengan asumsi — gunakan data aktual dari referensi.
- Jika ada alur yang memang tidak bisa ditentukan dari referensi manapun, tandai dengan label: `:[ PERLU DIISI MANUAL: deskripsi kebutuhan ];`

---

### TAHAP 8 — Eksekusi Perbaikan ke Dokumen Target

> **PENTING:** Semua perbaikan harus dituangkan langsung ke file `docs/sdlc/03_design/04_cli_interaction_flow.puml`. Jangan membuat file baru atau file sementara.

**Langkah 8.1 — Tulis ulang atau tambahkan konten yang diperbaiki:**
- Terapkan semua temuan dari Tahap 1–7 langsung ke dokumen.
- Jika ada alur yang perlu ditambahkan, sisipkan di dalam partition yang tepat.
- Jika ada label yang perlu diperbaiki, perbaiki label tersebut secara langsung.
- Jika ada partition baru yang perlu dibuat, tambahkan di posisi yang logis sesuai urutan alur.
- Jika ada sintaks yang tidak valid, perbaiki sintaksnya.

**Langkah 8.2 — Update versi dokumen di metadata komentar:**
- Ubah versi di metadata komentar dari `1.0.0` menjadi `1.1.0`.
- Contoh perubahan:
  ```
  ' Versi: 1.0.0   →   ' Versi: 1.1.0
  ```

**Langkah 8.3 — Status dokumen JANGAN diubah:**
- Status dokumen **tetap `[draft]`** — perubahan status adalah wewenang pemilik proyek, bukan tugasmu.
- Jangan mengubah baris `' Status: [draft]` menjadi apapun.

**Langkah 8.4 — Tambahkan referensi baru jika ada:**
- Jika dalam proses perbaikan kamu menggunakan file referensi yang belum tercantum di bagian komentar `REFERENSI DOKUMEN` di akhir file, tambahkan file tersebut di baris paling bawah daftar tersebut.
- Format: `' [nomor]. path/ke/file`

---

### TAHAP 9 — Verifikasi Akhir Setelah Perbaikan

Setelah semua perbaikan diterapkan, lakukan verifikasi akhir dengan membaca ulang seluruh file dari `@startuml` hingga `@enduml`:

**Checklist Verifikasi Akhir:**
- [ ] Setiap `if` memiliki pasangan `else`/`elseif` dan `endif` yang tepat
- [ ] Setiap `partition` terbuka dan tertutup dengan benar
- [ ] Tidak ada aksi yang menggantung tanpa koneksi
- [ ] Semua 11 partition (Login, Menu Utama, F-02 s.d F-09, Logout) ada dan lengkap
- [ ] Perbedaan menu Pemilik vs Karyawan tervisualisasi jelas di Partition 2
- [ ] RBAC filtering di setiap sub-menu khusus Pemilik sudah benar
- [ ] Alur brute-force (5x gagal → lock) ada di Partition 1
- [ ] Idle timeout (>= 10 menit) ada di loop Menu Utama dan di Partition 11
- [ ] PIN verification untuk nominal > Rp 5.000.000 ada di Partition 3 dan Partition 8
- [ ] Peringatan saldo < Rp 150.000 ada di Partition 8
- [ ] Tabel Mapping di komentar mencakup semua alur
- [ ] Daftar referensi di komentar sudah lengkap dan valid
- [ ] Versi sudah diupdate ke `1.1.0`
- [ ] Status tetap `[draft]`
- [ ] Label menggunakan Bahasa Indonesia yang natural dan tidak ambigu
- [ ] Tidak ada data kosong, placeholder `[TBD]`, atau aksi `"dst."`
- [ ] Skinparam tetap konsisten (Teal, LightCyan, DarkCyan)
- [ ] `@enduml` ada di baris terakhir

---

## Poin Tambahan Spesifik untuk Diagram CLI Interaction Flow

Selain poin-poin umum di atas, khusus untuk diagram Activity Diagram CLI pada proyek AbuCom, periksa juga:

**A. Konsistensi Clear Screen Strategy:**
- Verifikasi bahwa aksi `clear screen` hanya muncul di titik-titik yang tepat: (1) setelah login berhasil, dan (2) saat berpindah ke modul utama dari menu utama.
- Jangan tambahkan `clear screen` di dalam sub-menu atau di antara aksi dalam satu modul.

**B. Kelengkapan Feedback Loop:**
- Setiap input dari `|Pengguna|` harus diikuti oleh minimal satu aksi dari `|Sistem|` (validasi, konfirmasi, atau tampilan data).
- Tidak boleh ada aksi pengguna yang langsung menuju aksi pengguna berikutnya tanpa intervensi sistem.

**C. Konsistensi Label Struk Digital:**
- Setiap transaksi yang berhasil harus menampilkan output berupa "Tampilkan Struk Digital" dengan detail konten struk yang konsisten: item, harga, status pembayaran, dan nomor transaksi.

**D. Validasi Alur Kembali ke Menu:**
- Setiap partition modul (Partition 3 s.d Partition 10) harus memiliki jalur eksplisit untuk kembali ke Menu Utama (Partition 2), baik melalui pilihan `[0] Kembali` maupun setelah selesai satu operasi.
- Pastikan tidak ada dead-end (titik buntu tanpa koneksi ke manapun) dalam diagram.

**E. Validasi Format Tanggal dan Angka:**
- Untuk semua prompt yang meminta tanggal, tampilkan format yang diharapkan: `(DD-MM-YYYY)`.
- Untuk semua prompt yang meminta nominal rupiah, tampilkan satuan: `(dalam Rupiah)`.

**F. Penanganan Input Tidak Valid:**
- Setiap prompt input numerik (pilihan menu, qty, nominal) harus memiliki percabangan: jika input bukan angka atau di luar rentang → tampilkan pesan error → kembali ke prompt yang sama (bukan kembali ke menu).

---

## Output yang Diharapkan

Setelah issue ini selesai diimplementasikan:

1. **File `docs/sdlc/03_design/04_cli_interaction_flow.puml`** sudah diperbarui dengan:
   - Versi `1.1.0` di metadata komentar
   - Semua alur yang hilang sudah ditambahkan
   - Semua label yang ambigu sudah diperbaiki
   - Sintaks PlantUML valid dan bisa di-render
   - Semua data kosong atau placeholder sudah diisi
   - Referensi baru (jika ada) ditambahkan di komentar akhir

2. **Tidak ada file baru** yang dibuat selain perubahan pada file target di atas.

3. **Tidak ada perubahan pada file referensi** — file referensi hanya dibaca, tidak dimodifikasi.

4. **Status di `sdlc.txt` tidak diubah** — perubahan status adalah wewenang pemilik proyek.

---

## Referensi Issue Ini

- `docs/sdlc/03_design/04_cli_interaction_flow.puml` — dokumen target
- `docs/sdlc/narasi.txt`
- `docs/sdlc/02_analysis/02_software_requirements.md`
- `docs/sdlc/02_analysis/03_use_case_diagram.puml`
- `docs/sdlc/02_analysis/06_access_control_matrix.md`
- `docs/sdlc/02_analysis/04_workflow_diagram.puml`
- `docs/sdlc/03_design/03_system_architecture.md`
