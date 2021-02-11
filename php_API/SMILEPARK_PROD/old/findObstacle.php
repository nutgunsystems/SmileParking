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
				
		$station_id = $_GET['station_id'];
		$issue_date = date('Y-m-d');

		// find obstacle by Current Date
		$query =  "SELECT o.*, c.owner_name, c.owner_contact, c.car_identify as ref_car_identify, c.car_province as ref_car_province , c.url_image as ref_car_picture, c.device_token as owner_device_token , ( select count(id) from announceTable as a where a.ref_obstacle_id = o.id ) as total_announce FROM obstacleTable as o left outer join carTable as c ON o.ref_car_id = c.id WHERE o.issue_date = '$issue_date' and  o.acknowledge_status = '0' and o.expire_status = '0' and o.ref_station_id = '$station_id' order by o.issue_datetime DESC LIMIT 20";
		

		//echo "query srtring : $query ";		

		$result = mysqli_query($link, $query);


		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
			$output[]=$row;

			}	// while

			echo json_encode($output);

		} //if

	} else echo "Welcome function find Obstacle [PROD]";	// if2
   
}	// if1


	mysqli_close($link);
?>