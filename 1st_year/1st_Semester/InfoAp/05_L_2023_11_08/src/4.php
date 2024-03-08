<html>
    <head>
    </head>
    <body>

    <form METHOD="POST" ACTION="4.php">
     <select NAME="MeasurementUnit">
        <option VALUE="10">mm</option>
        <option VALUE="1">cm</option>
        <option VALUE="0.01">Metri</option>
     </select><br><br>
     <b>Inch</b> <input TYPE="TEXT" NAME="Inch"> ---> <b>CM</b> <input TYPE="TEXT" NAME="Cm" DISABLED VALUE=<?php $inch=@$_POST["Inch"]; $mu=@$_POST["MeasurementUnit"]; echo $inch * 2.54 * $mu; ?>> <input TYPE="SUBMIT" VALUE="Poi">
     /* TODO: Polish this up to meet MeasurementUnit criteria on both title and value */
    </form>

    </body>
</html>
