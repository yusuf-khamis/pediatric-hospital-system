<?php

    session_start();

    include 'dbconnect.php';

    $data = array();
    
    if(isset($_SESSION['username'])) {
        try {
            $sql = mysqli_query($con, "SELECT id, child_id FROM patient_visit_log WHERE purpose = 'new'");
            while ($row = mysqli_fetch_assoc($sql)) {
                $id = $row['child_id'];
                $sqlDataFetch = mysqli_query($con, "SELECT first_name, second_name, surname FROM personal_info WHERE child_id = $id");
                while ($innerRow = mysqli_fetch_assoc($sqlDataFetch)) {
                    $data[] = array_merge($row, $innerRow);
                }
            }
            echo json_encode($data);
        } catch (Exception $ex) {
            echo 3;
        }
    } else {
        echo 7;
    }

    include 'closeDBConnection.php';