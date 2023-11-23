<?php

if (! isset($_COOKIE['access_cnt']))
    setcookie('access_cnt', 0, time() + 15);
else {
    setcookie('access_cnt', $_COOKIE['access_cnt'] + 1, time() + 15);
}

echo "Count: ".$_COOKIE['access_cnt'];

?>
