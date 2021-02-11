<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
date_default_timezone_set('Asia/Bangkok');
$link = mysqli_connect('localhost', 'nutgunsy_sa', 'H1ng@1634', "nutgunsy_smilepark");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$obstacle_id = $_GET['obstacle_id'];
		$car_identify = $_GET['car_identify'];
		$car_province = $_GET['car_province'];
		$station_id = $_GET['station_id'];
		$issue_date = date('Y-m-d');


		if ($car_identify != '')  {
			//find by car_identify
			$query =  "SELECT * FROM obstacleTable WHERE car_identify = '$car_identify' and  car_province = '$car_province' and issue_date = '$issue_date' and expire_status = '0' and  acknowledge_status = '0' and ref_station_id = '$station_id' ";
		} elseif ($obstacle_id != '')  {
			//find by obstacle id
			$query =  "SELECT * FROM obstacleTable WHERE id = '$obstacle_id' and issue_date = '$issue_date' and expire_status = '0' and acknowledge_status = '0' and ref_station_id = '$station_id' ";
		}
		
	    //echo "query srtring : $query ";		

		$result = mysqli_query($link, $query);

		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
			$output[]=$row;

			}	// while

			echo json_encode($output);

		} //if

	} else echo "Welcome get New Obstacle function [PROD]";	// if2
   
}	// if1


	mysqli_close($link);
?>