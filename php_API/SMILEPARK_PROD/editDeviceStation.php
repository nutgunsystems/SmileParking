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
			
		$id = $_GET['id'];		
		//$device_token = $_GET['device_token'];	
		$station_id = $_GET['station_id'];		
		$mod_datetime = date('Y-m-d H:i:s');
		
		
							
		$sql = "UPDATE `stationTable` SET  `ref_station_id` = '$station_id' ,  `mod_date` = '$mod_datetime'  WHERE id = '$id'";

		//echo "SQL text >> $sql";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome edit device station Info [PROD].";
   
}

	mysqli_close($link);
?>