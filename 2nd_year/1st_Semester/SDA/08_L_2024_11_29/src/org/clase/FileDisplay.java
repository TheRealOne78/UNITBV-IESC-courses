package org.clase;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class FileDisplay {

    /**
     * Writes student data to a specified file.
     *
     * @param studentsMap The HashMap containing student data.
     * @param studentsFile The file to write student data to.
     */
    public void displayStudents(HashMap<Integer, Student> studentsMap, File studentsFile) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(studentsFile))) {
            // Writing header
            writer.write("Id,Nume,Prenume,An,Username,Password,Grupa");
            writer.newLine();

            // Writing student data
            for (Student student : studentsMap.values()) {
                writer.write(String.format("%d,%s,%s,%d,%s,%s,%s",
                        student.getId(), student.getNume(), student.getPrenume(),
                        student.getAn(), student.getUsername(), student.getPassword(),
                        student.getGrupa()));
                writer.newLine();
            }

        } catch (IOException e) {
            System.out.println("Error writing to students file: " + e.getMessage());
        }
    }

    /**
     * Writes professor data to a specified file.
     *
     * @param professorsMap The HashMap containing professor data.
     * @param professorsFile The file to write professor data to.
     */
    public void displayTeachers(HashMap<Integer, Profesor> professorsMap, File professorsFile) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(professorsFile))) {
            // Writing header
            writer.write("Id,Nume,Prenume,Username,Password");
            writer.newLine();

            // Writing professor data
            for (Profesor profesor : professorsMap.values()) {
                writer.write(String.format("%d,%s,%s,%s,%s",
                        profesor.getId(), profesor.getNume(), profesor.getPrenume(),
                        profesor.getUsername(), profesor.getPassword()));
                writer.newLine();
            }

        } catch (IOException e) {
            System.out.println("Error writing to professors file: " + e.getMessage());
        }
    }

    /**
     * Writes course data and grades to specified files.
     *
     * @param coursesMap The HashMap containing course data.
     * @param gradesMap  The HashMap containing grade data for each course.
     * @param coursesFile The file to write course data to.
     * @param gradesFile The file to write grade data to.
     */
    public void displayCoursesAndGrades(HashMap<Integer, Curs> coursesMap,
                                        HashMap<Integer, HashMap<Integer, Integer>> gradesMap,
                                        File coursesFile, File gradesFile) {
        try (BufferedWriter courseWriter = new BufferedWriter(new FileWriter(coursesFile));
             BufferedWriter gradesWriter = new BufferedWriter(new FileWriter(gradesFile))) {
            // Writing course headers
            courseWriter.write("Id,Nume,Descriere,IdProfesor,An");
            courseWriter.newLine();

            // Writing grade headers
            gradesWriter.write("IdCurs,IdStudent,Nota");
            gradesWriter.newLine();

            // Writing course data
            for (Curs course : coursesMap.values()) {
                courseWriter.write(String.format("%d,%s,%s,%d,%d",
                        course.getId(), course.getNume(), course.getDescriere(),
                        course.getProfesor().getId(), course.getAn()));
                courseWriter.newLine();

                // Writing grades for this course
                HashMap<Integer, Integer> courseGrades = gradesMap.get(course.getId());
                if (courseGrades != null) {
                    for (Map.Entry<Integer, Integer> gradeEntry : courseGrades.entrySet()) {
                        gradesWriter.write(String.format("%d,%d,%d",
                                course.getId(), gradeEntry.getKey(), gradeEntry.getValue()));
                        gradesWriter.newLine();
                    }
                }
            }

        } catch (IOException e) {
            System.out.println("Error writing to courses or grades file: " + e.getMessage());
        }
    }
}