#include <iostream>
#include <cstring>
#include "employee1.h"
#include "date1.h"

using std::cout;
using std::endl;

Employee::Employee(char* fname, char*lname,
                   int bday, int bmonth, int byear,
                   int hday, int hmonth, int hyear)
    : birthDate(bday, bmonth, byear),
      hireDate(hday, hmonth, hyear) {

    //copiaza fname in firstName verificand daca lungimea corespunde
    int length = strlen(fname);
    length = (length < 25 ? length : 24);
    strncpy( firstName, fname, length);
    firstName[length] = '\0';

    //copiaza lname in lastName verificand daca lungimea corespunde
    length = strlen(lname);
    length = (length < 25 ? length : 24);
    strncpy( lastName, lname, length);
    lastName[length] = '\0';
    cout << "Constructorul obiectului Employee: "
         << firstName << ' ' << lastName << endl;
}

void Employee::print() const {
    cout << lastName << ", " << firstName << "\nAngajat: ";
    hireDate.print();
    cout << " Data nasterii: ";
    birthDate.print();
    cout << endl;
}

//Destructorul folosit pentru confirmarea stergerii obiectului
Employee::~Employee() {
    cout << "Destructorul obiectului de tip Employee: "
         << lastName << ", " << firstName << endl;
}
