<?php
require(connection.php);

$makeQuery = "SELECT * FROM  manager";
$statement = $connection -> prepare($makeQuery);
$statement -> execute();
$myarray = array();
while($resultsFrom = $statement -> fetch()){
array_push(
$myarray,array(
"id"=resultsFrom['mang_id'];
"name"=resultsFrom['mang_name'];
)
);
}

echo json_encode($myarray);
?>