<?php

    session_start();

    include 'dbconnect.php';

    $session = $_SESSION['username'];
    $childFname = $_POST['childFname'];
    $childSname = $_POST['childSname'];
    $childSurname = $_POST['childSurname'];
    $childDOB = $_POST['childDOB'];
    $childGender = $_POST['childGender'];
    $guardianFname = $_POST['guardianFname'];
    $guardianSurname = $_POST['guardianSurname'];

    if(isset($session)) {
        try {
            mysqli_begin_transaction($con);
            mysqli_query($con, "INSERT INTO personal_info(first_name, second_name, surname, dob, gender, guardian_first_name, guardian_surname, "
                    . "date_recieved, time_recieved) VALUES('$childFname', '$childSname', '$childSurname', '$childDOB', '$childGender', "
                    . "'$guardianFname', '$guardianSurname', curdate(), curtime())");
            mysqli_query($con, "INSERT INTO patient_visit_log(child_id, visit_date, visit_time, purpose) VALUES((SELECT child_id FROM personal_info "
                    . "ORDER BY child_id DESC LIMIT 1), curdate(), curtime(), 'new')");
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
