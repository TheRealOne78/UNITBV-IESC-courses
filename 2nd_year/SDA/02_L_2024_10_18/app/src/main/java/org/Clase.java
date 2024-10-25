package org.clase;
public class Clase {
    public static void main(String[] args) {
        //definire studenti
        Student[] studenti = new Student[]{new Student("Andrei","Negoita",2231),new Student("Ion","Mateescu",4221)};
        //definire profesor
        Profesor prof = new Profesor("Anton","Panaitescu");
        //definire curs nou
        Curs curs = new Curs("Rezistenta Materialelor", "calculul reacţiunilor,\n" +
                             "diagramele de eforturi, calculul caracteristicilor geometrice ale\n" +
                             "suprafeţelor plane şi calculul elementelor de rezistenţă la solicitări simple\n"
                             , prof, studenti);
        //adaugare curs in lista de cursuri
        ManagerCursuri cursuri = new ManagerCursuri();
        cursuri.AddCurs(curs);
        cursuri.AfiseazaCursuriLaConsola();
    }
}
