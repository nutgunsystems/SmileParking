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
		
		$Car_Identify = $_GET['car_identify'];	
		$Car_Province = $_GET['car_province'];		
		$Owner_Name = $_GET['owner_name'];
		$Owner_Contact = $_GET['owner_contact'];
		$url_Image = $_GET['url_image'];
		$device_Token = $_GET['device_token'];
		$identify_Search = $_GET['identify_search'];	
		$Park_Date = date('Y-m-d');
		$Park_Datetime = date('Y-m-d H:i:s');
		
							
		$sql = "INSERT INTO `carTable` (`id`, `car_identify`, `car_province`, `owner_name`, `owner_contact`, `park_date`, `park_datetime`, `url_image`, `expire_status`, `device_id` , `device_token`, `identify_search`) VALUES (NULL, '$Car_Identify', '$Car_Province', '$Owner_Name', '$Owner_Contact', '$Park_Date', '$Park_Datetime', '$url_Image', '0', NULL, '$device_Token', '$identify_Search');";

		//echo "SQL : $sql ";


		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome add car function to SMILEPARK [PROD]";
   
}
	mysqli_close($link);
?>