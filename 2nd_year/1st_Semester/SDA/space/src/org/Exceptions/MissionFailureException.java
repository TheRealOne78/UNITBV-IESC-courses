package org.Exceptions;

public class MissionFailureException extends Exception {
    // Parameterless Constructor
    public MissionFailureException() {}

    // Constructor that accepts a message
    public MissionFailureException(String message)
    {
        super(message);
    }
}
