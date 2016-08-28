<?php

session_start();

include 'dbconnect.php';

$info = array();

if (isset($_SESSION["username"])) {
    try {
        $sql = mysqli_query($con, "SELECT * FROM staff_info WHERE username = '".$_SESSION["username"]."'");
        mysqli_data_seek($sql, 0);
        $row = mysqli_fetch_assoc($sql);
        $surname = $row['surname'];
        switch ($row['role']) {
            case "nurse":
                $info['name'] = 'Ms. ' . $surname;
                $info['role'] = 'nurse';
                break;
            case "doctor":
                $info['name'] = 'Dr. ' . $surname;
                $info['role'] = 'doctor';
                break;
            case "lab":
                if ($row['gender'] == "Male") {
                    $info['name'] = 'Mr. ' . $surname;
                } else {
                    $info['name'] = 'Ms. ' . $surname;
                }
                $info['role'] = 'lab';
                break;
            case "receptionist":
                $info['name'] = 'Ms. ' . $surname;
                $info['role'] = 'receptionist';
                break;
            case "chemist":
                $info['name'] = 'Mr. ' . $surname;
                $info['role'] = 'chemist';
                break;
            case "admin":
                if ($row['gender'] == "Male") {
                    $info['name'] = 'Mr. ' . $surname . ' - Admin';
                } else {
                    $info['name'] = 'Ms. ' . $surname . ' - Admin';
                }
                $info['role'] = 'admin';
                break;
        }
        echo json_encode($info);
    } catch (Exception $ex) {
        echo 3;
    }
} else {
    echo 7;
}

include 'closeDBConnection.php';
