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
}
