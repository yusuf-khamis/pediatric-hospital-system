<?php

    session_start();

    include 'dbconnect.php';
    
    $data = array();
    
    if(isset($_SESSION['username'])) {
        try {
            $sqlSelect = mysqli_query($con, "SELECT child_id, visit_time FROM patient_visit_log WHERE visit_date = curdate() AND visit_time >= "
                    . "(SELECT time FROM login_log WHERE username = '".$_SESSION['username']."' AND date = curdate()) ORDER BY visit_time ASC");
            while ($row = mysqli_fetch_assoc($sqlSelect)) {
            $id = $row['child_id'];
                $sqlDataFetch = mysqli_query($con, "SELECT * FROM personal_info WHERE child_id = $id");
                while ($innerRow = mysqli_fetch_assoc($sqlDataFetch)) {
                    $data['new'][] = array_merge($row, $innerRow);
                }
            }
            
            $sql = mysqli_query($con, "SELECT * FROM personal_info");
            while ($row = mysqli_fetch_assoc($sql)) {
                $data['all'][] = $row;
            }
            echo json_encode($data);
        } catch (Exception $ex) {
            echo 3;
        }
    } else {
        echo 7;
    }

    include 'closeDBConnection.php';
