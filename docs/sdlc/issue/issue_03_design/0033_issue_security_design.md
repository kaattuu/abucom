# Issue #0033: Pembuatan Dokumen Security Design

## Deskripsi Tugas

Menyusun dokumen utama `06_security_design.md` di folder `docs/sdlc/03_design/`. File ini berstatus `[create_file]`. Dokumen ini adalah dokumen rancangan teknis keamanan yang mendefinisikan secara lengkap arsitektur keamanan sistem AbuCom — mencakup autentikasi berbasis JWT, hashing password bcrypt, Role-Based Access Control (RBAC), audit trail, soft delete framework, proteksi brute-force & idle timeout, validasi PIN transaksi finansial, pencadangan database terenkripsi, strategi penanganan error aman, dan arsitektur keamanan multi-branch.

---

## Persona Implementasi

Bertindaklah sebagai **Senior Information Security Architect** dan **Senior Cybersecurity Engineer** yang memiliki keahlian mendalam dalam:

- Perancangan arsitektur keamanan aplikasi end-to-end untuk sistem informasi bisnis.
- Implementasi autentikasi stateless berbasis JSON Web Token (JWT) dengan algoritma HS256.
- Penerapan hashing password menggunakan bcrypt dengan konfigurasi salt rounds yang aman.
- Perancangan Role-Based Access Control (RBAC) untuk pemisahan hak akses Pemilik vs Karyawan.
- Strategi audit trail imutabel untuk pelacakan forensik aktivitas pengguna.
- Penerapan soft delete framework untuk integritas data historis.
- Mekanisme proteksi brute-force, idle auto-logout, dan validasi PIN transaksi sensitif.
- Pencadangan database otomatis terenkripsi lokal menggunakan mysqldump.
- Penanganan error aman (secure error handling) tanpa kebocoran informasi teknis.
- Standar keamanan industri: NIST Cybersecurity Framework, ISO/IEC 27002:2022.

---

## File Referensi Utama

1. `docs/sdlc/03_design/03_system_architecture.md` — **REFERENSI UTAMA #1**: Berisi arsitektur sistem. Rangkum spesifik:
   - Bagian 5: Arsitektur Berlapis — Security Layer sebagai lapisan terpusat yang mengeksekusi bcrypt, pyjwt, RBAC, dan audit trail.
   - Bagian 9: Arsitektur Keamanan — 9 poin keamanan: JWT Stateless (HS256, exp 8 jam, payload user_id/role/branch_id), Idle Auto-Logout 10 menit, Brute-Force Protection (5x gagal → is_locked=1), RBAC tanpa DB lookup berulang, Soft Delete Framework (is_deleted=1), Validasi PIN transaksi > Rp 5.000.000, Generator Tata Nama File Desain, Pencadangan Database Otomatis (mysqldump, retensi 30 hari), Audit Trail Imutabel.
   - Bagian 10: Strategi Penanganan Error — Stack trace hiding, pesan CLI ramah, rollback otomatis.
   - Bagian 8: Strategi Koneksi Database FP — Pola transaksi ACID, stateless connection, branch_id injection.

2. `docs/sdlc/02_analysis/06_access_control_matrix.md` — **REFERENSI UTAMA #2**: Berisi definisi RBAC. Rangkum spesifik:
   - Bagian 3: Legenda Notasi Akses — C/R/U/D, ✓/✗/Terbatas.
   - Bagian 4: Prinsip Keamanan — Least Privilege, Separation of Duties, Data Classification, Defense in Depth, Fail-Safe Defaults, Complete Mediation.
   - Bagian 5: Definisi Peran — Pemilik (akses absolut) vs Karyawan (operasional terbatas).
   - Bagian 6: Matriks Akses per Modul Fungsional — Tabel lengkap 15+ sub-fitur dengan otorisasi per role.
   - Bagian 7: Matriks Akses per Entitas Data — CRUD per tabel untuk Master, Transaksi, Pendukung & Keamanan.
   - Bagian 8: Daftar Data Sensitif — loans, asset_savings, Laporan Laba Rugi, payroll & employee_loans.
   - Bagian 10: Aturan Audit Trail — 5 kategori operasi yang wajib di-log.
   - Bagian 11: Aturan Keamanan Tambahan — Enkripsi bcrypt rounds=12, JWT HS256 exp 8 jam, SQL Role-Based Filtering, CLI Interface Rendering, Brute Force 5x lockout + delay 500ms, Session Invalidation, Secure Error Handling.

3. `docs/sdlc/02_analysis/01_business_requirements.md` — **REFERENSI UTAMA #3**: Berisi aturan bisnis. Rangkum spesifik:
   - Bagian 4.1: Keamanan & Pemisahan Akses Data — RBAC Pemilik vs Karyawan, Audit Trail mutlak.
   - BR-10: Karyawan tidak boleh melihat data pinjaman bank berbunga dan tabungan pengadaan aset pemilik.
   - Bagian 4.3: Perlindungan Aset Data — Integritas database tanpa manipulasi di luar alur sistem.

4. `docs/sdlc/02_analysis/02_software_requirements.md` — **REFERENSI UTAMA #4**: Berisi spesifikasi teknis. Rangkum spesifik:
   - F-01: Modul Autentikasi — bcrypt rounds=12, JWT exp 8 jam, payload user_id/role/branch_id.
   - F-09: Modul Pelaporan — fungsi penyaring keamanan role (Karyawan difilter dari data sensitif).
   - Bagian 5 Keamanan: RBAC token JWT, enkripsi bcrypt, audit trail wajib.
   - Bagian 5 Keandalan: ACID transaction MySQL, commit/rollback.

5. `docs/sdlc/03_design/01_database_schema.sql` — **REFERENSI UTAMA #5**: Berisi struktur DDL. Rangkum spesifik:
   - Tabel `users` (baris 41-52): username UNIQUE, password_hash VARCHAR(255), role ENUM('Pemilik','Karyawan'), is_active, branch_id FK.
   - Tabel `login_sessions` (baris 400-407): user_id FK, jwt_token VARCHAR(512) UNIQUE, expires_at.
   - Tabel `audit_trail` (baris 446-455): user_id FK, action_type ENUM('INSERT','UPDATE','DELETE','LOGIN','LOGOUT'), target_entity, change_detail TEXT, timestamp. Append-only (INSERT only).
   - Tabel `loans` (baris 428-437): Catatan sensitif — hanya role Pemilik (BR-10).
   - Tabel `asset_savings` (baris 462-470): Catatan sensitif — hanya role Pemilik (BR-10).
   - Kolom `is_active` pada tabel users, vendors, products_services, branches — mekanisme soft delete.

6. `docs/sdlc/01_planning/04_tech_stack_decision.md` — **REFERENSI UTAMA #6**: Berisi keputusan teknologi. Rangkum spesifik:
   - Bagian 5.7: bcrypt 4.3.0 — rounds=12, Apache 2.0, pre-compiled wheel.
   - Bagian 5.8: pyjwt 2.10.1 — HS256, exp 8 jam, MIT license.
   - Bagian 5.6: python-dotenv 1.1.0 — kredensial .env, .gitignore wajib.
   - Paradigma FP murni — semua fungsi keamanan tanpa class.

7. `docs/sdlc/01_planning/05_innovation_proposal.md` — **REFERENSI UTAMA #7**: Berisi 5 inovasi keamanan. Rangkum spesifik:
   - Inovasi 5.1: Pencadangan Database Otomatis Terenkripsi — mysqldump, retensi 30 hari, cron/Task Scheduler.
   - Inovasi 5.2: Brute-Force Protection & Idle Auto-Logout — 5x gagal lockout, idle 10 menit.
   - Inovasi 5.4: Soft Delete Framework — is_deleted=1, WHERE is_deleted=0 wajib.
   - Inovasi 5.5: Validasi PIN Transaksi > Rp 5.000.000 — bcrypt.checkpw(), Maker-Checker pattern.

8. `docs/sdlc/narasi.txt` — **REFERENSI PENDUKUNG**: Berisi konteks bisnis pemilik. Rangkum spesifik:
   - Baris 89: Manajemen Hak Akses — data sensitif pinjaman bank & tabungan pribadi, pembedaan Pemilik vs Karyawan.
   - Baris 85: Audit Trail — catatan aktivitas siapa melakukan apa dan kapan.
   - Baris 24: Pinjaman berbunga Bank BRI & Mandiri — data sensitif.

---

## Instruksi Kelayakan & Kriteria Dokumen Utama

1. **Struktur Dokumen Markdown**: Dokumen harus menggunakan format Markdown (.md) yang rapi, dengan heading hierarkis (H1 untuk judul, H2 untuk bagian utama, H3 untuk sub-bagian), tabel, dan daftar bernomor/bullet.

2. **Metadata Dokumen**: Sertakan tabel metadata di awal: Versi (1.0.0), Status ([create_file]), Tanggal, Persona penyusun.

3. **Cakupan Isi Dokumen yang Wajib Ada**:

   **a. Pendahuluan & Tujuan**: Jelaskan tujuan dokumen Security Design, ruang lingkup, dan hubungannya dengan modul lain (autentikasi, transaksi kasir, gudang, pelaporan keuangan, SDM).

   **b. Prinsip Keamanan Fundamental**: Definisikan 6 prinsip keamanan dari ACM — Least Privilege, Separation of Duties, Data Classification, Defense in Depth, Fail-Safe Defaults, Complete Mediation. Jelaskan penerapan masing-masing prinsip secara spesifik ke konteks sistem AbuCom.

   **c. Arsitektur Autentikasi (Authentication Design)**: Rancang secara detail mekanisme autentikasi:
   - Alur login CLI: input username/password → hash bcrypt (rounds=12) → verifikasi → generate JWT.
   - Struktur payload JWT: `user_id`, `role`, `branch_id`, `exp` (8 jam).
   - Algoritma: HS256 dengan secret_key dari .env.
   - Penyimpanan sesi: tabel `login_sessions` (jwt_token, expires_at).
   - Alur logout: hapus record dari login_sessions, invalidasi token.
   - Sertakan diagram alur (flowchart teks) dari proses login hingga menu render.

   **d. Arsitektur Otorisasi RBAC (Authorization Design)**: Rancang secara detail mekanisme RBAC:
   - Definisi role: Pemilik (akses absolut) vs Karyawan (operasional terbatas).
   - Mekanisme filter menu CLI berdasarkan role dari payload JWT.
   - SQL Role-Based Filtering: klausa WHERE untuk tabel dengan akses Terbatas (users, employees, employee_loans, payroll, incentive_points → WHERE employee_id/user_id = ?).
   - Proteksi data sensitif: loans, asset_savings, Laporan Laba Rugi → UnauthorizedException jika role = Karyawan.
   - Referensikan matriks akses lengkap dari ACM (Bagian 6, 7, 8).

   **e. Desain Audit Trail**: Rancang mekanisme pencatatan audit:
   - Struktur tabel audit_trail: user_id, action_type, target_entity, change_detail, timestamp.
   - 5 kategori operasi yang wajib di-log (dari ACM Bagian 10): Transaksi Keuangan, Jejak Autentikasi, Integritas Barang & Harga, Mutasi SDM & Kasbon, Akses Sensitif Manajerial.
   - Aturan append-only: tidak ada UPDATE/DELETE pada audit_trail dari level aplikasi.
   - Format string change_detail yang terstandar.
   - Implementasi FP: fungsi log_audit(user_id, action_type, target_entity, change_detail, db_conn).

   **f. Soft Delete Framework**: Rancang mekanisme penghapusan lunak:
   - Kolom is_active BOOLEAN DEFAULT TRUE pada semua tabel master.
   - Larangan mutlak penggunaan SQL DELETE dari level aplikasi.
   - Setiap fungsi SELECT wajib menambahkan WHERE is_active = TRUE / WHERE is_deleted = 0.
   - Dampak pada integritas referensial dan audit trail.

   **g. Proteksi Brute-Force & Idle Auto-Logout**: Rancang mekanisme perlindungan sesi:
   - Brute-Force: counter gagal login, lockout setelah 5x gagal berturut-turut, delay 500ms pada respons gagal, mekanisme unlock oleh Pemilik.
   - Idle Timeout: pemantauan time.time() pada event loop CLI, invalidasi sesi setelah 10 menit tidak aktif, hapus JWT dari memori dan login_sessions.

   **h. Validasi PIN Transaksi Finansial**: Rancang mekanisme otorisasi ganda:
   - Threshold: transaksi jasa keuangan > Rp 5.000.000.
   - Alur: COMMIT tertunda → prompt PIN Pemilik → bcrypt.checkpw() → commit/rollback.
   - Pola Maker-Checker: kasir membuat, pemilik menyetujui.

   **i. Pencadangan Database Otomatis Terenkripsi**: Rancang mekanisme backup:
   - Tool: mysqldump via subprocess.
   - Penjadwalan: cron job (Linux) / Task Scheduler (Windows).
   - Kompresi dan enkripsi sandi lokal.
   - Retensi: hapus arsip > 30 hari.
   - Kredensial dari .env via python-dotenv.

   **j. Strategi Penanganan Error Aman**: Rancang mekanisme error handling:
   - Stack trace hiding: tidak boleh muncul di CLI.
   - Pesan CLI ramah dan generik untuk pengguna.
   - Logging detail error di backend internal.
   - Rollback otomatis pada transaksi yang gagal.

   **k. Keamanan Koneksi Database**: Rancang mekanisme keamanan DB:
   - Kredensial dari .env (python-dotenv), .gitignore wajib.
   - Parameterized queries (prepared statements) untuk anti SQL injection.
   - ACID transaction: start_transaction → commit/rollback.
   - branch_id injection wajib pada semua query transaksional.

   **l. Keamanan Multi-Branch**: Rancang isolasi data antar cabang:
   - branch_id dari JWT payload, bukan global variable.
   - WHERE branch_id = ? wajib pada semua query.
   - Pencegahan kebocoran data lintas cabang.

4. **Bahasa Indonesia**: Seluruh isi dokumen menggunakan Bahasa Indonesia yang natural, tidak ambigu, dan mudah dipahami.

5. **Tandai Data Kosong**: Jika ada data yang tidak tersedia di file referensi, tandai dengan `[PERLU DIISI MANUAL: deskripsi]`.

6. **Referensi di Akhir**: Cantumkan daftar file referensi di bagian paling akhir dokumen.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)

### Langkah 1: Baca Semua Referensi Wajib Sampai Tuntas

- Baca keseluruhan isi `docs/sdlc/03_design/03_system_architecture.md` — catat Bagian 5 (Arsitektur Berlapis, Security Layer), Bagian 9 (9 poin Arsitektur Keamanan), Bagian 10 (Strategi Penanganan Error), Bagian 8 (Strategi Koneksi Database FP).
- Baca keseluruhan isi `docs/sdlc/02_analysis/06_access_control_matrix.md` — catat Bagian 3-11: Legenda notasi, prinsip keamanan, definisi role, matriks akses modul, matriks akses entitas, data sensitif, aturan audit trail, aturan keamanan tambahan.
- Baca keseluruhan isi `docs/sdlc/02_analysis/01_business_requirements.md` — catat Bagian 4 (Kebutuhan Non-Fungsional Keamanan), BR-10 (data sensitif), Bagian 4.3 (Perlindungan Aset Data).
- Baca keseluruhan isi `docs/sdlc/02_analysis/02_software_requirements.md` — catat F-01 (Autentikasi), F-09 (Pelaporan + filter keamanan), Bagian 5 (NFR Keamanan & Keandalan).
- Baca keseluruhan isi `docs/sdlc/03_design/01_database_schema.sql` — catat tabel `users` (baris 41-52), `login_sessions` (baris 400-407), `audit_trail` (baris 446-455), `loans` (baris 428-437), `asset_savings` (baris 462-470).
- Baca keseluruhan isi `docs/sdlc/01_planning/04_tech_stack_decision.md` — catat Bagian 5.7 (bcrypt 4.3.0), Bagian 5.8 (pyjwt 2.10.1), Bagian 5.6 (python-dotenv 1.1.0).
- Baca keseluruhan isi `docs/sdlc/01_planning/05_innovation_proposal.md` — catat 5 inovasi keamanan (Backup, Brute-Force, Nama File Desain, Soft Delete, PIN Transaksi).
- Baca baris 24, 85, 89 dari `docs/sdlc/narasi.txt` — catat konteks pinjaman bank, audit trail, hak akses.
- **JANGAN** mulai menulis dokumen sebelum semua file referensi selesai dibaca dan dipahami.

### Langkah 2: Tulis Metadata dan Pendahuluan

- Buka file `docs/sdlc/03_design/06_security_design.md`.
- Hapus konten placeholder yang ada.
- Tulis tabel metadata: Judul "Security Design — Sistem Manajemen Usaha Percetakan AbuCom", Versi 1.0.0, Status [create_file], Tanggal (hari ini), Disusun Oleh (Senior Information Security Architect & Senior Cybersecurity Engineer (AI)).
- Tulis bagian Pendahuluan yang menjelaskan tujuan dokumen, ruang lingkup keamanan, dan hubungannya dengan modul autentikasi, transaksi, gudang, pelaporan, dan SDM.

### Langkah 3: Tulis Prinsip Keamanan Fundamental

- Salin dan elaborasi 6 prinsip dari ACM Bagian 4: Least Privilege, Separation of Duties, Data Classification, Defense in Depth, Fail-Safe Defaults, Complete Mediation.
- Untuk setiap prinsip, berikan contoh penerapan spesifik di AbuCom.

### Langkah 4: Tulis Arsitektur Autentikasi

- Definisikan alur login lengkap: input CLI → hash bcrypt (rounds=12) → verifikasi → generate JWT (HS256, secret_key dari .env).
- Definisikan struktur payload JWT: user_id, role, branch_id, exp (8 jam).
- Definisikan penyimpanan sesi di tabel login_sessions.
- Definisikan alur logout dan invalidasi sesi.
- Buat diagram alur teks (flowchart ASCII/mermaid) untuk proses login.

### Langkah 5: Tulis Arsitektur Otorisasi RBAC

- Definisikan 2 role: Pemilik dan Karyawan dengan hak akses masing-masing.
- Definisikan mekanisme filter menu CLI berdasarkan role.
- Definisikan SQL Role-Based Filtering: query bersyarat WHERE employee_id/user_id = ? untuk tabel Terbatas.
- Definisikan proteksi data sensitif: loans, asset_savings → UnauthorizedException jika Karyawan.
- Referensikan matriks akses dari ACM tanpa menduplikasi seluruh tabel (cukup ringkasan dan pointer).

### Langkah 6: Tulis Desain Audit Trail

- Definisikan struktur tabel audit_trail dengan semua kolom.
- Definisikan 5 kategori operasi wajib log dari ACM Bagian 10.
- Definisikan aturan append-only.
- Definisikan format string change_detail standar.
- Definisikan fungsi FP: log_audit().

### Langkah 7: Tulis Soft Delete, Brute-Force, PIN, Backup, Error Handling

- Soft Delete: is_active/is_deleted, larangan DELETE, WHERE filter wajib.
- Brute-Force: 5x gagal lockout, delay 500ms, unlock oleh Pemilik.
- Idle Timeout: 10 menit, hapus JWT, paksa login ulang.
- PIN Transaksi: threshold Rp 5.000.000, bcrypt.checkpw(), Maker-Checker.
- Backup: mysqldump, cron/Task Scheduler, retensi 30 hari, enkripsi sandi.
- Error Handling: stack trace hiding, pesan ramah, rollback otomatis.

### Langkah 8: Tulis Keamanan Database & Multi-Branch

- Kredensial .env, parameterized queries, ACID transaction.
- branch_id dari JWT, WHERE branch_id = ? wajib, isolasi data.

### Langkah 9: Tulis Referensi dan Validasi

- Cantumkan daftar file referensi di bagian akhir dokumen.
- Validasi kelengkapan: pastikan semua bagian (a-l) dari Instruksi Kelayakan sudah tercakup.
- Pastikan tidak ada instruksi kerja atau komentar proses yang tertinggal di dokumen.
- Pastikan bahasa Indonesia natural dan tidak ambigu.
- Pastikan semua data kosong ditandai `[PERLU DIISI MANUAL]`.

### Langkah 10: Update Status di sdlc.txt

- Setelah dokumen selesai ditulis dan divalidasi, buka file `docs/sdlc/sdlc.txt`.
- Cari baris yang berisi `06_security_design.md` (baris 27).
- Ubah `status: [create_file]` menjadi `status: [done]`.
- Pastikan HANYA baris 27 yang berubah, tidak ada baris lain yang termodifikasi.

---

## Poin Tambahan Spesifik untuk Security Design

1. **Konsistensi dengan System Architecture**: Seluruh desain keamanan WAJIB konsisten dengan 9 poin keamanan yang sudah didefinisikan di Bagian 9 System Architecture. Jangan menambahkan mekanisme yang bertentangan.

2. **FP Murni Tanpa Class**: Seluruh fungsi keamanan (autentikasi, RBAC, audit) WAJIB diimplementasikan sebagai pure functions. Tidak ada class, tidak ada mutable state. Fungsi bcrypt dan pyjwt dipanggil sebagai stateless function calls.

3. **Tabel Ringkasan Mapping Entitas Keamanan**: Sertakan tabel yang memetakan setiap entitas database yang terlibat dalam ekosistem keamanan (users, login_sessions, audit_trail, loans, asset_savings) beserta perannya.

4. **Tabel Klasifikasi Data**: Sertakan tabel klasifikasi data berdasarkan tingkat sensitivitas (Publik, Internal, Rahasia) sesuai ACM Bagian 4 poin 3.

5. **Referensi Standar Industri**: Cantumkan referensi ke NIST Cybersecurity Framework dan ISO/IEC 27002:2022 sebagai landasan desain, sesuai Innovation Proposal.

6. **Integrasi dengan Modul Lain**: Jelaskan bagaimana Security Layer berinteraksi dengan setiap lapisan arsitektur (Presentation, Application/Service, Data Access, Utility) — sesuai diagram di System Architecture Bagian 5.

7. **Skenario Serangan & Mitigasi**: Dokumentasikan skenario serangan potensial (brute-force, session hijacking, SQL injection, privilege escalation, data tampering) beserta mitigasi yang sudah dirancang.

---

## Checklist Penerimaan (Definition of Done)

- [ ] File `docs/sdlc/03_design/06_security_design.md` berisi dokumen rancangan keamanan lengkap
- [ ] Metadata dokumen lengkap (versi, status, tanggal, persona)
- [ ] 6 prinsip keamanan fundamental terdefinisi dengan contoh penerapan AbuCom
- [ ] Arsitektur autentikasi lengkap (bcrypt, JWT, login/logout flow, diagram)
- [ ] Arsitektur otorisasi RBAC lengkap (role, menu filter, SQL filter, data sensitif)
- [ ] Desain audit trail lengkap (struktur, 5 kategori, append-only, format change_detail)
- [ ] Soft delete framework terdokumentasi
- [ ] Proteksi brute-force & idle auto-logout terdokumentasi
- [ ] Validasi PIN transaksi finansial terdokumentasi
- [ ] Pencadangan database otomatis terenkripsi terdokumentasi
- [ ] Strategi penanganan error aman terdokumentasi
- [ ] Keamanan koneksi database terdokumentasi (parameterized queries, ACID)
- [ ] Keamanan multi-branch terdokumentasi (branch_id isolation)
- [ ] Tabel mapping entitas keamanan tersedia
- [ ] Tabel klasifikasi data tersedia
- [ ] Skenario serangan & mitigasi terdokumentasi
- [ ] Konsisten dengan System Architecture Bagian 9
- [ ] Bahasa Indonesia natural dan tidak ambigu
- [ ] Data kosong ditandai dengan `[PERLU DIISI MANUAL]`
- [ ] Referensi dokumen tercantum di bagian akhir
- [ ] Dokumen bersih tanpa instruksi kerja atau komentar proses
- [ ] Status di sdlc.txt berubah dari [create_file] ke [done]
