<?php

    session_start();

    include 'dbconnect.php';

    $username = $_POST['username'];
    $pwd = $_POST['password'];
    $info = array();

    $sql = mysqli_query($con, "SELECT * FROM staff_info WHERE username = '$username'");

    if (mysqli_num_rows($sql) == 0) {
        echo 8;
    } else if ($pwd != mysqli_fetch_row($sql)[7]) {
        echo 9;
    } else {
        try {
            $_SESSION['username'] = $username;
            mysqli_query($con, "INSERT INTO login_log (username, date, time) VALUES ('$username', curdate(), curtime())");
            echo 0;
        } catch (Exception $ex) {
            echo 3;
        }
    }
	
include 'closeDBConnection.php';