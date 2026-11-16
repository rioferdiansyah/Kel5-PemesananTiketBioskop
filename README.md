# Full-Stack Flutter + Backend PHP + MySQL + phpMyAdmin (Port 8080)

## 1. Struktur Folder Lengkap
```text
fullstack_flutter_php_project/
├── backend_php/
│   ├── docker-compose.yml       # Orkestrasi MySQL 8.0, phpMyAdmin (8080), & PHP 8.2 (3000)
│   ├── Dockerfile               # Image PHP 8.2 Apache + ekstensi pdo_mysql & mysqli
│   ├── index.php                # Status REST API & daftar endpoint
│   ├── config/
│   │   └── database.php         # Koneksi PDO MySQL + auto-create tabel & seed admin
│   ├── sql/
│   │   └── init.sql             # Inisialisasi database flutter_auth_db
│   └── api/
│       ├── register.php         # POST registrasi user/admin
│       ├── login.php            # POST login & verifikasi password
│       ├── users.php            # GET / DELETE daftar user & admin
│       └── tickets.php          # GET / POST / PUT / DELETE data tiket
│
└── flutter_app/
    ├── pubspec.yaml             # Dependensi http & shared_preferences
    └── lib/
        ├── main.dart            # Entry point & SessionGate (auto-redirect Admin/Member)
        ├── config/
        │   └── api_config.dart  # Konfigurasi baseUrl (Web / Android Emulator 10.0.2.2)
        ├── models/
        │   ├── user_model.dart
        │   └── ticket_model.dart
        ├── services/
        │   ├── auth_service.dart
        │   └── ticket_service.dart
        └── screens/
            ├── auth/
            │   ├── login_screen.dart
            │   └── register_screen.dart
            ├── home/
            │   └── home_screen.dart
            └── admin/
                └── admin_dashboard_screen.dart
```

## 2. Cara Menjalankan Backend & Pantau di phpMyAdmin
1. Masuk ke folder `backend_php/`:
   ```bash
   cd backend_php
   docker-compose up -d --build
   ```
2. Buka **phpMyAdmin** di `http://localhost:8080` (User: `root`, Password: `rootpassword123`).
3. Klik database `flutter_auth_db` -> tabel `users`. Akun bawaan sudah tersedia:
   - **Admin:** `admin@gmail.com` / `admin123`
   - **Member:** `member@gmail.com` / `member123`

## 3. Cara Menjalankan Flutter
1. Salin isi folder `flutter_app/lib/` dan `pubspec.yaml` ke proyek Flutter Anda.
2. Jalankan `flutter pub get` lalu `flutter run`.
>>>>>>> 3cfef23 (update UTS)
