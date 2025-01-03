package org.clase;

public interface OperatiiCurs {

    /**
     * Updates the professor of the course.
     *
     * @param p The new professor to be assigned to the course.
     */
    public void updateProfesor(Profesor p);

    /**
     * Adds a student to the course.
     *
     * @param student The student to be added to the course.
     */
    public void addStudent(Student student);

    /**
     * Removes a student from the course.
     *
     * @param student The student to be removed from the course.
     */
    public void removeStudent(Student student);

    /**
     * Updates a student's information in the course. The method will replace the old student
     * with the new student.
     *
     * @param student_old The student to be replaced.
     * @param student_nou The new student to replace the old student.
     */
    public void updateStudent(Student student_old, Student student_nou);

    /**
     * Updates the course details, including its name and description.
     *
     * @param nume The new name for the course.
     * @param descriere The new description for the course.
     */
    public void updateCurs(String nume, String descriere);
}
