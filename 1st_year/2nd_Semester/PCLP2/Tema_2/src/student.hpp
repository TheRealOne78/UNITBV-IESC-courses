#include <cstdint>

class Student {
    public:
        /* Constructors */
        Student(uint16_t,
                char*,
                char*,
                float,
                float,
                float);

        /* Setters */
        void set_nr_matricol(uint16_t);

        void set_nume(char*);
        void set_prenume(char*);

        void set_medie_admitere(float);

        void set_nota_materie_1(float);
        void set_nota_materie_2(float);
        void set_nota_materie_3(float);

        /* Getters */
        uint16_t get_nr_matricol();

        char*    get_nume();
        char*    get_prenume();

        float    get_medie_admitere();

        float    get_nota_materie_1();
        float    get_nota_materie_2();
        float    get_nota_materie_3();

        /* Misc */
        bool is_integralist();
        bool has_bursa_merit();
        bool has_bursa_studiu();

        void printStudentData();

    private:

        uint16_t nr_matricol;

        char* nume;
        char* prenume;

        float medie_admitere;

        float nota_materie_1;
        float nota_materie_2;
        float nota_materie_3;

        bool  integralist;
        bool  bursa_merit;
        bool  bursa_studiu;

    protected:
        Student();
};
