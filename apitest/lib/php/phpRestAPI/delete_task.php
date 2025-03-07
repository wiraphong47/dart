<?php
header('Content-Type: application/json');

include "db_connect.php";

$id = (int)$_POST['id'];

$sql = "DELETE FROM task WHERE id = " . $id;
$query= mysqli_query($conn, $sql);

if($query) {
    echo json_encode("Success");
} else {
    echo json_encode("Failed");
}
?>