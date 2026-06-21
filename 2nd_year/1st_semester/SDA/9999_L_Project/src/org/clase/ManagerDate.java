package org.clase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.passwd.PasswdHasher;

public class ManagerDate {
    private ManagerCursuri managerCursuri;
    private PasswdHasher ph;

    public ManagerDate() {
        managerCursuri = new ManagerCursuri();
        ph = new PasswdHasher();
    }

    // Profesor
    public synchronized List<Curs> getCoursesByYear(int year) {
        List<Curs> coursesInYear = new ArrayList<>();

        // Borrow the courses from the ManagerCursuri
        for (Curs course : managerCursuri.getCoursesMap().values()) {
            if (course.getAn() == year) {
                coursesInYear.add(course);
            }
        }

        return coursesInYear;
    }

    // Student
    public synchronized List<Curs>
    getCoursesByYear(int studentId,
                     int year)
    {
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

    /**
     * Create a new course.
     *
     * @param courseName  The name of the course.
     * @param description The description of the course.
     * @param profesor    The professor teaching the course.
     * @param year        The year for which the course is created.
     */
    public synchronized void
    createCourse(String courseName,
                 String description,
                 Profesor profesor,
                 int year)
    {
        Set<Student> enrolledStudents = new HashSet<>();

        // Get all students for the specified year
        for (Student student : managerCursuri.getStudentsMap().values()) {
            if (student.getAn() == year) {
                enrolledStudents.add(student);
            }
        }

        managerCursuri.AddCurs(courseName,
                               description,
                               profesor,
                               year,
                               enrolledStudents,
                               new HashMap<>());
    }

    /**
     * Get the student ID based on the provided username and password.
     *
     * @param username The student's username.
     * @param password The student's password.
     * @return The account id, -1 if there is no match.
     */
    public synchronized int
    getStudentID(String username,
                 String password)
    {
        String encryptedPasswd = ph.hashPassword(password);

        for (Student student : managerCursuri.getStudentsMap().values()) {
            if (student.getUsername().equals(username) && student.getPassword().equals(encryptedPasswd)) {
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
    public synchronized int
    getProfessorID(String username,
                   String password)
    {
        String encryptedPasswd = ph.hashPassword(password);

        for (Profesor professor : managerCursuri.getProfessorsMap().values()) {
            if (professor.getUsername().equals(username) && professor.getPassword().equals(encryptedPasswd)) {
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
    public synchronized char
    getAccountType(String username,
                   String password)
    {
        String encryptedPasswd = ph.hashPassword(password);

        if (getProfessorID(username, encryptedPasswd) != -1) {
            return 'p'; // If it's a professor
        } else if (getStudentID(username, encryptedPasswd) != -1) {
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
    public synchronized boolean
    isRegistered(String username)
    {
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
     * Wrapper for ManagerCursuri.setGrade().
     *
     * @param studentID the student ID.
     * @param courseID  the course ID.
     * @param grade     the grade.
     */
    public synchronized void
    setGrade(int studentID,
             int courseID,
             int grade)
    {
        managerCursuri.setGrade(studentID, courseID, grade);
    }

    /**
     * Register a new student and enroll them in all courses for their year.
     *
     * @param surname  The surname (nume) to register the student as.
     * @param forename The forename (prenume) to register the student as.
     * @param year     The year the student should be registered to.
     * @param username The student's username.
     * @param password The student's password.
     * @param group    The group the student belongs to.
     */
    public synchronized void
    registerStudent(String surname,
                    String forename,
                    int year,
                    String username,
                    String password,
                    String group)
    {
        String encryptedPasswd = ph.hashPassword(password);

        int newId = generateNewStudentId();
        Student newStudent = new Student(newId,
                                         surname,
                                         forename,
                                         year,
                                         username,
                                         encryptedPasswd,
                                         group);

        managerCursuri.getStudentsMap().put(newId, newStudent);
        managerCursuri.writeStudents();

        List<Curs> allCourses = getCoursesByYear(year);
        for (Curs course : allCourses) {
            course.getStudenti().add(newStudent);
            managerCursuri.setGrade(newStudent.getId(), course.getId(), -1); // Default grade of -1 or null
            managerCursuri.writeCourses();
        }
    }

    /**
     * Register a new professor.
     *
     * @param surname  The surname (nume) to register the professor as.
     * @param forename The forename (prenume) to register the professor as.
     * @param username The professor's username.
     * @param password The professor's password.
     */
    public synchronized void
    registerProfessor(String surname,
                      String forename,
                      String username,
                      String password)
    {
        String encryptedPasswd = ph.hashPassword(password);

        int newId = generateNewProfessorId();
        Profesor newProfessor = new Profesor(newId,
                                             surname,
                                             forename,
                                             username,
                                             encryptedPasswd);

        managerCursuri.getProfessorsMap().put(newId, newProfessor);
        managerCursuri.writeProfessors();
    }

    /**
     * Get all courses a student is enrolled in.
     *
     * @param id The student's ID.
     * @return A list of courses the student is enrolled in.
     */
    public synchronized List<Curs>
    getStudentCourses(int id)
    {
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
    public synchronized List<Curs>
    getProfessorCourses(int id)
    {
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
    public synchronized HashMap<Curs, Integer>
    getStudentGrades(int id)
    {
        HashMap<Curs, Integer> studentGrades = new HashMap<>();
        Student student = managerCursuri.getStudentsMap().get(id);

        for (Curs curs : managerCursuri.getCoursesMap().values()) {
            if (curs.getStudenti().contains(student)) {
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

    public synchronized void
    enrollStudents(int courseId,
                   Set<Student> students)
    {
        Curs course = managerCursuri.getCoursesMap().get(courseId);
        course.getStudenti().addAll(students);
        managerCursuri.writeCourses();
    }

    public synchronized Student
    getStudentByUsername(String username)
    {
        for (Student student : managerCursuri.getStudentsMap().values()) {
            if (student.getUsername().equalsIgnoreCase(username)) {
                return student;
            }
        }
        return null; // Return null no student matches the username
    }

    /**
     * Get a list of courses where the student has failed exams.
     *
     * @param id The student's ID.
     * @return A list of courses where the student has failed.
     */
    public synchronized List<Curs>
    getStudentFailedExams(int id)
    {
        List<Curs> failedExams = new ArrayList<>();
        HashMap<Curs, Integer> grades = getStudentGrades(id);
        for (Curs curs : grades.keySet()) {
            if (grades.get(curs) < 5)
                failedExams.add(curs);
        }
        return failedExams;
    }

    public synchronized List<Curs>
    getFailedExamsByYear(int studentId,
                         int year)
    {
        List<Curs> failedExams = new ArrayList<>();
        HashMap<Curs, Integer> studentGrades = getStudentGrades(studentId);

        for (Curs curs : studentGrades.keySet()) {
            if (curs.getAn() == year && studentGrades.get(curs) < 5)
                failedExams.add(curs);
        }

        return failedExams;
    }

    public synchronized List<Curs>
    getCoursesByProfessorID(int professorId)
    {
        List<Curs> professorCourses = new ArrayList<>();
        List<Curs> allCourses       = managerCursuri.getCoursesMap().values().stream().toList();

        // Loop through all courses and filter by professor
        for (Curs course : allCourses) {
            if (course.getProfesor().getId() == professorId) {
                professorCourses.add(course);
            }
        }

        return professorCourses;
    }

    public synchronized Student
    getStudentById(int id)
    {
        return managerCursuri.getStudentsMap().get(id);
    }

    public synchronized Profesor
    getProfessorById(int id)
    {
        return managerCursuri.getProfessorsMap().get(id);
    }

    public synchronized float
    getStudentYearAverage(int studentId,
                          int year)
    {
        HashMap<Curs, Integer> studentGrades = getStudentGrades(studentId);
        if (studentGrades.isEmpty()) {
            return 0;
        }

        float totalGrades = 0;
        int count         = 0;

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

    /**
     * Generate a new unique ID for a student.
     *
     * @return The new student ID.
     */
    private synchronized int
    generateNewStudentId()
    {
        return managerCursuri.getStudentsMap().size() + 1;
    }

    /**
     * Generate a new unique ID for a professor.
     *
     * @return The new professor ID.
     */
    private synchronized int
    generateNewProfessorId()
    {
        return managerCursuri.getProfessorsMap().size() + 1;
    }
}
