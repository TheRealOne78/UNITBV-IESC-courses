package org.clase;

public class Profesor extends Persoana {

    /**
     * @param id The unique identifier for the professor.
     * @param nume The first name of the professor.
     * @param prenume The last name of the professor.
     * @param username The username associated with the professor.
     * @param password The password associated with the professor.
     */
    public
    Profesor(int    id,
             String nume,
             String prenume,
             String username,
             String password)
    {
        super(id, nume, prenume, username, password);
    }

    @Deprecated
    public Profesor() { super(-1, null, null, null, null); }

    @Override
    public String toString() {
        return "Profesor []";
    }
}
