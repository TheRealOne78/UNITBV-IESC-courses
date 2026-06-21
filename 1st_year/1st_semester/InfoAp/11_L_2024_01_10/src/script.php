<?php

    include "./index.html";

    $coord_x= $_GET['x'];
    $coord_y= $_GET['y'];

    $zona=0;

    if ($coord_x <= 250 && $coord_y <= 250) {
        $zona=1;
    }
    elseif ($coord_x > 250 && $coord_y <= 250) {
        $zona=2;
    }
    elseif ($coord_x <= 250 && $coord_y > 250) {
        $zona=3;
    }
    else {
        $zona=4;
    }

    echo "<br>Click in zona $zona";

?>
