<?php

// Pornirea sesiunii trebuie sa fie la inceputul fisierului (inainte de functii gen echo)
session_start();

echo "<br>Inceput program setare sesiune<br>";

// Setarea variabilelor salvate in sesiune
$_SESSION["prenume"] = "Mihai";
$_SESSION["oras"] = "Sibiu";

echo "<br> variabilele sesiunii au fost setate.";
print_r($_COOKIE); // pot vedea cookie-ul care pastrează SID-ul

?>
