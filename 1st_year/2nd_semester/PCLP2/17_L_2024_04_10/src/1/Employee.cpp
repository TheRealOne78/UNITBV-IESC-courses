#include "Employee.hpp"

Employee::Employee() {
    firstName = "";
    lastName = "";
}

Employee::Employee(string fn, string ln) {
    firstName = fn;
    lastName = ln;
}

void Employee::print() {
    cout << "Se executa Employee::print()" << endl;
    cout << "--Angajatul " << firstName << " "
         << lastName << endl;
}
