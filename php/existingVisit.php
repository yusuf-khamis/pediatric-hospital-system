<?php

    session_start();

    include 'dbconnect.php';

    $id = $_POST['id'];
    
    if(isset($_SESSION['username'])) {
        try {
            mysqli_query($con, "INSERT INTO patient_visit_log(child_id, visit_date, visit_time, purpose) VALUES($id, curdate(), curtime(), 'new')");
            echo 0;
        } catch (Exception $ex) {
            echo 4;
        }
    }

    include 'closeDBConnection.php';