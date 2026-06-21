<?php
$parola = $_GET['password'];
$cod_hash = password_hash($parola, PASSWORD_DEFAULT);
echo "<br> cod hash: $cod_hash";
echo "<br> Acum verific parola... ";
if (password_verify($parola, $cod_hash))
    echo 'OK';
else
    echo '<br>Parola gresita!';
?>
