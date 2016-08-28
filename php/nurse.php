<?php

    session_start();

    include 'dbconnect.php';

    $height = $_POST['height'];
    $weight = $_POST['weight'];
    $bp = $_POST['bp'];
    $temp = $_POST['temp'];
    $id = $_POST['id'];
    $logId = $_POST['logId'];

    if(isset($_SESSION['username'])) {
        try {
            mysqli_begin_transaction($con);
            mysqli_query($con, "UPDATE patient_visit_log SET purpose = 'clinic' WHERE id = $logId");
            mysqli_query($con, "INSERT INTO clinic_info (child_id, date, time, temperature, blood_pressure, height, weight) VALUES ($id, curdate(), "
            . "curtime(), $temp, '$bp', $height, $weight)");
            mysqli_query($con, "INSERT INTO diagnosis(child_id, waiting_status) VALUES($id, 'nurse')");
        } catch (Exception $ex) {
            mysqli_rollback($con);
            echo 0;
        } finally {
            mysqli_commit($con);
            echo 0;
        }
    } else {
        echo 7;
    }

    include 'closeDBConnection.php';

