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
				
		$identify_search = $_GET['identify_search'];
		$car_province = $_GET['car_province'];
		$park_date = date('Y-m-d');

		
		if (($identify_search !== '') and ($car_province === NULL)) {
			$query =  "SELECT * FROM carTable WHERE identify_search = '$identify_search' and park_date = '$park_date' and expire_status = '0'";
			
		} elseif ($identify_search !== '') {
			$query =  "SELECT * FROM carTable WHERE identify_search = '$identify_search' and car_province = '$car_province' and park_date = '$park_date' and expire_status = '0'";
		}

		//echo "query srtring : $query ";		

		$result = mysqli_query($link, $query);


		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
			$output[]=$row;

			}	// while

			echo json_encode($output);

		} //if

	} else echo "Welcome function find Car by identify_search [PROD]";	// if2
   
}	// if1


	mysqli_close($link);
?>