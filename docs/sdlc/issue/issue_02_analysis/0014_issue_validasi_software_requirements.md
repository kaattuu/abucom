# Issue: Validasi Software Requirements Specification (SRS)

## Deskripsi Tugas
Melakukan proses validasi, pemeriksaan, dan analisis mendalam secara ketat terhadap dokumen utama `02_software_requirements.md` yang saat ini masih memiliki status `[draft]`. Tujuannya adalah untuk menyempurnakan dokumen spesifikasi kebutuhan perangkat lunak tersebut agar bersih, fokus, komprehensif, teknikal, dan memenuhi standar industri sehingga layak menjadi acuan utama pada tahapan desain (SDLC berikutnya).

## Persona Implementasi
Bertindaklah sebagai **Senior Systems Analyst**, **Senior Software Architect**, dan **Senior Quality Assurance Specialist**. Anda memiliki keahlian tingkat tinggi dalam memastikan kualitas dokumen spesifikasi teknis (Software Requirements), berorientasi pada detail logika komputasi, teliti terhadap arsitektur, sangat kritis terhadap ambiguitas fungsionalitas, dan mampu memvalidasi keselarasan antara *Business Requirements* dengan *Software Requirements*. Anda bertanggung jawab penuh memastikan dokumen ini tidak memiliki cacat rancangan atau kekurangan detail teknis.

## File Referensi
Dalam pengerjaan issue ini, Anda diwajibkan untuk membandingkan dan memvalidasi `02_software_requirements.md` dengan dokumen berikut:
1. `docs/sdlc/02_analysis/01_business_requirements.md`
2. `docs/sdlc/01_planning/04_tech_stack_decision.md`
3. `docs/sdlc/narasi.txt`
4. (Serta file referensi lain yang relevan yang sudah ada sebelumnya)

## Daftar Pekerjaan (Planning & Tasks)
Berikut adalah instruksi *low-level* yang harus Anda jalankan secara terstruktur agar tidak terjadi ambiguitas atau halusinasi selama implementasi:

1. **Komparasi Mendalam:** Lakukan komparasi mendalam antara dokumen `02_software_requirements.md` dengan file referensi yang disebutkan di atas (termasuk `narasi.txt`). Pastikan tidak ada data krusial, spesifikasi teknis, atau batasan sistem yang saling bertentangan.
2. **Kelengkapan Informasi:** Periksa, analisa, dan validasi kembali apakah dokumen ini sudah merangkum secara utuh semua data dan informasi teknis yang ada di dalam file referensi. Pastikan tidak ada satupun detail fungsionalitas atau kebutuhan sistem (seperti pembatasan resource atau interaksi user) yang terlewat.
3. **Fokus dan Relevansi Data:** Periksa, analisa, dan validasi kembali apakah dokumen ini hanya mengambil dan merangkum data/informasi yang **spesifik dibutuhkan** oleh dokumen Software Requirements ini. Bersihkan dokumen dari informasi bisnis tingkat tinggi yang tidak relevan dengan implementasi teknis agar dokumen tetap fokus pada kebutuhan operasional *software*.
4. **Standar Struktur Dokumen:** Periksa, analisa, dan validasi kembali apakah dokumen ini memiliki standar struktur dokumen yang sesuai, terorganisir, lengkap, dan informatif layaknya dokumen praktik industri (*industry standard*). Pastikan ada pemisahan yang sangat jelas antara *Functional Requirements* dan *Non-Functional Requirements*.
5. **Kelayakan Sebagai Referensi Utama:** Periksa, analisa, dan validasi kembali apakah isi dokumen ini sudah cukup solid, detail secara teknikal, dan layak untuk dijadikan sebagai referensi, acuan, dan input utama bagi pembuatan Use Case, Workflow, Database Schema, dan System Architecture pada fase SDLC selanjutnya.
6. **Kualitas Bahasa (Natural & Jelas):** Periksa, analisa, dan validasi kembali apakah dokumen ini menggunakan struktur bahasa Indonesia yang natural, baku, tidak ambigu, tidak membingungkan, dan mudah dipahami secara spesifik oleh *junior programmer* maupun model AI lain yang akan mengeksekusi *coding* atau mendesain sistem nantinya.
7. **Kualitas dan Integritas Dokumen:** Periksa, analisa, dan validasi kembali apakah kualitas kelengkapan isi dokumen ini tidak akan selalu dipertanyakan dan tidak akan selalu diinterupsi oleh tim di tahap selanjutnya, yang mana hal itu dapat menghambat berjalannya proses desain dan implementasi.
8. **Pengisian Data Kosong (*Placeholder*):** Periksa, analisa, dan validasi kembali apakah ada data yang kosong, tidak tersedia, atau berisi *placeholder* (seperti `[...]`, `TBD`, dsb). Jika ada, **isilah data tersebut** dengan estimasi rasional, parameter teknis yang logis, atau data buatan yang sesuai, relevan, dan masih dalam ruang lingkup dokumen serta sejalan dengan *Tech Stack Decision*. **Jangan biarkan ada data teknis yang kosong.**
9. **Kesesuaian Paradigma dan Arsitektur (Kekhususan Dokumen):** Mengingat proyek ini berfokus pada CLI dan menggunakan Functional Programming (FP), pastikan, periksa, dan validasi kembali bahwa **TIDAK ADA** terminologi *Object-Oriented Programming* (OOP) seperti "Class", "Object", atau "Inheritance", dan **TIDAK ADA** terminologi *Graphical User Interface* (GUI) seperti "Button", "Click", atau "Window". Semua interaksi harus direpresentasikan sesuai paradigma CLI dan FP murni.
10. **Finalisasi & Update Versi:** Tuangkan semua hasil temuan dan perbaikan langsung ke dalam file `docs/sdlc/02_analysis/02_software_requirements.md` (yang berstatus `[draft]`). Pastikan untuk **merubah riwayat versi (Version Control)** di dalam dokumen sebagai tanda bukti bahwa dokumen ini telah mengalami perbaikan dan proses validasi tahap lanjut.
11. **Penambahan Referensi:** Jika terdapat penambahan file referensi baru yang Anda gunakan dalam proses perbaikan dokumen ini (yang sebelumnya belum ada), **jangan sampai lupa** untuk menambahkannya di bagian akhir (baris paling bawah) dari dokumen `02_software_requirements.md`.

## Instruksi Eksekusi (Anti-Halusinasi)
- **Modifikasi Langsung:** Jangan hanya memberikan daftar apa yang salah atau saran perbaikan dalam bentuk teks percakapan. Anda harus **mengeksekusinya secara langsung** dengan memodifikasi isi file `02_software_requirements.md` secara nyata.
- **Batasi Imajinasi:** Hanya validasi dan tambahkan detail berdasarkan dokumen yang sudah ada (BRD, Tech Stack, dll). Jangan mengarang fitur baru yang tidak pernah direncanakan di fase sebelumnya.
- **Self-Correction:** Setelah Anda selesai melakukan modifikasi, baca kembali dokumen `02_software_requirements.md` dari atas sampai bawah untuk memastikan seluruh format konsisten dan tidak ada instruksi tugas di atas yang terlewat.
