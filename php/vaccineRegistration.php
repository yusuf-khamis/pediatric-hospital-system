<?php

    session_start();

    include 'dbconnect.php';

    $id = $_POST['id'];
    $name = $_POST['name'];
    $purpose = $_POST['purpose'];
    $consumption = $_POST['consumption'];
    $completion = $_POST['completion'];
    $time = null;

    switch (substr($completion, 2)) {
    case 'week':
        $time = "DATE_ADD(curdate(), INTERVAL " . substr($completion, 0, 1) . " WEEK)";
        break;
    case 'month':
        $time = "DATE_ADD(curdate(), INTERVAL " . substr($completion, 0, 1) . " MONTH)";
        break;
    case 'day':
        $time = "DATE_ADD(curdate(), INTERVAL " . substr($completion, 0, 1) . " DAY)";
        break;
    case 'year':
        $time = "DATE_ADD(curdate(), INTERVAL " . substr($completion, 0, 1) . " YEAR)";
        break;
    }

    if(isset($_SESSION['username'])) {
        try {
            mysqli_query($con, "INSERT INTO vaccination(child_id, name, purpose, completion, consumption) VALUES($id, '$name', '$purpose', $time, "
                    . "'$consumption')");
            echo 0;
        } catch (Exception $ex) {
            echo 4;
        }
    }

    include 'closeDBConnection.php';