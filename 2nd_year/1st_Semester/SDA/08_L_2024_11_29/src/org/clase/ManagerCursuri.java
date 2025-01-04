package org.clase;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

/**
 * Manages a list of courses (Curs) and provides methods to manipulate and display them.
 * This class extends ManagerCursCSV to maintain synchronization with the course data in CSV.
 */
public class ManagerCursuri extends ManagerCursCSV implements OperatiiManagerCursuri {
    private List<Curs> cursuri = new ArrayList<Curs>();

    // Constructor that loads the course data from the parent ManagerCursCSV
    public ManagerCursuri() {
        super(); // Calls the constructor of ManagerCursCSV to load course data
        loadCoursesFromManagerCursCSV(); // Load the courses into the cursuri list
    }

    /**
     * Loads the courses from the coursesMap in ManagerCursCSV into the cursuri list.
     */
    private void loadCoursesFromManagerCursCSV() {
        // Synchronize cursuri list with the coursesMap from ManagerCursCSV
        for (HashMap.Entry<Integer, Curs> entry : coursesMap.entrySet()) {
            cursuri.add(entry.getValue());
        }
    }

    /**
     * Adds a new course to the courses list, assigns a new ID, updates the data structures,
     * and writes the new data back to the CSV files.
     *
     * @param nume The name of the course.
     * @param descriere The description of the course.
     * @param profesor The professor teaching the course.
     * @param an The year of the course.
     * @param studenti The list of students enrolled in the course.
     * @param nota The grades for each student in the course.
     */
    public void
    AddCurs(String nume,
            String descriere,
            Profesor profesor,
            int an,
            Set<Student> studenti,
            HashMap<Student, Integer> nota) {

        int  newCourseId = generateNewCourseId();
        Curs newCurs     = new Curs(newCourseId,
                                    nume,
                                    descriere,
                                    profesor,
                                    an,
                                    studenti,
                                    nota);
        cursuri.add(newCurs);
        coursesMap.put(newCourseId, newCurs);

        writeCourses();
    }

    /**
     * Generates a new unique ID for a course based on the size of the coursesMap.
     *
     * @return The new course ID.
     */
    private int generateNewCourseId() {
        return coursesMap.size() + 1;
    }

    /**
     * Deletes a specified course from the courses list and removes it from coursesMap.
     * Updates the data structures and writes the changes back to the CSV files.
     *
     * @param curs The course to be deleted.
     */
    public void DeleteCurs(Curs curs) {
        // Remove the course from the list and from coursesMap
        cursuri.remove(curs);
        coursesMap.remove(curs.getId());

        // Write the updated data to the CSV files
        writeCourses();
    }

    /**
     * Updates an existing course in the courses list with a new one.
     * The course is replaced in both the cursuri list and coursesMap.
     * After the update, the data is written back to the CSV files.
     *
     * @param cursVechi The existing course to be replaced.
     * @param cursNou   The new course to replace the old one.
     */
    public void UpdateCurs(Curs cursVechi, Curs cursNou) {
        // Find the course to update in the list
        for (int i = 0; i < cursuri.size(); i++) {
            if (cursuri.get(i).equals(cursVechi)) {
                // Update the course in the list and map
                cursuri.set(i, cursNou);
                coursesMap.put(cursNou.getId(), cursNou);

                // Write the updated data to the CSV files
                writeCourses();
                return;
            }
        }
    }

    /**
     * Displays all courses in the list to the console.
     */
    public void afiseazaCursuriLaConsola() {
        for (Curs c : cursuri) {
            System.out.println(c);
        }
    }

    /**
     * Displays the grades of students for each course in the list.
     */
    public void afiseazaNoteStudenti() {
        for (Curs c : cursuri) {
            c.afiseazaNoteStudenti();
        }
    }

    /**
     * Calculates and displays the average grade of a professor for all their courses.
     *
     * @param profesor The professor for whom the average grade is calculated.
     */
    public void afiseazaMedieProfesor(Profesor profesor) {
        float suma = 0;
        int i = 0;

        for (Curs tmp : cursuri) {
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
