<?php
require('connection.php');

$mang_id = $_POST['mang_id'];

$makeQuery = "SELECT resr_id, table_id, booked_date_time FROM seating WHERE mang_id = $mang_id AND confirm = 0";
$statement = $connection -> prepare($makeQuery);
$statement -> execute();
$myarray = array();
while($resultsFrom = $statement -> fetch()){
array_push(
$myarray,array(
"resr_id"=>$resultsFrom['resr_id'],
"table_id"=>$resultsFrom['table_id'],
"booked_date_time"=>$resultsFrom['booked_date_time']
)
);
}

echo json_encode($myarray);
?>