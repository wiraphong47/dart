<?php
    header('Content-Type: application/json');
    include "db_connect.php";

        $id = (int)$_POST['id'];

        $sql = "SELECT * FROM task WHERE id = " . $id;
        $query = mysqli_query($conn, $sql);
        $result = mysqli_fetch_assoc($query);
        $result['id'] = (int)$result['id'];
        
        echo json_encode([$result]);
?>