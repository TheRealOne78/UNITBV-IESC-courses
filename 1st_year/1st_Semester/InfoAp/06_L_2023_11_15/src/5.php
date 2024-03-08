<html>
    <head>
    </head>
    <body>

    <b>Operație</b><br>
    <form METHOD="POST" ACTION="5.php">
      <input VALUE="+" NAME="operator" TYPE="radio">Însumare</input><br>
      <input VALUE="-" NAME="operator" TYPE="radio">Scădere</input><br>
      <input VALUE="*" NAME="operator" TYPE="radio">Înmulțire</input><br>
      <input VALUE="/" NAME="operator" TYPE="radio">Împărțire</input><br>
     <br>
     <b>Primul număr</b> <input TYPE="TEXT" NAME="num1"><br>
     <b>Al doilea număr</b> <input TYPE="TEXT" NAME="num2"><br>
     <input TYPE="SUBMIT" VALUE="Poi"><br>
     <br>
     <b>Rezultat</b> <input TYPE="TEXT" NAME="result" VALUE=<?php $num1=@$_POST["num1"];
$num2=@$_POST["num2"];
$operator=@$_POST["operator"];

switch($operator) {
    case "+":
        $rez = $num1 + $num2;
        break;
    case "-":
        $rez = $num1 - $num2;
        break;
    case "*":
        $rez = $num1 * $num2;
        break;
    case "/":
        $rez = $num1 / $num2;
        break;
}
    echo "$rez";
?> DISABLED >

    </form>

    </body>
</html>
