package org.UI;

import java.awt.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.swing.*;
import org.clase.ManagerDate;
import org.clase.Curs;
import org.clase.Profesor;
import org.clase.Student;

public class GUI extends Thread {
    private ManagerDate mgr;

    public GUI(ManagerDate mgr) {
        this.mgr = mgr;
    }

    @Override
    public void run() {
        new HomeFrame(mgr).setVisible(true);
    }
}

class HomeFrame extends JFrame {
    public HomeFrame(ManagerDate mgr) {
        setTitle("Login");
        setSize(700, 320);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        JLabel lblImage = new JLabel(new ImageIcon("assets/javaimg.png"));
        JLabel lblUsername = new JLabel("Username:");
        JLabel lblPassword = new JLabel("Password:");
        JTextField txtUsername = new JTextField(15);
        JPasswordField txtPassword = new JPasswordField(15);
        JButton btnLogin = new JButton("Login");
        JButton btnRegister = new JButton("Register");
        JPanel pnlLogin = new JPanel();

        setLayout(new GridLayout(1, 2));
        add(lblImage);
        add(pnlLogin);

        pnlLogin.setLayout(new GridLayout(3, 2, 5, 5));
        pnlLogin.add(lblUsername);
        pnlLogin.add(txtUsername);
        pnlLogin.add(lblPassword);
        pnlLogin.add(txtPassword);
        pnlLogin.add(btnLogin);
        pnlLogin.add(btnRegister);

        btnLogin.addActionListener(e -> {
            String username = txtUsername.getText();
            String password = new String(txtPassword.getPassword());

            int userId = mgr.getStudentID(username, password);
            if (userId == -1) userId = mgr.getProfessorID(username, password);

            if (userId != -1) {
                char accountType = mgr.getAccountType(username, password);
                if (accountType == 's') {
                    new StudentDashboardFrame(mgr, mgr.getStudentById(userId)).setVisible(true);
                } else if (accountType == 'p') {
                    new ProfessorDashboardFrame(mgr, mgr.getProfessorById(userId)).setVisible(true);
                }
                dispose();
            } else {
                JOptionPane.showMessageDialog(this, "Date de logare invalide!");
            }
        });

        btnRegister.addActionListener(e -> {
            new RegisterFrame(mgr).setVisible(true);
            dispose();
        });
    }
}

class RegisterFrame extends JFrame {
    public RegisterFrame(ManagerDate mgr) {
        setTitle("Register");
        setSize(300, 200);
        setLocationRelativeTo(null);

        JLabel lblRole = new JLabel("Înregistrează ca:");
        JButton btnStudent = new JButton("Student");
        JButton btnProfessor = new JButton("Profesor");

        setLayout(new GridLayout(3, 1));
        add(lblRole);
        add(btnStudent);
        add(btnProfessor);

        btnStudent.addActionListener(e -> {
            new RegisterStudentFrame(mgr).setVisible(true);
            dispose();
        });

        btnProfessor.addActionListener(e -> {
            new RegisterProfessorFrame(mgr).setVisible(true);
            dispose();
        });
    }
}

class RegisterStudentFrame extends JFrame {
    public RegisterStudentFrame(ManagerDate mgr) {
        setTitle("Student Registration");
        setSize(400, 300);
        setLocationRelativeTo(null);

        JLabel lblSurname = new JLabel("Nume:");
        JLabel lblForename = new JLabel("Prenume:");
        JLabel lblUsername = new JLabel("Username:");
        JLabel lblPassword = new JLabel("Parolă:");
        JLabel lblConfirmPassword = new JLabel("Confirmă parola:");
        JLabel lblYear = new JLabel("An:");
        JLabel lblGroup = new JLabel("Grupa:");
        JTextField txtSurname = new JTextField();
        JTextField txtForename = new JTextField();
        JTextField txtUsername = new JTextField();
        JPasswordField txtPassword = new JPasswordField();
        JPasswordField txtConfirmPassword = new JPasswordField();
        JTextField txtYear = new JTextField();
        JTextField txtGroup = new JTextField();
        JButton btnRegister = new JButton("Înregistrează");

        setLayout(new GridLayout(8, 2));
        add(lblSurname); add(txtSurname);
        add(lblForename); add(txtForename);
        add(lblUsername); add(txtUsername);
        add(lblPassword); add(txtPassword);
        add(lblConfirmPassword); add(txtConfirmPassword);
        add(lblYear); add(txtYear);
        add(lblGroup); add(txtGroup);
        add(new JLabel()); add(btnRegister);

        btnRegister.addActionListener(e -> {
            String password = new String(txtPassword.getPassword());
            String confirmPassword = new String(txtConfirmPassword.getPassword());

            if (!password.equals(confirmPassword)) {
                JOptionPane.showMessageDialog(this, "Parolele nu coincid!");
                return;
            }

            mgr.registerStudent(
                txtSurname.getText(),
                txtForename.getText(),
                Integer.parseInt(txtYear.getText()),
                txtUsername.getText(),
                password,
                txtGroup.getText()
            );

            JOptionPane.showMessageDialog(this, "Student înregistrat.");
            new HomeFrame(mgr).setVisible(true);
            dispose();
        });
    }
}

class StudentDashboardFrame extends JFrame {
    private ManagerDate mgr;
    private Student student;

    public StudentDashboardFrame(ManagerDate mgr, Student student) {
        this.mgr = mgr;
        this.student = student;

        setTitle("Dashboard student - " + student.getUsername());
        setSize(500, 400);
        setLocationRelativeTo(null);

        JButton btnCourses = new JButton("Vezi cursuri");
        JButton btnGrades = new JButton("Vezi note");
        JButton btnFailedExams = new JButton("Vezi restante");
        JButton btnLogout = new JButton("Logout");

        setLayout(new GridLayout(4, 1));
        add(btnCourses);
        add(btnGrades);
        add(btnFailedExams);
        add(btnLogout);

        // View Courses Button
        btnCourses.addActionListener(e -> {
            int year = promptYear("Introdu an: ");
            viewCourses(year);
        });

        // View Grades Button
        btnGrades.addActionListener(e -> {
            int year = promptYear("Introdu an: ");
            viewGrades(year);
        });

        // View Failed Exams Button
        btnFailedExams.addActionListener(e -> {
            int year = promptYear("Introdu an: ");
            viewFailedExams(year);
        });

        // Logout Button
        btnLogout.addActionListener(e -> {
            new HomeFrame(mgr).setVisible(true);
            dispose();
        });
    }

    private int promptYear(String message) {
        String yearInput = JOptionPane.showInputDialog(this, message);
        try {
            return Integer.parseInt(yearInput);
        } catch (NumberFormatException ex) {
            JOptionPane.showMessageDialog(this, "An invalid!");
            return -1;
        }
    }

    private void viewCourses(int year) {
        if (year == -1) return;  // Exit if invalid year

        List<Curs> courses = mgr.getCoursesByYear(student.getId(), year);
        if (courses.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Niciun curs găsit.");
        } else {
            StringBuilder courseList = new StringBuilder("** Cursuri pentru anul " + year + " **\n");
            for (Curs c : courses) {
                courseList.append("Id: ").append(c.getId())
                        .append(" | Nume: ").append(c.getNume())
                        .append("\nDescriere: ").append(c.getDescriere())
                        .append("\n-----------------------------------------\n");
            }
            JOptionPane.showMessageDialog(this, courseList.toString());
        }
    }

    private void viewGrades(int year) {
        if (year == -1) return;  // Exit if invalid year

        double average = mgr.getStudentYearAverage(student.getId(), year);
        JOptionPane.showMessageDialog(this, "Media anului " + year + ": " + average);
    }

    private void viewFailedExams(int year) {
        if (year == -1) return;  // Exit if invalid year

        List<Curs> failedCourses = mgr.getFailedExamsByYear(student.getId(), year);
        if (failedCourses.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Nicio restanță pentru anul acesta.");
        } else {
            StringBuilder failedCourseList = new StringBuilder("** Restanțe an " + year + " **\n");
            for (Curs c : failedCourses) {
                failedCourseList.append("Id: ").append(c.getId())
                        .append(" | Nume: ").append(c.getNume())
                        .append("\nDescriere: ").append(c.getDescriere())
                        .append("\n-----------------------------------------\n");
            }
            JOptionPane.showMessageDialog(this, failedCourseList.toString());
        }
    }
}

class RegisterProfessorFrame extends JFrame {
    public RegisterProfessorFrame(ManagerDate mgr) {
        setTitle("Înregistrare profesor");
        setSize(400, 300);
        setLocationRelativeTo(null);

        JLabel lblSurname = new JLabel("Nume:");
        JLabel lblForename = new JLabel("Prenume:");
        JLabel lblUsername = new JLabel("Username:");
        JLabel lblPassword = new JLabel("Parolă:");
        JLabel lblConfirmPassword = new JLabel("Confirmă parolă:");
        JTextField txtSurname = new JTextField();
        JTextField txtForename = new JTextField();
        JTextField txtUsername = new JTextField();
        JPasswordField txtPassword = new JPasswordField();
        JPasswordField txtConfirmPassword = new JPasswordField();
        JButton btnRegister = new JButton("Înregistrează");

        setLayout(new GridLayout(6, 2));
        add(lblSurname); add(txtSurname);
        add(lblForename); add(txtForename);
        add(lblUsername); add(txtUsername);
        add(lblPassword); add(txtPassword);
        add(lblConfirmPassword); add(txtConfirmPassword);
        add(new JLabel()); add(btnRegister);

        btnRegister.addActionListener(e -> {
            String password = new String(txtPassword.getPassword());
            String confirmPassword = new String(txtConfirmPassword.getPassword());

            if (!password.equals(confirmPassword)) {
                JOptionPane.showMessageDialog(this, "Parolele nu coincid.");
                return;
            }

            mgr.registerProfessor(
                txtSurname.getText(),
                txtForename.getText(),
                txtUsername.getText(),
                password
            );

            JOptionPane.showMessageDialog(this, "Profesor înregistrat.");
            new HomeFrame(mgr).setVisible(true);
            dispose();
        });
    }
}
class ProfessorDashboardFrame extends JFrame {
    public ProfessorDashboardFrame(ManagerDate mgr, Profesor professor) {
        setTitle("Professor Dashboard - " + professor.getUsername());
        setSize(600, 500);
        setLocationRelativeTo(null);

        JButton btnViewCourses  = new JButton("View Courses");
        JButton btnViewStudents = new JButton("View Students at Course");
        JButton btnGradeStudent = new JButton("Grade Student");
        JButton btnCreateCourse = new JButton("Create Course");
        JButton btnLogout       = new JButton("Logout");

        setLayout(new GridLayout(5, 1));
        add(btnViewCourses);
        add(btnViewStudents);
        add(btnGradeStudent);
        add(btnCreateCourse);
        add(btnLogout);

        // View courses button
        btnViewCourses.addActionListener(e -> {
            List<Curs> courses = mgr.getProfessorCourses(professor.getId());
            StringBuilder courseList = new StringBuilder("** Cursuri **\n");
            for (Curs c : courses) {
                courseList.append("Id: ").append(c.getId())
                        .append(" | Nume: ").append(c.getNume())
                        .append(" | An: ").append(c.getAn())
                        .append("\n").append(c.getDescriere()).append("\n\n");
            }
            JOptionPane.showMessageDialog(this, courseList.toString());
        });

        // View students button
        btnViewStudents.addActionListener(e -> {
            List<Curs> courses = mgr.getProfessorCourses(professor.getId());
            StringBuilder studentsInfo = new StringBuilder("** Studenți la curs **\n");
            for (Curs c : courses) {
                studentsInfo.append("Curs: ").append(c.getNume()).append("\n");
                Set<Student> students = c.getStudenti();
                students.forEach(s -> studentsInfo.append("ID: ").append(s.getId())
                        .append(" | Nume: ").append(s.getNume())
                        .append(" | Grup: ").append(s.getGrupa())
                        .append("\n"));
                studentsInfo.append("\n");
            }
            JOptionPane.showMessageDialog(this, studentsInfo.toString());
        });

        // Grade student button
        btnGradeStudent.addActionListener(e -> {
            List<Curs> courses = mgr.getProfessorCourses(professor.getId());
            if (courses.isEmpty()) {
                JOptionPane.showMessageDialog(this, "Niciun curs disponibil.");
                return;
            }

            StringBuilder courseChoiceMessage = new StringBuilder("Selectează curs:\n");
            for (int i = 0; i < courses.size(); i++) {
                courseChoiceMessage.append(i + 1).append(". ").append(courses.get(i).getNume()).append("\n");
            }

            String input = JOptionPane.showInputDialog(this, courseChoiceMessage.toString());
            int courseChoice = Integer.parseInt(input) - 1;

            if (courseChoice < 0 || courseChoice >= courses.size()) {
                JOptionPane.showMessageDialog(this, "Alegere invalidă!");
                return;
            }

            Curs selectedCourse = courses.get(courseChoice);
            Set<Student> students = selectedCourse.getStudenti();
            if (students.isEmpty()) {
                JOptionPane.showMessageDialog(this, "Niciun student înrolat în curs.");
                return;
            }

            StringBuilder studentChoiceMessage = new StringBuilder("Selectează un student:\n");
            int studentIndex = 1;
            for (Student s : students) {
                studentChoiceMessage.append(studentIndex++).append(". ").append(s.getUsername()).append("\n");
            }

            input = JOptionPane.showInputDialog(this, studentChoiceMessage.toString());
            int studentChoice = Integer.parseInt(input) - 1;

            if (studentChoice < 0 || studentChoice >= students.size()) {
                JOptionPane.showMessageDialog(this, "Alegere invalidă!");
                return;
            }

            Student selectedStudent = new ArrayList<>(students).get(studentChoice);
            String gradeInput = JOptionPane.showInputDialog(this, "Notează pe" + selectedStudent.getUsername() + ":");
            int grade = Integer.parseInt(gradeInput);

            mgr.setGrade(selectedStudent.getId(), selectedCourse.getId(), grade);
            JOptionPane.showMessageDialog(this, "Notat cu succes");
        });

        // Create course button
        btnCreateCourse.addActionListener(e -> {
            String courseName = JOptionPane.showInputDialog(this, "Introdu numele cursului:");
            String courseDescription = JOptionPane.showInputDialog(this, "Introdu descrierea cursului:");
            String yearInput = JOptionPane.showInputDialog(this, "Introdu anul cursului:");
            int year = Integer.parseInt(yearInput);

            mgr.createCourse(courseName, courseDescription, professor, year);
            JOptionPane.showMessageDialog(this, "Curs creat cu succes.");
        });

        // Logout button
        btnLogout.addActionListener(e -> {
            new HomeFrame(mgr).setVisible(true);
            dispose();
        });
    }
}
