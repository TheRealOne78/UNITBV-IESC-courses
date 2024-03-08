<html>
    <head>
    </head>
    <body>

    <form METHOD="POST" ACTION="3.php">
     <b>Inch</b> <input TYPE="TEXT" NAME="Inch"> ---> <b>CM</b> <input TYPE="TEXT" NAME="Cm" DISABLED VALUE=<?php $inch=@$_POST["Inch"]; echo $inch * 2.54; ?>> <input TYPE="SUBMIT" VALUE="Poi">
    </form>

    </body>
</html>
