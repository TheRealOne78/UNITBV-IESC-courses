package org;

import java.util.Comparator;
import java.util.List;

public class Main {
    private static List<SpaceMission> crewedMissionsList;
    private static List<SpaceMission> uncrewedMissionsList;

    public static void main (String[] args) {
        // Load the lists
        CSVLoader loader     = new CSVLoader("spacemissions.csv");
        crewedMissionsList   = loader.getCrewedMissionsList();
        uncrewedMissionsList = loader.getUncrewedMissionsList();

        System.out.println("CREWED\n"   + crewedMissionsList);
        System.out.println("UNCREWED\n" + uncrewedMissionsList);

        // Group stuff
        System.out.println('\n');

        // Filter and sort crewed missions by destination, excluding "Luna"
        List<SpaceMission> sortedCrewedMissions = crewedMissionsList.stream()
            .filter(mission -> !"Luna".equalsIgnoreCase(mission.getDestination())) // Exclude "Luna"
            .sorted(Comparator.comparing(SpaceMission::getDestination)) // Sort by destination
            .toList(); // Collect into a sorted list (Java 16+)

        // Print sorted missions
        sortedCrewedMissions.forEach(System.out::println);
    }
}
