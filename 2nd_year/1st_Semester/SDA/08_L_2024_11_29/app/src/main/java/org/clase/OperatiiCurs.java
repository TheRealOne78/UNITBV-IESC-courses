package org.clase;

public interface OperatiiCurs {
    public void updateProfesor(Profesor p);
    public void addStudent(Student student);
    public void removeStudent(Student student);
    public void updateStudent(Student student_old, Student student_nou);
    public void updateCurs(String nume, String descriere);
}
