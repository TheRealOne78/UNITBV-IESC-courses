package org.clase;

public abstract class Persoana {
    protected int id;
    protected String nume, prenume, username, password;

    public Persoana(int id,
                    String nume, String prenume,
                    String username, String password) {
        this.id       = id;
        this.nume     = nume;
        this.prenume  = prenume;
        this.username = username;
        this.password = password;
    }

    /*===========================*/
    /*======Getters&Setters======*/
    /*===========================*/
    protected int getId() {
        return id;
    }

    protected String getNume() {
        return nume;
    }

    protected String getPrenume() {
        return prenume;
    }

    protected String getUsername() {
        return username;
    }

    protected void setUsername(String username) {
        this.username = username;
    }

    protected String getPassword() {
        return password;
    }

    protected void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Persoana [nume=" + nume + ", prenume=" + prenume + ", username=" + username + "]";
    }
}
