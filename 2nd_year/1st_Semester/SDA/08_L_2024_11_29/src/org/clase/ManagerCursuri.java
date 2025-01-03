package org.clase;

import java.util.List;
import java.util.ArrayList;

/**
 * Manages a list of courses (Curs) and provides _SOME_ methods to manipulate and display them.
 */
public class ManagerCursuri extends ManagerCursCSV implements OperatiiManagerCursuri {
    List<Curs> cursuri = new ArrayList<Curs>();

    public ManagerCursuri(){}

    /**
     * Adds a new course to the list of courses.
     *
     * @param curs The course to be added.
     */
    public void AddCurs(Curs curs) {
        cursuri.add(curs);
    }

    /**
     * Deletes a specified course from the list of courses.
     *
     * @param curs The course to be deleted.
     */
    public void DeleteCurs(Curs curs) {
        for (var tmp : cursuri) {
            if (tmp.equals(curs))
                cursuri.remove(tmp);
        }
    }

    /**
     * Updates an existing course with a new one in the list.
     *
     * @param curs_vechi The existing course to be replaced.
     * @param curs_nou The new course to replace the old one.
     */
    public void UpdateCurs(Curs curs_vechi, Curs curs_nou) {
        for (Curs c : cursuri) {
            if (c.equals(curs_vechi))
                c = curs_nou; // Should use proper setter if needed, updating the object reference here won't work
        }
    }

    /**
     * Displays all courses in the list to the console.
     */
    public void AfiseazaCursuriLaConsola() {
        for (Curs c : cursuri)
            System.out.println(c);
    }

    /**
     * Displays the grades of students for each course in the list.
     */
    public void AfiseazaNoteStudenti() {
        for (Curs c : cursuri)
            c.afiseazaNoteStudenti();
    }

    /**
     * Calculates and displays the average grade of a professor for all their courses.
     *
     * @param profesor The professor for whom the average grade is calculated.
     */
    public void AfiseazaMedieProfesor(Profesor profesor) {
        float suma = 0;
        int i = 0;

        for (var tmp : cursuri) {
            if (tmp.getProfesor().equals(profesor)) {
                suma += tmp.getMedie();
                i++;
            }
        }

        if (i > 0) {
            System.out.println("Medie profesor " + profesor.getNume() + " " + profesor.getPrenume() + ": " + suma / i);
        } else {
            System.out.println("Profesorul " + profesor.getNume() + " " + profesor.getPrenume() + " nu are cursuri.");
        }
    }
}
