CREATE DATABASE IF NOT EXISTS flutter_auth_db;
USE flutter_auth_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'member') NOT NULL DEFAULT 'member',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    price VARCHAR(50) NOT NULL,
    event_date VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Akun Default (Password: password)
-- Catatan: backend PHP juga otomatis melakukan seeding akun 'admin@gmail.com' (pass: admin123) & 'member@gmail.com' (pass: member123)
INSERT INTO users (name, email, password, role) VALUES
('Admin Utama', 'admin@gmail.com', '$2y$10$TKh8H1.PfQx37YgCzwiKb.KjNyWgaHb9cbcoQgdIVFlYg7B77UdFm', 'admin'),
('Member User', 'member@gmail.com', '$2y$10$TKh8H1.PfQx37YgCzwiKb.KjNyWgaHb9cbcoQgdIVFlYg7B77UdFm', 'member')
ON DUPLICATE KEY UPDATE email=email;

INSERT INTO tickets (title, price, event_date) VALUES
('Konser Musik Bandung', 'Rp 150.000', '2026-12-20'),
('Seminar Teknologi Web', 'Rp 50.000', '2026-12-25');
