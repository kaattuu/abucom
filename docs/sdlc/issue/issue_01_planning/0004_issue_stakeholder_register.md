# Issue: Pembuatan Dokumen Stakeholder Register (03_stakeholder_register.md)

## Deskripsi Tugas
Anda ditugaskan untuk membuat dokumen **Stakeholder Register** (`03_stakeholder_register.md`) yang merupakan bagian dari fase Perencanaan (Planning) dalam siklus SDLC. Dokumen ini saat ini memiliki status `[create_file]`. Tujuan Anda adalah merangkum, mengekstrak, dan menyusun informasi terkait pemangku kepentingan (stakeholder) dari dokumen referensi yang ada menjadi satu dokumen yang terstruktur, komprehensif, dan siap digunakan secara profesional.

## 1. Persona yang Digunakan
**Bertindaklah sebagai "Senior Project Manager" dan "Senior Business Analyst".**
Anda memiliki keahlian mendalam dalam manajemen proyek, analisis bisnis, dan komunikasi korporat. Anda sangat teliti dalam mengidentifikasi pemangku kepentingan, memahami ekspektasi mereka, memetakan tingkat pengaruh serta kepentingan mereka terhadap keberhasilan proyek, dan merumuskan strategi komunikasi yang efektif.

## 2. Referensi Utama
Gunakan file-file berikut yang berada di dalam folder `docs/sdlc/` sebagai sumber informasi utama dan satu-satunya acuan:
- `docs/sdlc/narasi.txt` (Konteks dasar proyek, latar belakang, dan pihak-pihak yang terlibat dalam cerita bisnis)
- `docs/sdlc/01_planning/01_project_charter.md` (Daftar awal sponsor, manajer proyek, dan pihak terkait utama)
- `docs/sdlc/01_planning/02_feasibility_study.md` (Informasi tambahan mengenai pihak yang terdampak dari sisi bisnis dan teknis)

## 3. Ekstraksi dan Rangkuman Data
- Baca dengan saksama seluruh referensi di atas.
- Ekstrak setiap nama, jabatan, departemen, entitas bisnis, dan peran yang disebutkan secara eksplisit maupun implisit.
- Pastikan tidak ada satupun pemangku kepentingan yang terlewat, sekecil apapun peran atau dampak yang mereka terima dari proyek ini.

## 4. Fokus pada Spesifikasi Dokumen
- Hanya ambil informasi yang berkaitan murni dengan **Stakeholder** (Pemangku Kepentingan).
- Abaikan informasi teknis sistem, anggaran detail, atau spesifikasi infrastruktur yang tidak berhubungan langsung dengan profil, peran, atau ekspektasi pemangku kepentingan, agar dokumen tetap bersih dan terfokus.

## 5. Standar Struktur Dokumen (Praktik Industri)
Gunakan struktur dokumen Stakeholder Register standar industri berikut ini:
1. **Informasi Dokumen** (Judul Dokumen, Versi, Tanggal, Penulis)
2. **Pendahuluan** (Tujuan dan cakupan dokumen ini)
3. **Daftar Pemangku Kepentingan (Stakeholder Roster)**. Gunakan format tabel dengan kolom:
   - Nama Lengkap
   - Jabatan/Peran
   - Departemen/Organisasi
   - Kontak (Email/No. HP)
4. **Analisis Pemangku Kepentingan (Stakeholder Analysis)**. Gunakan format tabel dengan kolom:
   - Nama/Peran
   - Tingkat Kepentingan (*Interest*: Tinggi/Sedang/Rendah)
   - Tingkat Pengaruh (*Power*: Tinggi/Sedang/Rendah)
   - Ekspektasi Utama/Kebutuhan
   - Strategi Manajemen/Komunikasi
5. **Referensi Dokumen** (Wajib diletakkan di akhir dokumen)

## 6. Kelayakan Sebagai Referensi Fase Selanjutnya
Dokumen ini harus memberikan kejelasan mutlak mengenai siapa pemegang keputusan (decision maker), siapa yang harus dihubungi untuk persetujuan (approval), eskalasi isu, dan narasumber utama untuk pengumpulan kebutuhan (requirement gathering) pada fase Analisis selanjutnya.

## 7. Gaya Bahasa
- Gunakan Bahasa Indonesia yang formal, natural, jelas, dan sangat profesional.
- Hindari kalimat bersayap atau ambigu. Gunakan kalimat langsung dan lugas agar mudah diproses oleh junior programmer atau sistem AI lainnya.

## 8. Kualitas dan Kelengkapan Tanpa Interupsi
- Pastikan hasil akhir sangat komprehensif dan terstruktur dengan rapi sehingga tidak menimbulkan pertanyaan lanjutan saat fase SDLC berikutnya berjalan.
- Jangan berikan opsi atau tebakan. Jika ada keputusan yang harus diambil, simpulkan secara logis berdasarkan data dari file referensi.

## 9. Penanganan Data Kosong (Pencegahan Halusinasi)
- Jika terdapat informasi spesifik yang **tidak ditemukan** pada file referensi (misalnya: Nama asli individu, alamat Email yang presisi, atau Nomor HP), **JANGAN MENGARANG (HALUSINASI)**.
- Gunakan penanda khusus (placeholder) seperti `[NAMA_TBA]`, `[EMAIL_TBA]`, atau `[KONTAK_TBA]` agar tim manajemen proyek mengetahui bagian mana yang perlu dilengkapi secara manual di kemudian hari.

## 10. Output Bersih (Clean Output)
- Hasilkan **HANYA** hasil akhir (konten bersih) dari isi dokumen `03_stakeholder_register.md`.
- **DILARANG KERAS** menyertakan instruksi pengerjaan, proses pemikiran (thinking process), pembuka/penutup percakapan ("Tentu, berikut adalah...", "Semoga membantu", dll.), atau komentar tambahan apa pun. File Markdown yang dihasilkan harus 100% murni berisi konten spesifik Stakeholder Register siap pakai.

## 11. Kewajiban Referensi di Akhir Dokumen
Pada bagian paling bawah (baris terakhir) dari dokumen yang Anda buat, wajib menyertakan sumber referensi dengan format persis seperti ini:

```markdown
## 5. Referensi
Dokumen ini disusun berdasarkan:
- `docs/sdlc/narasi.txt`
- `docs/sdlc/01_planning/01_project_charter.md`
- `docs/sdlc/01_planning/02_feasibility_study.md`
```

---

# Tahapan Implementasi (Instruksi Low-Level)
Bagi junior programmer atau model AI yang mengimplementasikan issue ini, kerjakan secara ketat menggunakan langkah-langkah sistematis berikut:

1. **Tahap 1: Pengumpulan Data Referensi**
   - Lakukan pemanggilan tool `view_file` atau tool pembaca file yang sesuai untuk membaca isi file `/docs/sdlc/narasi.txt`.
   - Lakukan pemanggilan tool pembaca file untuk membaca isi file `/docs/sdlc/01_planning/01_project_charter.md`.
   - Lakukan pemanggilan tool pembaca file untuk membaca isi file `/docs/sdlc/01_planning/02_feasibility_study.md`.
   - Simpan seluruh teks tersebut ke dalam memori kerja (context) Anda.

2. **Tahap 2: Ekstraksi dan Klasifikasi Entitas**
   - Cari kata kunci entitas manusia, jabatan, atau divisi (contoh: "Pemilik", "Klien", "Manajer", "Tim IT", "Pengguna").
   - Identifikasi ekspektasi masing-masing entitas tersebut terhadap proyek.
   - Petakan setiap entitas ke dalam kategori *Power* (Pengaruh) dan *Interest* (Kepentingan). Misalnya, Pemilik (Sponsor) memiliki Power: Tinggi dan Interest: Tinggi.

3. **Tahap 3: Penyusunan Draf Markdown**
   - Buat format dasar Markdown mengikuti spesifikasi struktur pada poin (5).
   - Isi tabel "Stakeholder Roster" dan "Stakeholder Analysis" dengan data hasil ekstraksi tahap 2.
   - Sisipkan label `[TBA]` untuk kolom kontak atau nama spesifik yang tidak disebutkan di file referensi.
   - Tambahkan blok Referensi di akhir baris sesuai poin (11).

4. **Tahap 4: Filter Output Bersih**
   - Hilangkan semua teks pengantar.
   - Pastikan keluaran hanya berisi tag Markdown dari `# Informasi Dokumen` hingga referensi terakhir.

5. **Tahap 5: Eksekusi Penulisan (Write/Replace)**
   - Gunakan tool `replace_file_content` (jika file sudah memiliki isi placeholder) atau `write_to_file` (jika file kosong) untuk menulis seluruh teks output ke target file: `docs/sdlc/01_planning/03_stakeholder_register.md`.
   - Pastikan Anda menggunakan *absolute path* yang benar sesuai _environment_ aktif.
