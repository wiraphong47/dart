<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// เชื่อมต่อฐานข้อมูล
require 'config.php'; // แก้เป็นไฟล์เชื่อมต่อฐานข้อมูลของคุณ

// คำสั่ง SQL สำหรับดึงข้อมูลทั้งหมดจากตาราง tasks
$sql = "SELECT id, title, description, created_at FROM tasks ORDER BY created_at DESC";
$result = $conn->query($sql);

// ตรวจสอบว่ามีข้อมูลหรือไม่
if ($result->num_rows > 0) {
    $tasks = array();
    
    while ($row = $result->fetch_assoc()) {
        $task = array(
            "id" => $row["id"],
            "title" => $row["title"],
            "description" => $row["description"],
            "created_at" => $row["created_at"]
        );
        array_push($tasks, $task);
    }

    echo json_encode(["success" => true, "tasks" => $tasks]);
} else {
    echo json_encode(["success" => false, "message" => "No tasks found"]);
}

// ปิดการเชื่อมต่อฐานข้อมูล
$conn->close();
?>
