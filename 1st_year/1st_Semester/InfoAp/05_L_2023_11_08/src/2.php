<html>
    <head>
    </head>
    <body>

    <form METHOD="POST" ACTION="2.php">
     <b>Raza</b>: <input TYPE="TEXT" NAME="Raza"><br>

     <b>Actiune</b>:
     <select NAME="Actiune">
     <option VALUE="aria">Calculează Aria Cerc</option>
     <option VALUE="volum">Calculează Volum Sferă</option>
     </select>

     <br><br>
     <input TYPE="SUBMIT" VALUE="Trimite">
    </form>

    <h2>Valori</h2>
     <b>Raza</b>: <?php $raza=@$_POST["Raza"]; echo $raza ?><br><br>
     <b>Actiune</b>: <?php $actiune=@$_POST["actiune"]; echo $actiune ?><br>
     <?php
         $action=@$_POST["Actiune"];
         $raza=@$_POST["Raza"];

        if($action == "aria") {
           echo "Aria cercului este de: ";
           $arie = pi() * $raza * $raza;
           echo "$arie<br>";
        }
        elseif($action == "volum") {
           echo "Volumul sferei este de: ";
           $volume = 4 / (3 * pi() * $raza * $raza * $raza);
           echo "$volume<br>";
        }
     ?>

    </body>
</html>
