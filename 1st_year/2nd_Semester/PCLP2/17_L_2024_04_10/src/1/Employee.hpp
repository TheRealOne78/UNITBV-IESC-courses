#ifndef EMPLOYEE_H
#define EMPLOYEE_H

#include <iostream>

using namespace std;

class Employee {
    public:
        Employee();
        Employee(string, string);
        void print();
    protected:
        string firstName;
        string lastName;
};

#endif
