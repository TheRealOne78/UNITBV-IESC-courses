package org.clase;

public interface OperatiiManagerCursuri {

    ///** DEPRECATED
    // * Adds a new course to the system.
    // *
    // * @param curs The course to be added.
    // */
    //public void AddCurs(Curs curs);

    /**
     * Updates an existing course with new details.
     *
     * @param curs_vechi The course to be replaced (old version).
     * @param curs_nou The new course to replace the old course.
     */
    public void UpdateCurs(Curs curs_vechi, Curs curs_nou);

    /**
     * Deletes a course from the system.
     *
     * @param curs The course to be deleted.
     */
    public void DeleteCurs(Curs curs);
}
