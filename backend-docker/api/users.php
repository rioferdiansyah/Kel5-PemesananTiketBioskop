<?php
header("Content-Type: application/json; charset=UTF-8");
require_once __DIR__ . '/../config/database.php';

$method = $_SERVER['REQUEST_METHOD'];

try {
    if ($method === 'GET') {
        $roleFilter = $_GET['role'] ?? null;
        if ($roleFilter && in_array($roleFilter, ['admin', 'member'])) {
            $stmt = $pdo->prepare("SELECT id, name, email, role, created_at FROM users WHERE role = ? ORDER BY id ASC");
            $stmt->execute([$roleFilter]);
        } else {
            $stmt = $pdo->query("SELECT id, name, email, role, created_at FROM users ORDER BY id ASC");
        }
        $users = $stmt->fetchAll();

        echo json_encode([
            "status" => "success",
            "total" => count($users),
            "data" => $users
        ]);
    } elseif ($method === 'DELETE') {
        $id = $_GET['id'] ?? null;
        if (!$id) {
            http_response_code(400);
            echo json_encode(["status" => "error", "message" => "ID user wajib disertakan"]);
            exit();
        }
        $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
        $stmt->execute([$id]);
        echo json_encode(["status" => "success", "message" => "User berhasil dihapus"]);
    } else {
        http_response_code(405);
        echo json_encode(["status" => "error", "message" => "Metode tidak didukung"]);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
