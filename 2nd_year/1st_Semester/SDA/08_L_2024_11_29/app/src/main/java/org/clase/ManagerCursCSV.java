package org.clase;

import java.io.File;
import java.util.*;

public class ManagerCursCSV extends ManagerCursuri {
    File studenti, profesori, cursuri;
    public ManagerCursCSV() {
        try {
            studenti  = new File("studenti.csv");
            profesori = new File("profesori.csv");
            cursuri   = new File("cursuri.csv");
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public ManagerCursCSV(File studenti, File profesori, File cursuri) {
        this.studenti  = studenti;
        this.profesori = profesori;
        this.cursuri   = cursuri;
    }

    /*functia va aduce din fisiere, datele despre studenti, profesori, cursuri
      si va popula colectia din clasa Manager: lista*/
    public void CitesteDateDinFisiere() {
        try {
            ArrayList<Student> studentlist = PopuleazaStudenti();
            ArrayList<Profesor> proflist   = PopuleazaProfesori();
            ArrayList<Curs> list           = PopuleazaCursuri(proflist, studentlist);
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public ArrayList<Student> PopuleazaStudenti() {
        //TODO
        return new ArrayList<>();

    }

    public ArrayList<Profesor> PopuleazaProfesori() {
        //TODO
        return new ArrayList<>();
    }

    public ArrayList<Curs> PopuleazaCursuri(ArrayList<Profesor> proflist, ArrayList<Student> studentlist) {
        //TODO
        return new ArrayList<>();
    }

    public void ScrieCursuriInFisier() {

    }
}
