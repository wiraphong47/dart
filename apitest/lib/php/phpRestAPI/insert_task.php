<?php 
    header('Content-Type: application/json'); 
    include "db_connect.php";

    $title = $_POST['title']; 
    $description = $_POST['description']; 

    $sql = "INSERT INTO task (title, description) VALUES ('$title', '$description')"; 
    $result = mysqli_query($conn, $sql); 

    if ($result) 
    { 
        echo json_encode("Success"); 
    } 
    else { 
        echo json_encode("Failed"); 
    } 
?>