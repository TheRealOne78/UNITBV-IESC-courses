<html>
    <head>
        <title>Calculator simplu</title>
    </head>
    <body>
        <h3>Calculator simplu</h3>
        <p>
        <FORM method=post action="calc.php">
            <INPUT TYPE="TEXT" NAME="op1" VALUE="<?php $op1=@$_POST["op1"]; echo $op1 ?>"> +
            <INPUT TYPE="TEXT" NAME="op2" VALUE="<?php $op2=@$_POST["op2"]; echo $op2 ?> ">
            <INPUT TYPE=SUBMIT VALUE=" = ">
            <INPUT TYPE=TEXT NAME=rezultat VALUE="<?php $op1=@$_POST["op1"]; $op2=@$_POST["op2"]; echo $op1+$op2;?>" disabled>
        </FORM>
    </body>
</html>
