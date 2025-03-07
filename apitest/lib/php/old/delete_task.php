<?php
include 'db_connect.php';

$id = $_GET['id'];

$stmt = $conn->prepare("DELETE FROM tasks WHERE id=?");
$stmt->execute([$id]);

echo json_encode(["message" => "Task deleted successfully"]);

if ($result) 
    { 
        echo json_encode("Success"); 
    } 
    else { 
        echo json_encode("Failed"); 
    } 
?>
