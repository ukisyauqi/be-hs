CREATE TABLE "User" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

CREATE TABLE "KategoriKelas" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(255) NOT NULL,
    deskripsi TEXT
);

CREATE TABLE "Tutor" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    bio TEXT
);

CREATE TABLE "Kelas" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(255) NOT NULL,
    deskripsi TEXT NOT NULL,
    kategori_id INT NOT NULL,
    tutor_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (kategori_id) REFERENCES "KategoriKelas"(id),
    FOREIGN KEY (tutor_id) REFERENCES "Tutor"(id)
);

CREATE TABLE "KelasSaya" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    kelas_id INT NOT NULL,
    enrollment_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "User"(id),
    FOREIGN KEY (kelas_id) REFERENCES "Kelas"(id)
);

CREATE TABLE "ModulKelas" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kelas_id INT NOT NULL,
    judul VARCHAR(255) NOT NULL,
    deskripsi TEXT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (kelas_id) REFERENCES "Kelas"(id)
);

CREATE TABLE "Material" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    modul_id INT NOT NULL,
    tipe ENUM('rangkuman', 'video', 'quiz') NOT NULL,
    konten TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (modul_id) REFERENCES "ModulKelas"(id)
);

CREATE TABLE "Pretest" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kelas_id INT NOT NULL,
    soal TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (kelas_id) REFERENCES "Kelas"(id)
);

CREATE TABLE "Pembayaran" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    jumlah DECIMAL(10, 2) NOT NULL,
    tanggal_pembayaran DATETIME NOT NULL,
    metode ENUM('kartu_kredit', 'transfer_bank', 'e-wallet') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "User"(id)
);

CREATE TABLE "Order" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    kelas_id INT NOT NULL,
    jumlah DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'paid', 'canceled') NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "User"(id),
    FOREIGN KEY (kelas_id) REFERENCES "Kelas"(id)
);

CREATE TABLE "Review" (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kelas_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    komentar TEXT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (kelas_id) REFERENCES "Kelas"(id),
    FOREIGN KEY (user_id) REFERENCES "User"(id)
);
