<?php

    session_start();

    include 'dbconnect.php';

    $data = array();

    if(isset($_SESSION['username'])) {
        try {
            $sqlFromNurse = mysqli_query($con, "SELECT child_id FROM diagnosis WHERE waiting_status = 'nurse'");
            $sqlFromLab = mysqli_query($con, "SELECT child_id FROM diagnosis WHERE waiting_status = 'lab'");
            while ($row = mysqli_fetch_assoc($sqlFromNurse)) {
                $id = $row['child_id'];
                $sqlInner = mysqli_query($con, "SELECT first_name, second_name, surname, temperature, blood_pressure, height, weight FROM "
                        . "personal_info, clinic_info WHERE personal_info.child_id = $id AND clinic_info.child_id = $id ORDER BY clinic_info.id DESC LIMIT 1");
                $sqlHistory = mysqli_query($con, "SELECT diagnosis, description, date FROM diagnosis WHERE child_id = $id AND diagnosis IS NOT NULL");
                $historyRows = NULL;
                if(mysqli_num_rows($sqlHistory) == 0) {
                    $historyRows['history'] = [];
                } else {
                    while ($rows = mysqli_fetch_assoc($sqlHistory)) {
                        $historyRows['history'][] = $rows;
                    }
                }
                while ($innerRow = mysqli_fetch_assoc($sqlInner)) {
                    $data['nurse'][] = array_merge($row, array_merge($innerRow, $historyRows));
                }
                
            }
            while ($row = mysqli_fetch_assoc($sqlFromLab)) {
                $id = $row['child_id'];
                $sqlInner = mysqli_query($con, "SELECT first_name, second_name, surname, test_id, results FROM personal_info, lab "
                        . "WHERE personal_info.child_id = $id AND lab.child_id = $id ORDER BY test_id DESC LIMIT 1");
                $sqlHistory = mysqli_query($con, "SELECT diagnosis, description, date FROM diagnosis WHERE child_id = $id AND diagnosis IS NOT NULL");
                $historyRows = NULL;
                if(mysqli_num_rows($sqlHistory) == 0) {
                    $historyRows['history'] = [];
                } else {
                    while ($rows = mysqli_fetch_assoc($sqlHistory)) {
                        $historyRows['history'][] = $rows;
                    }
                }
                while ($innnerRow = mysqli_fetch_assoc($sqlInner)) {
                    $data['lab'][] = array_merge($row, array_merge($innnerRow, $historyRows));
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
