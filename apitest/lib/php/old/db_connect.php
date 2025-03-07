<?php
$host = "localhost";
$db_name = "its66040233112";
$username = "its66040233112";
$password = "H5tmJ2K8";

 $conn = new mysqli($host, $username, $password, $db_name);
 if ($conn->connect_error) {
     die("Connection failed: " . $conn->connect_error);
 }
?>
