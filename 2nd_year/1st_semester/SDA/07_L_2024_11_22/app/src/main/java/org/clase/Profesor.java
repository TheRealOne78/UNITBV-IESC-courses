package org.clase;

public class Profesor extends Persoana {

    public Profesor(String nume, String prenume) {
        super(nume, prenume);
    }

    public String getNume() {
        return nume;
    }

    public void setNume(String nume) {
        this.nume = nume;
    }

    public String getPrenume() {
        return prenume;
    }

    public void setPrenume(String prenume) {
        this.prenume = prenume;
    }
}
