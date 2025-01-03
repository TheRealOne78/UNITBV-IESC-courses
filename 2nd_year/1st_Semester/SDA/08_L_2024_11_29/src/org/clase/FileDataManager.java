package org.clase;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class FileDataManager {

    protected synchronized void
    createStudentsData(HashMap<Integer, Student> studentsMap,
                       File studentsFile)
    {
        try (BufferedReader br = new BufferedReader(new FileReader(studentsFile))) {
            br.readLine(); // Skip CSV header

            String line;
            while ((line = br.readLine()) != null) {
                String[] fields = line.split(",");
                int id = Integer.parseInt(fields[0].trim());
                Student student = new Student(id,
                                              fields[1].trim(),
                                              fields[2].trim(),
                                              Integer.parseInt(fields[3].trim()),
                                              fields[4].trim(),
                                              fields[5].trim(),
                                              fields[6].trim());

                studentsMap.put(id, student);
            }
        } catch (Exception ex) {
            System.out.println("Eroare la incarcare studenti: " + ex.getMessage());
        }
    }

    protected synchronized void
    createProfesorData(HashMap<Integer, Profesor> professorsMap,
                       File professorsFile)
    {
        try (BufferedReader br = new BufferedReader(new FileReader(professorsFile))) {
            br.readLine(); // Skip CSV header

            String line;
            while ((line = br.readLine()) != null) {
                String[] fields = line.split(",");
                int id = Integer.parseInt(fields[0].trim());
                Profesor profesor = new Profesor(id,
                                                 fields[1].trim(),
                                                 fields[2].trim(),
                                                 fields[3].trim(),
                                                 fields[4].trim());
                professorsMap.put(id, profesor);
            }
        } catch (Exception ex) {
            System.out.println("Eroare la incarcare profesori: " + ex.getMessage());
        }
    }

    protected synchronized void
    createCoursesData(HashMap<Integer, Curs> coursesMap,
                      HashMap<Integer, HashMap<Integer, Integer>> gradesMap,
                      HashMap<Integer, Student> studentsMap,
                      HashMap<Integer, Profesor> professorsMap,
                      File coursesFile,
                      File gradesFile)
    {
        try (BufferedReader br = new BufferedReader(new FileReader(coursesFile))) {
            getNotaHashmap(gradesMap, gradesFile);
            br.readLine(); // Skip CSV header

            String line;
            while ((line = br.readLine()) != null) {
                String[] fields = line.split(",");
                int courseId = Integer.parseInt(fields[0].trim());

                Curs course = new Curs(courseId,
                                       fields[1].trim(),
                                       fields[2].trim(),
                                       professorsMap.get(Integer.parseInt(fields[3].trim())), // Professor
                                       Integer.parseInt(fields[4].trim()), // Year
                                       getStudentsSetByID(gradesMap, studentsMap, courseId), // Students
                                       getNotaHashmapByIDs(gradesMap, studentsMap, courseId) // Grades
                );
                coursesMap.put(courseId, course);
            }
        } catch (Exception ex) {
            System.out.println("Eroare la incarcare cursuri " + ex.getMessage());
        }
    }

    private synchronized void
    getNotaHashmap(HashMap<Integer, HashMap<Integer, Integer>> gradesMap,
                   File gradesFile)
    {
        try (BufferedReader br = new BufferedReader(new FileReader(gradesFile))) {
            br.readLine(); // Skip CSV header

            String line;
            while ((line = br.readLine()) != null) {
                String[] fields = line.split(",");
                int courseId    = Integer.parseInt(fields[0].trim());
                int studentId   = Integer.parseInt(fields[1].trim());
                int grade       = Integer.parseInt(fields[2].trim());

                gradesMap
                        .computeIfAbsent(courseId, k -> new HashMap<>())
                        .put(studentId, grade);
            }
        } catch (Exception ex) {
            System.out.println("Eroare la incarcare note: " + ex.getMessage());
        }
    }

    private synchronized HashMap<Student, Integer>
    getNotaHashmapByIDs(HashMap<Integer, HashMap<Integer, Integer>> gradesMap,
                        HashMap<Integer, Student> studentsMap,
                        int courseId)
    {
        HashMap<Student, Integer> result = new HashMap<>();

        HashMap<Integer, Integer> courseGrades = gradesMap.get(courseId);
        if (courseGrades != null) {
            courseGrades.forEach((studentId, grade) -> {
                Student student = studentsMap.get(studentId);
                if (student != null)
                    result.put(student, grade);
            });
        }

        return result;
    }

    private synchronized Set<Student>
    getStudentsSetByID(HashMap<Integer, HashMap<Integer, Integer>> gradesMap,
                       HashMap<Integer, Student> studentsMap,
                       int courseId)
    {
        Set<Student> studentSet = new HashSet<>();

        HashMap<Integer, Integer> courseGrades = gradesMap.get(courseId);
        if (courseGrades != null) {
            courseGrades.keySet().forEach(studentId -> {
                Student student = studentsMap.get(studentId);
                if (student != null)
                    studentSet.add(student);
            });
        }

        return studentSet;
    }
}
