# Tech Stack Decision

## Metadata Dokumen

| Atribut | Detail |
|---|---|
| **Judul Dokumen** | Tech Stack Decision |
| **Versi** | 1.1.0 |
| **Status** | [finish] |
| **Tanggal Dibuat** | 2026-05-12 |
| **Tanggal Direvisi** | 2026-05-12 |
| **Disusun Oleh** | Senior Enterprise Architect & Senior Technical Lead (AI) |
| **Catatan Revisi** | v1.1.0 — Validasi teknis arsitektur, pengisian parameter versi spesifik, penegasan paradigma FP, penyesuaian tata bahasa, dan pembersihan placeholder. |

## Ringkasan Eksekutif (Executive Summary)

Dokumen ini menguraikan keputusan arsitektur dan teknologi (Tech Stack Decision) untuk pengembangan Sistem Manajemen Usaha Percetakan "AbuCom". Keputusan utama meliputi penggunaan **Python 3.14.2+** dengan paradigma **Functional Programming (FP)** secara murni, basis data **MySQL 8.4 LTS (Community Edition)**, dan antarmuka **CLI** pada tahap pertama. Pemilihan ini didasarkan pada kebutuhan sistem yang andal, dapat direplikasi secara lokal (*Multi-Branch Ready*), kendala biaya lisensi perangkat lunak sebesar **Rp 0**, serta kemudahan kolaborasi dengan ekosistem AI-Augmented Development. Seluruh komponen berstatus *open-source* dan telah dikonfirmasi kompatibel di **Linux Debian 12 Bookworm** maupun **Windows 11 24H2**.

## Konteks dan Latar Belakang Keputusan

Proyek AbuCom adalah sistem pengelolaan operasional untuk UMKM percetakan dengan **20 modul fungsional** yang mencakup produksi cetak, penjualan retail ATK, layanan PPOB, jasa keuangan, jasa teknis, SDM, penggajian, dan manajemen kasir. Karena keterbatasan sumber daya manusia (pemilik tunggal), sistem ini difokuskan pada otomatisasi operasional terpadu. Sistem dibangun sebagai aplikasi CLI, berjalan secara lokal, dengan dua kendala mutlak:

1. **Biaya lisensi Rp 0** — seluruh teknologi wajib *open-source*.
2. **Paradigma Functional Programming** — tidak boleh ada arsitektur OOP.

Arsitektur dirancang agar *Multi-Branch Ready*: setiap entitas data menyimpan referensi `branch_id` sebagai *foreign key* wajib sehingga sistem siap dikonsolidasikan menjadi platform multi-cabang tanpa *re-design* skema database di kemudian hari.

## Kriteria Evaluasi Teknologi

- **Biaya Lisensi**: Seluruh teknologi harus gratis dan *open-source* (Rp 0).
- **Kesesuaian Paradigma**: Dukungan murni terhadap *Functional Programming* — tidak ada ketergantungan pada *class instance* atau *mutable state*.
- **Kemudahan Pembelajaran**: Relatif mudah dikuasai oleh Junior Programmer dengan bantuan langsung agen AI.
- **Ketersediaan Dokumentasi & Komunitas**: Ekosistem matang dengan referensi standar dan komunitas aktif.
- **Performa & Integritas Relasional**: Basis data mampu menangani 20 modul integratif secara stabil dengan jaminan ACID.
- **Kompatibilitas Lintas OS**: Mendukung Linux Debian 12 Bookworm dan Windows 11 24H2 tanpa *compiler error*.
- **Kesiapan Skalabilitas**: Struktur data mendukung arsitektur multi-cabang terpusat.

## Keputusan Teknologi per Komponen

### 5.1 Bahasa Pemrograman

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **Python 3.14.2+** | Sintaks bersih, ekosistem besar, mendukung FP *pure functions*, sangat optimal dikembangkan bersama AI. | Eksekusi lebih lambat dari bahasa *compiled*; distribusi *executable* CLI sedikit menantang. | 5 |
| Node.js / TypeScript | *Async I/O* unggul, ekosistem masif. | Kurva *async* membingungkan untuk FP murni tingkat junior. | 4 |
| Go | Eksekusi stabil dan kencang, kompilasi binari ringkas. | Tipe data kaku memperlambat eksplorasi logika bersama AI. | 3 |
| Java | Ekosistem sangat matang. | Terlalu *verbose* dan berat untuk aplikasi bisnis CLI. | 2 |

**Keputusan**: Python 3.14.2+

**Justifikasi**: Python adalah pilihan terbaik untuk metode *AI-Augmented Development* karena agen AI sangat efektif berinteraksi dengan sintaks Python. Python mendukung penulisan *pure functions*, *higher-order functions*, dan *immutable data structures* secara alami tanpa memerlukan modifikasi kompilator.

**Risiko dan Mitigasi**: Kinerja I/O dapat melambat jika data masif. Strategi: optimasi pada lapisan kueri SQL (penggunaan indeks, *prepared statements*) dan pemrosesan data fungsional yang efisien.

---

### 5.2 Paradigma Pemrograman

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **Functional Programming (FP)** | *Pure functions* bebas efek samping, prediktabilitas tinggi, *testability* maksimal. | Membutuhkan pergeseran pola pikir dari OOP yang lebih umum. | 5 |
| Object-Oriented Programming (OOP) | Cocok untuk memetakan objek dunia nyata. | *Mutable state* berpotensi memicu inkonsistensi data pada 20 modul yang saling terintegrasi. | 3 |
| Procedural Programming | Eksekusi linier, mudah dioperasikan. | *Codebase* cepat tidak terawat saat logika bisnis berkembang melewati 5 modul. | 2 |

**Keputusan**: Functional Programming

**Justifikasi**: Pemilik mewajibkan FP secara teknis untuk memastikan reliabilitas output. Setiap fungsi harus menerima input dan mengembalikan output tanpa mengubah *state* eksternal (*pure function*). Ini sangat kritis untuk menjaga ketepatan laporan rekonsiliasi kas dan stok. Semua library yang dipilih (mysql-connector-python, python-dotenv, pyjwt, bcrypt) dapat digunakan murni melalui pemanggilan fungsi langsung tanpa instansiasi *class*.

**Aturan Teknis Wajib FP**:
- Seluruh logika bisnis ditulis sebagai fungsi murni (*pure functions*).
- Data bersifat *immutable* — gunakan `tuple` dan `dict` baru, bukan modifikasi *in-place*.
- Tidak ada penggunaan `class` untuk logika bisnis. `dataclass` hanya boleh digunakan sebagai wadah data *read-only* jika diperlukan.
- Gunakan `map()`, `filter()`, `functools.reduce()` untuk transformasi data koleksi.

**Risiko dan Mitigasi**: *Learning curve* bagi Junior Programmer. Mitigasi: panduan arsitektur ketat dari AI Agent perencana kode sebelum setiap sesi implementasi modul.

---

### 5.3 Sistem Basis Data (Database)

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **MySQL 8.4 LTS** | Matang, relasional kokoh (jaminan ACID), teruji mengikat integritas transaksi antar modul, komunitas raksasa. | Membutuhkan instalasi server; pengaturan awal tidak sepraktis layanan *serverless*. | 5 |
| PostgreSQL | Standar industri mutakhir, dukungan JSON kuat. | *Overkill* untuk UMKM tahap awal yang baru migrasi dari Excel. | 4 |
| SQLite | Instan, portabilitas tanpa *setup*. | Berbahaya untuk stabilitas integritas sistem *Multi-Branch* dengan sesi pengguna bersamaan. | 3 |
| MongoDB (NoSQL) | Penyimpanan lincah untuk data tidak terstruktur. | Rapuh untuk rekonsiliasi transaksi relasional HPP (*Bill of Materials*). | 2 |

**Keputusan**: MySQL 8.4 LTS (Community Edition)

**Justifikasi**: Kebutuhan manajemen Stok BOM, *Payroll*, PPOB, Kasir, dan Modul Hutang berakar pada relasi data ganda yang membutuhkan jaminan ACID. MySQL 8.4 adalah rilis LTS (*Long-Term Support*) yang dijamin mendapat patch keamanan hingga 2032, menjamin stabilitas jangka panjang proyek. Lisensi: **GPL v2** (gratis, open-source).

**Risiko dan Mitigasi**: Inkonsistensi versi saat migrasi OS. Mitigasi: versi dikunci di **MySQL 8.4 LTS Community Edition** di semua environment.

---

### 5.4 Antarmuka Pengguna (User Interface)

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **CLI / Console** | Fokus pada fungsi bisnis tanpa overhead UI; eksekusi cepat. | Kurva adaptasi lebih tinggi bagi staf non-teknis. | 5 |
| Web GUI | Ramah pengguna awam. | Membutuhkan bulan pertama untuk merakit kerangka HTTP (API) dan *frontend framework*. | 3 |
| Desktop GUI | Responsif untuk *hardware*. | Library *windowing* Linux dan Windows berpotensi tidak sinkron. | 2 |

**Keputusan**: CLI / Console

**Justifikasi**: CLI adalah jalur tercepat merealisasikan 20 modul *backend* dalam 12 bulan dengan 1 developer. Antarmuka CLI dirancang dengan navigasi hierarkis berbasis angka (mirip menu USSD) agar intuitif.

**Risiko dan Mitigasi**: Resistensi adaptasi dari kasir dan staf produksi. Mitigasi: navigasi menu angka intuitif dan SOP operasional tercetak.

---

### 5.5 Library Koneksi Database

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **mysql-connector-python** | Driver resmi Oracle; kompatibel penuh dengan MySQL 8.4; mendukung *pure function* via hasil kueri berbentuk `tuple`. | *Benchmarking* kueri massal sedikit lebih lambat dibanding *C-extensions*. | 5 |
| PyMySQL | *Pure Python*, portabilitas tinggi. | Rilis keamanan lambat menyusul MySQL resmi. | 4 |
| SQLAlchemy | ORM lengkap, migrasi tabel mudah. | Paradigma ORM kental berorientasi objek; bertentangan mutlak dengan aturan FP proyek ini. | 1 |
| aiomysql | *Async*, cocok volume tinggi. | Konkurensi I/O *overkill* untuk ekosistem CLI UMKM. | 3 |

**Keputusan**: mysql-connector-python **9.3.0**

**Justifikasi**: Driver resmi menekan risiko koneksi terputus (SSL/TLS). Karena ORM dilarang, konektor dasar ini menjamin kontrol FP murni: hasil kueri dikembalikan sebagai `tuple` Python — struktur data *immutable* yang sepenuhnya kompatibel dengan paradigma FP. Pemanggilan `cursor.execute()` adalah *stateless function call*, bukan *method* pada *class* bisnis.

**Konfirmasi Lisensi**: GNU GPL v2 — gratis, open-source.

**Konfirmasi Kompatibilitas OS**: Tersedia sebagai *wheel* biner untuk Windows 11 (amd64) dan Debian 12 (linux/amd64) tanpa memerlukan kompilasi C.

**Risiko dan Mitigasi**: Isu kompatibilitas pada Python 3.14.2+. Mitigasi: kunci versi di `requirements.txt` — `mysql-connector-python==9.3.0`.

---

### 5.6 Library Manajemen Konfigurasi

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **python-dotenv** | Standar industri isolasi kredensial; memisahkan *secret* dari kode sumber. | Tidak melakukan *type-checking* pada variabel *environment*. | 5 |
| configparser | Bawaan Python, tanpa instalasi tambahan. | File `.ini` rentan ikut ter-*commit* ke Git. | 3 |
| pydantic-settings | *Auto-cast* tipe data sangat teliti. | Memaksa arsitektur *class instance*; bertentangan dengan FP. | 2 |
| dynaconf | Mendukung JSON, TOML, YAML. | *Overhead* berlebihan untuk kebutuhan kredensial bisnis sederhana. | 2 |

**Keputusan**: python-dotenv **1.1.0**

**Justifikasi**: Kredensial MySQL dan *token encryption key* disimpan di file `.env` yang wajib masuk `.gitignore`. `load_dotenv()` dan `os.getenv()` adalah *pure function calls* yang tidak bergantung pada *class instance* — sepenuhnya kompatibel dengan FP. File `.env` tidak pernah masuk repositori.

**Konfirmasi Lisensi**: BSD 3-Clause — gratis, open-source.

**Konfirmasi Kompatibilitas OS**: *Pure Python*, berjalan identik di Windows 11 dan Debian 12 tanpa dependensi OS.

**Risiko dan Mitigasi**: File `.env` ter-*commit* ke repositori. Mitigasi: `.gitignore` dikonfigurasi di awal proyek sebelum baris kode pertama ditulis.

---

### 5.7 Library Keamanan — Hashing Password

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **bcrypt** | *Hashing* adaptif berbasis *work factor*; tahan *brute-force* dan serangan kamus. | Sedikit lebih lambat dari Argon2 untuk resistensi GPU massal. | 5 |
| argon2-cffi | Algoritma *hash* terkuat saat ini (*memory-hard*). | Memerlukan kompilasi C — sangat rawan *error* di server Windows lokal UMKM. | 4 |
| hashlib+scrypt | Bawaan Python *built-in*. | Konfigurasi *salt padding* manual memicu celah keamanan jika tidak cermat. | 3 |
| passlib | Kompendium multi-algoritma. | Status *legacy*, tidak menerima pemeliharaan aktif. | 2 |

**Keputusan**: bcrypt **4.3.0**

**Justifikasi**: `bcrypt.hashpw(password, bcrypt.gensalt())` adalah *pure function* — menerima *bytes*, mengembalikan *bytes* tanpa *side effects*. Tidak ada *class* yang perlu diinstansiasi. *Work factor* default (`rounds=12`) aman dan cukup cepat untuk respons *login* CLI. Stabil di Windows 11 dan Debian 12 tanpa perlu *C compiler* manual karena paket tersedia sebagai *pre-compiled wheel*.

**Konfirmasi Lisensi**: Apache 2.0 — gratis, open-source.

**Konfirmasi Kompatibilitas OS**: *Pre-compiled wheel* tersedia di PyPI untuk `win_amd64` dan `linux_x86_64` (Debian 12). Instalasi via `pip install bcrypt==4.3.0` tidak memerlukan `gcc`.

**Penetapan Parameter**: `bcrypt.gensalt(rounds=12)` — nilai 12 adalah standar industri yang menyeimbangkan keamanan dan kecepatan respons pada perangkat keras kelas UMKM.

**Risiko dan Mitigasi**: Peningkatan waktu komputasi saat CPU *throttling*. Mitigasi: *salt rounds* dikunci di `12`, tidak lebih tinggi, agar respons *login* CLI tetap cepat.

---

### 5.8 Library Keamanan — Autentikasi Token

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **pyjwt** | Standar JWT *stateless*; ringan; mendukung RBAC via *payload claims*. | Pencabutan token saat karyawan diberhentikan memerlukan mekanisme *blacklist* tambahan. | 5 |
| python-jose | Protokol berlapis tinggi dengan JWE (*Json Web Encryption*). | Konfigurasi awal terlalu kompleks untuk *debugging* CLI oleh Junior. | 3 |
| authlib | Orkestrasi OAuth dan SSO menyeluruh. | Dirancang untuk klien web, bukan *user environment* internal CLI terpusat. | 1 |
| session-based | Sesi bisa dicabut seketika. | *Database lookup* di setiap navigasi menu memperburuk waktu muat CLI multi-cabang. | 2 |

**Keputusan**: pyjwt **2.10.1**

**Justifikasi**: `jwt.encode(payload, secret, algorithm="HS256")` dan `jwt.decode(token, secret, algorithms=["HS256"])` adalah *pure functions* — menerima `dict` dan `str`, mengembalikan nilai baru tanpa *state mutation*. Token JWT membawa `user_id`, `role`, `branch_id`, dan `exp` di *payload*, memungkinkan validasi RBAC tanpa *database lookup* tambahan di setiap aksi pengguna.

**Konfirmasi Lisensi**: MIT — gratis, open-source.

**Konfirmasi Kompatibilitas OS**: *Pure Python*, berjalan identik di Windows 11 dan Debian 12.

**Penetapan Parameter**: `exp` (expiry) = **8 jam** dari waktu *login* — sesuai durasi 1 shift kerja. Token tidak dapat diperpanjang; karyawan wajib *login* ulang setelah sesi berakhir.

**Risiko dan Mitigasi**: Token dicopy ke perangkat lain. Mitigasi: durasi *expiry* singkat (8 jam) dan validasi `secret_key` dari `.env` lokal yang terlindungi.

---

### 5.9 Sistem Operasi Target

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **Linux Debian 12 Bookworm & Windows 11 24H2** | Selaras penuh dengan infrastruktur *existing* bisnis AbuCom; biaya Rp 0. | Skema konfigurasi *path* berbeda antara dua OS (slash vs backslash). | 5 |
| Ubuntu Server | Komunitas besar, paket standar mudah. | Menyelisih mandat dokumen kelayakan untuk tidak menambah variabel OS baru. | 3 |
| CentOS / RHEL | Andal untuk infrastruktur *Enterprise*. | Pemutakhiran eksklusif dan memberatkan admin non-IT. | 2 |

**Keputusan**: Linux Debian 12 Bookworm (kernel 6.1 LTS) & Windows 11 24H2

**Justifikasi**: Kedua OS sudah tersedia di infrastruktur bisnis AbuCom tanpa biaya tambahan. Debian 12 adalah rilis LTS yang dijamin mendapat dukungan keamanan hingga 2028. Windows 11 24H2 adalah versi stabil terkini untuk lingkungan desktop.

**Penanganan Perbedaan Path**: Seluruh operasi *file path* wajib menggunakan `pathlib.Path()` dari Python *standard library* — secara otomatis menangani perbedaan `\` (Windows) dan `/` (Linux) tanpa kode kondisional.

**Risiko dan Mitigasi**: Inkonsistensi resolusi *path* direktori. Mitigasi: `pathlib.Path()` wajib di semua modul yang membaca/menulis file; penggunaan `os.path` string literal dilarang.

---

### 5.10 Strategi Arsitektur Skalabilitas

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **Multi-Branch Ready** | Fondasi siap ekspansi tanpa *re-design* skema database. | Setiap tabel wajib menyertakan kolom `branch_id` dari awal. | 5 |
| Single-Tenant | Sangat lugas untuk arsitektur toko tunggal. | Mustahil dikembangkan ke multi-cabang tanpa *overhaul* total. | 2 |
| Microservices | Independen dan terdistribusi sangat baik. | *Over-engineering* parah; tidak mungkin dikerjakan oleh *solo AI-augmented dev*. | 1 |

**Keputusan**: Multi-Branch Ready

**Justifikasi**: Pemilik mewajibkan fondasi data terstruktur dengan penugasan `branch_id`. Ini membuka kesiapan transisi ke fase cabang baru tanpa perombakan skema.

**Konfigurasi Implementasi**: Setiap tabel utama (transaksi, stok, karyawan, aset, keuangan, laporan) wajib memiliki kolom `branch_id INT NOT NULL` yang mereferensi tabel `branches(id)`. Fungsi-fungsi modul menerima `branch_id` sebagai parameter eksplisit, bukan variabel global.

**Risiko dan Mitigasi**: Kueri tercampur data antar cabang. Mitigasi: setiap fungsi modul database menerima `branch_id` sebagai argumen wajib; tidak ada kueri tanpa filter `WHERE branch_id = ?`.

---

### 5.11 Model Pengembangan (Development Model)

| Kandidat | Kelebihan | Kekurangan | Skor (1-5) |
|---|---|---|---|
| **AI-Augmented Development** | Kapabilitas setara tim senior; biaya HR Rp 0; tersedia 24/7. | Kualitas output bergantung pada kejernihan spesifikasi dokumen dan kualitas *prompt*. | 5 |
| Solo Junior Programmer | Komunikasi *bug* satu arah tanpa konflik teknis. | Volume 20 modul tidak realistis dalam 12 bulan tanpa bantuan AI. | 1 |
| Vendor Outsourcing | SLA kontrak terima beres. | Melanggar batas modal; rentan *vendor lock-in*. | 1 |

**Keputusan**: AI-Augmented Development (1 Junior Programmer + 6 Agen AI)

**Justifikasi**: Tim dirancang dengan orkestrasi: 1 Junior Programmer (sebagai *Project Manager/Driver*) dipadu 6 Agen AI (Gemini 3.1 Pro High — arsitektur & logika berat; Gemini 3.1 Pro Low — dokumentasi & rutin; Gemini 3 Flash — *debugging* cepat; Claude Sonnet 4.6 Thinking — *deep coding* & *refactoring* FP; Claude Opus 4.6 Thinking — audit keamanan & strategi sistem; GPT-OSS 120B Medium — *boilerplate* & data *dummy*). Metode ini memenuhi syarat ekonomi anggaran tenaga pengembangan Rp 0.

**Risiko dan Mitigasi**: Agen AI berhalusinasi dan melanggar batasan FP saat menulis kode. Mitigasi: wajib menyuntikkan dokumen *project charter* dan dokumen ini sebagai konteks sebelum setiap sesi *prompt* penulisan fungsi.

## Matriks Ringkasan Keputusan (Decision Summary Matrix)

| Komponen | Teknologi Terpilih | Versi / Spesifikasi | Lisensi | Risiko |
|---|---|---|---|---|
| Bahasa Pemrograman | Python | 3.14.2+ | PSF (Open-Source, Rp 0) | Rendah |
| Paradigma Pemrograman | Functional Programming | N/A — Paradigma Umum | N/A | Sedang |
| Database | MySQL Community Edition | 8.4 LTS | GPL v2 (Rp 0) | Rendah |
| Antarmuka Pengguna | CLI / Console | N/A | N/A | Sedang |
| Library Konektor DB | mysql-connector-python | 9.3.0 | GPL v2 (Rp 0) | Rendah |
| Library Manajemen Konfigurasi | python-dotenv | 1.1.0 | BSD 3-Clause (Rp 0) | Rendah |
| Library Keamanan (Hashing) | bcrypt | 4.3.0 | Apache 2.0 (Rp 0) | Rendah |
| Library Keamanan (Token) | pyjwt | 2.10.1 | MIT (Rp 0) | Rendah |
| OS Target Deployment | Linux Debian 12 Bookworm & Windows 11 | Debian 12.9 / Windows 11 24H2 | Tersedia *Existing* / Open-Source | Rendah |
| Strategi Skalabilitas | Multi-Branch Ready | `branch_id INT NOT NULL` di setiap tabel utama | N/A | Sedang |
| Model Pengembangan | AI-Augmented Development | 1 Junior Programmer + 6 Agen AI | Akses Ekosistem | Tinggi |

## Kendala dan Batasan (Constraints)

- **Paradigma FP Wajib**: Pelarangan mutlak OOP. Seluruh logika bisnis ditulis sebagai *pure functions*. Tidak ada `class` untuk logika bisnis.
- **Anggaran Rp 0**: Seluruh komponen wajib *open-source* dan gratis. Tidak ada versi *Enterprise* berbayar.
- **CLI-Only (Fase 1)**: Tidak ada GUI, Web, atau Mobile pada fase pertama. Semua akses via terminal.
- **Kompatibilitas Lintas OS**: Kode wajib berjalan tanpa *error* di Debian 12.9 dan Windows 11 24H2. Gunakan `pathlib` untuk semua operasi *path*.
- **Versi Terkunci**: Semua library dikunci di versi yang tertera pada dokumen ini di `requirements.txt` untuk mencegah regresi akibat pembaruan otomatis.

## Riwayat Versi

| Versi | Tanggal | Diubah Oleh | Keterangan |
|---|---|---|---|
| 1.0.0 | 2026-05-12 | Senior Enterprise Architect & Senior Technical Lead (AI) | Pembuatan draf dokumen *Tech Stack Decision* berdasarkan rujukan spesifikasi terpusat ekosistem SDLC. |
| 1.1.0 | 2026-05-12 | Senior System Architect & Technical Auditor AI (Claude Sonnet 4.6 — Validasi Issue #8) | Validasi teknis arsitektur: pengisian semua placeholder versi spesifik, konfirmasi lisensi dan kompatibilitas OS per library, penegasan aturan teknis FP, penetapan konfigurasi Multi-Branch Ready, penambahan parameter token JWT, dan penyesuaian tata bahasa. |

## Referensi Dokumen

Dokumen ini disusun dan divalidasi berdasarkan:
- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/01_planning/02_feasibility_study.md`
- `docs/sdlc/01_planning/03_stakeholder_register.md`
