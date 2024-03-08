<html>
    <head>
    </head>
    <body>

    <form METHOD="POST" ACTION="4.php">
     <select NAME="MeasurementUnit">
        <option VALUE="Mm">Mm</option>
        <option VALUE="Cm">Cm</option>
        <option VALUE="M">Metri</option>
     </select><br><br>
     <b>Inch</b> <input TYPE="TEXT" NAME="Inch"> ---> <b><?php $mu=@$_POST["MeasurementUnit"]; echo $mu; ?></b> <input TYPE="TEXT" NAME="Cm" VALUE=<?php $inch=@$_POST["Inch"];
$mu=@$_POST["MeasurementUnit"];

$ratio=0;
switch($mu) {
case "Mm":
    $ratio=10;
    break;
case "Cm":
    $ratio=1;
    break;
case "M":
    $ratio=0.01;
}

$rezult=$inch * 2.54 * $ratio;
echo "$rezult";
?> DISABLED >

     <input TYPE="SUBMIT" VALUE="Poi"><br>
    </form>

    </body>
</html>
