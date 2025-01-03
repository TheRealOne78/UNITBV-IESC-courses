package org.clase;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Set;

/**
 * This class is responsible for managing file operations related to students, professors, courses, and grades.
 * It reads data from CSV files to create and manage instances of Student, Profesor, and Curs objects.
 */
public class FileDataManager {
    /**
     * Creates a list of Student objects from a given CSV file.
     *
     * @param studentFile The file containing student data in CSV format.
     * @return A list of Student objects created from the data in the file.
     */
    protected void createStudentsData(HashMap<Integer, Student> studentsMap, File studentsFile) {
        try {
            BufferedReader br = new BufferedReader(new FileReader(studentsFile));
            String line = br.readLine(); // skip CSV header

            if (line != null) {
                line = br.readLine();
            }
            while (line != null) {
                String[] splituri = line.split(",");
                Student s = new Student(Integer.parseInt(splituri[0]),
                                        splituri[1].trim(),
                                        splituri[2],
                                        Integer.parseInt(splituri[3].trim()),
                                        splituri[4].trim(),
                                        splituri[5].trim(),
                                        splituri[6].trim());
                studentsMap.put(Integer.parseInt(splituri[0]), s);
                line = br.readLine();
            }

            br.close();

        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    /**
     * Creates a list of Profesor objects from a given CSV file.
     *
     * @param profesorFile The file containing professor data in CSV format.
     * @return A list of Profesor objects created from the data in the file.
     */
    protected void createProfesorData(HashMap<Integer, Profesor> professorsMap, File professorsFile) {
        try {
            BufferedReader br = new BufferedReader(new FileReader(professorsFile));
            String line = br.readLine(); // skip CSV header

            if (line != null) {
                line = br.readLine();
            }
            while (line != null) {
                String[] splituri = line.split(",");
                Profesor p = new Profesor(Integer.parseInt(splituri[0]),
                                          splituri[1].trim(),
                                          splituri[2],
                                          splituri[3].trim(),
                                          splituri[4].trim());
                professorsMap.put(Integer.parseInt(splituri[0]), p);
                line = br.readLine();
            }

            br.close();

        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    /**
     * Creates a list of Curs objects from the provided CSV files for courses and grades.
     *
     * @param profList A list of professors that might be assigned to courses.
     * @param studentList A list of students that might be enrolled in the courses.
     * @param courseFile The file containing course data in CSV format.
     * @param gradesFile The file containing grades data in CSV format.
     * @return A list of Curs objects created from the data in the files.
     */
    protected void
    createCoursesData(HashMap<Integer, Curs> coursesMap,
                      HashMap<Integer, Integer> gradesMap,
                      HashMap<Integer, Student> studentsMap,
                      HashMap<Integer, Profesor> professorsMap,
                      File coursesFile,
                      File gradesFile)
    {
        try {
            // === Curs ===
            BufferedReader br_course = new BufferedReader(new FileReader(coursesFile));
            String line = br_course.readLine(); // skip CSV header
            line = br_course.readLine(); // skip header

            if (line != null) {
                line = br_course.readLine();
            }
            while (line != null) {
                String[] splituri = line.split(",");

                Curs c = new Curs(Integer.parseInt(splituri[0]),
                                  splituri[1].trim(),
                                  splituri[2].trim(),
                                  getProfesorByID(Integer.parseInt(splituri[3])),
                                  getStudentsSetByID(Integer.parseInt(splituri[0])).iterator().next().getAn(),
                                  getStudentsSetByID(Integer.parseInt(splituri[0])),
                                  getNotaHashmapByIDs(Integer.parseInt(splituri[0]))
                                  );
                coursesMap.put(Integer.parseInt(splituri[0]), c);
                line = br_course.readLine();
            }

            br_course.close();

        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    /**
     * Retrieves a Student object by its ID from the list of students.
     *
     * @param id The ID of the student to retrieve.
     * @return The Student object that corresponds to the given ID.
     * @throws NoSuchElementException If no student with the given ID is found.
     */
    private Student getStudentByID(int id) {
        for (Student student : studentsMap) {
            if(student.getId() == id)
                return student;
        }
        throw new NoSuchElementException("Student cu ID " + id + " negasit");
    }

    /**
     * Retrieves a Profesor object by its ID from the list of professors.
     *
     * @param id The ID of the professor to retrieve.
     * @return The Profesor object that corresponds to the given ID.
     * @throws NoSuchElementException If no professor with the given ID is found.
     */
    private Profesor getProfesorByID(int id) {
        for (Profesor profesor : professorsMap) {
            if(profesor.getId() == id)
                return profesor;
        }
        throw new NoSuchElementException("Profesor cu ID " + id + " negasit");
    }

    /**
     * Retrieves a HashMap of students and their corresponding grades for a specific course by the course ID.
     *
     * @param idCurs The ID of the course for which to retrieve grades.
     * @param gradesFile The file containing grades data in CSV format.
     * @return A HashMap with students as keys and their grades as values.
     */
    private HashMap<Student, Integer> getNotaHashmapByIDs(int idCurs) {
        HashMap<Student, Integer> n = new HashMap<>();

        try {
            // === Grades ===
            BufferedReader br_grades = new BufferedReader(new FileReader(gradesFile));
            String line = br_grades.readLine(); // skip CSV header

            if (line != null)
                line = br_grades.readLine();

            while (line != null) {
                String[] splituri = line.split(",");
                if (Integer.parseInt(splituri[0]) == idCurs) {
                    n.put(getStudentByID(Integer.parseInt(splituri[1])), Integer.parseInt(splituri[2]));
                }
                line = br_grades.readLine();
            }

            br_grades.close();

        } catch (Exception ex) {
            System.out.println(ex);
        }

        return n;
    }

    /**
     * Retrieves a set of students enrolled in a course by the course ID.
     *
     * @param idCurs The ID of the course for which to retrieve the enrolled students.
     * @param gradesFile The file containing grades data in CSV format.
     * @return A set of students enrolled in the specified course.
     */
    private Set<Student> getStudentsSetByID(int idCurs) {
        Set<Student> s = new HashSet<>();

        try {
            // === Grades ===
            BufferedReader br_grades = new BufferedReader(new FileReader(gradesFile));
            String line = br_grades.readLine(); // skip CSV header

            if (line != null)
                line = br_grades.readLine();

            while (line != null) {
                String[] splituri = line.split(",");
                if (Integer.parseInt(splituri[0]) == idCurs) {
                    s.add(getStudentByID(Integer.parseInt(splituri[1])));
                }
                line = br_grades.readLine();
            }

            br_grades.close();

        } catch (Exception ex) {
            System.out.println(ex);
        }

        return s;
    }
}
