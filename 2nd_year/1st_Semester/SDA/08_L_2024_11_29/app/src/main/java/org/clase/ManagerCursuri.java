package org.clase;

import java.util.List;
import java.util.ArrayList;

public class ManagerCursuri implements OperatiiManagerCursuri {
    List<Curs> cursuri = new ArrayList<Curs>();
    public ManagerCursuri() {
    }

    public void AddCurs(Curs curs) {
        cursuri.add(curs);
    }

    public void DeleteCurs(Curs curs) {
        for (var tmp : cursuri) {
            if (tmp.equals(curs))
                cursuri.remove(tmp);
        }
    }

    public void UpdateCurs(Curs curs_vechi, Curs curs_nou) {
        for(Curs c : cursuri) {
            if(c.equals(curs_vechi))
                c = curs_nou;
        }
    }

    public void AfiseazaCursuriLaConsola() {
        for(Curs c : cursuri)
            System.out.println(c);
    }

    public void AfiseazaNoteStudenti() {
        for(Curs c: cursuri)
            c.AfiseazaNoteStudenti();
    }

    public void AfiseazaMedieProfesor(Profesor profesor) {
        float suma = 0;
        int i = 0;

        for(var tmp : cursuri) {
            if(tmp.getProfu().equals(profesor)) {
                suma += tmp.GetMedie();
                i++;
            }
        }

        System.out.println("Medie profesor " + profesor.getNume() + " " + profesor.getPrenume() + ": " + suma/i);
    }
}
