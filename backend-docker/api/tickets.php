<?php
header("Content-Type: application/json; charset=UTF-8");
require_once __DIR__ . '/../config/database.php';

$method = $_SERVER['REQUEST_METHOD'];
$data = json_decode(file_get_contents("php://input"), true);

try {
    if ($method === 'GET') {
        $stmt = $pdo->query("SELECT * FROM tickets ORDER BY id DESC");
        echo json_encode([
            "status" => "success",
            "data" => $stmt->fetchAll()
        ]);
    } elseif ($method === 'POST') {
        $title = trim($data['title'] ?? $_POST['title'] ?? '');
        $price = trim($data['price'] ?? $_POST['price'] ?? '');
        $event_date = trim($data['event_date'] ?? $_POST['event_date'] ?? '');

        if (empty($title) || empty($price) || empty($event_date)) {
            http_response_code(400);
            echo json_encode(["status" => "error", "message" => "Title, price, dan event_date wajib diisi"]);
            exit();
        }

        $stmt = $pdo->prepare("INSERT INTO tickets (title, price, event_date) VALUES (?, ?, ?)");
        $stmt->execute([$title, $price, $event_date]);

        http_response_code(201);
        echo json_encode([
            "status" => "success",
            "message" => "Tiket berhasil ditambahkan",
            "id" => (int)$pdo->lastInsertId()
        ]);
    } elseif ($method === 'PUT') {
        $id = $data['id'] ?? $_GET['id'] ?? null;
        $title = trim($data['title'] ?? '');
        $price = trim($data['price'] ?? '');
        $event_date = trim($data['event_date'] ?? '');

        if (!$id || empty($title) || empty($price) || empty($event_date)) {
            http_response_code(400);
            echo json_encode(["status" => "error", "message" => "ID, title, price, dan event_date wajib diisi"]);
            exit();
        }

        $stmt = $pdo->prepare("UPDATE tickets SET title = ?, price = ?, event_date = ? WHERE id = ?");
        $stmt->execute([$title, $price, $event_date, $id]);

        echo json_encode(["status" => "success", "message" => "Tiket berhasil diperbarui"]);
    } elseif ($method === 'DELETE') {
        $id = $data['id'] ?? $_GET['id'] ?? null;
        if (!$id) {
            http_response_code(400);
            echo json_encode(["status" => "error", "message" => "ID tiket wajib disertakan"]);
            exit();
        }

        $stmt = $pdo->prepare("DELETE FROM tickets WHERE id = ?");
        $stmt->execute([$id]);

        echo json_encode(["status" => "success", "message" => "Tiket berhasil dihapus"]);
    } else {
        http_response_code(405);
        echo json_encode(["status" => "error", "message" => "Metode tidak didukung"]);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
