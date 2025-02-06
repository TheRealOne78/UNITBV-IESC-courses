package org;

import java.util.List;

import org.Exceptions.MissionFailureException;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;

class CSVLoader {
    private List<SpaceMission> crewedMissionsList   = new ArrayList<>();
    private List<SpaceMission> uncrewedMissionsList = new ArrayList<>();

    CSVLoader(String path) {
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            br.readLine(); // Skip CSV header

            String line;
            while ((line = br.readLine()) != null) {
                try {

                String[] fields = line.split(",");
                // CREW_SIZE YEAR SUCCESSFU

                if(fields[2].trim().equals("No") ) {
                    throw new MissionFailureException();
                }

                SpaceMission spaceMission =
                    new SpaceMission(Integer.valueOf(fields[0].trim()),
                                     Integer.valueOf(fields[1].trim()),
                                     fields[3]);

                if(Integer.valueOf(fields[0].trim()) == 0)
                    uncrewedMissionsList.add(spaceMission);
                else
                    crewedMissionsList.add(spaceMission);
                } catch (Exception ex) {
                    System.out.println("Eroare la incarcare misiuni: " + ex.getMessage());
                    continue;
                }
            }

            br.close();
        } catch (Exception ex) {
            System.out.println("Eroare la incarcare misiuni: " + ex.getMessage());
        }
    }

    public List<SpaceMission> getCrewedMissionsList() {
        return crewedMissionsList;
    }

    public List<SpaceMission> getUncrewedMissionsList() {
        return uncrewedMissionsList;
    }
}
