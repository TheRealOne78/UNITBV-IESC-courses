package org;

import java.util.Set;
import java.util.HashSet;

import org.clase.Curs;
import org.clase.ManagerCursuri;
import org.clase.Profesor;
import org.clase.Student;


public class Clase {
    public static void main(String[] args) {
        //definire studenti
        //Student[] studenti = new Student[]{new Student("Andrei","Negoita",2231),new Student("Ion","Mateescu",4221)};
        Set<Student> studenti = new HashSet<Student>();

        //Student student1 = new Student("Andrei", "Negoita", 2231);
        //Student student2 = new Student("Ion", "Mateescu", 4221);

        //studenti.add(student1);
        //studenti.add(student2);
        //definire profesor
        //Profesor prof = new Profesor("Anton", "Panaitescu");
        //definire curs nou
        //Curs curs = new Curs("Rezistenta Materialelor", "calculul reacţiunilor,\n" +
        //                     "diagramele de eforturi, calculul caracteristicilor geometrice ale\n" +
        //                     "suprafeţelor plane şi calculul elementelor de rezistenţă la solicitări simple\n"
        //                     , prof, studenti);
        ////adaugare curs in lista de cursuri
        //ManagerCursuri cursuri = new ManagerCursuri();
        //cursuri.AddCurs(curs);

        //curs.AfiseazaStudentiLaConsola();   // OK
        //cursuri.AfiseazaCursuriLaConsola(); // OK

        ////curs.AddStudentGrade(studenti[0], 10, prof);
        ////curs.AddStudentGrade(studenti[1], 7.5f, prof);

        //curs.AddStudentGrade(student1, 10);
        //curs.AddStudentGrade(student2, 8);

        //curs.AfiseazaStudentiLaConsola();   // OK

        //curs.AfiseazaMedie(); // OK

        //cursuri.AfiseazaNoteStudenti(); //OK

        //cursuri.AfiseazaMedieProfesor(prof); //OK
    }
}
