<?php

try{
$connection = new PDO('mysql:host=localhost;dbname=id15221483_view', 'id15221483_manager', '3wFUJB2PP<@s#$B[');
$connection ->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
echo("Yes");

}catch(PDOException $exc) {
echo $exc->getMessage();
die("could not connect");
}

?>

