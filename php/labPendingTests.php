<?php

    session_start();

    include 'dbconnect.php';

    $tests = array();
    
    if(isset($_SESSION['username'])) {
        try {
            $sql = mysqli_query($con, "SELECT test_id, child_id, test_type FROM lab WHERE results = 'empty'");
            while ($row = mysqli_fetch_assoc($sql)) {
            $id = $row['child_id'];
            $sqlName = mysqli_query($con, "SELECT first_name, second_name, surname FROM personal_info WHERE child_id = $id");
            while($innerRow = mysqli_fetch_assoc($sqlName)){
                $tests[] = array_merge($row, $innerRow);
            }
        }
        echo json_encode($tests);
        } catch (Exception $ex) {
            echo 3;
        }
    }  else {
        echo 7;
    }

    include 'closeDBConnection.php';