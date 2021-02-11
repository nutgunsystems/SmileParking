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
		
		$car_identify = $_GET['car_identify'];
		$car_province = $_GET['car_province'];
		$station_id = $_GET['station_id'];
		$acknowledge_status = '1';
		$issue_datetime = date('Y-m-d H:i:s');
		
							
		$sql = "UPDATE `obstacleTable` SET  `acknowledge_status` = '$acknowledge_status', `acknowledge_datetime` = '$issue_datetime' WHERE  car_identify = '$car_identify' and car_province = '$car_province' and expire_status = '0' and ref_station_id = '$station_id' ";

		//echo "SQL text >> $sql";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome fixed Obstacle Info [PROD].";
   
}

	mysqli_close($link);
?>