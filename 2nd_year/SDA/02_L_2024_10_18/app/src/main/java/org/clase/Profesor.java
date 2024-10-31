package org.clase;

public class Profesor {
    String nume;
    String prenume;
    @Override
    public String toString() {
        return "Profesor{" + "nume=" + nume + ", prenume=" + prenume + '}';
    }

    public Profesor(String nume, String prenume) {
        this.nume = nume;
        this.prenume = prenume;
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
