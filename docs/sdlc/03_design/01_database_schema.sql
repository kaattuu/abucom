-- =================================================================================
-- Nama Proyek   : AbuCom — Sistem Manajemen Usaha Percetakan
-- Deskripsi     : DDL SQL lengkap untuk pembentukan skema basis data
-- Versi         : 1.1.0
-- Status        : [finish]
-- Database      : MySQL 8.4 LTS Community Edition
-- Engine        : InnoDB
-- Charset       : utf8mb4
-- Collation     : utf8mb4_unicode_ci
-- Tanggal       : 2026-05-14
-- Oleh          : Senior Database Architect
-- =================================================================================
-- Konvensi yang digunakan: penamaan snake_case, DECIMAL(15,4) untuk finansial dan 
-- kuantitas presisi tinggi, ENUM untuk domain nilai terbatas, soft-delete via is_active, 
-- dan arsitektur Multi-Branch Ready via branch_id.
-- =================================================================================

DROP DATABASE IF EXISTS abucom_db;
CREATE DATABASE abucom_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE abucom_db;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- Tabel: branches
-- Deskripsi: Menyimpan informasi unit cabang usaha percetakan.
-- ============================================
CREATE TABLE branches (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_name VARCHAR(100) NOT NULL COMMENT 'Nama cabang percetakan',
    address TEXT NOT NULL COMMENT 'Alamat lengkap cabang',
    phone_number VARCHAR(20) COMMENT 'Nomor telepon kontak cabang',
    is_active BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'Status operasional cabang (Aktif/Tidak)',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu pencatatan data cabang'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Menyimpan informasi unit cabang usaha percetakan.';

-- ============================================
-- Tabel: users
-- Deskripsi: Menyimpan data login dan otorisasi dari pemilik maupun karyawan.
-- ============================================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang tempat pengguna terdaftar',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT 'Username untuk login CLI',
    password_hash VARCHAR(255) NOT NULL COMMENT 'Hash password bcrypt',
    role ENUM('Pemilik', 'Karyawan') NOT NULL COMMENT 'Hak akses dan peran pengguna',
    is_active BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'Status keaktifan akun pengguna',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu akun dibuat',
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Waktu akun terakhir diperbarui',
    CONSTRAINT fk_users_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Menyimpan data login dan otorisasi dari pemilik maupun karyawan.';

-- ============================================
-- Tabel: pricing_tiers
-- Deskripsi: Mengelola skema tingkatan harga (contoh: Retail, Grosir, Mitra).
-- ============================================
CREATE TABLE pricing_tiers (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang',
    tier_name ENUM('Retail', 'Grosir', 'Mitra') NOT NULL UNIQUE COMMENT 'Nama tingkatan harga',
    min_qty DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Kuantitas minimal untuk mendapatkan skema harga ini',
    min_active_months INT NOT NULL DEFAULT 0 COMMENT 'Syarat durasi aktif pelanggan (bulan) untuk harga Mitra',
    description TEXT COMMENT 'Deskripsi syarat dan ketentuan skema harga',
    CONSTRAINT fk_pricing_tiers_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Mengelola skema tingkatan harga (contoh: Retail, Grosir, Mitra).';

-- ============================================
-- Tabel: customers
-- Deskripsi: Menyimpan data kontak pelanggan dan riwayat keanggotaan.
-- ============================================
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang tempat pelanggan terdaftar',
    pricing_tier_id INT NOT NULL COMMENT 'ID referensi skema harga pelanggan',
    full_name VARCHAR(150) NOT NULL COMMENT 'Nama lengkap pelanggan',
    whatsapp_number VARCHAR(20) COMMENT 'Nomor kontak/WhatsApp pelanggan',
    registered_date DATE NOT NULL DEFAULT (CURRENT_DATE) COMMENT 'Tanggal pelanggan pertama kali transaksi',
    CONSTRAINT fk_customers_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_customers_pricing_tier FOREIGN KEY (pricing_tier_id) REFERENCES pricing_tiers(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Menyimpan data kontak pelanggan dan riwayat keanggotaan.';

-- ============================================
-- Tabel: vendors
-- Deskripsi: Data supplier atau vendor yang memasok bahan baku atau layanan.
-- ============================================
CREATE TABLE vendors (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang',
    vendor_name VARCHAR(150) NOT NULL COMMENT 'Nama vendor atau supplier',
    contact_person VARCHAR(100) COMMENT 'Nama narahubung vendor',
    phone_number VARCHAR(20) COMMENT 'Nomor kontak vendor',
    address TEXT COMMENT 'Alamat operasional vendor',
    is_active BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'Status kerjasama vendor',
    CONSTRAINT fk_vendors_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Data supplier atau vendor yang memasok bahan baku atau layanan.';

-- ============================================
-- Tabel: employees
-- Deskripsi: Informasi detail mengenai karyawan (termasuk jabatan dan skema gaji).
-- ============================================
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang penugasan karyawan',
    user_id INT UNIQUE COMMENT 'ID akun pengguna login jika diberikan',
    full_name VARCHAR(150) NOT NULL COMMENT 'Nama lengkap karyawan',
    position VARCHAR(100) NOT NULL COMMENT 'Jabatan struktural karyawan',
    salary_schema ENUM('Tetap', 'Persentase') NOT NULL DEFAULT 'Persentase' COMMENT 'Skema dasar penentuan gaji karyawan',
    base_salary DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Nilai dasar gaji bulanan jika skema Tetap',
    join_date DATE NOT NULL COMMENT 'Tanggal masuk kerja (Mulai karyawan)',
    CONSTRAINT fk_employees_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_employees_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Informasi detail mengenai karyawan (termasuk jabatan dan skema gaji).';

-- ============================================
-- Tabel: products_services
-- Deskripsi: Menyimpan semua jenis produk, barang ritel (ATK), dan layanan.
-- ============================================
CREATE TABLE products_services (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang kepemilikan',
    service_type ENUM('Percetakan', 'ATK', 'PPOB', 'Jasa Keuangan', 'Jasa Teknis') NOT NULL COMMENT 'Kategori layanan/produk',
    name VARCHAR(150) NOT NULL COMMENT 'Nama produk/jasa',
    base_price DECIMAL(15,4) NOT NULL COMMENT 'Harga dasar retail produk/jasa',
    stock_quantity DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Saldo stok untuk tipe ATK (0 untuk Jasa)',
    unit_of_measure VARCHAR(20) COMMENT 'Satuan ukur (pcs, lbr, dll)',
    is_active BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'Apakah produk/layanan tersedia',
    CONSTRAINT fk_products_services_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Menyimpan semua jenis produk, barang ritel (ATK), dan layanan.';

-- ============================================
-- Tabel: materials
-- Deskripsi: Data inventaris bahan baku produksi beserta satuannya.
-- ============================================
CREATE TABLE materials (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang penyimpanan bahan baku',
    vendor_id INT COMMENT 'ID vendor penyedia bahan ini',
    material_name VARCHAR(150) NOT NULL COMMENT 'Nama bahan baku (kertas, tinta, gagang, dll)',
    stock_quantity DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Kuantitas sisa stok secara presisi',
    unit_of_measure VARCHAR(20) NOT NULL COMMENT 'Satuan ukur presisi tinggi (rim, cm2, ml, dll)',
    cost_per_unit DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Harga modal per satuan ukur untuk kalkulasi HPP',
    min_stock_alert DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Batas kuantitas pemunculan peringatan stok',
    CONSTRAINT fk_materials_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_materials_vendor FOREIGN KEY (vendor_id) REFERENCES vendors(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Data inventaris bahan baku produksi beserta satuannya.';

-- ============================================
-- Tabel: ppob_accounts
-- Deskripsi: Master data akun digital dan bank PPOB.
-- ============================================
CREATE TABLE ppob_accounts (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang pengelola',
    platform_name ENUM('Mandiri', 'Dana', 'Gopay', 'OVO', 'LinkAja', 'ShopeePay') NOT NULL COMMENT 'Platform yang menaungi akun digital ini',
    account_number VARCHAR(50) NOT NULL COMMENT 'Nomor identitas / rekening / ponsel akun',
    current_balance DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Saldo aktual di dalam akun',
    min_balance DECIMAL(15,4) NOT NULL DEFAULT 150000.0000 COMMENT 'Batas saldo minimum (aturan Rp 150.000)',
    deposit_recommend DECIMAL(15,4) NOT NULL DEFAULT 500000.0000 COMMENT 'Nilai anjuran deposit saat saldo mencapai limit',
    CONSTRAINT fk_ppob_accounts_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Master data akun digital dan bank PPOB.';

-- ============================================
-- Tabel: assets
-- Deskripsi: Data aset operasional (printer, mesin cetak, dll).
-- ============================================
CREATE TABLE assets (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang penempatan aset',
    asset_name VARCHAR(150) NOT NULL COMMENT 'Nama barang / mesin aset',
    purchase_date DATE NOT NULL COMMENT 'Tanggal aset dibeli',
    purchase_price DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Harga perolehan aset',
    condition_status ENUM('Normal', 'Rusak', 'Perbaikan') DEFAULT 'Normal' COMMENT 'Status mesin (Normal, Rusak, Perbaikan)',
    CONSTRAINT fk_assets_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Data aset operasional (printer, mesin cetak, dll).';

-- ============================================
-- Tabel: transactions
-- Deskripsi: Data utama dari seluruh layanan kasir lintas tipe.
-- ============================================
CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang pelaksanaan transaksi',
    user_id INT NOT NULL COMMENT 'ID pengguna kasir yang bertugas',
    customer_id INT NOT NULL COMMENT 'ID pelanggan yang melakukan transaksi',
    transaction_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu transaksi di-input',
    total_amount DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Total tagihan nilai transaksi (setelah harga khusus)',
    total_hpp DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Total HPP (Cost of Goods Sold) transaksi ini',
    payment_status ENUM('Belum Bayar', 'DP', 'Lunas', 'Refund', 'Dibatalkan') NOT NULL DEFAULT 'Belum Bayar' COMMENT 'Status penyelesaian pembayaran transaksi',
    CONSTRAINT fk_transactions_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_transactions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_transactions_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Data utama dari seluruh layanan kasir lintas tipe.';

-- ============================================
-- Tabel: transaction_items
-- Deskripsi: Baris detail (keranjang) dari transaksi induk.
-- ============================================
CREATE TABLE transaction_items (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    transaction_id INT NOT NULL COMMENT 'ID induk dari tabel transactions',
    product_id INT NOT NULL COMMENT 'ID produk/layanan yang dibeli',
    quantity DECIMAL(15,4) NOT NULL DEFAULT 1.0000 COMMENT 'Kuantitas (mendukung desimal jika berupa ukuran)',
    unit_price DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Harga jual per kuantitas (disesuaikan dengan tier)',
    subtotal DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Total tagihan baris ini',
    item_hpp DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Total HPP khusus baris keranjang ini berdasarkan BOM',
    CONSTRAINT fk_transaction_items_transaction FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_transaction_items_product FOREIGN KEY (product_id) REFERENCES products_services(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Baris detail (keranjang) dari transaksi induk.';

-- ============================================
-- Tabel: payments
-- Deskripsi: Histori pembayaran transaksi (pelunasan / penerimaan DP).
-- ============================================
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    transaction_id INT NOT NULL COMMENT 'ID transaksi yang dilunasi/di-DP',
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu uang diterima',
    amount_paid DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Besaran uang nominal pembayaran',
    payment_type ENUM('DP', 'Lunas', 'Refund') NOT NULL COMMENT 'Status termin pembayaran yang diinput',
    CONSTRAINT fk_payments_transaction FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Histori pembayaran transaksi (pelunasan / penerimaan DP).';

-- ============================================
-- Tabel: orders_job_tracking
-- Deskripsi: Informasi spesifik untuk tracking tahapan produksi cetak.
-- ============================================
CREATE TABLE orders_job_tracking (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    transaction_id INT NOT NULL UNIQUE COMMENT 'ID transaksi induk yang terhubung ke job ini',
    status ENUM('Antri', 'Proses Desain', 'Produksi', 'Selesai', 'Diambil', 'Dibatalkan') NOT NULL DEFAULT 'Antri' COMMENT 'Status posisi pesanan percetakan di operasional',
    design_file_path VARCHAR(255) COMMENT 'Path/URL direktori fisik/logis menyimpan file desain',
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Kapan status ini diperbarui terakhir kali',
    CONSTRAINT fk_orders_job_tracking_transaction FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Informasi spesifik untuk tracking tahapan produksi cetak.';

-- ============================================
-- Tabel: production_waste
-- Deskripsi: Tabel pelaporan/pencatatan limbah dan bahan baku produksi cacat.
-- ============================================
CREATE TABLE production_waste (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang',
    material_id INT NOT NULL COMMENT 'ID bahan baku / material referensi',
    waste_quantity DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Kuantitas bahan terbuang/rusak dalam presisi desimal',
    waste_reason TEXT NOT NULL COMMENT 'Deskripsi penyebab kerusakan (salah desain, salah ukuran, dll)',
    recorded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu kerusakan tercatat',
    CONSTRAINT fk_production_waste_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_production_waste_material FOREIGN KEY (material_id) REFERENCES materials(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Tabel pelaporan/pencatatan limbah dan bahan baku produksi cacat.';

-- ============================================
-- Tabel: ppob_mutations
-- Deskripsi: Pencatatan mutasi penambahan/pengurangan pada rekening digital.
-- ============================================
CREATE TABLE ppob_mutations (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    ppob_account_id INT NOT NULL COMMENT 'ID akun PPOB bersangkutan',
    transaction_id INT COMMENT 'ID referensi ke modul transaksi (opsional jika mutasi mandiri)',
    mutation_type ENUM('Kredit', 'Debit') NOT NULL COMMENT 'Penambahan (Kredit) atau pengurangan (Debit)',
    amount DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Nilai mutasi pergerakan kas',
    mutation_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu mutasi terjadi',
    description TEXT COMMENT 'Catatan peruntukan mutasi (transfer ke A, dsb)',
    CONSTRAINT fk_ppob_mutations_account FOREIGN KEY (ppob_account_id) REFERENCES ppob_accounts(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ppob_mutations_transaction FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Pencatatan mutasi penambahan/pengurangan pada rekening digital.';

-- ============================================
-- Tabel: employee_attendance
-- Deskripsi: Riwayat kehadiran karyawan per hari.
-- Catatan Implementasi: Skema gaji persentase menggunakan bagi hasil 15% dari pendapatan bersih jika target bulanan tidak tercapai, sesuai BR-03.
-- ============================================
CREATE TABLE employee_attendance (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    employee_id INT NOT NULL COMMENT 'ID karyawan terkait',
    check_in_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Jam kedatangan',
    check_out_time DATETIME COMMENT 'Jam kepulangan',
    work_date DATE NOT NULL DEFAULT (CURRENT_DATE) COMMENT 'Tanggal hari kerja terkait absensi ini',
    CONSTRAINT fk_employee_attendance_employee FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Riwayat kehadiran karyawan per hari.';

-- ============================================
-- Tabel: employee_loans
-- Deskripsi: Data hutang/kasbon internal karyawan ke perusahaan.
-- Catatan Implementasi: Skema gaji persentase menggunakan bagi hasil 15% dari pendapatan bersih jika target bulanan tidak tercapai, sesuai BR-03.
-- ============================================
CREATE TABLE employee_loans (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    employee_id INT NOT NULL COMMENT 'ID peminjam / karyawan terkait',
    loan_amount DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Nominal uang dihutang (kasbon)',
    remaining_amount DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Sisa nominal kasbon yang belum dipotong gaji',
    loan_date DATE NOT NULL DEFAULT (CURRENT_DATE) COMMENT 'Tanggal pengambilan pinjaman',
    CONSTRAINT fk_employee_loans_employee FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Data hutang/kasbon internal karyawan ke perusahaan.';

-- ============================================
-- Tabel: payroll
-- Deskripsi: Penerbitan rekapitulasi gaji karyawan (Slip Gaji Digital).
-- Catatan Implementasi: Skema gaji persentase menggunakan bagi hasil 15% dari pendapatan bersih jika target bulanan tidak tercapai, sesuai BR-03.
-- ============================================
CREATE TABLE payroll (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    employee_id INT NOT NULL COMMENT 'ID karyawan penerima gaji',
    period_month VARCHAR(7) NOT NULL COMMENT 'Periode gaji, contoh format YYYY-MM',
    base_payment DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Gaji dasar / gaji komisi persentase pendapatan perusahaan',
    incentive_bonus DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Total uang ekuivalen dari poin insentif bulanan',
    loan_deduction DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Total potongan kasbon hutang aktif karyawan pada bulan tsb',
    net_salary DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Uang bersih yang diserahkan/dibayarkan',
    processed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Tanggal waktu validasi dan penerbitan slip',
    CONSTRAINT fk_payroll_employee FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Penerbitan rekapitulasi gaji karyawan (Slip Gaji Digital).';

-- ============================================
-- Tabel: cash_reconciliation
-- Deskripsi: Hasil laporan validasi jumlah fisik laci dibandingkan riwayat transaksi.
-- ============================================
CREATE TABLE cash_reconciliation (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID unit cabang pelaksana rekonsiliasi',
    user_id INT NOT NULL COMMENT 'Karyawan/User yang melaporkan',
    system_balance DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Kalkulasi saldo laci berdasarkan rekam transaksi database',
    physical_balance DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Kalkulasi lembaran uang tunai aktual laci fisik kasir',
    difference DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Nilai selisih (physical - system)',
    reconciled_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Tanggal dan jam eksekusi penutupan shift/rekonsiliasi',
    CONSTRAINT fk_cash_reconciliation_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_cash_reconciliation_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Hasil laporan validasi jumlah fisik laci dibandingkan riwayat transaksi.';

-- ============================================
-- Tabel: stock_opname
-- Deskripsi: Pencatatan penyesuaian/kecocokan data gudang.
-- ============================================
CREATE TABLE stock_opname (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang pelaksana opname',
    material_id INT NOT NULL COMMENT 'ID bahan baku/barang di audit',
    system_qty DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Catatan persediaan material di sistem',
    actual_qty DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Angka persediaan material temuan nyata',
    difference_qty DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Ketidaksesuaian/Selisih presisi tinggi',
    recorded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Jam opname inventaris selesai',
    CONSTRAINT fk_stock_opname_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_stock_opname_material FOREIGN KEY (material_id) REFERENCES materials(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Pencatatan penyesuaian/kecocokan data gudang.';

-- ============================================
-- Tabel: bom
-- Deskripsi: Menyimpan resep / rumus komposisi material sebuah layanan pesanan (HPP Presisi).
-- ============================================
CREATE TABLE bom (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    product_id INT NOT NULL COMMENT 'ID produk utama/hasil cetakan',
    material_id INT NOT NULL COMMENT 'ID referensi bahan penyusun / material dasar',
    required_qty DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Jumlah nilai presisi yang ditarik dari material stok per-1 satuan cetak produk',
    CONSTRAINT fk_bom_product FOREIGN KEY (product_id) REFERENCES products_services(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_bom_material FOREIGN KEY (material_id) REFERENCES materials(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Menyimpan resep / rumus komposisi material sebuah layanan pesanan.';

-- ============================================
-- Tabel: incentive_points
-- Deskripsi: Catatan koleksi dan log akumulasi poin bonus kerja karyawan atas pekerjaan/job.
-- Catatan Implementasi: Poin dikonversi ke nominal uang (misal 1 Poin = Rp 500) pada saat rekapitulasi payroll di akhir bulan.
-- Catatan Implementasi: Skema gaji persentase menggunakan bagi hasil 15% dari pendapatan bersih jika target bulanan tidak tercapai, sesuai BR-03.
-- ============================================
CREATE TABLE incentive_points (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    employee_id INT NOT NULL COMMENT 'ID penerima komisi poin',
    transaction_id INT COMMENT 'ID transaksinya sebagai pelacakan referensi asal muasal poin',
    point_category ENUM('Rutin', 'Dasar', 'Kustom', 'Teknis Berat') NOT NULL COMMENT 'Tingkat kesulitan/bobot poin transaksi',
    earned_points INT NOT NULL DEFAULT 0 COMMENT 'Besar poin utuh yang didapatkan',
    earned_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Kapan pekerjaan ini diselesaikan',
    CONSTRAINT fk_incentive_points_employee FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_incentive_points_transaction FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Catatan koleksi dan log akumulasi poin bonus kerja karyawan atas pekerjaan/job.';

-- ============================================
-- Tabel: login_sessions
-- Deskripsi: Data persisten untuk token sesi pengguna aktif.
-- ============================================
CREATE TABLE login_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    user_id INT NOT NULL COMMENT 'ID pemegang hak sesi login',
    jwt_token VARCHAR(512) NOT NULL UNIQUE COMMENT 'String panjang token penanda keaktifan validitas akses',
    expires_at DATETIME NOT NULL COMMENT 'Ambang batas kadaluarsa token/sesi 8 jam',
    CONSTRAINT fk_login_sessions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Data persisten untuk token sesi pengguna aktif.';

-- ============================================
-- Tabel: routine_expenses
-- Deskripsi: Pengeluaran umum bisnis di luar operasional bahan baku.
-- ============================================
CREATE TABLE routine_expenses (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang',
    expense_name VARCHAR(150) NOT NULL COMMENT 'Kategori nama keperluan anggaran biaya operasional (listrik, wifi, dll)',
    amount DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Besaran nominal angka dicairkan',
    expense_date DATE NOT NULL DEFAULT (CURRENT_DATE) COMMENT 'Tanggal realisasi kebutuhan',
    CONSTRAINT fk_routine_expenses_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Pengeluaran umum bisnis di luar operasional bahan baku.';

-- ============================================
-- Tabel: loans
-- Deskripsi: Rekap modal eksternal perusahaan dan perputaran pinjaman operasional.
-- Catatan Khusus: Tabel sensitif ini hanya boleh diakses oleh role Pemilik dan disembunyikan dari Karyawan sesuai aturan keamanan (BR-10).
-- ============================================
CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID cabang bisnis bersangkutan',
    loan_source VARCHAR(150) NOT NULL COMMENT 'Pihak yang mengutangi (Teman/Orang Tua/Bank)',
    loan_type ENUM('Tanpa Bunga', 'Berbunga') NOT NULL COMMENT 'Sifat kewajiban utang piutang modal',
    principal_amount DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Besar nominal modal diinjeksi atau nilai total kredit',
    remaining_debt DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Nominal tagihan atau sisa pengembalian hutang usaha',
    CONSTRAINT fk_loans_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Rekap modal eksternal perusahaan dan perputaran pinjaman operasional.';

-- ============================================
-- Tabel: audit_trail
-- Deskripsi: Fitur tracking riwayat histori aktivitas yang berpotensi fraud / rekayasa.
-- ============================================
-- Catatan Khusus: Tabel ini TIDAK boleh memiliki operasi DELETE dari level aplikasi.
-- Data audit trail bersifat append-only (INSERT only).
-- ============================================
CREATE TABLE audit_trail (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    user_id INT NOT NULL COMMENT 'Identitas subyek/pelaku yang memicu perubahan',
    action_type ENUM('INSERT', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT') NOT NULL COMMENT 'Sifat/kategori modifikasi aksi di sistem',
    target_entity VARCHAR(50) NOT NULL COMMENT 'Objek tabel yang terkena dampaknya',
    change_detail TEXT NOT NULL COMMENT 'Narasi rincian komprehensif atas kejadian mutasi nilai spesifik',
    timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Jejak rekam waktu peristiwa manipulasi terjadi',
    CONSTRAINT fk_audit_trail_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Fitur tracking riwayat histori aktivitas yang berpotensi fraud / rekayasa.';

-- ============================================
-- Tabel: asset_savings
-- Deskripsi: Tabungan kas khusus pengadaan alat baru pemilik (diakses khusus role Pemilik).
-- Catatan Implementasi: Sesuai BR-10, data dari tabel ini secara eksplisit disembunyikan dari akses role Karyawan. Tabel sensitif ini hanya boleh diakses oleh role Pemilik.
-- ============================================
CREATE TABLE asset_savings (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID unik auto-increment sebagai primary key tabel ini',
    branch_id INT NOT NULL COMMENT 'ID referensi cabang',
    account_name VARCHAR(150) NOT NULL COMMENT 'Nama rekening / tempat tabungan',
    balance DECIMAL(15,4) NOT NULL DEFAULT 0.0000 COMMENT 'Saldo aktual tabungan aset',
    last_updated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Jejak rekam waktu peristiwa penambahan/penarikan',
    CONSTRAINT fk_asset_savings_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Tabungan kas khusus pengadaan alat baru pemilik.';


-- =================================================================================
-- INDEKS TAMBAHAN UNTUK PERFORMA QUERY
-- =================================================================================
CREATE INDEX idx_transactions_transaction_date ON transactions(transaction_date);
CREATE INDEX idx_transactions_payment_status ON transactions(payment_status);
CREATE INDEX idx_employee_attendance_work_date ON employee_attendance(work_date);
CREATE INDEX idx_payroll_period_month ON payroll(period_month);
CREATE INDEX idx_audit_trail_timestamp ON audit_trail(timestamp);
CREATE INDEX idx_orders_job_tracking_status ON orders_job_tracking(status);

-- =================================================================================
-- STATEMENT PENUTUP
-- =================================================================================
SET FOREIGN_KEY_CHECKS = 1;

-- =================================================================================
-- REFERENSI DOKUMEN:
-- 1. docs/sdlc/02_analysis/05_data_dictionary.md (Referensi Utama #1)
-- 2. docs/sdlc/02_analysis/06_access_control_matrix.md (Referensi Utama #2)
-- 3. docs/sdlc/02_analysis/01_business_requirements.md (Referensi Pendukung)
-- 4. docs/sdlc/02_analysis/02_software_requirements.md (Referensi Pendukung)
-- 5. docs/sdlc/01_planning/04_tech_stack_decision.md (Referensi Pendukung)
-- 6. docs/sdlc/narasi.txt (Referensi Konteks)
-- =================================================================================
