# Aplikasi Pemesanan Tiket (Fullstack Flutter & Node.js/MySQL)

Proyek ini dikembangkan untuk memenuhi tugas mata kuliah **Pemrograman Perangkat Bergerak**, Universitas Muhammadiyah Bandung (Kelompok 5).

## Informasi Kelompok (Kelompok 5)

1. **Erlangga Tryandhika Putra** - 240102027
2. **Ghazi Al Ghifari** - 240102035
3. **Isra Muhammad Rifa'ah** - 240102043
4. **Pinas Syahrafaraz Aulia** - 240102097
5. **Rio Ferdiansyah** - 240102116

## Fitur Utama

### 1. Autentikasi Pengguna
Login dan registrasi dengan enkripsi password menggunakan `bcryptjs` serta manajemen sesi pengguna.

### 2. Hak Akses Berbasis Peran (Role-Based Access Control)

#### Admin
- Melihat daftar tiket.
- Menambahkan tiket baru ke dalam sistem.

#### Member
- Melihat daftar tiket yang tersedia.
- Melakukan pemesanan tiket.

### 3. Desain Konsisten dan Responsif
Menggunakan tema warna **Gold (Emas)** yang elegan dengan tata letak terpusat (**Centered Layout**) sehingga nyaman digunakan di smartphone, web, maupun desktop.

### 4. Manajemen Database via Web (phpMyAdmin)
Terintegrasi langsung dengan phpMyAdmin yang berjalan melalui Docker pada port `8080`.

---

## Penjelasan Peran (Role) dan Cara Pembuatan Akun

Sistem basis data dirancang otomatis melalui konfigurasi backend (`backend/src/config/db.js`) dengan kolom `role` bertipe:

```sql
ENUM('admin', 'member')
```

Nilai default yang digunakan adalah:

```text
member
```

### Akun Member

#### Cara Pembuatan
1. Buka aplikasi Flutter.
2. Pilih menu **Register**.
3. Isi nama, email, dan password.
4. Akun akan otomatis dibuat sebagai **member**.

#### Hak Akses
- Melihat daftar tiket.
- Melakukan pemesanan tiket.

### Akun Admin

#### Cara Pembuatan

1. Registrasikan akun terlebih dahulu melalui halaman **Register** pada aplikasi Flutter.
   Contoh:

   ```text
   admin@gmail.com
   ```

2. Buka browser dan akses:

   ```text
   http://localhost:8080
   ```

3. Login menggunakan:

   **Username**

   ```text
   root
   ```

   **Password**

   ```text
   rootpassword123
   ```

4. Pilih database:

   ```text
   flutter_auth_db
   ```

5. Buka tabel:

   ```text
   users
   ```

6. Ubah kolom `role` dari:

   ```text
   member
   ```

   menjadi:

   ```text
   admin
   ```

#### Hak Akses
- Melihat seluruh tiket.
- Menambahkan tiket baru.
- Mendapatkan badge **ADMIN** pada halaman profil.
- Mendapatkan tombol **+ Tambah Tiket** pada dashboard.

### Default Akun Login

#### Admin

Email

```text
admin@gmail.com
```

Password

```text
admin123
```

#### Member

Email

```text
member@gmail.com
```

Password

```text
member123
```

---

# Panduan Instalasi dan Menjalankan Aplikasi

## Tahap 1: Menjalankan Backend dan phpMyAdmin dengan Docker

1. Pastikan **Docker Desktop** sudah terpasang dan berjalan.
2. Buka terminal lalu masuk ke folder backend:

```bash
cd backend
```

3. Jalankan Docker Compose:

```bash
docker-compose up --build
```

Perintah tersebut akan menjalankan:

- API Backend
- MySQL Database
- phpMyAdmin

---

## Tahap 2: Mengelola Database melalui phpMyAdmin

1. Buka browser dan akses:

```text
http://localhost:8080
```

2. Login menggunakan:

**Username**

```text
root
```

**Password**

```text
rootpassword123
```

3. Setelah berhasil login, Anda dapat:

- Melihat tabel `users`.
- Melihat tabel `tickets`.
- Mengubah role pengguna menjadi `admin`.
- Mengelola data langsung melalui antarmuka web.

---

## Tahap 3: Menjalankan Aplikasi Frontend Flutter

1. Buka terminal baru lalu masuk ke folder frontend:

```bash
cd flutter_app
```

2. Install dependency:

```bash
flutter pub get
```

3. Jalankan aplikasi sesuai platform yang digunakan.

### Android Emulator

```bash
flutter run
```

Backend yang digunakan:

```text
http://10.0.2.2:3000/api
```

### Flutter Web / Desktop

```bash
flutter run -d chrome
```

Backend yang digunakan:

```text
http://localhost:3000/api
```

---

## Teknologi yang Digunakan

### Frontend
- Flutter
- Dart

### Backend
- Node.js
- Express.js

### Database
- MySQL

### Tools Pendukung
- Docker
- Docker Compose
- phpMyAdmin
- bcryptjs

---

## Hak Akses Sistem

### Member
- Login
- Registrasi
- Melihat tiket
- Memesan tiket

### Admin
- Login
- Melihat tiket
- Menambah tiket
- Mengelola data tiket

---

## Struktur Role

```text
Admin
├── Lihat Tiket
└── Tambah Tiket

Member
├── Lihat Tiket
└── Pesan Tiket
```
