package org.clase;

public interface OperatiiCurs {
    public void UpdateProfesor(Profesor p);
    public void AddStudent(Student student);
    public void RemoveStudent(Student student);
    public void UpdateStudent(Student student_old, Student student_nou);
    public void UpdateCurs(String nume, String descriere);
}
