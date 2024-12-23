package org.clase;

import java.util.Set;
import java.util.HashMap;

public class Curs implements OperatiiCurs {
    private int id, an;
    private String nume, descriere;
    private Profesor profesor;
    private Set<Student> studenti;
    private HashMap<Student, Integer> nota;

    public Curs(int id,
                String nume,
                String descriere,
                Profesor profesor,
                int an,
                Set<Student> studenti,
                HashMap<Student, Integer> nota) {

        this.id        = id;
        this.an        = an;
        this.nume      = nume;
        this.descriere = descriere;
        this.profesor  = profesor;
        this.studenti  = studenti;
        this.nota      = nota;
    }


    public void addStudent(Student student) {
        studenti.add(student);
    }

    public void updateStudent(Student student_old, Student student_nou) {
        for(Student s : this.studenti) {
            if(s.equals(student_old))
                s = student_nou;
        }
    }

    public void removeStudent(Student student) {
        for (var tmp : studenti) {
            if (tmp.equals(student))
                studenti.remove(tmp);
        }
    }

    public void delStudent(Student student) {
        removeStudent(student); // NOTE: REDUNDANT
    }


    public void updateProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    public void updateCurs(String nume, String descriere) {
        this.nume = nume;
        this.descriere = descriere;
    }

    public void addStudentGrade(Student student, int grade) {
        nota.put(student, grade);
    }

    protected void afiseazaNoteStudenti() {
        for (Student student : studenti) {
            int grade = nota.get(student);
            System.out.println("Student: " + student + ", Nota: " + grade);
        }
    }

    protected float getMedie() {
        int sum = 0, cnt = 0;

        for (int grade : nota.values()) {
            sum += grade;
            cnt++;
        }

        return sum / cnt;
    }

    public void afiseazaMedie() {
        float medie = getMedie();
        System.out.println("Media: " + medie);
    }

    public void afiseazaStudentiLaConsola() {
        for(Student s : this.studenti)
            System.out.println(s);
    }

    /*===========================*/
    /*======Getters&Setters======*/
    /*===========================*/
    public int getId() {
        return id;
    }

    public int getAn() {
        return an;
    }

    public String getNume() {
        return nume;
    }

    public void setNume(String nume) {
        this.nume = nume;
    }

    public String getDescriere() {
        return descriere;
    }

    public void setDescriere(String descriere) {
        this.descriere = descriere;
    }

    public Profesor getProfesor() {
        return profesor;
    }

    public void setProfesor(Profesor profesor) {
        this.profesor = profesor;
    }

    public Set<Student> getStudenti() {
        return studenti;
    }

    public void setStudenti(Set<Student> studenti) {
        this.studenti = studenti;
    }

    public HashMap<Student, Integer> getNota() {
        return nota;
    }

    public void setNota(HashMap<Student, Integer> nota) {
        this.nota = nota;
    }
}
