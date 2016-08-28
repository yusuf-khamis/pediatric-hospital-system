<?php
    
    session_start();
    
    include 'dbconnect.php';

    $results = $_POST['results'];
    $id = $_POST['testId'];
    
    if(isset($_SESSION['username'])) {
        try {
            mysqli_begin_transaction($con);
            mysqli_query($con, "UPDATE lab SET results = '$results', completed_time = curtime(), completed_date = curdate() WHERE test_id = $id");
            mysqli_query($con, "UPDATE diagnosis SET waiting_status = 'lab' WHERE test_id = $id");
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
