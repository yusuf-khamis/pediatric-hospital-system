<?php

    session_start();

    include 'dbconnect.php';

    $data = $_POST['data'];
    $id = $_POST['id'];
    
    $sqlString = "INSERT INTO vaccine_administration(vaccine_id, date_last_administered, time_last_administered), VALUES ";

    foreach ($data as $vaccine_id) {
        $sqlString .= " ($vaccine_id, curdate(), curtime()),";
    }
    
    if(isset($_SESSION['username'])) {
        try {
            mysqli_begin_transaction($con);
            mysqli_query($con, substr($sqlString, 0, strlen($sqlString)-1));
            mysqli_query($con, "UPDATE patient_visit_log SET purpose = 'vaccine' WHERE id = $id");
        } catch (Exception $ex) {
            mysqli_rollback($con);
            echo 4;
        } finally {
            mysqli_commit($con);
            echo 0;
        }
    } else {
        echo 7;
    }

    include 'closeDBConnection.php';