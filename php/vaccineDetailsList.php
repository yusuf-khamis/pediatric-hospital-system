<?php

    session_start();
    
    include 'dbconnect.php';

    $id = $_POST['id'];
    $data = array();

    if(isset($_SESSION['username'])) {
        try {
            $sql = mysqli_query($con, "SELECT * FROM vaccination WHERE child_id = $id");
            while($row = mysqli_fetch_assoc($sql)){
                $data[] = $row;
            }
            echo json_encode($data);
        } catch (Exception $ex) {
            echo 3;
        }
    } else {
        echo 7;
    }

    include 'closeDBConnection.php';