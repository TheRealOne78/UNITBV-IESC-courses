#ifndef EMPLOYEE1_H
#define EMPLOYEE1_H

#include "date1.h"
class Employee {
public:
    Employee(char*, char*, int, int, int, int, int, int);
    void print() const;
    ~Employee(); //destructor folosit la confirmarea ordinii in care sunt sterse obiectele
private:
    char firstName[25];
    char lastName[25];
    const Date birthDate;
    const Date hireDate;
};

#endif // EMPLOYEE1_H
