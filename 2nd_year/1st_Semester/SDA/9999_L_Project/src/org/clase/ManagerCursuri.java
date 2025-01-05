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
        super(); // Load course data

        // Load our courses list
        for (HashMap.Entry<Integer, Curs> e : coursesMap.entrySet()) {
            cursuri.add(e.getValue());
        }
    }

    /**
     * Adds a new course to the courses list, assigns a new ID, updates the data structures,
     * and writes the new data back to the CSV files.
     *
     * @param nume       The name of the course.
     * @param descriere  The description of the course.
     * @param profesor   The professor teaching the course.
     * @param an         The year of the course.
     * @param studenti   The list of students enrolled in the course.
     * @param nota       The grades for each student in the course.
     */
    public synchronized void
    AddCurs(String       nume,
            String       descriere,
            Profesor     profesor,
            int          an,
            Set<Student> studenti,
            HashMap<Student, Integer> nota)
    {
        int newCourseId = generateNewCourseId();

        for (Student student : studenti) {
            setGrade(student.getId(), newCourseId, -1); // Default grade of -1
            nota.put(student, -1); // Update the grades hashmaps
        }

        Curs newCurs = new Curs(newCourseId,
                                nume,
                                descriere,
                                profesor,
                                an,
                                studenti,
                                nota);

        cursuri.add(newCurs);
        coursesMap.put(newCourseId, newCurs);

        writeCourses(); // Update CSV
    }


    public synchronized void
    setGrade(int studentId,
             int courseId,
             int grade)
    {
        HashMap<Integer, Integer> courseGrades = getGradesMap().computeIfAbsent(courseId, k -> new HashMap<>());
        courseGrades.put(studentId, grade); // Set the student's grade for the course

        writeGrades(); // Update CSV
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
        cursuri.remove(curs);
        coursesMap.remove(curs.getId());

        writeCourses(); // Update CSV
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
        for (int i = 0; i < cursuri.size(); i++) {
            if (cursuri.get(i).equals(cursVechi)) {
                cursuri.set(i, cursNou);
                coursesMap.put(cursNou.getId(), cursNou);

                writeCourses(); // Update CSV
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
