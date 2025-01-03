package org.UI;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserManager {
    private static String FILE_NAME = "users.txt";

    public static List<User> readUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_NAME))) {
            String line;
            line = reader.readLine();
            while ((line = reader.readLine()) != null) {
                String[] splituri = line.split(",");
                if (splituri.length == 2) {
                    users.add(new User(splituri[0], splituri[1]));
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading users: " + e.getMessage());
        }
        return users;
    }

    public static void writeUser(User user) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_NAME, true))) {
            writer.write(user.toString());
            writer.newLine();
        } catch (IOException e) {
            System.err.println("Error writing user: " + e.getMessage());
        }
    }

    public static boolean authenticate(String username, String password) {
        List<User> userList = readUsers();
        for (User user : userList) {
            if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
    }
}
