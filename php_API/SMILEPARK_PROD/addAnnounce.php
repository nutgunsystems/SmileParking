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
		
							
		$sql = "INSERT INTO `announceTable` (`id`, `ref_obstacle_id`,  `announce_datetime`) VALUES (NULL, '$obstacle_id',  '$issue_datetime');";

		//echo "sql string : $sql";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome add Announce function [PROD].";
   
}
	mysqli_close($link);
?>