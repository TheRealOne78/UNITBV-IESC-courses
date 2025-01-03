package org.clase;

public class Student extends Persoana {
    private int an;
    private String grupa;

    /**
     * @param id The unique identifier for the student.
     * @param nume The first name of the student.
     * @param prenume The last name of the student.
     * @param an The year of study for the student.
     * @param username The username associated with the student.
     * @param password The password associated with the student.
     * @param grupa The group the student belongs to.
     */
    public
    Student(int    id,
            String nume,
            String prenume,
            int    an,
            String username,
            String password,
            String grupa)
    {
        super(id, nume, prenume, username, password);
        this.grupa = grupa;
        this.an    = an;
    }

    @Deprecated
    public Student() {
        super(-1, null, null, null, null);
        this.grupa = null;
        this.an = -1;
    }

    /*===========================*/
    /*======Getters&Setters======*/
    /*===========================*/

    /**
     * Gets the group of the student.
     *
     * @return The group the student belongs to.
     */
    public String getGrupa() {
        return grupa;
    }

    /**
     * Gets the year of study of the student.
     *
     * @return The year of study.
     */
    public int getAn() {
        return an;
    }

    /**
     * Provides a string representation of the student.
     *
     * @return A string containing the student's ID, group, year of study, name, and username.
     */
    @Override
    public String toString() {
        return "Student [id=" + id + ", grupa=" + grupa + ", an=" + an + ", nume=" + nume + ", prenume=" + prenume
                + ", username=" + username + "]";
    }
}
