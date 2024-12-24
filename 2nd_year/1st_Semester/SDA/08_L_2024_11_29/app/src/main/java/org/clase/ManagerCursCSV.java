package org.clase;

import java.io.File;
import java.util.*;

public class ManagerCursCSV extends FileDataManager {
    File studenti, profesori, cursuri, note;

    public ManagerCursCSV() {
        try {
            studenti  = new File("studenti.txt");
            profesori = new File("profesori.txt");
            cursuri   = new File("cursuri.txt");
            note      = new File("note.txt");
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public ManagerCursCSV(File studenti, File profesori, File cursuri, File note) {
        this.studenti  = studenti;
        this.profesori = profesori;
        this.cursuri   = cursuri;
        this.note      = note;
    }

    /* functia va aduce din fisiere, datele despre studenti, profesori, cursuri
       si va popula colectia din clasa Manager: lista*/
    public void CitesteDateDinFisiere() {
        try {
            List<Student> studentList = populeazaStudenti();
            List<Profesor> profList   = populeazaProfesori();
            List<Curs> lista          = populeazaCursuri(studentList, profList);
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public List<Student> populeazaStudenti() {
        return createStudentsData(studenti);
    }

    public List<Profesor> populeazaProfesori() {
        return createProfesorData(profesori);
    }

    public List<Curs> populeazaCursuri(List<Student> studentlist, List<Profesor> proflist) {
        return createCoursesData(proflist, studentlist, cursuri, note);
    }

}
