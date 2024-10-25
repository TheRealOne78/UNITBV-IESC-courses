package org.clase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ManagerCursuri {
    Curs[] cursuri;
    public ManagerCursuri() {
        Connection conn = null;
        cursuri = new Curs[0];
    }

    public void AddCurs(Curs curs) {
        int noualungime = cursuri.length+1;
        Curs[] aux = new Curs[noualungime];
        int index = 0;
        for(Curs c : cursuri)
            aux[index++] = c;
        //la final adaugam noul curs pe ultimul index
        aux[index] = curs;
        //si realocam lista de curs cu aux;
        this.cursuri = new Curs[noualungime];
        System.arraycopy(aux, 0, cursuri, 0, noualungime);
    }

    public void DelCurs(String nume) {
        int tmp_indx = -1;

        for (int i = 0; i < cursuri.length; i++) {
            if (cursuri[i].nume.equals(nume)) {
                tmp_indx = i;
                break;
            }
        }

        if (tmp_indx != -1) {
            Curs[] aux = new Curs[cursuri.length - 1];
            int index = 0;

            for (int i = 0; i < cursuri.length; i++) {
                if (i != tmp_indx) {
                    aux[index++] = cursuri[i];
                }
            }

            this.cursuri = aux;
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
}
