# Issue: Pembuatan Dokumen Software Requirements Specification (SRS)

## Objektif
Membuat dokumen `02_software_requirements.md` yang berada di dalam folder `docs/sdlc/02_analysis/`. Dokumen ini merupakan spesifikasi teknis turunan dari Business Requirements Document (BRD) dan akan menjadi acuan utama, fundamental, dan instruksional bagi fase desain sistem (Arsitektur, Database, dan Alur CLI).

## Instruksi Implementasi (Low-Level & Direktif)

Kepada Junior Programmer / AI Agent yang bertugas: Ikuti seluruh instruksi di bawah ini secara ketat tanpa deviasi.

1. **Penentuan Persona**:
   Bertindaklah sebagai **Senior Systems Analyst** dan **Senior Software Engineer** dengan spesialisasi pada arsitektur perangkat lunak berbasis Command Line Interface (CLI) dan paradigma *Functional Programming* murni.

2. **Pemilihan File Referensi Utama**:
   Gunakan file-file berikut sebagai acuan wajib (baca dan analisa secara menyeluruh sebelum mulai menulis):
   - `docs/sdlc/02_analysis/01_business_requirements.md` (Referensi utama untuk menerjemahkan aturan bisnis menjadi fungsionalitas sistem).
   - `docs/sdlc/01_planning/04_tech_stack_decision.md` (Referensi batasan teknologi dan lingkungan sistem).
   - `docs/sdlc/narasi.txt` (Hanya gunakan jika terdapat konteks fungsionalitas CLI atau batasan spesifik yang belum terakomodasi di BRD).

3. **Merangkum Data & Ekstraksi Menyeluruh**:
   Ekstrak seluruh kebutuhan bisnis dan operasional dari file referensi. Terjemahkan menjadi Kebutuhan Fungsional (System Features) dan Kebutuhan Non-Fungsional. Pastikan TIDAK ADA detail fitur atau batasan dari BRD yang terlewatkan.

4. **Fokus Spesifik Perangkat Lunak**:
   Dokumen ini adalah *Software Requirements*, maka isi dokumen HARUS sangat spesifik membahas perilaku sistem (Input, Proses, Output). Hindari memasukkan latar belakang bisnis, narasi manajemen, atau asumsi non-teknis. Jaga agar dokumen ini tetap bersih dan murni teknis.

5. **Struktur Dokumen (Standar Industri)**:
   Susun dokumen dengan struktur baku SRS yang komprehensif dan profesional. Wajib mencakup:
   - **1. Pendahuluan**: Tujuan Dokumen, Ruang Lingkup Perangkat Lunak.
   - **2. Deskripsi Keseluruhan**: Perspektif Sistem, Karakteristik Pengguna, Lingkungan Operasi, Asumsi & Ketergantungan.
   - **3. Kebutuhan Antarmuka Eksternal**: Antarmuka Pengguna (CLI), Antarmuka Perangkat Lunak/Sistem.
   - **4. Kebutuhan Fungsional (Detail System Features)**: Rincian setiap fitur aplikasi dengan batasan input, proses komputasi fungsional, dan output yang jelas pada terminal CLI.
   - **5. Kebutuhan Non-Fungsional**: Kinerja (Performance), Keamanan (Security), Keandalan (Reliability).
   - **6. Referensi**: Daftar dokumen acuan.

6. **Kualitas Kelayakan Input Fase Selanjutnya**:
   Pastikan deskripsi fungsional sangat presisi. Sebagai contoh, jika mendeskripsikan fitur input, sebutkan secara logis parameter yang dibutuhkan. Kelengkapan dokumen ini harus mampu mencegah interupsi pertanyaan dari tim fase desain (fase 03).

7. **Struktur Bahasa dan Kejelasan**:
   Gunakan Bahasa Indonesia yang natural, baku, teknis, dan lugas (contoh: "Sistem HARUS memvalidasi...", "Sistem AKAN menampilkan..."). Hindari struktur kalimat yang ambigu, menggantung, atau multitafsir.

8. **Kelengkapan Tanpa Halusinasi**:
   Setiap fungsi yang dijabarkan harus memiliki dasar dari referensi. Jangan membuat fitur baru yang tidak ada landasan bisnisnya di BRD. 

9. **Penanganan Data Kosong (Placeholders)**:
   Apabila terdapat kebutuhan teknis yang harus ada namun datanya tidak tersedia di file referensi (misal: batas maksimum ukuran file, batasan waktu sesi, rincian tipe data tertentu), JANGAN mengarang/halusinasi. Tandai dengan kurung siku kapital, misalnya: `[BUTUH_KLARIFIKASI_BATAS_MAKSIMAL_KARAKTER]` atau `[MASUKKAN_NILAI_TIMEOUT]`, agar dapat diisi secara manual nantinya.

10. **Aturan Output Konten Bersih (Clean Output)**:
    Keluarkan **HANYA** hasil akhir markdown dari [dokumen utama] (`02_software_requirements.md`). JANGAN menyertakan *thought process*, JANGAN menuliskan komentar, pembuka, atau penutup di luar isi dokumen itu sendiri. Dokumen harus siap pakai seketika.

11. **Pencantuman Referensi di Akhir Dokumen**:
    Pada bagian paling bawah (Seksi 6. Referensi), cantumkan daftar *relative path* dan nama file dari dokumen-dokumen yang digunakan sebagai acuan pembuatan dokumen SRS ini.

12. **Aturan Khusus Domain (Ciri Khas Proyek)**:
    - **Strict CLI Context**: Karena aplikasi murni CLI, dilarang keras menggunakan terminologi Graphical User Interface (GUI) seperti "klik", "tombol", "jendela pop-up", "halaman", dll. Gunakan terminologi CLI seperti "prompt", "perintah (command)", "argumen", "stdout/stderr", dan "input keyboard".
    - **Strict Functional Programming (FP)**: Sesuai pedoman arsitektur, dilarang menggunakan terminologi Object-Oriented Programming (OOP) seperti "class", "object", "instansiasi", "inheritance", dsb. Gunakan terminologi FP seperti "fungsi", "pure function", "immutability", dan "state passing".
