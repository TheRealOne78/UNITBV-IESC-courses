#include "student.hpp"
#include <iostream>

Student::Student() {}

/* Constructors */
Student::Student(uint16_t nr_matricol,
                 char* nume,
                 char* prenume,
                 float nota_materie_1,
                 float nota_materie_2,
                 float nota_materie_3) {

    Student::set_nr_matricol(nr_matricol);
    Student::set_nume(nume);
    Student::set_prenume(prenume);
    Student::set_nota_materie_1(nota_materie_1);
    Student::set_nota_materie_2(nota_materie_2);
    Student::set_nota_materie_3(nota_materie_3);
}

/* Setters */
void Student::set_nr_matricol(uint16_t nr_matricol) {
    this->nr_matricol = nr_matricol;
}

void Student::set_nume(char* nume) {
    this->nume = nume;
}

void Student::set_prenume(char* prenume) {
    this->prenume = prenume;
}

void Student::set_medie_admitere(float nota_admitere) {
    this->medie_admitere = nota_admitere;

}

void Student::set_nota_materie_1(float nota_materie_1) {
    this->nota_materie_1 = nota_materie_1;
}

void Student::set_nota_materie_2(float nota_materie_2) {
    this->nota_materie_2 = nota_materie_2;

}

void Student::set_nota_materie_3(float nota_materie_3) {
    this->nota_materie_3 = nota_materie_3;
}

/* Getters */
uint16_t Student::get_nr_matricol() {
    return this->nr_matricol;
}

char* Student::get_nume() {
    return this->nume;
}

char* Student::get_prenume() {
    return this->prenume;
}

float Student::get_medie_admitere() {
    try {
        this->medie_admitere = (this->nota_materie_1 +
                                this->nota_materie_2 +
                                this->nota_materie_3) / 3;
    }
    catch(...) {
        std::cerr << "Ceva nu a mers ok" << std::endl;
        return 0;
    }

    return this->medie_admitere;
}

float Student::get_nota_materie_1() {
    return this->nota_materie_1;
}

float Student::get_nota_materie_2() {
    return this->nota_materie_2;
}

float Student::get_nota_materie_3() {
    return this->nota_materie_3;
}


bool Student::is_integralist() {
    if(get_nota_materie_1() < 5 ||
       get_nota_materie_2() < 5 ||
       get_nota_materie_3() < 5) {
        return false;
    }

    return true;
}

bool Student::has_bursa_merit() {
    if(get_medie_admitere() < 9.5f)
        return false;

    return true;
}

bool Student::has_bursa_studiu() {
    if(get_medie_admitere() < 8.5f)
        return false;

    return true;
}

void Student::printStudentData() {
    std::cout << "\033[32m" <<
        '(' << this->get_nr_matricol() << ") " <<
        this->get_nume() << ' ' <<
        this->get_prenume() << "\033[0m\n";
}
