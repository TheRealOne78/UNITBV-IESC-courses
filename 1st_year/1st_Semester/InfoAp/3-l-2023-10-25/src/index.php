<html>
    <head>
        <title>My first PHP page</title>
    </head>
    <body>
        <?php
            echo "<h1>Hello world!</h1>";
            $a=2;
            $b=3;

            $media = ($a + $b) / 2;

            echo $media;
            //sau mai elegant:
            echo "<br> Media dintre $a si $b este $media <br>";

            define("PI", 3.14);
            echo "Pi = " .PI ."<br>";

            $sir[0]='a'; $sir[1]='b'; $sir[2]='c';
            $v[0]=2; $v[1]=4; $v[2]=6;
            echo "$v[1] <br>"; //va afisa al doilea element al vectorului numeric

            $lungime=10;
            $latime=5;

            $aria_dreptunghi = 2*$lungime + 2*$latime;
            echo "<br>Avand in vedere ca lungimea dreptunghiului este de <code>$lungime</code> si latimea dreptunghiului este de <code>$latime</code>, aria dreptunghiului este de <code> $aria_dreptunghi </code><br>";

            $raza_cerc = 15;
            $circumferinta = 2 * pi() * $raza_cerc;
            $aria = pi() * ($raza_cerc * $raza_cerc);
            echo "<br>Avand in vedere ca raza cercului este de <code>$raza_cerc</code>, aria cercului este de <code>$aria</code>, iar circumferinta cerului este de $circumferinta<br>";

            if ($a >= 0)
                echo "<br>$a este pozitiv sau zero <br>";
            else
                echo "<br>$a este negativ <br>";

            $categorie = 2;
            switch ($categorie) {
                case 1:
                    echo "prima categorie<br>"; break;
                case 2:
                    echo "a doua categorie<br>"; break;
                default:
                    echo "alta categorie<br>";
            }

            $suma=0;
            for($i=1; $i <= 5; $i++)
                $suma += $i;
            $i--;
            echo "<BR> suma numerelor de la 1 la $i este $suma <BR>";

            $vector = array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

            echo "<br><h2>Elemente vectori:</h2>";
            $sum=0;
            for($i=0; $i <= sizeof($vector); $i++) {
                echo "$vector[$i]<br>";
                $sum = $sum + $vector[$i];
            }
            echo "Suma: $sum<br>";

            function maxof($one, $two, $three) {
            }
        ?>
    </body>
</html>
