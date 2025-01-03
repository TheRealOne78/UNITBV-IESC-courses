package org.clase;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

/**
 * This class is responsible for displaying data related to students, professors, and courses to text files.
 * It provides methods to write student, professor, course, and grade information to different files.
 */
public class FileDisplay {

    /**
     * Writes the list of students to a file named "Studenti.txt".
     * Each student's details are written as a CSV entry.
     *
     * @param students The list of students to be written to the file.
     */
    public void displayStudents(List<Student> students) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("Studenti.txt"))) {
            // Writing header
            writer.write("Id,Nume,Prenume,An,Username,Password");
            writer.newLine();

            // Writing student data
            for (Student student : students) {
                writer.write(String.format("%d,%s,%s,%d,%s,%s",
                        student.getId(), student.getNume(), student.getPrenume(),
                        student.getAn(), student.getUsername(), student.getPassword()));
                writer.newLine();
            }

        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }

    /**
     * Writes the list of professors to a file named "Profesori.txt".
     * Each professor's details are written as a CSV entry.
     *
     * @param profesors The list of professors to be written to the file.
     */
    public void displayTeachers(List<Profesor> profesors) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("Profesori.txt"))) {
            // Writing header
            writer.write("Id,Nume,Prenume,Username,Password");
            writer.newLine();

            // Writing professor data
            for (Profesor profesor : profesors) {
                writer.write(String.format("%d,%s,%s,%s,%s",
                        profesor.getId(), profesor.getNume(), profesor.getPrenume(),
                        profesor.getUsername(), profesor.getPassword()));
                writer.newLine();
            }

        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }

    /**
     * Writes the list of courses and their corresponding grades to the files "Cursuri.txt" and "Note.txt".
     *
     * @param cursuri The list of courses to be written to the files.
     */
    public void displayCourses(List<Curs> cursuri) {
        try (BufferedWriter courseWriter = new BufferedWriter(new FileWriter("Cursuri.txt"));
             BufferedWriter gradesWriter = new BufferedWriter(new FileWriter("Note.txt"))) {
            // Writing course data
            courseWriter.write("Id,Nume,Descriere,IdProfesor");
            courseWriter.newLine();

            // Writing grades data
            gradesWriter.write("IdCurs,IdStudent,Nota");
            gradesWriter.newLine();

            for (Curs curs : cursuri) {
                // Writing course data
                courseWriter.write(String.format("%d,%s,%s,%d",
                        curs.getId(), curs.getNume(), curs.getDescriere(),
                        curs.getProfesor().getId()));
                courseWriter.newLine();

                // Writing grades data for the course
                for (Student student : curs.getStudenti()) {
                    gradesWriter.write(String.format("%d,%d,%d", curs.getId(), student.getId(),
                            curs.getNota().get(student)));
                    gradesWriter.newLine();
                }
            }

        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }
}
