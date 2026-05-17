# Issue Validasi Dokumen Security Design

## Deskripsi Tugas

Melakukan pemeriksaan, analisis, dan validasi secara ketat terhadap dokumen utama `06_security_design.md` yang saat ini berstatus `[draft]` di folder `docs/sdlc/03_design/`. Tujuan validasi ini adalah memastikan dokumen tersebut akurat, lengkap, konsisten dengan semua file referensi, memiliki standar struktur dokumen industri yang layak, dan siap dijadikan acuan utama bagi fase SDLC selanjutnya (Implementation & Testing).

---

## Persona Implementasi

Bertindaklah sebagai **Senior Information Security Architect** yang juga merangkap **Principal Technical Writer** berpengalaman, dengan keahlian mendalam dalam:

- Audit dan validasi dokumen rancangan keamanan perangkat lunak (Security Design Review).
- Penguasaan mendalam atas standar NIST Cybersecurity Framework dan ISO/IEC 27002:2022.
- Analisis konsistensi lintas dokumen SDLC (BRD, SRS, ACM, System Architecture, Database Schema).
- Perancangan dan validasi mekanisme JWT, bcrypt, RBAC, Audit Trail, dan Soft Delete.
- Penulisan dokumentasi teknis berbahasa Indonesia yang presisi, tidak ambigu, dan ramah implementasi.
- Kemampuan mendeteksi celah, inkonsistensi, data kosong, dan bagian yang berpotensi menimbulkan halusinasi pada implementor yang lebih junior.

**Penting**: Kamu adalah validator, bukan penulis dari awal. Tugasmu adalah memeriksa dokumen yang sudah ada, menemukan kekurangan, dan memperbaikinya langsung pada file `06_security_design.md`.

---

## File yang Akan Divalidasi

- **File Target**: `docs/sdlc/03_design/06_security_design.md`
- **Status Saat Ini**: `[draft]`
- **Versi Saat Ini**: `1.0.0`

---

## File Referensi Wajib Dibaca

Baca semua file berikut secara menyeluruh sebelum memulai validasi. Jangan lewatkan satu pun.

1. `docs/sdlc/03_design/03_system_architecture.md` — Referensi utama arsitektur keamanan berlapis. Fokus pada: Bagian 5 (Security Layer), Bagian 8 (Koneksi Database FP), Bagian 9 (9 poin Arsitektur Keamanan), Bagian 10 (Strategi Penanganan Error).

2. `docs/sdlc/02_analysis/06_access_control_matrix.md` — Referensi utama RBAC. Fokus pada: Bagian 3 (Legenda), Bagian 4 (6 Prinsip Keamanan), Bagian 5 (Definisi Role), Bagian 6 (Matriks Modul), Bagian 7 (Matriks Entitas Data), Bagian 8 (Data Sensitif), Bagian 10 (Aturan Audit Trail), Bagian 11 (Aturan Keamanan Tambahan).

3. `docs/sdlc/02_analysis/01_business_requirements.md` — Referensi aturan bisnis. Fokus pada: Bagian 4.1 (Keamanan & Pemisahan Akses), BR-10 (data sensitif pinjaman & tabungan), Bagian 4.3 (Perlindungan Aset Data).

4. `docs/sdlc/02_analysis/02_software_requirements.md` — Referensi spesifikasi teknis. Fokus pada: F-01 (Autentikasi), F-09 (Pelaporan & filter keamanan), Bagian 5 NFR (Keamanan & Keandalan).

5. `docs/sdlc/03_design/01_database_schema.sql` — Referensi DDL. Fokus pada: tabel `users`, `login_sessions`, `audit_trail`, `loans`, `asset_savings`, dan kolom `is_active`/`is_deleted` pada tabel master.

6. `docs/sdlc/01_planning/04_tech_stack_decision.md` — Referensi teknologi. Fokus pada: bcrypt 4.3.0 (rounds=12), pyjwt 2.10.1 (HS256, exp 8 jam), python-dotenv 1.1.0, paradigma Functional Programming (FP) murni.

7. `docs/sdlc/01_planning/05_innovation_proposal.md` — Referensi inovasi keamanan. Fokus pada: Inovasi 5.1 (Backup Terenkripsi), Inovasi 5.2 (Brute-Force & Idle Logout), Inovasi 5.4 (Soft Delete), Inovasi 5.5 (PIN Transaksi > Rp 5.000.000).

8. `docs/sdlc/narasi.txt` — Referensi konteks bisnis. Fokus pada: baris tentang pinjaman bank (BRI & Mandiri), audit trail, dan pemisahan hak akses Pemilik vs Karyawan.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)

### Langkah 1: Baca Dokumen Target Secara Menyeluruh

- Buka dan baca seluruh isi `docs/sdlc/03_design/06_security_design.md` dari baris pertama hingga terakhir.
- Catat setiap bagian (heading, sub-heading, tabel, dan teks) yang ada di dalamnya.
- Buat catatan internal tentang bagian mana yang tampak kurang, ambigu, atau berpotensi tidak akurat.
- **Jangan ubah apapun dulu**. Ini adalah tahap pembacaan awal saja.

### Langkah 2: Baca Semua File Referensi Secara Menyeluruh

- Baca satu per satu semua file referensi yang tercantum di bagian "File Referensi Wajib Dibaca" di atas.
- Untuk setiap file referensi, catat poin-poin data dan informasi yang **seharusnya** ada atau **seharusnya dihindari** dalam dokumen Security Design.
- Susun daftar mental atau catatan: "informasi X ada di referensi Y, apakah sudah ada di dokumen target?"
- **Jangan mulai menulis perbaikan dulu** sebelum semua referensi selesai dibaca.

### Langkah 3: Validasi Kelengkapan Isi (Coverage Check)

Periksa apakah semua bagian wajib berikut sudah ada dan sudah terisi dengan benar di dokumen target. Centang secara mental setiap poin:

**a. Metadata Dokumen**
- Apakah ada tabel metadata? (Versi, Status, Tanggal, Disusun Oleh)
- Apakah Status masih `[draft]`? (Ini benar, jangan ubah status di tahap validasi ini)

**b. Pendahuluan & Tujuan**
- Apakah sudah menjelaskan tujuan dokumen Security Design?
- Apakah sudah menyebutkan ruang lingkup yang mencakup: autentikasi, otorisasi, perlindungan data sensitif, audit trail, dan ketahanan terhadap serangan?
- Apakah sudah menyebut standar industri (NIST CSF, ISO/IEC 27002:2022)?
- Apakah sudah menjelaskan hubungan Security Layer dengan modul lain (Autentikasi, Kasir, Gudang, Pelaporan, SDM)?

**c. Prinsip Keamanan Fundamental**
- Apakah sudah ada 6 prinsip? (Least Privilege, Separation of Duties, Data Classification, Defense in Depth, Fail-Safe Defaults, Complete Mediation)
- Apakah setiap prinsip dilengkapi contoh penerapan spesifik di konteks AbuCom?
- Bandingkan dengan ACM Bagian 4 — apakah ada prinsip yang terlewat atau definisinya berbeda?

**d. Arsitektur Autentikasi**
- Apakah alur login CLI sudah dijelaskan langkah demi langkah? (input → bcrypt verifikasi → generate JWT → simpan sesi → render menu)
- Apakah algoritma JWT disebutkan secara eksplisit? (HS256)
- Apakah bcrypt rounds=12 disebutkan secara eksplisit?
- Apakah payload JWT lengkap? (user_id, role, branch_id, exp dengan durasi 8 jam)
- Apakah secret_key disebutkan berasal dari `.env`?
- Apakah tabel `login_sessions` disebutkan untuk penyimpanan sesi?
- Apakah alur logout (invalidasi token & hapus dari `login_sessions`) sudah ada?
- Apakah ada diagram alur (flowchart teks) untuk proses login?

**e. Arsitektur Otorisasi RBAC**
- Apakah 2 role (Pemilik & Karyawan) didefinisikan dengan hak akses masing-masing?
- Apakah mekanisme filter menu CLI berdasarkan role dari JWT dijelaskan?
- Apakah SQL Role-Based Filtering dijelaskan? (WHERE employee_id/user_id = ? untuk tabel Terbatas)
- Apakah proteksi data sensitif dijelaskan? (loans, asset_savings → UnauthorizedException jika role = Karyawan)
- Apakah ada referensi ke ACM untuk matriks akses lengkap?

**f. Desain Audit Trail**
- Apakah struktur tabel `audit_trail` disebutkan dengan semua kolomnya? (id, user_id, action_type, target_entity, change_detail, timestamp)
- Apakah 5 kategori operasi wajib log disebutkan? (Transaksi Keuangan, Jejak Autentikasi, Integritas Barang & Harga, Mutasi SDM & Kasbon, Akses Sensitif Manajerial)
- Apakah aturan append-only (hanya INSERT, tidak ada UPDATE/DELETE) sudah ada?
- Apakah format string `change_detail` sudah distandarisasi dengan contoh?
- Apakah fungsi FP `log_audit()` sudah didefinisikan dengan parameter lengkap?

**g. Soft Delete Framework**
- Apakah kolom `is_active` / `is_deleted` pada tabel master disebutkan?
- Apakah larangan mutlak penggunaan SQL `DELETE` dari level aplikasi sudah ada?
- Apakah aturan `WHERE is_active = TRUE` / `WHERE is_deleted = 0` pada setiap SELECT sudah ada?
- Apakah pengecualian untuk tabel `login_sessions` (boleh DELETE) sudah disebutkan secara eksplisit?

**h. Proteksi Brute-Force & Idle Auto-Logout**
- Apakah threshold brute-force disebutkan secara eksplisit? (5x gagal → lockout)
- Apakah delay respons 500ms pada kegagalan login disebutkan?
- Apakah mekanisme unlock oleh Pemilik disebutkan?
- Apakah durasi idle timeout disebutkan secara eksplisit? (10 menit)
- Apakah mekanisme penghapusan JWT dari memori dan `login_sessions` saat idle timeout disebutkan?
- Apakah kolom `is_locked` pada tabel `users` disebutkan sebagai media penyimpanan status kunci?

**i. Validasi PIN Transaksi Finansial**
- Apakah threshold transaksi disebutkan secara eksplisit? (> Rp 5.000.000)
- Apakah modul spesifik yang memicu validasi PIN disebutkan? (Jasa Keuangan)
- Apakah alur Maker-Checker dijelaskan? (kasir membuat → COMMIT ditahan → Pemilik input PIN → bcrypt.checkpw() → commit/rollback)

**j. Pencadangan Database Otomatis Terenkripsi**
- Apakah tool yang digunakan disebutkan? (mysqldump via subprocess Python)
- Apakah penjadwalan disebutkan untuk dua OS? (cron job Linux & Task Scheduler Windows)
- Apakah mekanisme enkripsi sandi lokal dari `.env` disebutkan?
- Apakah retensi 30 hari disebutkan secara eksplisit?

**k. Strategi Penanganan Error Aman**
- Apakah stack trace hiding (tidak boleh muncul ke CLI) disebutkan?
- Apakah pesan error ramah pengguna (generik) disebutkan dengan contoh kalimat?
- Apakah logging detail error ke backend internal disebutkan?
- Apakah rollback otomatis (`connection.rollback()`) pada kegagalan transaksi disebutkan?

**l. Keamanan Koneksi Database & Multi-Branch**
- Apakah penggunaan parameterized queries (prepared statements) disebutkan?
- Apakah pengelolaan kredensial via `python-dotenv` dan `.gitignore` disebutkan?
- Apakah ACID transaction (start → commit/rollback) disebutkan?
- Apakah isolasi `branch_id` dari JWT (bukan dari variabel bebas) disebutkan?
- Apakah klausa `WHERE branch_id = ?` pada semua query transaksional disebutkan?

**m. Tabel Ringkasan & Skenario Serangan**
- Apakah ada tabel klasifikasi data? (Publik/Operasional, Internal Terbatas, Rahasia/Sensitif)
- Apakah ada tabel mapping entitas keamanan? (users, login_sessions, audit_trail, loans, asset_savings)
- Apakah ada tabel skenario serangan & mitigasi? (Brute-Force, SQL Injection, Privilege Escalation, Session Hijacking, Data Tampering)

**n. Referensi**
- Apakah bagian Referensi ada di paling akhir dokumen?
- Apakah semua file referensi yang benar-benar digunakan sudah tercantum?

### Langkah 4: Validasi Konsistensi Lintas Dokumen

Lakukan pengecekan konsistensi antara dokumen target dengan file referensi. Periksa setiap poin berikut:

- **Nilai bcrypt rounds**: Dokumen target harus menyebut `rounds=12`. Jika menyebut nilai lain, perbaiki sesuai `04_tech_stack_decision.md`.
- **Durasi JWT exp**: Dokumen target harus menyebut `8 jam`. Jika berbeda, perbaiki.
- **Threshold brute-force**: Dokumen target harus menyebut `5x gagal`. Jika berbeda, perbaiki.
- **Threshold idle timeout**: Dokumen target harus menyebut `10 menit`. Jika berbeda, perbaiki.
- **Threshold PIN transaksi**: Dokumen target harus menyebut `> Rp 5.000.000`. Jika berbeda, perbaiki.
- **Retensi backup**: Dokumen target harus menyebut `30 hari`. Jika berbeda, perbaiki.
- **Nama kolom tabel**: Pastikan nama kolom di dokumen target konsisten dengan DDL di `01_database_schema.sql`. Contoh: `is_active`, `password_hash`, `jwt_token`, `expires_at`, `action_type`, `target_entity`, `change_detail`.
- **Algoritma JWT**: Dokumen target harus menyebut `HS256`. Jika berbeda, perbaiki.
- **6 Prinsip Keamanan**: Nama dan definisi 6 prinsip harus konsisten dengan ACM Bagian 4. Jika ada perbedaan nama atau definisi, sesuaikan dengan ACM.
- **5 Kategori Audit Trail**: Nama dan cakupan 5 kategori harus konsisten dengan ACM Bagian 10. Periksa apakah ada kategori yang terlewat atau namanya berbeda.
- **Paradigma FP**: Pastikan tidak ada penyebutan `class` atau `object-oriented` dalam konteks implementasi fungsi keamanan. Semua harus `pure function` / `stateless`.

### Langkah 5: Validasi Fokus & Relevansi Isi (Content Relevance Check)

Periksa apakah dokumen target hanya memuat informasi yang relevan dengan Security Design. Hapus atau tandai bagian yang tidak seharusnya ada:

- Jika ada penjelasan logika bisnis yang seharusnya ada di BRD, bukan di Security Design → hapus atau sederhanakan menjadi referensi saja.
- Jika ada spesifikasi fitur yang seharusnya ada di SRS, bukan di Security Design → hapus atau sederhanakan.
- Jika ada detail DDL SQL yang berlebihan (sudah ada di `01_database_schema.sql`) → cukup sebut nama tabel dan kolom relevan saja, jangan copy-paste DDL.
- Pastikan dokumen ini TIDAK menduplikasi seluruh isi ACM, cukup merangkum poin keamanan yang relevan dan mengarahkan pembaca ke ACM untuk detail matriks akses lengkap.

### Langkah 6: Validasi Standar Struktur Dokumen Industri

Periksa apakah struktur dokumen sudah memenuhi standar dokumen teknis profesional:

- Apakah ada H1 tunggal sebagai judul dokumen?
- Apakah heading hierarkis digunakan dengan benar? (H1 → H2 → H3, tidak ada yang melompat)
- Apakah tabel digunakan untuk data tabular? (metadata, matriks, klasifikasi)
- Apakah daftar bernomor digunakan untuk langkah berurutan?
- Apakah daftar bullet digunakan untuk poin-poin tidak berurutan?
- Apakah ada bagian pendahuluan, isi utama, dan penutup (referensi)?
- Apakah tidak ada bagian yang hanya berisi satu kalimat tanpa elaborasi?
- Apakah tidak ada heading yang kosong tanpa konten di bawahnya?

### Langkah 7: Validasi Bahasa Indonesia

Periksa kualitas bahasa Indonesia di seluruh dokumen:

- Baca setiap paragraf. Apakah kalimatnya dapat dipahami tanpa membaca ulang?
- Apakah ada kalimat yang terlalu panjang (lebih dari 3 klausa)? Jika ada, pecah menjadi kalimat lebih pendek.
- Apakah ada istilah teknis bahasa Inggris yang digunakan tanpa penjelasan atau konteks? Jika ada, tambahkan penjelasan singkat dalam tanda kurung atau italic pada kemunculan pertama.
- Apakah ada kata yang ambigu atau bermakna ganda? Jika ada, ganti dengan kata yang lebih presisi.
- Apakah instruksi dalam dokumen (seperti "wajib", "dilarang") dirumuskan dengan kalimat aktif yang jelas? Contoh yang benar: "Kode aplikasi wajib menggunakan parameterized queries." Contoh yang salah: "Parameterized queries sebaiknya digunakan."
- Apakah konsistensi penggunaan istilah terjaga? Contoh: jangan bergantian menyebut "JWT Token" dan "token" dan "access token" untuk hal yang sama tanpa definisi sebelumnya.

### Langkah 8: Validasi Kelayakan Sebagai Referensi Fase Selanjutnya

Pikirkan sudut pandang implementor (Junior Programmer atau AI model lain) yang akan membaca dokumen ini sebagai acuan untuk fase Implementation (04_implementation). Periksa:

- Apakah setelah membaca dokumen ini, implementor tahu **secara pasti** library apa yang digunakan untuk autentikasi? (bcrypt 4.3.0, pyjwt 2.10.1) → Jika tidak, tambahkan.
- Apakah implementor tahu **secara pasti** berapa rounds bcrypt dan berapa lama JWT berlaku? → Jika tidak, tambahkan.
- Apakah implementor tahu **secara pasti** kolom-kolom apa di tabel `audit_trail` yang harus diisi saat logging? → Jika tidak, tambahkan.
- Apakah implementor tahu **secara pasti** kapan harus memanggil `rollback()`? → Jika tidak, tambahkan.
- Apakah implementor tahu **secara pasti** tabel mana saja yang "Rahasia" dan tidak boleh diakses oleh Karyawan? → Jika tidak, tambahkan.
- Apakah implementor tahu **secara pasti** format string `change_detail` yang harus ditulis saat log audit? → Jika tidak, tambahkan contoh nyata.
- Apakah implementor tahu **secara pasti** di mana menyimpan `secret_key` JWT dan bagaimana cara membacanya? → Jika tidak, tambahkan.

### Langkah 9: Periksa dan Isi Data Kosong

- Baca seluruh dokumen target dan cari bagian yang datanya belum terisi, berupa placeholder, atau tanda `[PERLU DIISI MANUAL]`.
- Untuk setiap data kosong yang ditemukan, cari informasinya di file referensi yang ada.
- Jika data tersedia di file referensi, isi langsung dengan data yang benar.
- Jika data **tidak tersedia** di file referensi manapun dan berada di luar ruang lingkup yang bisa diasumsikan, biarkan dengan keterangan `[PERLU DIISI MANUAL: <deskripsi data yang dibutuhkan>]`.
- Pastikan tidak ada heading, tabel, atau bagian yang dibiarkan kosong tanpa konten.

### Langkah 10: Lakukan Perbaikan pada File Target

Setelah menyelesaikan semua validasi di Langkah 1–9, lakukan perbaikan langsung pada file `docs/sdlc/03_design/06_security_design.md`:

- **Perbaikan konten**: Tambahkan bagian yang kurang, perbaiki data yang salah, lengkapi informasi yang belum ada.
- **Perbaikan bahasa**: Perbaiki kalimat ambigu, kalimat terlalu panjang, atau istilah tidak konsisten.
- **Perbaikan struktur**: Perbaiki heading yang salah level, tabel yang kurang kolom, atau daftar yang format tidak konsisten.
- **Tambah referensi baru**: Jika dalam proses perbaikan kamu menggunakan data dari file referensi yang belum tercantum di bagian Referensi dokumen target, tambahkan file tersebut ke daftar Referensi di bagian akhir dokumen.
- **Update versi**: Ubah versi dokumen dari `1.0.0` menjadi `1.1.0` sebagai tanda dokumen telah mengalami perbaikan. Status tetap `[draft]` (jangan ubah status).
- **Jangan sisakan** instruksi kerja, komentar proses, atau catatan validator di dalam dokumen final.

### Langkah 11: Validasi Akhir Sebelum Selesai

Sebelum menyatakan selesai, lakukan satu kali bacaan akhir pada dokumen yang sudah diperbaiki:

- Pastikan semua checklist di bagian "Checklist Penerimaan" sudah terpenuhi.
- Pastikan versi sudah berubah menjadi `1.1.0`.
- Pastikan tidak ada teks instruksi atau placeholder yang tersisa.
- Pastikan daftar referensi di bagian akhir sudah lengkap dan akurat.

### Langkah 12: Update Status di sdlc.txt

- Buka file `docs/sdlc/sdlc.txt`.
- Cari baris yang berisi `06_security_design.md` dengan status `[draft]`.
- Ubah `status: [draft]` menjadi `status: [check]`.
- Pastikan **hanya baris tersebut** yang berubah. Tidak ada baris lain yang boleh dimodifikasi.
- Simpan file.

---

## Poin Tambahan Spesifik untuk Validasi Security Design

1. **Konsistensi FP Murni**: Pastikan dokumen tidak menggunakan terminologi OOP (class, object, instance, method) dalam menjelaskan implementasi fungsi keamanan. Ganti dengan terminologi FP: "fungsi", "pemanggilan fungsi", "pure function", "stateless".

2. **Spesifisitas Contoh change_detail**: Bagian format `change_detail` pada Audit Trail harus menyertakan minimal 3 contoh string nyata yang berbeda konteks. Contoh: untuk login, untuk update stok, untuk transaksi keuangan. Jika kurang dari 3 contoh, tambahkan.

3. **Kelengkapan Tabel Skenario Serangan**: Tabel skenario serangan harus mencakup minimal 5 jenis serangan: Brute-Force Attack, SQL Injection, Privilege Escalation, Session Hijacking, dan Data Tampering (Kasir Fraud). Jika ada yang kurang, tambahkan baris yang sesuai.

4. **Eksplisitasi Pengecualian Soft Delete**: Dokumen harus secara eksplisit menyebutkan bahwa tabel `login_sessions` adalah **satu-satunya pengecualian** yang boleh menggunakan perintah `DELETE` secara fisik dari level aplikasi. Jika tidak ada pernyataan ini, tambahkan.

5. **Konteks Multi-Branch pada Setiap Mekanisme**: Dokumen harus menjelaskan bahwa `branch_id` dari JWT harus disertakan bukan hanya pada query transaksional, tetapi juga relevan pada: filter laporan, isolasi data audit trail, dan scope validasi PIN. Periksa apakah hal ini sudah dijelaskan.

6. **Referensi ke narasi.txt**: Pastikan konteks bisnis dari `narasi.txt` (pinjaman bank BRI & Mandiri sebagai data sensitif, kebutuhan audit trail untuk forensik bisnis) sudah terangkum dalam dokumen. Jika belum, tambahkan kalimat konteks yang relevan dan cantumkan `narasi.txt` di daftar referensi.

7. **Kejelasan Threshold dan Nilai Numerik**: Setiap nilai numerik dalam dokumen (5x gagal, 10 menit, 8 jam, rounds=12, Rp 5.000.000, 30 hari, 500ms) harus ditulis dengan format yang konsisten dan jelas. Hindari menulis "beberapa menit" atau "beberapa kali" — selalu gunakan angka eksplisit.

---

## Checklist Penerimaan (Definition of Done)

- [ ] Seluruh file referensi sudah dibaca sebelum mulai menulis perbaikan
- [ ] Metadata dokumen lengkap (Versi `1.1.0`, Status `[draft]`, Tanggal diperbarui, Persona)
- [ ] 6 prinsip keamanan fundamental ada dan konsisten dengan ACM Bagian 4
- [ ] Arsitektur autentikasi lengkap dengan diagram alur teks
- [ ] Payload JWT lengkap (user_id, role, branch_id, exp 8 jam, algoritma HS256)
- [ ] Arsitektur otorisasi RBAC lengkap (2 role, filter menu CLI, SQL filter, data sensitif)
- [ ] Desain audit trail lengkap (struktur tabel, 5 kategori, append-only, format change_detail dengan ≥3 contoh)
- [ ] Soft delete framework lengkap termasuk pengecualian tabel `login_sessions`
- [ ] Proteksi brute-force (5x, 500ms, unlock Pemilik) dan idle auto-logout (10 menit) terdokumentasi
- [ ] Validasi PIN transaksi (> Rp 5.000.000, Maker-Checker) terdokumentasi
- [ ] Pencadangan otomatis terenkripsi (mysqldump, cron/Task Scheduler, retensi 30 hari) terdokumentasi
- [ ] Penanganan error aman (stack trace hiding, pesan ramah, rollback) terdokumentasi
- [ ] Keamanan koneksi database (parameterized queries, ACID, .env) terdokumentasi
- [ ] Isolasi multi-branch (branch_id dari JWT, WHERE branch_id = ?) terdokumentasi
- [ ] Tabel klasifikasi data (Publik, Internal Terbatas, Rahasia) ada dan akurat
- [ ] Tabel mapping entitas keamanan ada dan akurat
- [ ] Tabel skenario serangan & mitigasi ada (minimal 5 jenis serangan)
- [ ] Semua nilai numerik eksplisit dan konsisten
- [ ] Semua terminologi konsisten (tidak campur antara istilah berbeda untuk hal yang sama)
- [ ] Bahasa Indonesia natural, tidak ambigu, dan mudah dipahami junior programmer
- [ ] Tidak ada data kosong yang dibiarkan tanpa keterangan
- [ ] Tidak ada instruksi kerja atau komentar proses yang tersisa di dokumen
- [ ] Daftar referensi di bagian akhir lengkap (semua file yang digunakan tercantum)
- [ ] Versi dokumen berubah menjadi `1.1.0`
- [ ] Status di `sdlc.txt` diperbarui dari `[draft]` menjadi `[check]`
