<?php

    session_start();
    
    include 'dbconnect.php';
    
//    if (isset($_SESSION['username'])) {
        $data = array();
        $time = array();
        try {
            $sql = mysqli_query($con, "SELECT * FROM staff_info WHERE role != 'admin'");
            $counter = 0;
            while($row = mysqli_fetch_assoc($sql)) {
                $username = $row['username'];
                $sqlAttendance = mysqli_query($con, "SELECT date, DAYNAME(date) AS day, time FROM login_log WHERE username = '$username'");
                $data['staff'][] = $row;
                while($attendance = mysqli_fetch_assoc($sqlAttendance)) {
                    $data['staff'][$counter]['attendance'][] = $attendance;
                }
                $counter++;
            }
            $sqlYearFetch = mysqli_query($con, "SELECT DISTINCT(YEAR(visit_date)) AS year FROM patient_visit_log");
            while($row = mysqli_fetch_assoc($sqlYearFetch)) {
                $time[] = $row['year'];
                $current = $row['year'];
                $sqlCountYearly = mysqli_query($con, "SELECT COUNT(id) AS count FROM patient_visit_log WHERE YEAR(visit_date) = $current");
                $count = mysqli_fetch_assoc($sqlCountYearly);
                $data['performance']['yearly'][$current] = $count['count'];
            }
            $time = array_flip($time);
            foreach ($time as $years => $year) {
                $sqlGetMonths = mysqli_query($con, "SELECT DISTINCT(MONTHNAME(visit_date)) AS month FROM patient_visit_log WHERE YEAR(visit_date) = $years");
                $time[$years] = array();
                while($row = mysqli_fetch_assoc($sqlGetMonths)) {
                    $current = $row['month'];
                    $sqlGetDays = mysqli_query($con, "SELECT DISTINCT(DAY(visit_date)) AS day FROM patient_visit_log WHERE YEAR(visit_date) = $years AND "
                            . "MONTHNAME(visit_date) = '$current'");
                    while($row2 = mysqli_fetch_assoc($sqlGetDays)){
                        $time[$years]['months'][$current][] = $row2['day'];
                    }
                    $sqlCountMonthly = mysqli_query($con, "SELECT COUNT(id) AS count FROM patient_visit_log WHERE YEAR(visit_date) = $years AND "
                            . "MONTHNAME(visit_date) = '$current'");
                    while($row2 = mysqli_fetch_assoc($sqlCountMonthly)) {
                        $data['performance']['monthly'][$years][] = array_combine($row, $row2);
                    }
                }
                $sqlGetWeeks = mysqli_query($con, "SELECT DISTINCT(WEEK(visit_date)) as week FROM patient_visit_log WHERE YEAR(visit_date) = $years");
                while($row = mysqli_fetch_assoc($sqlGetWeeks)) {
                    $current = $row['week'];
                    $time[$years]['weeks'][] = $current;
                    $sqlCountWeekly = mysqli_query($con, "SELECT COUNT(id) AS count FROM patient_visit_log WHERE YEAR(visit_date) = $years AND "
                                . "WEEK(visit_date) = $current");
                    while($row2 = mysqli_fetch_assoc($sqlCountWeekly)) {
                        $data['performance']['weekly'][$years][] = array_combine($row, $row2);
                    }
                }
                foreach ($time['2016']['months'] as $month => $date) {
                    foreach ($date as $dts) {
                        $sqlCountDaily = mysqli_query($con, "SELECT COUNT(id) as count FROM patient_visit_log WHERE YEAR(visit_date) = $years AND "
                                . "MONTHNAME(visit_date) = '$month' AND DAY(visit_date) = $dts") or die(mysqli_error($con));
                        while($row = mysqli_fetch_assoc($sqlCountDaily)) {
                            $data['performance']['daily'][$years][$month][$dts] = $row['count'];
                        }
                    }
                }
            }
            $sqlGetDiseases = mysqli_query($con, "SELECT DISTINCT(diagnosis) AS disease FROM diagnosis WHERE diagnosis IS NOT NULL");
            while($row = mysqli_fetch_assoc($sqlGetDiseases)) {
                $current = $row['disease'];
                $sqlCountDiseases = mysqli_query($con, "SELECT COUNT(diagnosis_id) AS count FROM diagnosis WHERE diagnosis = '$current'");
                while($row2 = mysqli_fetch_assoc($sqlCountDiseases)) {
                    $data['diseases'][$current] = $row2['count'];
                }
            }
        } catch (Exception $ex) {
            echo 5;
        }
        echo json_encode($data);
//    } else {
//        echo 7;
//    }
    
    include 'closeDBConnection.php';

