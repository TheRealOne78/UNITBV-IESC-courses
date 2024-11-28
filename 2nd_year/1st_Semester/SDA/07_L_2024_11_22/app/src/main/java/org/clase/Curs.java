package org.clase;

import java.util.Set;
import java.util.HashMap;

public class Curs implements OperatiiCurs {
    String nume;
    String descriere;
    Profesor profu;
    Set<Student> studenti;
    HashMap<Student, Float> note_studenti;

    public Curs(String nume, String descriere, Profesor profu, Set<Student> studenti) {
        this.nume          = nume;
        this.descriere     = descriere;
        this.profu         = profu;
        this.studenti      = studenti;
        this.note_studenti = new HashMap<>();
    }

    public void RemoveStudent(Student student) {
        for (var tmp : studenti) {
            if (tmp.equals(student))
                studenti.remove(tmp);
        }
    }

    public void UpdateCurs(String nume, String descriere) {
        this.nume = nume;
        this.descriere = descriere;
    }

    public void UpdateProfesor(Profesor profu) {
        this.profu = profu;
    }

    public void AddStudent(Student student) {
        studenti.add(student);
    }

    public void DelStudent(Student student) {
        RemoveStudent(student);
    }

    public void UpdateStudent(Student student_old, Student student_nou) {
        for(Student s : this.studenti) {
            if(s.equals(student_old))
                s = student_nou;
        }
    }

    public void AddStudentGrade(Student student, float grade, Profesor prof) {
        note_studenti.put(student, grade);
    }

    protected void AfiseazaNoteStudenti() {
        for (Student student : studenti) {
            Float grade = note_studenti.get(student);
            System.out.println("Student: " + student + ", Nota: " + grade);
        }
    }

    protected float GetMedie() {
        float sum = 0;
        int cnt = 0;

        for (float grade : note_studenti.values()) {
            sum += grade;
            cnt++;
        }

        return sum / cnt;
    }

    public void AfiseazaMedie() {
        float medie = GetMedie();
        System.out.println("Media: " + medie);
    }

    public void AfiseazaStudentiLaConsola() {
        for(Student s : this.studenti)
            System.out.println(s);
    }

    @Override
    public String toString() {
        String str = "Curs: " + "nume=" + nume + ", descriere=" + descriere + ",\nprofu=" + profu + ",\nstudenti:\n" ;

        for(Student s : studenti)
            str+= s + "\n";

        return str;
    }

    public String getNume() {
        return nume;
    }

    public String getDescriere() {
        return descriere;
    }

    public Profesor getProfu() {
        return profu;
    }

    public Set<Student> getStudenti() {
        return studenti;
    }

    public HashMap<Student, Float> getNote_studenti() {
        return note_studenti;
    }

}
