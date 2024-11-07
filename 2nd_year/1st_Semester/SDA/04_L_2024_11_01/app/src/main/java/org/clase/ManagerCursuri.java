package org.clase;

public class ManagerCursuri implements OperatiiManagerCursuri {
    Curs[] cursuri;
    public ManagerCursuri() {
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

    public void DeleteCurs(Curs curs) {
        int tmp_indx = -1;

        for (int i = 0; i < cursuri.length; i++) {
            if (cursuri[i].equals(curs)) {
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

    public void AfiseazaNoteStudenti() {
        for(Curs c: cursuri)
            c.AfiseazaNoteStudenti();
    }

    public void AfiseazaMedieProfesor(Profesor profesor) {
        float suma = 0;
        int i;
        for(i = 0; i < this.cursuri.length; i++)
            if(cursuri[i].getProfu().equals(profesor))
                suma += this.cursuri[i].GetMedie();

        System.out.println("Medie profesor " + profesor.getNume() + " " + profesor.getPrenume() + ": " + suma/i);
    }
}
