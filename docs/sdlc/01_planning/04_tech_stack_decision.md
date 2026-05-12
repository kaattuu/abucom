# Tech Stack Decision

## Metadata Dokumen

| Atribut | Detail |
|---|---|
| **Judul Dokumen** | Tech Stack Decision |
| **Versi** | 1.0.0 |
| **Status** | [draft] |
| **Tanggal Dibuat** | 2026-05-12 |
| **Disusun Oleh** | Senior Enterprise Architect & Senior Technical Lead (AI) |

## Ringkasan Eksekutif (Executive Summary)
Dokumen ini menguraikan keputusan arsitektur dan teknologi (Tech Stack Decision) untuk pengembangan Sistem Manajemen Usaha Percetakan "AbuCom". Keputusan utama meliputi penggunaan Python 3.14.2+ dengan paradigma Functional Programming, basis data MySQL, dan antarmuka CLI pada tahap awal. Pemilihan ini didasarkan pada kebutuhan sistem yang handal, dapat direplikasi secara lokal (*Multi-Branch Ready*), kendala biaya lisensi perangkat lunak sebesar Rp 0, serta kemudahan kolaborasi dengan ekosistem AI-Augmented Development.

## Konteks dan Latar Belakang Keputusan
Proyek AbuCom adalah sistem pengelolaan operasional untuk UMKM percetakan dengan 20 modul fungsional yang membawahi produksi cetak, layanan retail ATK, PPOB, layanan teknis, hingga SDM dan manajemen kasir. Karena keterbatasan sumber daya manusia tunggal (pemilik), sistem ini berfokus pada otomatisasi operasional terpadu. Sistem akan dibangun sebagai aplikasi CLI pada skala usaha lokal dengan kendala mutlak berupa lisensi perangkat lunak sebesar Rp 0 (mengandalkan teknologi *open-source*) dan pewajiban penerapan paradigma *Functional Programming*. Arsitektur dirancang sedemikian rupa agar mematuhi standar skalabilitas *Multi-Branch Ready* untuk rencana ekspansi toko cabang di kemudian hari.

## Kriteria Evaluasi Teknologi
- **Biaya Lisensi**: Seluruh teknologi harus gratis dan *open-source* (Rp 0).
- **Kesesuaian Paradigma**: Dukungan murni terhadap penerapan *Functional Programming*.
- **Kemudahan Pembelajaran**: Relatif mudah dikuasai oleh Junior Programmer dengan bantuan langsung agen AI.
- **Ketersediaan Dokumentasi & Komunitas**: Kematangan ekosistem dalam menyediakan referensi standar dan fitur penyelesaian modul kompleks.
- **Performa & Integritas Relasional**: Kemampuan basis data menangani 20 modul integratif secara stabil tanpa celah *error*.
- **Kompatibilitas Lintas OS**: Mendukung infrastruktur yang sudah sedia ada yaitu Linux Debian 12 Bookworm dan Windows 11.
- **Kesiapan Skalabilitas**: Abstraksi data mendukung penuh struktur basis multi-cabang terpusat.

## Keputusan Teknologi per Komponen

### 5.1 Bahasa Pemrograman
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **Python 3.14.2+** | Sintaks bersih, ekosistem besar, mendukung *Functional Programming*, sangat optimal dikembangkan bersama AI. | Eksekusi dapat lebih lambat dari bahasa *compiled*, distribusi aplikasi *executable* CLI sedikit menantang. | 5 |
| Node.js / TypeScript | *Asynchronous I/O* yang unggul, ekosistem masif. | Kurva pembelajaran *async* cukup membingungkan untuk implementasi *functional programming* murni tingkat junior. | 4 |
| Go | Performa tingkat eksekusi sangat stabil dan kencang, kompilasi binari ringkas. | Tipe data kaku (*strict*) membuatnya cukup memakan waktu dalam eksplorasi logika bersama AI. | 3 |
| Java | Ekosistem sangat matang. | Terlalu *verbose* (bertele-tele) dan berat untuk *use-case* aplikasi bisnis *command line* sederhana. | 2 |

**Keputusan**: Python 3.14.2+
**Justifikasi**: Python merupakan opsi terbaik demi mendayagunakan metode kerja *AI-Augmented Development*, mengingat kecerdasan buatan luar biasa kuat saat berinteraksi dengan sintaks Python. Selain itu, Python mendukung struktur penulisan paradigma *Functional Programming* yang bebas *state* tanpa harus memasukkan lapisan modifikasi kompilator yang mendalam.
**Risiko dan Mitigasi**: Kinerja I/O aplikasi *console* mungkin melambat jika data masif. Strateginya difokuskan pada pemrosesan fungsional dan pengoptimasian skema panggilan kueri basis data.

### 5.2 Paradigma Pemrograman
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **Functional Programming (FP)** | Fungsi bebas dari efek samping (*pure functions*), prediktabilitas luar biasa stabil, *testability* amat tinggi. | Membutuhkan pergeseran pola pikir dari cara pemrograman umum yang berlandaskan orientasi objek. | 5 |
| Object-Oriented Programming (OOP) | Cara paling dominan untuk memetakan skema objek dunia nyata secara rasional. | Sistem internal berbasis *state* berpotensi tinggi menghasilkan tumpang-tindih data (*race conditions*) pada aplikasi skala 20 modul. | 3 |
| Procedural Programming | Eksekusi linier berurutan, mudah dioperasikan. | Struktur *codebase* akan seketika tidak terawat manakala logika bisnis berkembang melewati 5 modul dasar. | 2 |

**Keputusan**: Functional Programming
**Justifikasi**: Pemilik (sebagai pemangku kepentingan utama) mewajibkan penuh secara teknis penerapan FP guna memastikan reliabilitas hasil output. Kode FP meminimalisasi modifikasi variabel tak diundang, hal ini sangat kritis mengamankan ketepatan pelaporan rekonsiliasi kas maupun stok pada fitur integratif.
**Risiko dan Mitigasi**: Risiko *learning curve* di sisi *Junior Programmer* yang diatasi murni lewat spesifikasi panduan ketat arsitektur dari *AI Agents* perencana kode.

### 5.3 Sistem Basis Data (Database)
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **MySQL** | Matang, relasional sangat kokoh (menjamin ACID), teruji mengikat integritas transaksi antar modul, dukungan komunitas raksasa. | Membutuhkan instalasi sistem server, pengaturan awal tidak sepraktis layanan *serverless*. | 5 |
| PostgreSQL | Standar industri mutakhir untuk struktur tabel dan kueri data JSON, sangat canggih. | Fitur berlebihan (*overkill*) untuk proyek UMKM tahap permulaan yang baru hijrah dari Excel. | 4 |
| SQLite | Sangat instan, portabilitas tanpa *setup*. | Berbahaya untuk stabilitas antrian integritas sistem *Multi-Branch* jika *user session* digabung. | 3 |
| MongoDB (NoSQL) | Penyimpanan sangat lincah untuk data terpisah. | Sangat rapuh mengamankan jalinan rekonsiliasi transaksi relasional HPP (*Bill of Materials*). | 2 |

**Keputusan**: MySQL
**Justifikasi**: Kebutuhan manajemen Stok BOM (*Bill of Materials*), *Payroll*, PPOB, Kasir, hingga Modul Hutang berakar kuat pada relasi data ganda. Integritas struktural MySQL mengakomodasi skenario sentralisasi laporan multi-cabang tanpa kendala skalabilitas memori di tahap *local server*.
**Risiko dan Mitigasi**: Ketidakcocokan versi layanan *engine database* saat migrasi OS. Ditanggulangi via komitmen versi standar yang ditetapkan ([VERSI_TBA]).

### 5.4 Antarmuka Pengguna (User Interface)
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **CLI / Console** | Fokus pembangunan absolut pada struktur fungsi kode tanpa terganggu elemen estetis, eksekusi super kilat. | UI teks dapat mempersulit adopsi cepat staf operasional lapangan yang terbiasa klik. | 5 |
| Web GUI | Presentasi bisnis ramah bagi awam. | Menyita alokasi bulan pertama untuk merakit kerangka HTTP (API) & antarmuka *frontend framework*. | 3 |
| Desktop GUI | Respons antarmuka sangat mulus untuk *hardware*. | Kode antar *library windowing* (GUI Linux dan Windows) berpotensi rusak dan tak sinkron. | 2 |

**Keputusan**: CLI / Console
**Justifikasi**: Desain utama dari kelayakan sistem pada inisiatif pengembangan dasar menekan keras kecepatan pembangunan Modul Inti dengan kendala batasan 1 orang pelaksana (*Junior Programmer*). CLI adalah jalan pintas merealisasikan 20 fitur *backend* dalam 12 bulan secara nyata.
**Risiko dan Mitigasi**: Perlawanan penyesuaian UX dari kasir & staf produksi. Mitigasinya, penerapan hirarki navigasi berbasis angka intuitif menyerupai format menu akses instan dan prosedur SOP operasional tercetak.

### 5.5 Library Koneksi Database
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **mysql-connector-python** | Driver konektivitas yang disokong secara formal oleh *Oracle*, sangat terjamin kompatibel dan ramah fungsi murni. | *Benchmarking* kueri massal sesekali dinilai sedikit lebih memakan waktu spesifik dibanding *C-extensions*. | 5 |
| PyMySQL | Modul *pure Python*, paling unggul untuk portabilitas server tanpa kakas kompilasi tambahan. | Eksekusi rilis keamanan dan spesifikasi fitur terbaru kadang lambat menyusul MySQL resminya. | 4 |
| SQLAlchemy | *Object-Relational Mapping* (ORM) yang mempermudah migrasi tabel. | Paradigma kental berorientasi objek menentang larangan FP dalam arsitektur murni kita. | 1 |
| aiomysql | *Asynchronous* memicu penanganan volume tinggi tanpa memblokir CPU (*non-blocking*). | Konkurensi I/O yang ditawarkan terlalu superior untuk ekosistem program sederhana CLI UMKM. | 3 |

**Keputusan**: mysql-connector-python
**Justifikasi**: Mengadopsi library resmi menekan kemungkinan insiden sistem aplikasi terputus (CORS/SSL koneksi basis data mati tiba-tiba). Karena ORM diblokir (akibat OOP), paket konektor dasar seperti ini menjamin kita sepenuhnya bertumpu pada kontrol FP murni dalam memparsing struktur hasil *query tuple* ke data tidak terubah.
**Risiko dan Mitigasi**: Isu kompatibilitas modul pada versi Python mutakhir (3.14.2+). Semua skema pustaka dipatok secara ketat [VERSI_TBA — gunakan versi stabil terbaru saat implementasi].

### 5.6 Library Manajemen Konfigurasi
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **python-dotenv** | Industri bersepakat sebagai isolasi data kredensial teraman dan paling praktis yang menolak menyatu dengan *source code*. | Sama sekali tidak membawa utilitas paksaan nilai tipe data parameter variabel lingkungan (*Type Checking*). | 5 |
| configparser | Bagian inti perbekalan Python tanpa perlu dipasang manual (*install*). | Kebiasaan penyimpanan fail `.ini` mengancam keamanan data (rentan ikut *commit* ke Git). | 3 |
| pydantic-settings | Fitur luar biasa teliti dalam menterjemahkan variabel menjadi kelas bertipe spesifik (*auto-cast*). | Pengikatan modulnya memaksakan arsitektur *class instance*, bertolak belakang pada visi FP. | 2 |
| dynaconf | Utilitas lengkap melayani skenario spesifikasi JSON, TOML, hingga YAML ganda. | *Overhead* yang berlebihan demi membungkus variabel kredensial bisnis tingkat sederhana. | 2 |

**Keputusan**: python-dotenv
**Justifikasi**: Membedah rahasia sandi MySQL dan Token Enkripsi ke file tunggal (.env) melepaskan ancaman eksfiltrasi saat repositori diakses anggota tak terduga. Pustaka ringan ini dapat disuntikkan secara fungsional ke seluruh inisiasi skrip program operasi AbuCom.
**Risiko dan Mitigasi**: Kode .env masuk ke repositori *public/private*. Mitigasinya, file .gitignore secara absolut dipersiapkan menolak membaca entitas ini di sesi pra-*commit* awal pengembangan. Versi pustaka: [VERSI_TBA — gunakan versi stabil terbaru saat implementasi].

### 5.7 Library Keamanan — Hashing Password
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **bcrypt** | Konvensi *hashing* terkuat, mencegah serangan kamus/*brute-force*, *work factor* adaptif menyesuaikan daya CPU klien. | Kalah efisien menghalau komputasi GPU massal dibandingkan seri hashing *Argon*. | 5 |
| argon2-cffi | Secara *de-facto* memenangkan algoritma hash pengaman terkini dengan alokasi ketahanan *memory-hard*. | Syarat instalasi ekosistem C (*compiler*) akan sangat rawan *error* di server Windows lokal milik UMKM. | 4 |
| hashlib+scrypt | Paket modul standar Python *built-in* meminimalkan pemasangan repositori pihak ketiga. | Pemrograman pengacakan kunci rahasia (*salt padding*) harus dikonfigurasi kustom, memicu lubang celah. | 3 |
| passlib | Kompendium kerangka utilitas kriptografi sangat ekstensif (*multi-algorithm*). | Tidak menerima peningkatan pemeliharaan aktif, status kode tertinggal (*legacy*). | 2 |

**Keputusan**: bcrypt
**Justifikasi**: Dalam ekosistem OS multi-sistem (Linux/Windows), modul `bcrypt` Python memberikan kestabilan fungsi instalasi tanpa membebani pemilik usaha merakit utilitas C++ pendukung. Kapasitas sandi yang di-hash cukup aman untuk akses data privat kasir maupun identitas aplikasi PPOB *gateway* internal.
**Risiko dan Mitigasi**: Peningkatan waktu komputasi saat perangkat *hardware* menurun (*CPU throttling*). Penetapan iterasi *salt-rounds* konstan di ambang aman (skala beban moderat) agar respon *login* CLI cepat. Versi: [VERSI_TBA — gunakan versi stabil terbaru saat implementasi].

### 5.8 Library Keamanan — Autentikasi Token
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **pyjwt** | Standar pelacakan aktivitas autentikasi nir-basis data (*stateless*), jejak ringan menopang otoritas spesifik di dalam berkas token rahasia. | Tantangan pencabutan hak token ketika karyawan didepak secara mendadak. | 5 |
| python-jose | Protokol keamaan berlapis tingkat tinggi dengan balutan JWE (*Json Web Encryption*). | Konfigurasi awal spesifik sangat menyulitkan penelaahan cepat *debugging* CLI oleh Junior. | 3 |
| authlib | Orkestrasi penyedia manajemen OAuth dan SSO yang menyeluruh. | Spesifikasi platform dirancang sebagai sentral klien web, bukan *user environment* internal terpusat. | 1 |
| session-based | Manajemen mudah dikendalikan, riwayat tercatat dalam *database*, sesi bisa disingkirkan detik itu juga. | Ketergantungan *database lookup* di setiap navigasi menu memperburuk waktu muat CLI jika berstatus terdistribusi cabang (*Multi-Branch*). | 2 |

**Keputusan**: pyjwt
**Justifikasi**: Token otorisasi JWT berpadu sempurna membawakan spesifikasi Hak Akses Berbasis Peran (*Role-Based Access Control*) ke aplikasi via variabel lingkungan *pure function* (nir-status). Ini memenuhi parameter *Audit Trail* bahwa setiap pemanggilan kueri sudah dibekali identitas *user* tanpa tambahan proses *server*.
**Risiko dan Mitigasi**: Pengkopian rahasia token JWT yang dipindah ke komputer karyawan berbeda. Ditetapkan *expiry duration* yang amat singkat (berlaku sesi paruh waktu harian) dan validasi JWT dari *secret-key* lokal terlindungi. Versi: [VERSI_TBA — gunakan versi stabil terbaru saat implementasi].

### 5.9 Sistem Operasi Target
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **Linux Debian 12 Bookworm & Windows 11** | Keselarasan komprehensif mengamankan *budget* penyediaan OS di parameter Rp 0 sesuai infrastruktur eksisting bisnis AbuCom. | Skema konfigurasi *environment pathing* ganda antara dua pilar arsitektur OS. | 5 |
| Ubuntu Server | Komunitas resolusi galat daring yang masif dan paket standar ekosistem pemula mutakhir. | Menyelisih mandat dokumen kelayakan untuk tidak memasukkan variabel instrumen peranti OS baru. | 3 |
| CentOS / RHEL | Tingkat retensi keandalan infrastruktur perangkat keras *Enterprise*. | Pendekatan sistem birokrasi pemutakhiran tergolong ekslusif dan memberatkan admin non-IT (pemilik). | 2 |

**Keputusan**: Linux Debian 12 Bookworm & Windows 11
**Justifikasi**: Kendala bisnis mengharuskan adaptasi implementasi aplikasi berjalan utuh di atas sistem ekosistem ketersediaan alat operasi pemilik di fasilitas layanan percetakan guna menghindari modal tidak langsung (*hardware purchase*).
**Risiko dan Mitigasi**: Inkonsistensi resolusi nama rute direktori berkas (*path naming*) Windows dan Linux yang merusak fungsional navigasi sistem lokal. Hal ini dieksekusi via perpustakaan `pathlib` Python untuk menangani pembatas format *slash/backslash* independen.

### 5.10 Strategi Arsitektur Skalabilitas
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **Multi-Branch Ready** | Mendemonstrasikan arsitektur fundamental pro-peluasan tanpa perombakan skema tabel MySQL ulang (*re-design db*). | Relasi entitas pada kode awal Python menyisipkan deklarasi ID wajib di seluruh parameter dasar. | 5 |
| Single-Tenant | Sangat lugas dan instan bagi arsitektur toko *local-only*. | Berpotensi membangkrutkan usaha saat konsolidasi *multi-store* dikemudian hari dipaksa berjalan. | 2 |
| Microservices | Pertumbuhan *server* terdistribusi sangat independen bagi konglomerasi korporat aplikasi level makro. | Memakan porsi integrasi kerangka ekosistem *over-engineering* parah dan tidak mungkin direalisasikan oleh *AI-augmented solo dev*. | 1 |

**Keputusan**: Multi-Branch Ready
**Justifikasi**: *Stakeholder* mensyaratkan dengan mutlak fondasi data base terstruktur dalam ikatan penugasan Multi-Branch (menyimpan referensi `branch_id`). Ini membuka jalan kesiapan transisi sentralisasi pusat komando saat AbuCom bertransformasi ke fase cabang-cabang baru dengan laporan pelacakan per terminal kasir utuh.
**Risiko dan Mitigasi**: Eksekusi kueri terisolasi tercampur data cabang imajiner. Dibentuk fungsi kontrol filter lapisan modul basis data secara presisi, yang menyuplai penanda unit cabang spesifik ke argumen fungsi per transaksi secara transparan.

### 5.11 Model Pengembangan (Development Model)
| Kandidat | Kelebihan | Kekurangan | Skor Evaluasi (1-5) |
|---|---|---|---|
| **AI-Augmented Development** | Daya komputasi perancangan terdistribusi tanpa henti, kapabilitas berstandar tim insinyur tingkat *senior*, biaya HR Rp 0. | Hasil modul bergantung erat pada kejernihan spesifikasi dokumen dan kualitas *prompt context* pengemudi eksekutor (Junior Programmer). | 5 |
| Solo Junior Programmer | Komunikasi *bug* satu arah tanpa perselisihan argumen teknis kerangka. | Volume 20 modul terlalu raksasa dikendalikan dalam parameter 12 bulan oleh pemula *coding*. | 1 |
| Vendor Outsourcing (Software House) | Jaminan *SLA (Service Level Agreement)* kontrak terima beres, lepas tangan dari urusan server. | Melanggar kerangka utama batas persediaan modal inisiatif, rentan penguncian ekosistem lisensi tertutup (*vendor lock-in*). | 1 |

**Keputusan**: AI-Augmented Development (1 Junior Programmer + 6 Agen AI)
**Justifikasi**: Tim pengembang dirancang dengan kolaborasi orkestrasi: 1 Junior Programmer (sebagai *Project Manager/Driver*) dipadu dukungan kognitif 6 Agen (Gemini Pro High merumuskan arsitektur, Gemini Pro Low di level dokumentasi, Gemini Flash pemecah kebuntuan *bug*, Claude Sonnet menangani eksekusi mendalam FP, Claude Opus penjaga audit *security*, dan GPT-OSS pengisi pustaka). Metode ini memenuhi syarat ekonomi mutlak anggaran tenaga pengembangan Rp 0.
**Risiko dan Mitigasi**: Risiko agen mengalami halusinasi dan melanggar ketetapan batasan fungsional arsitektur saat kode ditulis. Strategi mitigasinya dipatok dengan mengharuskan eksekusi penyuntikan parameter *referensi project charter* ini sebelum setiap *prompt* penulisan fungsi aplikasi dikerjakan.

## Matriks Ringkasan Keputusan (Decision Summary Matrix)
| Komponen | Teknologi Terpilih | Versi/Spesifikasi | Status Lisensi | Tingkat Risiko |
|---|---|---|---|---|
| Bahasa Pemrograman | Python | 3.14.2+ | Open-Source (Rp 0) | Rendah |
| Paradigma Pemrograman | Functional Programming | N/A | Paradigma Umum | Sedang |
| Database | MySQL | [VERSI_TBA] | Open-Source (Rp 0) | Rendah |
| Antarmuka Pengguna | CLI / Console | N/A | N/A | Sedang |
| Library Konektor DB | mysql-connector-python | [VERSI_TBA — gunakan versi stabil terbaru saat implementasi] | Open-Source (Rp 0) | Rendah |
| Library Manajemen Konfigurasi | python-dotenv | [VERSI_TBA — gunakan versi stabil terbaru saat implementasi] | Open-Source (Rp 0) | Rendah |
| Library Keamanan (Hashing) | bcrypt | [VERSI_TBA — gunakan versi stabil terbaru saat implementasi] | Open-Source (Rp 0) | Rendah |
| Library Keamanan (Token) | pyjwt | [VERSI_TBA — gunakan versi stabil terbaru saat implementasi] | Open-Source (Rp 0) | Rendah |
| OS Target Deployment | Linux Debian 12 & Windows 11 | [SPESIFIKASI_TBA] | Tersedia (Existing) / Open-Source | Rendah |
| Strategi Arsitektur Skalabilitas | Multi-Branch Ready | [KONFIGURASI_TBA] | N/A | Sedang |
| Model Pengembangan Sistem | AI-Augmented Development | 1 Junior + 6 Agen AI | Akses Ekosistem | Tinggi |

## Kendala dan Batasan (Constraints)
- Pelarangan mutlak eksploitasi OOP, wajib menggunakan **Functional Programming** sebagai penyusun logika dan pengelolaan modul program.
- Syarat pendanaan **Rp 0** terhadap kompensasi perangkat lunak basis operasi (seluruh komponen mutlak berafiliasi **Open-Source**).
- Penolakan kerangka kerja integrasi *Graphic User Interface (GUI)* untuk fase tahap pertama ini, semua rute sistem operasional mutlak via terminal **CLI/Console**.
- Aplikasi dirancang murni bagi landasan mesin berfasilitas operasional lingkungan sistem lokal Windows 11 dan mesin komputasi Linux Debian 12 Bookworm.

## Riwayat Versi
| Versi | Tanggal | Diubah Oleh | Keterangan |
|---|---|---|---|
| 1.0.0 | 2026-05-12 | Senior Enterprise Architect & Senior Technical Lead (AI) | Pembuatan draf dokumen *Tech Stack Decision* berdasarkan rujukan spesifikasi terpusat ekosistem SDLC (Siklus Pelaksanaan *Planning*). |

## Referensi Dokumen
Dokumen ini disusun dan divalidasi berdasarkan:
- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/01_planning/02_feasibility_study.md`
- `docs/sdlc/01_planning/03_stakeholder_register.md`
