<?php

function impartire($x) {
    if ($x==0) {
        throw new Exception('Impartire la zero');
    }
    return 1/$x;
}
try {
    echo "1/3=".impartire(3) . "<br>";
    echo "1/0=".impartire(0) . "<br>";
} catch (Exception $e) {
    echo 'Eroarea aparuta: ', $e->getMessage(), "<br>";
}

?>
