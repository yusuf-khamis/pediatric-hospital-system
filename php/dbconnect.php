<?php
    $con = null;
    try {
        $con = mysqli_connect('localhost', 'root', '', 'peadiatric_hospital');
    } catch (Exception $ex) {
        echo 1;
        die();
    }

