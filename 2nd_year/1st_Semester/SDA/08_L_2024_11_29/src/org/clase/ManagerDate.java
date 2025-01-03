package org.clase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ManagerDate {
    ManagerCursuri managerCursuri;

    public ManagerDate() {
        managerCursuri = new ManagerCursuri();
    }

    /**
     * Get the account ID.
     *
     * @param username The student's username.
     * @param password The student's password.
     * @return The account id,
     *         -1 if there is no match.
     */
    public int getStudentID(String username, String password) {
        return -1; // if no match
    }

    /**
     * Get the account ID.
     *
     * @param username The professor's username.
     * @param password The professor's password.
     * @return The account id,
     *         -1 if there is no match.
     */
    public int getProfessorID(String username, String password) {
        return -1; // if no match
    }

    /**
     * Get the account type.
     *
     * @param username The account's username.
     * @param password The account's password.
     * @return 'p' if professor account,
     *         's' if student account.
     */
    public char getAccountType(String username, String password) {
        if(true) {
            // TODO
            return 'p';    //if professor account
        } else return 's'; //if student account

    }

    /**
     * Check if the username is registered.
     *
     * @param username A string with the username (Eg. someone@example.com).
     * @return true if someone registered with the provided username,
     *         false if there is noone registered with the provided username.
     */
    public boolean isRegistered(String username) {
        // TODO

        return false;
    }

    /**
     * Register a new student.
     *
     * @param surname The surname (nume) to register the student as.
     * @param forename The forename (prenume) to register the student as.
     * @param year The year the student should be registered to.
     * @param username The student's username.
     * @param password The student's password.
     * @param group The group the user belongs to.
     */
    public void
    registerStudent(String surname,
                    String forename,
                    int    year,
                    String username,
                    String password,
                    String group)
    {
        // TODO
    }


    /**
     * Register a new professor.
     *
     * @param surname The surname (nume) to register the professor as.
     * @param forename The forename (prenume) to register the professor as.
     * @param username The professor's username.
     * @param password The professor's password.
     */
    public void
    registerProfessor(String surname,
                      String forename,
                      String username,
                      String password)
    {
        // TODO
    }

    public List<Curs> getStudentCourses(int id) {
        return new ArrayList<>(); // TODO
    }

    public List<Curs> getProfessorCourses(int id) {
        return new ArrayList<>(); // TODO
    }

    public HashMap<Curs, Integer> getStudentGrades(int id) {
        return new HashMap<Curs, Integer>(); //TODO
    }

    public List<Curs> getStudentFailedExams(int id) {
        return new ArrayList<>(); // TODO
    }

    public float getStudentYearAverage(int id) {
        return -1; // TODO
    }

    public void setGrade(int idStudent, int idCourse) {
        // TODO
    }
}
