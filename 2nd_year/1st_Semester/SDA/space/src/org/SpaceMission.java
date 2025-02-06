package org;

class SpaceMission {
    private int crewSize;
    private int year;
    private String destination;

    public SpaceMission() {
        this.crewSize = 0;
    }

    public SpaceMission(int crewSize) {
        this.crewSize = crewSize;
        this.year     = 0;
    }

    public SpaceMission(int crewSize,
                        int year,
                        String destination)
    {
        this.crewSize    = crewSize;
        this.year        = year;
        this.destination = destination;
    }

    public int getCrewSize() {
        return crewSize;
    }

    public void setCrewSize(int crewSize) {
        this.crewSize = crewSize;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    @Override
    public String toString() {
        if(this.year <= 2000)
            return "";
        return "SpaceMission [crewSize=" + crewSize + ", year=" + year + ", destination=" + destination + "]";
    }
}
