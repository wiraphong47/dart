<?php 
    header('Content-Type: application/json'); 
    include "db_connect.php";

    $id = (int)$_POST['id']; 
    $title = $_POST['title']; 
    $description = $_POST['description']; 

    $sql = "UPDATE task SET title = ?, description = ? WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssi", $title, $description, $id);
    $query = $stmt->execute();

    if ($query) { 
        echo json_encode("Success"); 
    } else { 
        echo json_encode("Failed"); 
    } 
?>
