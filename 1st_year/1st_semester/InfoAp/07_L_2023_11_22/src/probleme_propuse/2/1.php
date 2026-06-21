<?php
$parola = $_GET['password'];
$cod_hash = password_hash($parola, PASSWORD_DEFAULT);
file_put_contents("password.txt", $cod_hash);

echo "Parola: $parola<br>";
echo "Hash: $cod_hash<br>";

echo "File contents: ".file_get_contents("password.txt");

//if (password_verify($parola, $cod_hash))
//    echo 'OK';
//else
//    echo '<br>Parola gresita!';
?>
