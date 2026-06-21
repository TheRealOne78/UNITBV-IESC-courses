<?php
    $nume = $_POST["nume"];
    $telefon = $_POST["telefon"];
    echo "Valori introduse in formular: <br>";
    echo "Numele este: $nume <br>";
    echo "Telefonul este: $telefon <br><br>";

    $http_user_agent = $_SERVER["HTTP_USER_AGENT"];
    $http_referer = $_SERVER["HTTP_REFERER"];
    $remote_addr = $_SERVER["REMOTE_ADDR"];
    $server_name = $_SERVER["SERVER_NAME"];

    echo "HTTP_USER_AGENT: $http_user_agent <br>";
    echo "HTTP_REFERER: $http_referer <br>";
    echo "remote_addr: $remote_addr <br>";
    echo "server_name: $server_name <br><br>";

    $textarea = $_POST["un_nume"];
    echo "$textarea <br>";

    $radio = $_POST["acoperire_nori"];
    echo "$radio <br><br>";

    $nume = $_POST["nume"][1];
    echo "$nume <br>";
?>
