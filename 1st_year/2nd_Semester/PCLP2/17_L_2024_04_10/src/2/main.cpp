#include <iostream>
#include "DateTime.hpp"

int main() {
    DateTime t; //instantiaza obiectul t de tip Time

    std::cout << "Valoarea initialia in format lung este ";
    t.printLong();

    t.setTime(2012, 10, 4, 13, 27, 6);

    std::cout << "\n\nOra in format lung dupa setTime este ";
    t.printLong();

    return 0;
}
