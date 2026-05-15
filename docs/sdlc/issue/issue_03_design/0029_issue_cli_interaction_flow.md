# Issue #0029: Pembuatan Dokumen CLI Interaction Flow

## Deskripsi Tugas

Menyusun dokumen utama `04_cli_interaction_flow.puml` di folder `docs/sdlc/03_design/`. File ini berstatus `[create_file]`. Dokumen ini adalah diagram PlantUML Activity Diagram yang memvisualisasikan seluruh alur interaksi pengguna dengan antarmuka CLI aplikasi AbuCom — mulai dari login, navigasi menu utama berdasarkan role (Pemilik/Karyawan), hingga eksekusi setiap sub-menu modul fungsional dan proses logout/idle timeout.

---

## Persona Implementasi

Bertindaklah sebagai **Senior UX Architect** dan **Senior CLI Interaction Designer** yang memiliki keahlian mendalam dalam:

- Perancangan alur interaksi pengguna (User Interaction Flow) untuk aplikasi berbasis Command Line Interface (CLI).
- Pembuatan diagram Activity Diagram menggunakan sintaks PlantUML (`@startuml`/`@enduml`).
- Visualisasi navigasi menu hierarkis berbasis angka dengan percabangan role RBAC.
- Perancangan alur input/output terminal yang intuitif, terstruktur, dan tidak ambigu.
- Pemahaman arsitektur berlapis (Layered Architecture) khususnya Presentation Layer CLI.
- Penerapan prinsip keamanan (idle timeout, brute-force protection, RBAC menu filtering) dalam alur interaksi.

---

## File Referensi Utama

1. `docs/sdlc/03_design/03_system_architecture.md` — **REFERENSI UTAMA #1**: Berisi arsitektur berlapis, struktur direktori proyek, alur data utama (Login, Transaksi Kasir, Penggajian), strategi keamanan (JWT, RBAC, idle timeout, brute-force), dan pola State Passing. Rangkum:
   - Presentation Layer: `cli/menus.py` (render navigasi dinamis berdasar RBAC) dan `cli/handlers.py` (prompt masukan pengguna CLI).
   - Alur Login (Bagian 7.1): prompt username/password → bcrypt verify → JWT generate (payload: user_id, role, branch_id, exp 8 jam) → session store di `login_sessions` → audit trail "LOGIN" → menu render berdasarkan role → idle timeout 10 menit.
   - Alur Transaksi Kasir (Bagian 7.2): pilih jenis pesanan → input ID produk & qty → kalkulasi harga (pricing_tiers, grosir/mitra) → kalkulasi BOM & HPP → potong stok → catat transaksi → audit trail → commit.
   - Alur Penggajian (Bagian 7.3): trigger manual → hitung pendapatan → skema gaji (tetap Rp 3.000.000 jika >= Rp 15.000.000, atau 15%) → akumulasi poin insentif → potong kasbon → slip gaji CLI.
   - Pola State Passing (Bagian 14): semua state (db_conn, jwt_payload, branch_id) diteruskan sebagai argumen fungsi, bukan global.
   - Menu CLI dirender dinamis berdasarkan role JWT — menu yang tidak diizinkan untuk Karyawan tidak pernah di-render.
   - Brute-force: 5x gagal login → akun terkunci.
   - Idle timeout: 10 menit tanpa aktivitas → auto-logout.

2. `docs/sdlc/02_analysis/02_software_requirements.md` — **REFERENSI UTAMA #2**: Berisi kebutuhan fungsional F-01 s.d F-09 dan antarmuka CLI. Rangkum:
   - F-01: Autentikasi — prompt username & password, bcrypt verify, JWT generate, clear screen, menu utama render sesuai role.
   - F-02: Transaksi Kasir — pilih tipe layanan (1.Percetakan, 2.ATK, 3.PPOB, 4.Jasa), input ID barang, qty, status pembayaran (DP/Lunas), struk digital CLI.
   - F-03: Gudang & BOM — input pembaruan inventaris, ID produk BOM, besaran pemakaian, output HPP & sisa stok.
   - F-04: Job Tracking — input ID Transaksi, status (Antri/Proses Desain/Produksi/Selesai/Diambil), path arsip desain.
   - F-05: Waste Management — input ID bahan baku, nominal pemakaian, alasan pembuangan.
   - F-06: SDM & Penggajian — input ID karyawan kasbon, log kehadiran masuk/keluar, trigger payroll.
   - F-07: PPOB & Jasa Keuangan — jenis transaksi, nominal, ID platform, peringatan saldo < Rp 150.000.
   - F-08: CRM — input data pelanggan/supplier baru.
   - F-09: Pelaporan — argumen rentang waktu, jenis laporan (Laba Rugi, Rekonsiliasi, Aset), tabel ASCII.
   - Antarmuka CLI: navigasi menu berbasis angka, prompt input keyboard berurutan, output tabel ASCII.

3. `docs/sdlc/02_analysis/03_use_case_diagram.puml` — **REFERENSI UTAMA #3**: Berisi daftar lengkap use case dan relasi aktor. Rangkum:
   - Aktor: Pemilik (extends Karyawan) dan Karyawan.
   - Use case Karyawan: UC_Login, UC_Transaksi, UC_Inventaris, UC_StatusPesanan, UC_Arsip, UC_Limbah, UC_Absen, UC_PPOB, UC_Pelanggan.
   - Use case eksklusif Pemilik: UC_BOM, UC_Kasbon, UC_Gaji, UC_Vendor, UC_Rekonsiliasi, UC_Laporan, UC_Sensitif.
   - Include: UC_Transaksi→UC_Bayar, UC_Transaksi→UC_HPP, UC_PPOB→UC_Saldo, UC_Gaji→UC_Kasbon.
   - Extend: UC_Retur←UC_Transaksi.

4. `docs/sdlc/02_analysis/06_access_control_matrix.md` — **REFERENSI UTAMA #4**: Berisi matriks RBAC per modul dan per entitas data. Rangkum:
   - Modul yang bisa diakses Karyawan: F-01 Login, F-02 Transaksi (termasuk Pembatalan & Retur), F-03 Inventaris (bukan BOM), F-04 Job Tracking, F-05 Waste, F-06 Absensi (bukan Kasbon/Gaji), F-07 PPOB, F-08 CRM Pelanggan (bukan Vendor).
   - Modul eksklusif Pemilik: F-03 BOM, F-06 Kasbon & Gaji, F-08 Vendor, F-09 Rekonsiliasi & Laporan & Data Sensitif.
   - Menu manajerial dilarang di-render ke layar jika pengguna = Karyawan.

5. `docs/sdlc/02_analysis/04_workflow_diagram.puml` — **REFERENSI UTAMA #5**: Berisi alur kerja transaksi utama dan pembatalan/retur. Rangkum:
   - Alur Transaksi: terima pesanan → pilih tipe layanan → input CLI → cek harga grosir/mitra → hitung subtotal → percabangan (Percetakan: DP/Lunas → HPP BOM → potong stok → struk → status Antri→Desain→Produksi→Selesai→Diambil) vs (ATK/PPOB/Jasa: Lunas → proses spesifik → struk).
   - Alur Pembatalan: cek status pesanan (>= Proses Desain → DP hangus) vs (< Proses Desain → kembalikan DP).
   - Alur Retur: cek 1x24 jam & kelalaian internal → setuju/tolak.

File `docs/sdlc/narasi.txt` **TIDAK diperlukan** karena seluruh informasi sudah tercakup lengkap dalam dokumen referensi di atas.

---

## Instruksi Kelayakan & Kriteria Dokumen Utama

1. **Format PlantUML Activity Diagram**: Dokumen harus menggunakan sintaks PlantUML yang valid (`@startuml`/`@enduml`) dengan Activity Diagram. Gunakan `partition` untuk mengelompokkan alur per modul/fase. Gunakan `swimlane` (`|Pengguna|`, `|Sistem|`) untuk memisahkan aksi pengguna dan respons sistem.

2. **Cakupan Alur Interaksi Lengkap**: Diagram harus mencakup seluruh alur interaksi CLI dari awal hingga akhir:
   - Alur Login (termasuk skenario gagal dan brute-force lock).
   - Rendering Menu Utama berdasarkan role (Pemilik vs Karyawan) — tampilkan daftar menu numerik yang berbeda.
   - Navigasi ke setiap sub-menu modul (F-01 s.d F-09).
   - Alur input/output untuk setiap modul fungsional utama.
   - Alur Logout manual dan auto-logout (idle timeout 10 menit).
   - Alur kembali ke menu utama setelah selesai satu operasi.

3. **Visualisasi Menu Hierarkis Berbasis Angka**: Tampilkan struktur menu CLI berbasis angka yang jelas. Contoh:
   - Menu Utama Karyawan: [1] Transaksi Kasir, [2] Gudang & Stok, [3] Job Tracking, [4] Limbah Produksi, [5] Absensi, [6] PPOB & Jasa Keuangan, [7] Data Pelanggan, [0] Logout.
   - Menu Utama Pemilik: Semua menu Karyawan + [8] BOM & HPP, [9] SDM & Penggajian, [10] Vendor & Supplier, [11] Laporan Keuangan, [12] Rekonsiliasi Kas, [13] Data Finansial, [0] Logout.
   - Setiap sub-menu juga harus memiliki opsi angka untuk kembali ke menu utama.

4. **Integrasi Keamanan dalam Alur**: Diagram harus menunjukkan:
   - Pemeriksaan JWT validity di setiap navigasi menu (apakah token masih valid/belum expired).
   - Pemeriksaan idle timeout sebelum setiap prompt input.
   - RBAC filtering saat rendering menu (menu yang tidak diizinkan tidak muncul).
   - PIN verification untuk transaksi keuangan > Rp 5.000.000.

5. **Detail Input/Output CLI**: Untuk setiap modul, tunjukkan:
   - Prompt input apa yang ditampilkan ke pengguna (contoh: "Masukkan ID Produk: ").
   - Output apa yang ditampilkan setelah proses selesai (contoh: "Struk Digital", "Tabel ASCII Stok").
   - Pesan error yang ramah jika terjadi kesalahan.

6. **Metadata Diagram**: Sertakan metadata di bagian komentar PlantUML:
   - Judul, Versi (1.0.0), Status ([create_file]), Tanggal, Persona penyusun.

7. **Skinparam & Styling**: Gunakan konfigurasi visual PlantUML yang konsisten dengan diagram lain di proyek (lihat referensi `03_use_case_diagram.puml` dan `04_workflow_diagram.puml` untuk skinparam).

8. **Tabel Mapping di Komentar**: Sertakan tabel mapping di bagian komentar akhir yang menghubungkan setiap alur interaksi dengan modul SRS (F-01 s.d F-09) dan Use Case terkait.

9. **Bahasa Indonesia**: Label dan deskripsi dalam diagram menggunakan Bahasa Indonesia yang natural.

10. **Tandai Data Kosong**: Jika ada detail interaksi yang belum bisa ditentukan, tandai dengan `[PERLU DIISI MANUAL: deskripsi]`.

11. **Referensi di Akhir**: Cantumkan daftar file referensi di bagian komentar paling akhir file.

---

## Tahapan Implementasi Terperinci (Low-Level Execution Guide)

### Langkah 1: Baca Semua Referensi Wajib Sampai Tuntas

- Baca keseluruhan isi `docs/sdlc/03_design/03_system_architecture.md` — catat arsitektur berlapis (Bagian 5), struktur direktori CLI (Bagian 6), alur data Login/Transaksi/Penggajian (Bagian 7), arsitektur keamanan (Bagian 9), pola State Passing (Bagian 14), dan strategi rendering menu CLI (Bagian 14).
- Baca keseluruhan isi `docs/sdlc/02_analysis/02_software_requirements.md` — catat semua kebutuhan fungsional F-01 s.d F-09 (Bagian 4), detail input/proses/output setiap modul, dan antarmuka CLI (Bagian 3).
- Baca keseluruhan isi `docs/sdlc/02_analysis/03_use_case_diagram.puml` — catat semua use case, relasi aktor (Pemilik extends Karyawan), dan relasi include/extend antar use case.
- Baca keseluruhan isi `docs/sdlc/02_analysis/06_access_control_matrix.md` — catat matriks akses per modul (Bagian 6), daftar modul eksklusif Pemilik, dan aturan keamanan tambahan (Bagian 11).
- Baca keseluruhan isi `docs/sdlc/02_analysis/04_workflow_diagram.puml` — catat alur transaksi utama, alur pembatalan, dan alur retur untuk dipetakan ke interaksi CLI.
- **JANGAN** mulai menulis diagram sebelum semua file referensi selesai dibaca dan dipahami.

### Langkah 2: Tulis Metadata dan Konfigurasi PlantUML

- Buka file `docs/sdlc/03_design/04_cli_interaction_flow.puml`.
- Hapus konten placeholder yang ada.
- Tulis `@startuml` di baris pertama.
- Tulis blok komentar metadata: Judul "CLI Interaction Flow - Sistem Manajemen Usaha Percetakan AbuCom", Versi 1.0.0, Status [create_file], Tanggal (hari ini), Disusun Oleh (Senior UX Architect & Senior CLI Interaction Designer (AI)).
- Tulis konfigurasi skinparam yang konsisten dengan diagram lain:
  ```
  skinparam defaultTextAlignment center
  skinparam ArrowColor Teal
  skinparam ActivityBackgroundColor LightCyan
  skinparam ActivityBorderColor DarkCyan
  ```
- Definisikan swimlane: `|Pengguna|` dan `|Sistem|`.

### Langkah 3: Tulis Alur Login (Partition 1)

- Buat `partition "1. Alur Autentikasi (Login)"`.
- Swimlane `|Sistem|`: Tampilkan prompt "=== SISTEM ABUCOM ===" dan "Masukkan Username:".
- Swimlane `|Pengguna|`: Input username.
- Swimlane `|Sistem|`: Tampilkan prompt "Masukkan Password:".
- Swimlane `|Pengguna|`: Input password.
- Swimlane `|Sistem|`: Proses verifikasi bcrypt.
- Decision: "Password cocok?":
  - **Tidak**: Increment counter gagal. Decision: "Gagal >= 5 kali?":
    - **Ya**: Set `is_locked = 1`, tampilkan "Akun terkunci. Hubungi Pemilik.", stop.
    - **Tidak**: Tampilkan "Login gagal. Silakan coba lagi.", kembali ke prompt username.
  - **Ya**: Generate JWT token (payload: user_id, role, branch_id, exp 8 jam). Simpan sesi ke `login_sessions`. Catat audit trail "LOGIN". Clear screen. Lanjut ke rendering menu utama.

### Langkah 4: Tulis Alur Rendering Menu Utama (Partition 2)

- Buat `partition "2. Menu Utama CLI (Berdasarkan Role)"`.
- Swimlane `|Sistem|`: Ekstrak `role` dari JWT payload.
- Decision: "role == Pemilik?":
  - **Ya**: Render Menu Utama Pemilik (semua menu F-01 s.d F-09 + modul eksklusif).
  - **Tidak**: Render Menu Utama Karyawan (hanya menu operasional: Transaksi, Gudang, Job Tracking, Limbah, Absensi, PPOB, Pelanggan).
- Swimlane `|Pengguna|`: Pilih nomor menu.
- Swimlane `|Sistem|`: Validasi input angka. Cek idle timeout (10 menit). Cek JWT expiry.
- Decision berdasarkan pilihan menu → arahkan ke partition alur masing-masing modul.

### Langkah 5: Tulis Alur Interaksi Modul F-02 Transaksi Kasir (Partition 3)

- Buat `partition "3. Alur Interaksi Transaksi Kasir (F-02)"`.
- Tampilkan sub-menu: [1] Buat Transaksi Baru, [2] Proses Pembatalan, [3] Proses Retur, [0] Kembali ke Menu Utama.
- Alur "Buat Transaksi Baru": Pilih tipe layanan (1.Percetakan, 2.ATK, 3.PPOB, 4.Jasa Keuangan, 5.Jasa Teknis) → input ID barang → input qty → sistem cek harga grosir/mitra → tampilkan subtotal → percabangan Percetakan (pilih DP/Lunas → input nominal DP jika DP → HPP BOM → potong stok → struk digital → set status "Antri") vs non-Percetakan (Lunas → proses spesifik → struk digital).
- Alur "Pembatalan": input ID Transaksi → cek status pesanan → DP hangus jika >= Proses Desain, atau kembalikan DP.
- Alur "Retur": input ID Transaksi → cek 1x24 jam → validasi → proses atau tolak.
- Setelah selesai → kembali ke sub-menu atau menu utama.

### Langkah 6: Tulis Alur Interaksi Modul F-03 Gudang & BOM (Partition 4)

- Sub-menu: [1] Lihat Stok, [2] Update Stok, [3] Kelola BOM (khusus Pemilik), [4] Hitung HPP, [0] Kembali.
- Alur input/output untuk setiap sub-fitur sesuai SRS F-03.

### Langkah 7: Tulis Alur Interaksi Modul F-04 Job Tracking (Partition 5)

- Sub-menu: [1] Lihat Daftar Pesanan, [2] Update Status Pesanan, [3] Catat Arsip Desain, [0] Kembali.
- Input: ID Transaksi, pilih status baru (Antri/Proses Desain/Produksi/Selesai/Diambil), path file desain.

### Langkah 8: Tulis Alur Interaksi Modul F-05, F-06, F-07, F-08 (Partition 6-9)

- F-05 Waste: input ID bahan, besaran, alasan → konfirmasi → tampilkan sisa stok.
- F-06 SDM: sub-menu Absensi (semua role), Kasbon (Pemilik), Payroll (Pemilik). Karyawan hanya lihat slip miliknya.
- F-07 PPOB: pilih jenis → input nominal → validasi saldo → proses → peringatan jika saldo < Rp 150.000. Cek PIN jika > Rp 5.000.000.
- F-08 CRM: sub-menu Pelanggan (semua role), Vendor (Pemilik).

### Langkah 9: Tulis Alur Interaksi Modul F-09 Pelaporan (Partition 10, Khusus Pemilik)

- Sub-menu: [1] Laporan Laba Rugi, [2] Rekonsiliasi Kas, [3] Data Finansial Sensitif, [0] Kembali.
- Input: rentang waktu (tanggal awal, tanggal akhir), jenis laporan.
- Output: tabel ASCII.

### Langkah 10: Tulis Alur Logout & Idle Timeout (Partition 11)

- Logout Manual: Pengguna pilih [0] → sistem hapus sesi dari `login_sessions` → audit trail "LOGOUT" → tampilkan "Anda telah keluar." → kembali ke prompt login.
- Idle Timeout: Sistem deteksi 10 menit tanpa input → invalidasi JWT → hapus sesi → tampilkan "Sesi berakhir karena tidak ada aktivitas." → kembali ke prompt login.

### Langkah 11: Tulis Tabel Mapping dan Referensi

- Tulis tabel mapping di komentar PlantUML:
  ```
  ' | Alur Interaksi CLI          | Modul SRS    | Use Case         |
  ' |------------------------------|-------------|------------------|
  ' | Login & Brute-force          | F-01        | UC_Login         |
  ' | Transaksi Kasir              | F-02        | UC_Transaksi     |
  ' | dst...                       |             |                  |
  ```
- Tulis daftar referensi dokumen di komentar akhir sebelum `@enduml`.

### Langkah 12: Validasi Kelengkapan Diagram

- Pastikan semua 9 modul fungsional (F-01 s.d F-09) memiliki alur interaksi CLI.
- Pastikan perbedaan menu Pemilik vs Karyawan tervisualisasi jelas.
- Pastikan alur keamanan (login, brute-force, idle timeout, PIN verification, RBAC) terintegrasi.
- Pastikan setiap alur memiliki jalur "kembali ke menu utama".
- Pastikan sintaks PlantUML valid dan bisa di-render.
- Pastikan bahasa Indonesia natural dan label tidak ambigu.
- Pastikan tidak ada instruksi kerja atau komentar proses yang tertinggal di luar blok komentar PlantUML.

### Langkah 13: Update Status di sdlc.txt

- Setelah diagram selesai ditulis dan divalidasi, buka file `docs/sdlc/sdlc.txt`.
- Cari baris yang berisi `04_cli_interaction_flow.puml` (baris 25).
- Ubah `status: [create_file]` menjadi `status: [done]`.
- Pastikan HANYA baris 25 yang berubah, tidak ada baris lain yang termodifikasi.

---

## Poin Tambahan Spesifik untuk CLI Interaction Flow

1. **Konsistensi Nomor Menu**: Pastikan penomoran menu konsisten di seluruh diagram. Gunakan angka [1], [2], dst. untuk opsi menu dan selalu [0] untuk "Kembali" atau "Logout".

2. **Feedback Loop**: Setiap aksi pengguna harus mendapatkan respons dari sistem (konfirmasi berhasil, pesan error, atau tampilan data). Tidak boleh ada aksi "bisu" tanpa output.

3. **Validasi Input di Setiap Prompt**: Tunjukkan bahwa sistem memvalidasi setiap input (angka valid, rentang yang diizinkan, format yang benar) dan menampilkan pesan error ramah jika input tidak valid, lalu meminta input ulang.

4. **Navigasi Bertingkat**: Tunjukkan hierarki navigasi: Menu Utama → Sub-Menu Modul → Aksi Spesifik → Konfirmasi → Kembali ke Sub-Menu → Kembali ke Menu Utama.

5. **Clear Screen Strategy**: Tunjukkan kapan sistem melakukan clear screen (setelah login berhasil, saat berpindah modul utama) untuk menjaga kebersihan tampilan CLI.

---

## Checklist Penerimaan (Definition of Done)

- [ ] File `docs/sdlc/03_design/04_cli_interaction_flow.puml` berisi diagram PlantUML Activity Diagram lengkap
- [ ] Sintaks PlantUML valid dan bisa di-render
- [ ] Alur Login dengan skenario sukses, gagal, dan brute-force lock tervisualisasi
- [ ] Menu Utama Pemilik dan Karyawan berbeda dan tervisualisasi jelas
- [ ] Semua 9 modul fungsional (F-01 s.d F-09) memiliki alur interaksi
- [ ] RBAC filtering pada menu tervisualisasi (menu eksklusif Pemilik tidak muncul untuk Karyawan)
- [ ] Idle timeout (10 menit) dan auto-logout tervisualisasi
- [ ] PIN verification untuk transaksi > Rp 5.000.000 tervisualisasi
- [ ] Setiap alur memiliki jalur kembali ke menu utama
- [ ] Detail input prompt dan output CLI tervisualisasi
- [ ] Validasi input dan pesan error ramah tervisualisasi
- [ ] Metadata diagram lengkap (komentar PlantUML)
- [ ] Skinparam konsisten dengan diagram lain di proyek
- [ ] Tabel mapping alur vs modul SRS vs Use Case tersedia (komentar)
- [ ] Bahasa Indonesia natural dan label tidak ambigu
- [ ] Data kosong ditandai dengan `[PERLU DIISI MANUAL]`
- [ ] Referensi dokumen tercantum di komentar akhir file
- [ ] Diagram bersih tanpa instruksi kerja atau komentar proses
- [ ] Status di sdlc.txt berubah dari [create_file] ke [done]
