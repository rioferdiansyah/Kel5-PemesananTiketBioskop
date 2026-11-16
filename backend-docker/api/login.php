<?php
header("Content-Type: application/json; charset=UTF-8");
require_once __DIR__ . '/../config/database.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["status" => "error", "message" => "Gunakan metode POST"]);
    exit();
}

$data = json_decode(file_get_contents("php://input"), true);
$email = trim($data['email'] ?? $_POST['email'] ?? '');
$password = $data['password'] ?? $_POST['password'] ?? '';

if (empty($email) || empty($password)) {
    http_response_code(400);
    echo json_encode(["status" => "error", "message" => "Email dan password wajib diisi"]);
    exit();
}

try {
    $stmt = $pdo->prepare("SELECT id, name, email, password, role, created_at FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if (!$user || !password_verify($password, $user['password'])) {
        http_response_code(401);
        echo json_encode(["status" => "error", "message" => "Email atau password salah"]);
        exit();
    }

    unset($user['password']);
    $token = base64_encode(json_encode([
        "id" => $user['id'],
        "email" => $user['email'],
        "role" => $user['role'],
        "exp" => time() + 86400
    ]));

    echo json_encode([
        "status" => "success",
        "message" => "Login berhasil sebagai " . $user['role'],
        "token" => $token,
        "user" => $user
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
