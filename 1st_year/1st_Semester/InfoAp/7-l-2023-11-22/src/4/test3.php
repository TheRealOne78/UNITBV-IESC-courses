<?php

ini_set('session.cookie_lifetime', 60 * 60 * 24 * 1); // persistenta de o zi
// la inceput pornesc sesiunea
session_start();

$prenume = $_SESSION["prenume"];
$oras = $_SESSION["oras"];

// Am preluat variabilele setate anterior in sesiune si afisez
echo "Prenumele dvs. este: $prenume <br>";
echo "Orasul este: $oras <br>";

?>
