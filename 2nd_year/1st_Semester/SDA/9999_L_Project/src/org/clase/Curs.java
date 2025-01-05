package org.clase;

import java.util.Set;
import java.util.HashMap;

/**
 * Represents a course (Curs object) which contains details about the course,
 * such as its name, description, professor, students, and grades.
 */
public class Curs implements OperatiiCurs {
    private int          id, an;
    private String       nume, descriere;
    private Profesor     profesor;
    private Set<Student> studenti;
    private HashMap<Student, Integer> nota;

    /**
     * Constructs a new Curs instance with the provided details.
     *
     * @param id The ID of the course.
     * @param nume The name of the course.
     * @param descriere A description of the course.
     * @param profesor The professor teaching the course.
     * @param an The academic year of the course.
     * @param studenti A set of students enrolled in the course.
     * @param nota A map of students and their corresponding grades.
     */
    public
    Curs(int          id,
         String       nume,
         String       descriere,
         Profesor     profesor,
         int          an,
         Set<Student> studenti,
         HashMap<Student, Integer> nota)
    {
        this.id        = id;
        this.an        = an;
        this.nume      = nume;
        this.descriere = descriere;
        this.profesor  = profesor;
        this.studenti  = studenti;
        this.nota      = nota;
    }

    @Deprecated
    public Curs() {
        this.id        = -1;
        this.an        = -1;
        this.nume      = null;
        this.descriere = null;
        this.profesor  = null;
        this.studenti  = null;
        this.nota      = null;
    }

    /**
     * Adds a student to the course.
     *
     * @param student The student to be added to the course.
     */
    public void addStudent(Student student) {
        studenti.add(student);
    }

    /**
     * Updates an existing student with a new one.
     *
     * @param student_old The existing student to be updated.
     * @param student_nou The new student to replace the old one.
     */
    public void updateStudent(Student student_old, Student student_nou) {
        for(Student s : this.studenti) {
            if(s.equals(student_old))
                s = student_nou;
        }
    }

    /**
     * Removes a student from the course.
     *
     * @param student The student to be removed from the course.
     */
    public void removeStudent(Student student) {
        for (var tmp : studenti) {
            if (tmp.equals(student))
                studenti.remove(tmp);
        }
    }

    /**
     * Deletes a student from the course (alias for removeStudent).
     *
     * @deprecated DEPRECATED in favor of removeStudent.
     *
     * @param student The student to be deleted from the course.
     */
    @Deprecated
    public void delStudent(Student student) { // NOTE:DEPRECATED: REDUNDANT
        removeStudent(student);
    }

    /**
     * Updates the professor for the course.
     *
     * @param profesor The new professor for the course.
     */
    public void updateProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    /**
     * Updates the course name and description.
     *
     * @param nume The new name for the course.
     * @param descriere The new description for the course.
     */
    public void updateCurs(String nume, String descriere) {
        this.nume = nume;
        this.descriere = descriere;
    }

    /**
     * Adds a grade for a student in the course.
     *
     * @param student The student to whom the grade belongs.
     * @param grade The grade given to the student.
     */
    public void addStudentGrade(Student student, int grade) {
        nota.put(student, grade);
    }

    /**
     * Displays the grades of students for this course.
     */
    protected void afiseazaNoteStudenti() {
        for (Student student : studenti) {
            int grade = nota.get(student);
            System.out.println("Student: " + student + ", Nota: " + grade);
        }
    }

    /**
     * Calculates and returns the average grade for all students in the course.
     *
     * @return The average grade of all students in the course.
     */
    protected float getMedie() {
        int sum = 0, cnt = 0;

        for (int grade : nota.values()) {
            sum += grade;
            cnt++;
        }

        return cnt > 0 ? sum / (float) cnt : 0;
    }

    /**
     * Displays the average grade for the course.
     */
    public void afiseazaMedie() {
        float medie = getMedie();
        System.out.println("Media: " + medie);
    }

    /**
     * Displays the list of students enrolled in the course to the console.
     */
    public void afiseazaStudentiLaConsola() {
        for(Student s : this.studenti)
            System.out.println(s);
    }

    /*===========================*/
    /*======Getters&Setters======*/
    /*===========================*/

    /**
     * Returns the ID of the course.
     *
     * @return The ID of the course.
     */
    public int getId() {
        return id;
    }

    /**
     * Returns the academic year of the course.
     *
     * @return The academic year.
     */
    public int getAn() {
        return an;
    }

    /**
     * Returns the name of the course.
     *
     * @return The name of the course.
     */
    public String getNume() {
        return nume;
    }

    /**
     * Sets the name of the course.
     *
     * @param nume The new name of the course.
     */
    public void setNume(String nume) {
        this.nume = nume;
    }

    /**
     * Returns the description of the course.
     *
     * @return The description of the course.
     */
    public String getDescriere() {
        return descriere;
    }

    /**
     * Sets the description of the course.
     *
     * @param descriere The new description of the course.
     */
    public void setDescriere(String descriere) {
        this.descriere = descriere;
    }

    /**
     * Returns the professor teaching the course.
     *
     * @return The professor teaching the course.
     */
    public Profesor getProfesor() {
        return profesor;
    }

    /**
     * Sets the professor teaching the course.
     *
     * @param profesor The new professor teaching the course.
     */
    public void setProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    /**
     * Returns the set of students enrolled in the course.
     *
     * @return The set of students.
     */
    public Set<Student> getStudenti() {
        return studenti;
    }

    /**
     * Sets the students enrolled in the course.
     *
     * @param studenti The new set of students.
     */
    public void setStudenti(Set<Student> studenti) {
        this.studenti = studenti;
    }

    /**
     * Returns the map of students and their corresponding grades.
     *
     * @return The map of students and grades.
     */
    public HashMap<Student, Integer> getNota() {
        return nota;
    }

    /**
     * Sets the map of students and their grades.
     *
     * @param nota The new map of students and grades.
     */
    public void setNota(HashMap<Student, Integer> nota) {
        this.nota = nota;
    }
}
