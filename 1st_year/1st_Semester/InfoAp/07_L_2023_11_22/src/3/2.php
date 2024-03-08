<?php

echo "<br> Inceput program citire cookie<br>";

if (isset($_COOKIE['nume1'])) {
    $nume1=$_COOKIE['nume1'];
    echo "<br> Valoare setata in cookie: $nume1<br>";
}
else
    echo "<br> cookie expirat";

?>
