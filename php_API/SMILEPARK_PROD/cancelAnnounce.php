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
		$issue_datetime = date('Y-m-d H:i:s');
		
							
		$sql = "UPDATE `announceTable` SET `cancel_status` = '1', `cancel_datetime` = '$issue_datetime' Where `ref_obstacle_id`= '$obstacle_id';";

		//echo "sql string : $sql";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome cancel Announce function [PROD].";
   
}
	mysqli_close($link);
?>