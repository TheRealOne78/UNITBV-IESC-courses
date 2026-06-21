#include "grupa.hpp"
#include <cstdint>
#include <iostream>

Grupa::~Grupa(){
    this->student_list.clear();
}

/* Getters */
void Grupa::getStudentIDs(){
    for (auto student : this->student_list) {
        std::cout << student.get_nr_matricol() << ", ";
    }

    std::cout << "\b\b " << std::endl;
}

Student Grupa::getStudentByID(uint16_t ID){
    for (auto student : this->student_list){
        if(student.get_nr_matricol() == ID) {
            return student;
        }
    }

    throw "invalidID";
}

/* Misc */
void Grupa::addStudent(uint16_t ID,
                       char* nume,
                       char* prenume,
                       float materia1,
                       float materia2,
                       float materia3){

    Student *student = new Student(ID, nume, prenume, materia1, materia2, materia3);

    student_list.push_back(*student);
}

void Grupa::delStudent(uint16_t ID){
    auto tmpStudent = getStudentByID(ID);

    if(tmpStudent.get_nota_materie_1() >= 5.f ||
       tmpStudent.get_nota_materie_2() >= 5.f ||
       tmpStudent.get_nota_materie_3() >= 5.f)
    {
        std::cerr << "\033[33m\033[1mAtentie, studentul nu are toate mediile sub 5!\033[0m" << std::endl;
        return;
    }

    for (auto student = student_list.begin();
         student != student_list.end();
         student++)
    {
        if (student->get_nr_matricol() == ID) {
            student_list.erase(student);
            return;
        }
    }
}

void Grupa::delStudentAuto() {
    for (auto student = student_list.begin();
         student != student_list.end();
         student++)
    {
        if(student->get_nota_materie_1() >= 5.f ||
           student->get_nota_materie_2() >= 5.f ||
           student->get_nota_materie_3() >= 5.f) {
            continue;
        }
        student_list.erase(student);
    }
}

bool Grupa::isIDInGroup(uint16_t ID){
    for (auto student : this->student_list){
        if(student.get_nr_matricol() == ID)
            return true;
    }

    return false;
}

float Grupa::getStudentCount() {
    return this->student_list.size();
}


void Grupa::printAllBursaStudiu() {
    for (auto student = student_list.begin();
         student != student_list.end();
         student++)
    {
        if(student->has_bursa_studiu())
            student->printStudentData();
    }
}

void Grupa::printAllBursaMerit() {
    for (auto student = student_list.begin();
         student != student_list.end();
         student++)
    {
        if(student->has_bursa_merit())
            student->printStudentData();
    }
}

void Grupa::printStudentByID(uint16_t ID) {
    try {
        auto student = getStudentByID(ID);
        student.printStudentData();
    }
    catch (...) {
        std::cerr << "ID invalid\n";
        throw "invalidID";
    }
}
