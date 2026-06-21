package org.clase;

/**
 * The Persoana class represents a person with basic details such as ID, name, username, and password.
 * It is an abstract class intended to be extended by other classes like Student or Profesor.
 */
public abstract class Persoana {
    protected int id;
    protected String nume, prenume, username, password;

    /**
     * Constructor to initialize the basic information of a person.
     *
     * @param id       The unique identifier for the person.
     * @param nume     The first name of the person.
     * @param prenume  The last name of the person.
     * @param username The username associated with the person.
     * @param password The password associated with the person.
     */
    public Persoana(int id,
                    String nume,
                    String prenume,
                    String username,
                    String password)
    {
        this.id = id;
        this.nume = nume;
        this.prenume = prenume;
        this.username = username;
        this.password = password;
    }

    /*===========================*/
    /*======Getters&Setters======*/
    /*===========================*/

    /**
     * Gets the unique ID of the person.
     *
     * @return The ID of the person.
     */
    public int getId() {
        return id;
    }

    /**
     * Gets the first name of the person.
     *
     * @return The first name of the person.
     */
    public String getNume() {
        return nume;
    }

    /**
     * Gets the last name of the person.
     *
     * @return The last name of the person.
     */
    public String getPrenume() {
        return prenume;
    }

    /**
     * Gets the username of the person.
     *
     * @return The username of the person.
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the username of the person.
     *
     * @param username The new username to set for the person.
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Gets the password of the person.
     *
     * @return The password of the person.
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the password of the person.
     *
     * @param password The new password to set for the person.
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Provides a string representation of the person, showing their first name, last name, and username.
     *
     * @return A string representation of the person.
     */
    @Override
    public String toString() {
        return "Persoana [nume=" + nume + ", prenume=" + prenume + ", username=" + username + "]";
    }
}
