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

public class FileDataManager {
    private List<Student> studentsList;
    private List<Profesor> profesorsList;

    protected List<Student> createStudentsData(File studentFile) {
        studentsList = new ArrayList<>();

        try {
            BufferedReader br = new BufferedReader(new FileReader(studentFile));
            String line = br.readLine(); // skip CSV header

            if (line != null) {
                line = br.readLine();
            }
            while (line != null) {
                String[] splituri = line.split(",");
                Student s = new Student(Integer.parseInt(splituri[0]),
                                        splituri[1].trim(), splituri[2],
                                        Integer.parseInt(splituri[3].trim()),
                                        splituri[4].trim(), splituri[5].trim(),
                                        splituri[6].trim());
                studentsList.add(s);
                line = br.readLine();
            }

            br.close();

        } catch (Exception ex) {
            System.out.println(ex);
        }

        return studentsList;
    }

    protected List<Profesor> createProfesorData(File profesorFile) {
        ArrayList<Profesor> tmp = new ArrayList<>();

        try {
            BufferedReader br = new BufferedReader(new FileReader(profesorFile));
            String line = br.readLine(); // skip CSV header

            if (line != null) {
                line = br.readLine();
            }
            while (line != null) {
                String[] splituri = line.split(",");
                Profesor p = new Profesor(Integer.parseInt(splituri[0]),
                                          splituri[1].trim(), splituri[2],
                                          splituri[3].trim(), splituri[4].trim());
                tmp.add(p);
                line = br.readLine();
            }

            br.close();

        } catch (Exception ex) {
            System.out.println(ex);
        }

        return tmp;
    }

    protected List<Curs> createCoursesData(List<Profesor> profList, List<Student> studentList, File courseFile, File gradesFile) {
        List<Curs> tmp = new ArrayList<>();

        try {
            // === Curs ===
            BufferedReader br_course = new BufferedReader(new FileReader(courseFile));
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
                                  getStudentsSetByID(Integer.parseInt(splituri[0]), gradesFile).iterator().next().getAn(),
                                  getStudentsSetByID(Integer.parseInt(splituri[0]), gradesFile),
                                  getNotaHashmapByIDs(Integer.parseInt(splituri[0]), gradesFile)
                                  );
                tmp.add(c);
                line = br_course.readLine();
            }

            br_course.close();

        } catch (Exception ex) {
            System.out.println(ex);
        }

        return tmp;
    }

    private Student getStudentByID(int id) {
        for (Student student : studentsList) {
            if(student.getId() == id)
                return student;
        }
        throw new NoSuchElementException("Student cu ID " + id + " negasit");
    }

    private Profesor getProfesorByID(int id) {
        for (Profesor profesor : profesorsList) {
            if(profesor.getId() == id)
                return profesor;
        }
        throw new NoSuchElementException("Profesor cu ID " + id + " negasit");

    }

    private HashMap<Student, Integer> getNotaHashmapByIDs(int idCurs, File gradesFile) {
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

    private Set<Student> getStudentsSetByID(int idCurs, File gradesFile) {
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
