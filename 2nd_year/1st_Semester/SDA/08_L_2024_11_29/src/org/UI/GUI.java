package org.UI;

import java.awt.GridLayout;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import org.clase.ManagerDate;

public class GUI extends Thread {
    private ManagerDate mgr;

    public GUI(ManagerDate mgr) {
        this.mgr = mgr;
    }

    public void run() {
        homeFrame frame = new homeFrame();
        frame.setVisible(true);
    }
}

class homeFrame extends JFrame {
    public homeFrame() {
        setTitle("Login");
        setSize(300, 200);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        // Components
        JLabel lblUsername         = new JLabel("Username:");
        JLabel lblPassword         = new JLabel("Password:");
        JTextField txtUsername     = new JTextField(15);
        JPasswordField txtPassword = new JPasswordField(15);
        JButton btnLogin           = new JButton("Login");
        JButton btnRegister        = new JButton("Register");

        // Layout
        setLayout(new GridLayout(3, 2));
        add(lblUsername);
        add(txtUsername);
        add(lblPassword);
        add(txtPassword);
        add(btnLogin);
        add(btnRegister);

        // Button Actions
        btnLogin.addActionListener(e -> {
            String username = txtUsername.getText();
            String password = new String(txtPassword.getPassword());
            // Authentication logic here (example checks)
            if (username.equals("student")) {
                new StudentDashboardFrame(username);
            } else if (username.equals("professor")) {
                new ProfessorDashboardFrame(username);
            } else {
                JOptionPane.showMessageDialog(this, "Invalid credentials!");
            }
            dispose(); // Close login frame
        });

        btnRegister.addActionListener(e -> {
            new RegisterFrame();
            dispose(); // Close login frame
        });

        setVisible(true);
    }
}

// === Register Frame ===
class RegisterFrame extends JFrame {
    public RegisterFrame() {
        setTitle("Register");
        setSize(300, 200);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        // Components
        JLabel lblRole       = new JLabel("Înregistrează ca:");
        JButton btnStudent   = new JButton("Student");
        JButton btnProfessor = new JButton("Professor");

        // Layout
        setLayout(new GridLayout(3, 1));
        add(lblRole);
        add(btnStudent);
        add(btnProfessor);

        // Button Actions
        btnStudent.addActionListener(e -> {
            JOptionPane.showMessageDialog(this, "Înregistrare student");
            // Open student registration form
        });

        btnProfessor.addActionListener(e -> {
            JOptionPane.showMessageDialog(this, "Înregistrare profesor");
            // Open professor registration form
        });

        setVisible(true);
    }
}

// === Student Dashboard Frame ===
class StudentDashboardFrame extends JFrame {
    public StudentDashboardFrame(String username) {
        setTitle("Student Dashboard - " + username);
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        // Components
        JLabel lblWelcome = new JLabel("Welcome, " + username);
        JButton btnViewCourses = new JButton("Vezi cursuri");
        JButton btnViewGrades = new JButton("Vezi note");
        JButton btnViewAverage = new JButton("Medie an");
        JButton btnViewRemainders = new JButton("Restante");

        // Layout
        setLayout(new GridLayout(5, 1));
        add(lblWelcome);
        add(btnViewCourses);
        add(btnViewGrades);
        add(btnViewAverage);
        add(btnViewRemainders);

        // Button Actions
        btnViewCourses.addActionListener(e -> JOptionPane.showMessageDialog(this, "List of courses..."));
        btnViewGrades.addActionListener(e -> JOptionPane.showMessageDialog(this, "List of grades..."));
        btnViewAverage.addActionListener(e -> JOptionPane.showMessageDialog(this, "Your average is..."));
        btnViewRemainders.addActionListener(e -> JOptionPane.showMessageDialog(this, "Your remainders are..."));

        setVisible(true);
    }
}

// === Professor Dashboard Frame ===
class ProfessorDashboardFrame extends JFrame {
    public ProfessorDashboardFrame(String username) {
        setTitle("Professor Dashboard - " + username);
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        // Components
        JLabel lblWelcome = new JLabel("Welcome, " + username);
        JButton btnViewCourses = new JButton("View Courses");
        JButton btnViewStudents = new JButton("View Students");
        JButton btnAssignGrade = new JButton("Assign Grade");

        // Layout
        setLayout(new GridLayout(4, 1));
        add(lblWelcome);
        add(btnViewCourses);
        add(btnViewStudents);
        add(btnAssignGrade);

        // Button Actions
        btnViewCourses.addActionListener(e -> JOptionPane.showMessageDialog(this, "List of courses you teach..."));
        btnViewStudents.addActionListener(e -> JOptionPane.showMessageDialog(this, "Students in the selected course..."));
        btnAssignGrade.addActionListener(e -> JOptionPane.showMessageDialog(this, "Assigning a grade..."));

        setVisible(true);
    }
}
