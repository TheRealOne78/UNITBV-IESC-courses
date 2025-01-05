package org.clase;

import java.io.File;
import java.util.HashMap;

/**
 * The ManagerCursCSV class is responsible for managing and handling data
 * related to students, professors, and courses.  It reads data from CSV files
 * and populates the necessary collections with that data.
 */
public class ManagerCursCSV extends FileDataManager {
    protected HashMap<Integer, Curs>     coursesMap    = new HashMap<>();
    protected HashMap<Integer, Student>  studentsMap   = new HashMap<>();
    protected HashMap<Integer, Profesor> professorsMap = new HashMap<>();
    protected HashMap<Integer, HashMap<Integer, Integer>> gradesMap = new HashMap<>();
    protected File studentsFile, professorsFile, coursesFile, gradesFile;
    protected FileDisplay csvwriter = new FileDisplay();

    /**
     * Default constructor. Initializes the file paths for students, professors,
     * courses, and grades.  The paths are hardcoded as "studenti.txt",
     * "profesori.txt", "cursuri.txt", and "note.txt".
     */
    public ManagerCursCSV() {
        try {
            studentsFile   = new File("studenti.txt");
            professorsFile = new File("profesori.txt");
            coursesFile    = new File("cursuri.txt");
            gradesFile     = new File("note.txt");
        } catch (Exception ex) {
            System.out.println(ex);
        }

        populeazaDate();
    }

    /**
     * Constructor that allows for custom file paths to be passed in for
     * students, professors, courses, and grades.
     *
     * @param studentsFile   The file containing student data.
     * @param professorsFile The file containing professor data.
     * @param coursesFile    The file containing course data.
     * @param gradesFile     The file containing grade data.
     */
    public
    ManagerCursCSV(File studentsFile,
                   File professorsFile,
                   File coursesFile,
                   File gradesFile)
    {
        this.studentsFile   = studentsFile;
        this.professorsFile = professorsFile;
        this.coursesFile    = coursesFile;
        this.gradesFile     = gradesFile;

        populeazaDate();
    }


    /**
     * Populates the required data from all the CSV files.
     */
    private synchronized void populeazaDate() {
        createStudentsData(studentsMap, studentsFile);
        createProfesorData(professorsMap, professorsFile);
        createCoursesData(coursesMap,
                          gradesMap,
                          studentsMap,
                          professorsMap,
                          coursesFile,
                          gradesFile);
    }

    /**
     * Populates the student list by reading data from the "studenti.txt" file.
     *
     * @deprecated Deprecated in favor of populeazaDate.
     */
    @Deprecated
    private synchronized void populeazaStudenti() { // NOTE:DEPRECATED: REDUNDANT
        createStudentsData(studentsMap, studentsFile);
    }

    /**
     * Populates the professor list by reading data from the "profesori.txt"
     * file.
     *
     * @deprecated Deprecated in favor of populeazaDate.
     */
    @Deprecated
    private synchronized void populeazaProfesori() { // NOTE:DEPRECATED: REDUNDANT
        createProfesorData(professorsMap, professorsFile);
    }

    /**
     * Populates the course list by reading data from the "cursuri.txt" file and
     * "note.txt" file.
     *
     * @deprecated Deprecated in favor of populeazaDate.
     */
    @Deprecated
    private synchronized void populeazaCursuri() { // NOTE:DEPRECATED: REDUNDANT
        createCoursesData(coursesMap,
                          gradesMap,
                          studentsMap,
                          professorsMap,
                          coursesFile,
                          gradesFile);
    }

    /**
     * Method for writing student data back to the file.
     */
    public synchronized void writeStudents() {
        this.csvwriter.displayStudents(studentsMap, studentsFile);
    }

    /**
     * Method for writing professor data back to the file.
     */
    public synchronized void writeProfessors() {
        this.csvwriter.displayTeachers(professorsMap, professorsFile);
    }

    /**
     * Method for writing course data back to the file.
     */
    public synchronized void writeCourses() {
        this.csvwriter.displayCoursesAndGrades(coursesMap, gradesMap, coursesFile, gradesFile);
    }

    /**
     * Method for writing grade data back to the file.
     */
    public synchronized void writeGrades() {
        writeCourses();
    }

    public synchronized HashMap<Integer, Curs> getCoursesMap() {
        return coursesMap;
    }

    public synchronized HashMap<Integer, Student> getStudentsMap() {
        return studentsMap;
    }

    public synchronized HashMap<Integer, Profesor> getProfessorsMap() {
        return professorsMap;
    }

    public synchronized HashMap<Integer, HashMap<Integer, Integer>> getGradesMap() {
        return gradesMap;
    }

}
