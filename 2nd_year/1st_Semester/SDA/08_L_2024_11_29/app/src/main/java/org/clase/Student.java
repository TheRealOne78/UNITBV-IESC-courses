package org.clase;

public class Student extends Persoana {
    private int an;
    private String grupa;

    public Student(int id,
                   String nume, String prenume,
                   int an,
                   String username, String password,
                   String grupa) {

        super(id, nume, prenume, username, password);
        this.grupa    = grupa;
        this.an       = an;
    }

    /*===========================*/
    /*======Getters&Setters======*/
    /*===========================*/
    public String getGrupa() {
        return grupa;
    }

    public int getAn() {
        return an;
    }

    @Override
    public String toString() {
        return "Student [id=" + id + ", grupa=" + grupa + ", an=" + an + ", nume=" + nume + ", prenume=" + prenume
                + ", username=" + username + "]";
    }
}
