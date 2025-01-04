package org.clase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

public class ManagerDate {
    private ManagerCursuri managerCursuri;

    public ManagerDate() {
        managerCursuri = new ManagerCursuri();
    }

    public List<Curs> getCoursesByYear(int year) {
        List<Curs> coursesInYear = new ArrayList<>();

        // Get all the courses from the ManagerCursuri class (assuming it's stored in a map or list)
        for (Curs course : managerCursuri.getCoursesMap().values()) {
            if (course.getAn() == year) {
                coursesInYear.add(course);
            }
        }

        return coursesInYear;
    }

    public List<Curs> getCoursesByYear(int studentId, int year) {
        List<Curs> coursesInYear = new ArrayList<>();

        // Get all the courses the student is enrolled in
        List<Curs> studentCourses = getStudentCourses(studentId);

        // Filter courses by the given year
        for (Curs course : studentCourses) {
            if (course.getAn() == year) {
                coursesInYear.add(course);
            }
        }

        return coursesInYear;
    }

    public void createCourse(String courseName,
                             String description,
                             Profesor profesor,
                             int year,
                             Set<Student> students,
                             HashMap<Student, Integer> grades)
    {
        managerCursuri.AddCurs(courseName,
                               description,
                               profesor,
                               year,
                               students,
                               grades);
    }

    /**
     * Get the student ID based on the provided username and password.
     *
     * @param username The student's username.
     * @param password The student's password.
     * @return The account id, -1 if there is no match.
     */
    public int getStudentID(String username, String password) {
        for (Student student : managerCursuri.getStudentsMap().values()) {
            if (student.getUsername().equals(username) && student.getPassword().equals(password)) {
                return student.getId();
            }
        }
        return -1; // If no match is found
    }

    /**
     * Get the professor ID based on the provided username and password.
     *
     * @param username The professor's username.
     * @param password The professor's password.
     * @return The account id, -1 if there is no match.
     */
    public int getProfessorID(String username, String password) {
        for (Profesor professor : managerCursuri.getProfessorsMap().values()) {
            if (professor.getUsername().equals(username) && professor.getPassword().equals(password)) {
                return professor.getId();
            }
        }
        return -1; // If no match is found
    }

    /**
     * Get the account type based on the username and password.
     *
     * @param username The account's username.
     * @param password The account's password.
     * @return 'p' if professor account, 's' if student account.
     */
    public char getAccountType(String username, String password) {
        if (getProfessorID(username, password) != -1) {
            return 'p'; // If it's a professor
        } else if (getStudentID(username, password) != -1) {
            return 's'; // If it's a student
        }
        return ' '; // Return space if no match found
    }

    /**
     * Check if the username is registered.
     *
     * @param username A string with the username (Eg. someone@example.com).
     * @return true if someone is registered with the provided username, false otherwise.
     */
    public boolean isRegistered(String username) {
        for (Student student : managerCursuri.getStudentsMap().values()) {
            if (student.getUsername().equals(username)) {
                return true;
            }
        }
        for (Profesor professor : managerCursuri.getProfessorsMap().values()) {
            if (professor.getUsername().equals(username)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Register a new student.
     *
     * @param surname  The surname (nume) to register the student as.
     * @param forename The forename (prenume) to register the student as.
     * @param year     The year the student should be registered to.
     * @param username The student's username.
     * @param password The student's password.
     * @param group    The group the student belongs to.
     */
    public void registerStudent(String surname, String forename, int year, String username, String password, String group) {
        int newId = generateNewStudentId(); // Generate a new ID for the student
        Student newStudent = new Student(newId, surname, forename, year, username, password, group);

        managerCursuri.getStudentsMap().put(newId, newStudent);
        managerCursuri.writeStudents();
    }

    /**
     * Register a new professor.
     *
     * @param surname  The surname (nume) to register the professor as.
     * @param forename The forename (prenume) to register the professor as.
     * @param username The professor's username.
     * @param password The professor's password.
     */
    public void registerProfessor(String surname, String forename, String username, String password) {
        int newId = generateNewProfessorId(); // Generate a new ID for the professor
        Profesor newProfessor = new Profesor(newId, surname, forename, username, password);

        managerCursuri.getProfessorsMap().put(newId, newProfessor);
        managerCursuri.writeProfessors();
    }

    /**
     * Get all courses a student is enrolled in.
     *
     * @param id The student's ID.
     * @return A list of courses the student is enrolled in.
     */
    public List<Curs> getStudentCourses(int id) {
        List<Curs> studentCourses = new ArrayList<>();
        for (Curs curs : managerCursuri.getCoursesMap().values()) {
            if (curs.getStudenti().contains(managerCursuri.getStudentsMap().get(id))) {
                studentCourses.add(curs);
            }
        }
        return studentCourses;
    }

    /**
     * Get all courses a professor is teaching.
     *
     * @param id The professor's ID.
     * @return A list of courses the professor is teaching.
     */
    public List<Curs> getProfessorCourses(int id) {
        List<Curs> professorCourses = new ArrayList<>();
        for (Curs curs : managerCursuri.getCoursesMap().values()) {
            if (curs.getProfesor().equals(managerCursuri.getProfessorsMap().get(id))) {
                professorCourses.add(curs);
            }
        }
        return professorCourses;
    }

    /**
     * Get the grades for all courses a student is enrolled in.
     *
     * @param id The student's ID.
     * @return A map of courses and the student's grades.
     */
    public HashMap<Curs, Integer> getStudentGrades(int id) {
        HashMap<Curs, Integer> studentGrades = new HashMap<>();
        // Get the student object using the ID
        Student student = managerCursuri.getStudentsMap().get(id);

        // Loop through the courses and check if the student is enrolled
        for (Curs curs : managerCursuri.getCoursesMap().values()) {
            if (curs.getStudenti().contains(student)) {
                // Retrieve the grade using the courseId and studentId
                Integer grade = managerCursuri.getGradesMap()
                    .get(curs.getId())  // Outer map (by courseId)
                    .get(id);           // Inner map (by studentId)

                if (grade != null) {
                    studentGrades.put(curs, grade);
                }
            }
        }
        return studentGrades;
    }

    public void enrollStudents(int courseId, Set<Student> students) {
        Curs course = managerCursuri.getCoursesMap().get(courseId);
        course.getStudenti().addAll(students);
        managerCursuri.writeCourses();
    }

    public Student getStudentByUsername(String username) {
        for (Student student : managerCursuri.getStudentsMap().values()) {
            if (student.getUsername().equalsIgnoreCase(username)) {
                return student;
            }
        }
        return null; // Return null if no student matches the username
    }

    /**
     * Get a list of courses where the student has failed exams.
     *
     * @param id The student's ID.
     * @return A list of courses where the student has failed.
     */
    public List<Curs> getStudentFailedExams(int id) {
        List<Curs> failedExams = new ArrayList<>();
        HashMap<Curs, Integer> grades = getStudentGrades(id);
        for (Curs curs : grades.keySet()) {
            if (grades.get(curs) < 5) {
                failedExams.add(curs);
            }
        }
        return failedExams;
    }

    public List<Curs> getFailedExamsByYear(int studentId, int year) {
        List<Curs> failedExams = new ArrayList<>();
        HashMap<Curs, Integer> studentGrades = getStudentGrades(studentId);

        for (Curs curs : studentGrades.keySet()) {
            if (curs.getAn() == year && studentGrades.get(curs) < 5) {
                failedExams.add(curs);
            }
        }

        return failedExams;
    }

    public List<Curs> getCoursesByProfessorID(int professorId) {
        List<Curs> professorCourses = new ArrayList<>();
        List<Curs> allCourses = managerCursuri.getCoursesMap().values().stream().toList();

        // Loop through all courses and filter by professor
        for (Curs course : allCourses) {
            if (course.getProfesor().getId() == professorId) {
                professorCourses.add(course);
            }
        }

        return professorCourses;
    }

    public Student getStudentById(int id) {
        return managerCursuri.getStudentsMap().get(id);
    }

    public Profesor getProfessorById(int id) {
        return managerCursuri.getProfessorsMap().get(id);
    }

    public float getStudentYearAverage(int studentId, int year) {
        HashMap<Curs, Integer> studentGrades = getStudentGrades(studentId);
        if (studentGrades.isEmpty()) {
            return 0;
        }

        float totalGrades = 0;
        int count = 0;

        for (Curs course : studentGrades.keySet()) {
            if (course.getAn() == year) {
                Integer grade = studentGrades.get(course);

                if (grade != null && grade >= 1) {
                    totalGrades += grade;
                    count++;
                }
            }
        }

        return (count == 0) ? 0 : totalGrades / count;
    }

    public void setGrade(int studentId, int courseId, int grade) {
        HashMap<Integer, Integer> courseGrades = managerCursuri.getGradesMap().computeIfAbsent(courseId, k -> new HashMap<>());
        courseGrades.put(studentId, grade); // Set the student's grade for the course

        // Write the updated grades to the file
        managerCursuri.writeGrades();
    }

    /**
     * Generate a new unique ID for a student.
     *
     * @return The new student ID.
     */
    private int generateNewStudentId() {
        return managerCursuri.getStudentsMap().size() + 1; // Generate new ID based on the size of the map
    }

    /**
     * Generate a new unique ID for a professor.
     *
     * @return The new professor ID.
     */
    private int generateNewProfessorId() {
        return managerCursuri.getProfessorsMap().size() + 1; // Generate new ID based on the size of the map
    }
}
