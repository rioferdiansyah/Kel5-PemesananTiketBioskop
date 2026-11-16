<?php
header("Content-Type: application/json; charset=UTF-8");
require_once __DIR__ . '/../config/database.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["status" => "error", "message" => "Gunakan metode POST"]);
    exit();
}

$data = json_decode(file_get_contents("php://input"), true);
$name = trim($data['name'] ?? $_POST['name'] ?? '');
$email = trim($data['email'] ?? $_POST['email'] ?? '');
$password = $data['password'] ?? $_POST['password'] ?? '';
$role = ($data['role'] ?? $_POST['role'] ?? 'member') === 'admin' ? 'admin' : 'member';

if (empty($name) || empty($email) || empty($password)) {
    http_response_code(400);
    echo json_encode(["status" => "error", "message" => "Nama, email, dan password wajib diisi"]);
    exit();
}

try {
    $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
    $stmt->execute([$email]);
    if ($stmt->fetch()) {
        http_response_code(409);
        echo json_encode(["status" => "error", "message" => "Email sudah terdaftar"]);
        exit();
    }

    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
    $insert = $pdo->prepare("INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)");
    $insert->execute([$name, $email, $hashedPassword, $role]);

    http_response_code(201);
    echo json_encode([
        "status" => "success",
        "message" => "Registrasi berhasil",
        "data" => [
            "id" => (int)$pdo->lastInsertId(),
            "name" => $name,
            "email" => $email,
            "role" => $role
        ]
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
