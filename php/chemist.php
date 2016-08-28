<?php

session_start();

include 'dbconnect.php';

$id = $_POST['id'];
$childId = $_POST['childId'];
$data = array();

if (isset($_SESSION['username'])) {
    try {
        mysqli_begin_transaction($con);
        mysqli_query($con, "UPDATE chemist SET issued_date = curdate(), issued_time = curtime() WHERE medication_id = $id");
        mysqli_query($con, "UPDATE diagnosis SET waiting_status = 'served' WHERE child_id = $childId AND waiting_status = 'chemist'");
    } catch (Exception $ex) {
        mysqli_rollback($con);
        echo 5;
    } finally {
        mysqli_commit($con);
        echo 0;
    }
} else {
    echo 7;
}

include 'closeDBConnection.php';
