package org.UI;

import java.io.Console;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.Set;

import org.clase.Curs;
import org.clase.ManagerDate;
import org.clase.Profesor;
import org.clase.Student;

public class TUI extends Thread {
    private ManagerDate mgr;

    public TUI(ManagerDate mgr) {
        this.mgr = mgr;
    }

    private Scanner scanner = new Scanner(System.in);
    private Console console = System.console();

    @Override
    public void run() {
        home();
    }

    public void home() {
        while (true) {
            clear();
            System.out.print("== HOME DASHBOARD ==\n"           +
                             "********************\n\n"         +
                             "Selecteaza actiune (input nr):\n" +
                             "1. Login\n"                       +
                             "2. Register\n"                    +
                             "3. Inchide\n"                     +
                             "[ 1 | 2 | 3 ]> ");
            String input = scanner.nextLine();

            switch(input) {
                case "1":
                    login();
                    continue;
                case "2":
                    register();
                    continue;
                case "3":
                    System.exit(0);
            }
        }
    }

    public void login() {
        clear();

        System.out.print("Introdu username: ");
        String username = scanner.nextLine();

        String passw = new String(console.readPassword("Introdu parola: "));

        int userId = mgr.getStudentID(username, passw);
        if (userId == -1) {
            userId = mgr.getProfessorID(username, passw);
        }

        if (userId != -1) {
            char accountType = mgr.getAccountType(username, passw);
            if (accountType == 's') {
                dashStudent(userId); // Call the student dashboard
            } else if (accountType == 'p') {
                dashProf(userId); // Call the professor dashboard
            }
        } else {
            System.out.println("Username sau parola incorecte.");

            holdReturn();
        }
    }

    public void register() {
        while (true) {
            clear();
            System.out.print("== INREGISTRARE ==\n"   +
                             "******************\n\n" +
                             "Inregistrare ca: \n"    +
                             "1. Student\n"           +
                             "2. Profesor\n"          +
                             "3. Anulare\n"           +
                             "[ 1 | 2 | 3 ]> ");
            String input = scanner.nextLine();

            switch (input) {
                case "1":
                    registerStudent();
                    continue;
                case "2":
                    registerProfesor();
                    continue;
                case "3":
                    return;
            }
        }
    }

public void registerStudent() {
    clear();

    System.out.print("Introdu numele de familie: ");
    String surname = scanner.nextLine();

    System.out.print("Introdu prenumele: ");
    String forename = scanner.nextLine();

    System.out.print("Introdu username: ");
    String username = scanner.nextLine();

    String passw     = new String(console.readPassword("Introdu parola: "));
    String passw_cnf = new String(console.readPassword("Confirma parola: "));
    if (!passw.equals(passw_cnf)) {
        System.out.println("\nParolele nu coincid!");
        holdReturn();
        return;
    }

    System.out.print("Introdu anul universitar: ");
    int year = Integer.parseInt(scanner.nextLine());

    System.out.print("Introdu grupul: ");
    String group = scanner.nextLine();

    // Register the student
    mgr.registerStudent(surname, forename, year, username, passw, group);
    System.out.println("Student inregistrat.");

    holdReturn();
}

    public void registerProfesor() {
        clear();

        System.out.print("Introdu numele de familie: ");
        String surname = scanner.nextLine();

        System.out.print("Introdu prenumele: ");
        String forename = scanner.nextLine();

        System.out.print("Introdu username: ");
        String username = scanner.nextLine();

        String passw     = new String(console.readPassword("Introdu parola: "));
        String passw_cnf = new String(console.readPassword("Confirmati parola: "));

        if (!passw.equals(passw_cnf)) {
            System.out.println("\nParola diferita fata de prima parola!");

            holdReturn();
            return;
        }

        mgr.registerProfessor(surname, forename, username, passw);
        System.out.println("Profesor inregistrat cu succes!");

        holdReturn();
    }

    public void dashStudent(int studentId) {
        clear();
        Student student = mgr.getStudentById(studentId);

        while (true) {
            System.out.print("== DASHBOARD STUDENT ==\n"     +
                             "***********************\n\n"   +
                             "1. Vezi cursuri\n"             +
                             "2. Media anului universitar\n" +
                             "3. Restante\n"                 +
                             "4. Log out\n"                  +
                             "[ 1 | 2 | 3 | 4 ]> ");

            String input = scanner.nextLine();
            switch (input) {
                case "1":
                    viewCourses(student, promptYear());
                    continue;
                case "2":
                    viewYearAverage(student, promptYear());
                    continue;
                case "3":
                    viewFailedExams(student, promptYear());
                    continue;
                case "4":
                    return; // Logout
            }
        }
    }

    private void dashProf(int professorId) {
        clear();
        Profesor profesor = mgr.getProfessorById(professorId);

        while (true) {
            System.out.print("== DASHBOARD PROFESOR ==\n"     +
                             "************************\n\n"   +
                             "1. Afiseaza cursuri\n"          +
                             "2. Afiseaza studenti la curs\n" +
                             "3. Noteaza student\n"           +
                             "4. Creaza curs\n"               +
                             "5. Log out\n"                   +
                             "[ 1 | 2 | 3 | 4 | 5 ]> ");

            String input = scanner.nextLine();
            switch (input) {
            case "1":
                viewCourses(profesor);
                continue;
            case "2":
                viewStudentsAtCourse(profesor);
                continue;
            case "3":
                gradeStudent(profesor);
                continue;
            case "4":
                createCourse(profesor);
                continue;
            case "5":
                return; // Logout
            }
        }
    }

    private void createCourse(Profesor profesor) {
        clear();

        System.out.println("== CREARE CURS ==");
        System.out.println("*****************\n");

        System.out.print("Introdu numele cursului: ");
        String courseName = scanner.nextLine();

        System.out.print("Introdu descrierea cursului: ");
        String description = scanner.nextLine();

        System.out.print("Introdu anul cursului: ");
        int year = Integer.parseInt(scanner.nextLine());

        mgr.createCourse(courseName, description, profesor, year);
        System.out.println("Curs `" + courseName + "' creat cu succes");
        holdReturn();
    }

    private void viewStudentsAtCourse(Profesor profesor) {
        clear();

        List<Curs> courses = mgr.getProfessorCourses(profesor.getId());
        System.out.println("** Sudenti la curs ** \n");
        for (Curs c : courses) {
            System.out.println("Curs: " + c.getNume());
            Set<Student> students = c.getStudenti();
            students.forEach(s -> System.out.println("Id: "       + s.getId()       + " | " +
                                                     "Nume: "     + s.getNume()     + " | " +
                                                     "Prenume: "  + s.getPrenume()  + " | " +
                                                     "Username: " + s.getUsername() + " | " +
                                                     "An: "       + s.getAn()       + " | " +
                                                     "Grupa: "    + s.getGrupa()));
        }
        holdReturn();
    }

    private void gradeStudent(Profesor profesor) {
        clear();

        List<Curs> courses = mgr.getProfessorCourses(profesor.getId());
        if (courses.isEmpty()) {
            System.out.println("Niciun curs disponibil!");
            holdReturn();
            return;
        }

        System.out.println("Selecteaza cursul la care sa notezi:");
        for (int i = 0; i < courses.size(); i++) {
            System.out.println(i + 1 + ". " + courses.get(i).getNume());
        }

        int courseChoice = Integer.parseInt(scanner.nextLine()) - 1;
        if (courseChoice < 0 || courseChoice >= courses.size()) {
            System.out.println("Optiune invalida!");
            holdReturn();
            return;
        }
        Curs selectedCourse = courses.get(courseChoice);

        if (selectedCourse.getStudenti().isEmpty()) {
            System.out.println("Cursul `" + selectedCourse.getNume() + "' nu are studenti inscrisi.");
            holdReturn();
            return;
        }

        System.out.println("Selecteaza studentul pe care doresti sa-l notezi:");
        List<Student> students = new ArrayList<>(selectedCourse.getStudenti());
        for (int i = 0; i < students.size(); i++) {
            System.out.println(i + 1 + ". " + students.get(i).getUsername());
        }

        int studentChoice = Integer.parseInt(scanner.nextLine()) - 1;
        if (studentChoice < 0 || studentChoice >= students.size()) {
            System.out.println("Optiune invalida!");
            holdReturn();
            return;
        }
        Student selectedStudent = students.get(studentChoice);

        System.out.print("Introdu nota pentru studentul `" + selectedStudent.getUsername() + "': ");
        int grade = Integer.parseInt(scanner.nextLine());

        mgr.setGrade(selectedStudent.getId(), selectedCourse.getId(), grade);
        System.out.println("Succes!");
        holdReturn();
    }


    private int promptYear() {
        clear();

        System.out.print("Introdu anul pentru care doresti sa vezi datele: ");
        return Integer.parseInt(scanner.nextLine());
    }

    // Student
    private void viewCourses(Student student, int year) {
        clear();

        List<Curs> courses = mgr.getCoursesByYear(student.getId(), year);
        System.out.println("** Lista cursuri pentru anul `" + year + "' ** \n");
        courses.forEach(c -> System.out.println("Id: "   + c.getId()    + " | " +
                                                "Nume: " + c.getNume()  + "\n" +
                                                c.getDescriere() + "\n" +
                                                "------------------------------------------------------\n"));
        holdReturn();
    }

    // Professor
    private void viewCourses(Profesor profesor) {
        clear();

        List<Curs> courses = mgr.getProfessorCourses(profesor.getId());
        System.out.println("** Lista cursuri ** \n");
        courses.forEach(c -> System.out.println("Id: "   + c.getId()    + " | " +
                                                "Nume: " + c.getNume()  + " | " +
                                                "An: "   + c.getAn()    + "\n"  +
                                                c.getDescriere() + "\n" +
                                                "------------------------------------------------------\n"));
        holdReturn();
    }

    private void viewYearAverage(Student student, int year) {
        clear();

        double average = mgr.getStudentYearAverage(student.getId(), year);
        System.out.println("Media anului `" + year + "' " + average);
        holdReturn();
    }

    private void viewFailedExams(Student student, int year) {
        clear();

        List<Curs> failedCourses = mgr.getFailedExamsByYear(student.getId(), year);
        System.out.println("** Restante pentru anul `" + year + "' ** \n");
        failedCourses.forEach(c -> System.out.println("Id: "   + c.getId()    + " | " +
                                                      "Nume: " + c.getNume()  + " | " +
                                                      "An: "   + c.getAn()    + "\n"  +
                                                      c.getDescriere() + "\n" +
                                                      "------------------------------------------------------\n"));
        holdReturn();
    }

    private void clear() {
        System.out.print("\033[H\033[2J");
        System.out.flush();
    }

    private void holdReturn() {
        System.out.println("\nApasa enter pentru a continua...");
        scanner.nextLine();
        clear();
    }
}
