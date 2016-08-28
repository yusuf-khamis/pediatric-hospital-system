<?php

    session_start();

    include 'dbconnect.php';

    $purpose = $_POST['submission'];
    $id = $_POST['id'];

    if ($purpose == 'tests') {
        $requested = $_POST['requestedTests'];
        
        try {
            mysqli_begin_transaction($con);
            mysqli_query($con, "INSERT INTO lab(child_id, test_type, results, requested_date, requested_time) VALUES($id, '$requested', 'empty', "
                    . "curdate(), curtime())");
            mysqli_query($con, "UPDATE diagnosis SET waiting_status = 'temp', test_id = (SELECT test_id FROM lab ORDER BY test_id DESC LIMIT 1) "
                . "WHERE waiting_status = 'nurse' AND child_id = $id");
        } catch (Exception $ex) {
            mysqli_rollback($con);
            echo 4;
        } finally {
            mysqli_commit($con);
            echo 0;
        }
    } else if ($purpose == 'diagnosis') {
        $diagnosis = $_POST['diagnosis'];
        $description = $_POST['description'];
        $prescription = $_POST['prescription'];
        $test_id = $_POST['test_id'];
        $sqlDiagnosisString = "";
        $sqlMedicationString = "";

        try {
            if (mysqli_num_rows(mysqli_query($con, "SELECT * FROM diagnosis WHERE child_id = $id AND waiting_status = 'nurse'")) > 0) {
                $sqlDiagnosisString = "UPDATE diagnosis SET date = curdate(), time = curtime(), diagnosis = '$diagnosis', "
                    . "description = '$description', waiting_status = 'chemist' WHERE child_id = $id AND waiting_status = 'nurse'";
                $sqlMedicationString = "INSERT INTO chemist(diagnosis_id, prescription, requested_date, requested_time) VALUES((SELECT diagnosis_id FROM "
                    . " diagnosis WHERE child_id = $id AND waiting_status = 'nurse'), '$prescription', curdate(), curtime())";
            } else if (mysqli_num_rows(mysqli_query($con, "SELECT * FROM diagnosis WHERE child_id = $id AND waiting_status = 'lab'")) > 0) {
                $sqlDiagnosisString = "UPDATE diagnosis SET test_id = $test_id, date = curdate(), time = curtime(), diagnosis = '$diagnosis', "
                    . "description = '$description', waiting_status = 'chemist' WHERE child_id = $id AND waiting_status = 'lab'";
                $sqlMedicationString = "INSERT INTO chemist(diagnosis_id, prescription, requested_date, requested_time) VALUES((SELECT diagnosis_id FROM "
                    . " diagnosis WHERE test_id = $test_id), '$prescription', curdate(), curtime())";
            }
            mysqli_begin_transaction($con);
            mysqli_query($con, $sqlMedicationString);
            mysqli_query($con, $sqlDiagnosisString);
        } catch (Exception $ex) {
            mysqli_rollback($con);
            echo 4;
        } finally {
            mysqli_commit($con);
            echo 0;
        }
    }

    include 'closeDBConnection.php';