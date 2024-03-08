<html>
    <head>
    </head>
    <body>

    <form METHOD="POST" ACTION="1.php">
     <b>Prenume</b>: <input TYPE="TEXT" NAME="Prenume"><br>
     <b>Nume</b>: <input TYPE="TEXT" NAME="Nume"><br>
     <b>E-Mail</b>: <input TYPE="TEXT" NAME="E-Mail"><br><br>

     <b>Studii</b>:<br>
     <input TYPE="RADIO" NAME="Studii" VALUE="Medii">Medii<br>
     <input TYPE="RADIO" NAME="Studii" VALUE="Superioare">Superioare<br>
     <input TYPE="RADIO" NAME="Studii" VALUE="Doctorat">Doctorat<br><br>

     <b>Limbi straine</b>:<br>
     <input TYPE="CHECKBOX" NAME="Limbi[]" VALUE="Engleza">Engleza<br>
     <input TYPE="CHECKBOX" NAME="Limbi[]" VALUE="Franceza">Franceza<br>
     <input TYPE="CHECKBOX" NAME="Limbi[]" VALUE="Germana">Germana<br><br>

     <b>Tara</b>:<br>
     <select NAME="Tara">
     <option VALUE="Romania">Romania</option>
     <option VALUE="Bulgaria">Bulgaria</option>
     <option VALUE="Republica Moldova">Republica Moldova</option>
     </select>

     <br><br>
     <input TYPE="SUBMIT" VALUE="Trimite">
    </form>

    <h2>Valori introduse</h2>
     Prenume: <?php $prenume=@$_POST["Prenume"]; echo $prenume ?><br>
     Nume: <?php $nume=@$_POST["Nume"]; echo $nume ?><br>
     E-Mail: <?php $email=@$_POST["E-Mail"]; echo $email ?><br>
     Studii: <?php $studii=@$_POST["Studii"]; echo $studii ?><br>
     Limbi: <?php $limbi=@$_POST["Limbi"]; foreach($limbi as $x) echo "| $x | "?><br>
     Tara: <?php $tara=@$_POST["Tara"]; echo "$tara" ?>

    </body>
</html>
