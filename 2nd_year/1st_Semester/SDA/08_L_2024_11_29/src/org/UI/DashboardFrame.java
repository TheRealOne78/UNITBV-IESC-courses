package org.UI;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


class DashboardFrame extends JFrame {
    private homeFrame homeFrame;
    private JPanel panel;
    public DashboardFrame(homeFrame loginFrame) {
        this.homeFrame = loginFrame;
        setTitle("Dashboard");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        JLabel welcomeLabel = new JLabel("Welcome to your dashboard!", JLabel.CENTER);
        add(welcomeLabel);
        JButton backButton = new JButton("Back");
        backButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                setVisible(false);
                loginFrame.setVisible(true);
            }
        });
        panel = new JPanel();
        panel.add(backButton);
        add(panel);
    }
}
