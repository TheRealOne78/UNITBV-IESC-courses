package org.clase;

public class Curs {
    String nume;
    String descriere;
    Profesor profu;
    Student[] studenti;
    int[] note_studenti;

    public Curs(String nume, String descriere, Profesor profu, Student[] studenti) {
        this.nume          = nume;
        this.descriere     = descriere;
        this.profu         = profu;
        this.studenti      = studenti;
        this.note_studenti = new int[this.studenti.length];
    }

    public void UpdateProfesor(Profesor profu) {
        this.profu = profu;
    }

    public void AddStudent(Student student) {
        //lucrand cu array trebuie inserat folosind un sir auxiliar
        int noualungime = studenti.length + 1;
        Student[] aux = new Student[noualungime];
        int index = 0;
        for(Student s : studenti) {
            aux[index++] = s;
        }
        //la final adaugam noul student pe ultimul index
        aux[index] = student;
        //si realocam lista de studenti cu aux;
        this.studenti = new Student[noualungime];
        System.arraycopy(aux, 0, studenti, 0, noualungime);
    }

    public void DelStudent(String nume) {
        int tmp_indx = -1;

        for (int i = 0; i < studenti.length; i++) {
            if (studenti[i].getNume().equals(nume)) {
                tmp_indx = i;
                break;
            }
        }

        if (tmp_indx != -1) {
            Student[] aux = new Student[studenti.length - 1];
            int index = 0;

            for (int i = 0; i < studenti.length; i++) {
                if (i != tmp_indx)
                    aux[index++] = studenti[i];

                this.studenti = aux;
            }
        }
    }

    public void UpdateStudent(Student student_old, Student student_nou) {
        for(Student s : this.studenti) {
            if(s.equals(student_old))
                s = student_nou;
        }
    }

    public void AfiseazaStudentiLaConsola() {
        for(Student s : this.studenti)
            System.out.println(s);
    }

    @Override
    public String toString() {
        String str = "Curs: " + "nume=" + nume + ", descriere=" + descriere + ",\nprofu=" + profu + ",\nstudenti:\n" ;

        for(Student s : studenti)
            str+= s + "\n";

        return str;
    }

}
