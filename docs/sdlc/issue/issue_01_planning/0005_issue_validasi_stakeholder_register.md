# Issue: Validasi Dokumen Stakeholder Register (03_stakeholder_register.md)

## Persona
Sebagai **Senior Project Manager** dan **Senior Business Analyst** yang ahli dalam manajemen proyek dan tata kelola korporat tingkat Enterprise, Anda ditugaskan untuk memeriksa, menganalisa, dan memvalidasi secara ketat dokumen `docs/sdlc/01_planning/03_stakeholder_register.md` yang saat ini memiliki status `[validasi]`.

## Tujuan Utama
Memastikan dokumen Stakeholder Register mencapai standar kualitas tinggi, akurat, relevan, tidak memiliki data halusinasi, dan siap menjadi acuan utama tanpa interupsi pada fase SDLC selanjutnya.

## Instruksi Validasi

Silakan lakukan perbaikan, pemeriksaan, dan validasi dengan mengikuti poin-poin berikut:

1. **Komparasi Mendalam**: Lakukan komparasi mendalam antara dokumen `03_stakeholder_register.md` dengan dokumen referensi seperti `01_project_charter.md`, `02_feasibility_study.md`, dan `narasi.txt`. Pastikan tidak ada data atau informasi yang bertentangan.
2. **Kelengkapan Data**: Periksa dan validasi kembali apakah dokumen ini sudah merangkum *semua* data dan informasi terkait stakeholder (pemangku kepentingan) yang terdapat di dalam file referensi. Pastikan tidak ada detail stakeholder atau entitas penting yang terlewat.
3. **Fokus dan Relevansi**: Periksa dan validasi apakah dokumen ini hanya mengambil dan merangkum data/informasi yang spesifik dibutuhkan oleh *Stakeholder Register*. Buang informasi yang tidak relevan agar dokumen ini bersih dan terfokus pada peran, ekspektasi, dan tingkat pengaruh stakeholder.
4. **Standar Industri**: Pastikan dokumen ini memiliki standar struktur yang sesuai, lengkap, dan informatif layaknya dokumen praktik industri yang sesungguhnya.
5. **Kualitas Sebagai Referensi Utama**: Periksa dan validasi apakah isi dokumen ini layak untuk dijadikan sebagai referensi, acuan, dan input utama bagi dokumen lain pada fase tahapan SDLC selanjutnya tanpa menimbulkan kebingungan.
6. **Struktur Bahasa**: Gunakan dan validasi penggunaan struktur Bahasa Indonesia yang natural, profesional, tidak ambigu, tidak membingungkan, dan sangat mudah dipahami oleh junior programmer atau LLM model AI lain yang akan menggunakannya.
7. **Ketangguhan Dokumen (Non-Interruptive)**: Pastikan kualitas kelengkapan isi dokumen ini sangat baik, sehingga tidak akan selalu dipertanyakan kembali dan tidak akan menginterupsi/menghambat kelancaran pekerjaan fase tahapan SDLC selanjutnya.
8. **Pengisian Data Kosong (Imputasi Logis)**: Periksa jika ada data yang kosong, tidak tersedia, atau `placeholder` yang perlu diisi manual. Jika ada, maka isilah data tersebut dengan asumsi logis profesional yang sesuai, cocok, dan masih dalam ruang lingkup proyek AbuCom.
9. **Karakteristik Khusus Stakeholder Register**: 
   - Pastikan terdapat **Matriks Analisis Stakeholder** (misal: analisis Power/Interest).
   - Pastikan memuat strategi manajemen dan komunikasi untuk masing-masing klasifikasi stakeholder.
   - Pastikan kriteria keberhasilan (*success criteria*) dari setiap stakeholder didefinisikan dengan jelas.
10. **Pembaruan Dokumen & Versi**: Tuangkan semua hasil temuan dan perbaikan secara langsung ke dalam file `docs/sdlc/01_planning/03_stakeholder_register.md`. **Pastikan merubah versi dokumen** (misal `v1.0` menjadi `v1.1`) di bagian meta/header dokumen sebagai tanda bahwa dokumen ini telah mengalami proses validasi dan perbaikan.
11. **Daftar Referensi Akhir**: Pastikan jika ada penambahan file referensi dalam proses perbaikan dokumen ini, Anda tidak lupa untuk menambahkannya di bagian akhir (baris paling bawah) pada dokumen `03_stakeholder_register.md` tersebut.

---

## Langkah-langkah Implementasi (Low-Level Execution)

Agar implementasi dapat berjalan dengan mulus dan terarah tanpa halusinasi, ikuti tahapan detail berikut:

**Tahap 1: Pengumpulan Konteks (Read & Analyze)**
1. Buka dan baca file `docs/sdlc/01_planning/01_project_charter.md` secara keseluruhan. Catat seluruh nama individu, posisi/jabatan, klien, vendor, atau entitas yang terlibat.
2. Buka dan baca `docs/sdlc/01_planning/02_feasibility_study.md` serta `narasi.txt`. Tambahkan entitas baru ke dalam daftar catatan jika ditemukan.
3. Buka file utama yang menjadi target: `docs/sdlc/01_planning/03_stakeholder_register.md`.

**Tahap 2: Audit dan Pemetaan Stakeholder**
1. Bandingkan daftar nama dan peran pada dokumen target (`03_stakeholder_register.md`) dengan catatan yang telah Anda buat di Tahap 1.
2. Tambahkan stakeholder yang tertinggal ke dalam dokumen target.
3. Hapus entitas atau penjelasan yang menyimpang dari ruang lingkup proyek AbuCom.

**Tahap 3: Validasi Analisis dan Strategi**
1. Periksa bagian Tabel Register (Daftar Stakeholder). Pastikan kolom seperti `Nama/Posisi`, `Peran`, `Ekspektasi Utama`, `Pengaruh (Power)`, `Kepentingan (Interest)`, dan `Kategori` telah terisi sepenuhnya. 
2. Apabila terdapat sel tabel yang masih kosong (`[TBD]`, `[Placeholder]`), isilah dengan analisis logis dari kacamata Senior Project Manager. (Contoh: *Project Sponsor* selalu memiliki nilai Power `Tinggi` dan Interest `Tinggi`).
3. Validasi strategi komunikasi (apakah cukup dengan *Keep Informed*, *Manage Closely*, dsb).

**Tahap 4: Pemeriksaan Tata Bahasa dan Format**
1. Baca ulang dari baris pertama hingga terakhir. Ubah kalimat yang berbelit-belit menjadi lugas, baku, dan jelas (menggunakan standar Bahasa Indonesia).
2. Periksa format *Markdown*. Pastikan tabel ter-render dengan baik (tidak rusak), heading berjenjang dengan benar (`#`, `##`, `###`), dan daftar list rapi.

**Tahap 5: Finalisasi (Write & Update)**
1. Lakukan *replace* atau penulisan ulang seluruh konten yang telah diperbaiki langsung ke file `docs/sdlc/01_planning/03_stakeholder_register.md`.
2. Cari bagian **Version/Versi** di header dokumen, dan tingkatkan angkanya (misalnya `v1.0` -> `v1.1`).
3. Cari bagian **Referensi** di bawah dokumen. Pastikan `01_project_charter.md`, `02_feasibility_study.md`, dan `narasi.txt` tertulis rapi sebagai daftar pustaka.
4. Pekerjaan selesai. Anda *tidak perlu* memodifikasi file `sdlc.txt`, cukup selesaikan perbaikan pada file dokumen utamanya saja.
