<?php

    session_start();
    
    include 'dbconnect.php';

    $data = array();
    
    if(isset($_SESSION['username'])) {
        try {
            $sql = mysqli_query($con, "SELECT diagnosis_id, child_id FROM diagnosis WHERE waiting_status = 'chemist'");
            while($row = mysqli_fetch_assoc($sql)) {
                $id = $row['diagnosis_id'];
                $child_id = $row['child_id'];
                $sqlDetails = mysqli_query($con,"SELECT medication_id, prescription, first_name, second_name, surname FROM chemist, personal_info "
                        . "WHERE personal_info.child_id = $child_id AND chemist.diagnosis_id = $id");
                while($innerRow = mysqli_fetch_assoc($sqlDetails)) {
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