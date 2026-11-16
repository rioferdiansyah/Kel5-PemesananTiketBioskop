<?php
header("Content-Type: application/json; charset=UTF-8");
require_once __DIR__ . '/config/database.php';

echo json_encode([
    "status" => "success",
    "message" => "Backend PHP REST API terhubung dengan MySQL!",
    "database" => "flutter_auth_db",
    "phpmyadmin_url" => "http://localhost:8080",
    "endpoints" => [
        "POST /api/register.php" => "Registrasi akun baru (member/admin)",
        "POST /api/login.php" => "Login user & cek role (admin/member)",
        "GET|DELETE /api/users.php" => "Pantau & kelola daftar seluruh user & admin",
        "GET|POST|PUT|DELETE /api/tickets.php" => "CRUD data tiket"
    ]
], JSON_PRETTY_PRINT);
?>
