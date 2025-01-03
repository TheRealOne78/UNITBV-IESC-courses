package org.UI;

import java.io.Console;
import java.util.*;

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
    //private FileDataManager fileDataManager = new FileDataManager(); // Assumes you have this to handle file reading.
    //private Map<String, User> users = new HashMap<>(); // To store users by username.

    @Override
    public void run() {
        home();
    }

    public void home() {
        while (true) {
            clear();

            System.out.print("== HOME DASHBOARD ==\n" +
                             "********************\n\n" +
                             "Selecteaza actiune (input nr):\n" +
                             "1. Login\n" +
                             "2. Register\n" +
                             "3. Close\n" +
                             "[ 1 | 2 | 3 ]> ");
            String input = scanner.nextLine();

            if (input.equals("1")) {
                login();
            } else if (input.equals("2")) {
                register();
            } else if (input.equals("3")) {
                System.exit(0);
            }
        }
    }

    public void login() {
        clear();

        System.out.print("Introduceti username: ");
        String username = scanner.nextLine();

        String passw     = new String(console.readPassword("Introduceti parola: "));

        //User user = users.get(username);
        //if (user != null && user.password.equals(password)) {
        //    if (user instanceof Student) {
        //        dashStudent((Student) user);
        //    } else if (user instanceof Profesor) {
        //        dashProf((Profesor) user);
        //    }
        //} else {
        //    System.out.println("Username sau parola incorecte. Te rog sa incerci din nou.");
        //}
    }

    public void register() {
        while (true) {
            clear();

            System.out.print("== INREGISTRARE ==\n" +
                             "******************\n\n" +
                             "Inregistrare ca: \n" +
                             "1. Student\n" +
                             "2. Profesor\n" +
                             "[ 1 | 2 ]> ");
            String input = scanner.nextLine();

            if (input.equals("1")) {
                registerStudent();
                break;
            } else if (input.equals("2")) {
                registerProfesor();
                break;
            }
        }
    }

    public void registerStudent() {
        clear();

        System.out.print("Introduceti username: ");
        String username = scanner.nextLine();

        String passw     = new String(console.readPassword("Introduceti parola: "));
        String passw_cnf = new String(console.readPassword("Confirmati parola: "));

        if(! passw.equals(passw_cnf)) {
            System.out.println("\nParola diferita fata de prima parola!");
            System.out.println("Apasati 'Return' pentru a iesi in meniul principal...");
            scanner.nextLine();
        }

        System.out.print("Introduceti anul universitar: ");
        int year = Integer.parseInt(scanner.nextLine());

        //if (!users.containsKey(username)) {
        //    users.put(username, new Student(username, password, year));
        //    System.out.println("Inregistrare cu succes!");
        //} else {
        //    System.out.println("Username deja existent. Incearca un altul.");
        //}
    }

    public void registerProfesor() {
        clear();

        System.out.print("Introduceti username: ");
        String username = scanner.nextLine();

        String passw     = new String(console.readPassword("Introduceti parola: "));
        String passw_cnf = new String(console.readPassword("Confirmati parola: "));

        if(! passw.equals(passw_cnf)) {
            System.out.println("\nParola diferita fata de prima parola!");
            System.out.println("Apasati 'Return' pentru a iesi in meniul principal...");
            scanner.nextLine();
        }

        //if (!users.containsKey(username)) {
        //    users.put(username, new Profesor(username, password));
        //    System.out.println("Inregistrare cu succes!");
        //} else {
        //    System.out.println("Username deja existent. Incearca un altul.");
        //}
    }

    public void dashStudent(Student student) {
        clear();

        while (true) {
            System.out.print("== DASHBOARD STUDENT ==\n" +
                             "***********************\n\n" +
                             "1. Vezi cursuri\n" +
                             "2. Media anului universitar\n" +
                             "3. Restante\n" +
                             "4. Log out\n" +
                             "[ 1 | 2 | 3 | 4 ]> ");

            String input = scanner.nextLine();
            if (input.equals("5")) {
                break;
            }
            // Handle other options based on your logic for each option
        }
    }
    public void dashProf(Profesor profesor) {
        clear();

        while (true) {
            System.out.print("== DASHBOARD PROFESOR ==\n" +
                             "************************\n\n" +
                             "1. Afiseaza cursuri\n" +
                             "2. Afiseaza studenti la curs\n" +
                             "3. Noteaza student\n" +
                             "4. Log out\n" +
                             "[ 1 | 2 | 3 | 4 ]> ");

            String input = scanner.nextLine();
            if (input.equals("4")) {
                break;
            }

            // Handle other options based on your logic for each option
        }
    }

    public void clear() {
        try {
            String os = System.getProperty("os.name");

            if (os.contains("Windows")) {
                // Windows system
                new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
            } else {
                // Unix/Linux/Mac system
                System.out.print("\033[H\033[2J");
                System.out.flush();
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }
}
