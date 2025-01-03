package org;

import org.UI.GUI;
import org.UI.TUI;
import org.clase.ManagerDate;

public class Clase {
    public static void main(final String[] args) {
        final ManagerDate mgr = new ManagerDate();
        final TUI consola     = new TUI(mgr);
        final GUI gui         = new GUI(mgr);
        consola.start();
        gui.start();
    }
}
