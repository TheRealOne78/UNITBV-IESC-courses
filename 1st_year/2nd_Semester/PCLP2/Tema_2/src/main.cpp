#include <iostream>
#include "grupa.hpp"

int main(void) {
    Grupa grupa;

    grupa.addStudent(1 , (char*)"Bogdan" , (char*)"Marian" , 10.f, 10.f, 10.f);
    grupa.addStudent(2 , (char*)"David"  , (char*)"Clark"  , 4.5f, 4.2f, 3.6f);
    grupa.addStudent(3 , (char*)"John"   , (char*)"Doe"    , 8.5f, 8.5f, 8.5f);
    grupa.addStudent(4 , (char*)"Alice"  , (char*)"Smith"  , 4.1f, 8.2f, 9.5f);
    grupa.addStudent(5 , (char*)"Emily"  , (char*)"Wilson" , 2.3f, 3.8f, 4.2f);
    grupa.addStudent(6 , (char*)"Bob"    , (char*)"Johnson", 2.8f, 7.3f, 8.9f);
    grupa.addStudent(7 , (char*)"Jane"   , (char*)"Doe"    , 3.9f, 6.5f, 9.8f);
    grupa.addStudent(8 , (char*)"Sophia" , (char*)"Roberts", 3.9f, 2.8f, 4.1f);
    grupa.addStudent(9 , (char*)"Foo"    , (char*)"Bar"    , 4.0f, 9.0f, 10.f);
    grupa.addStudent(10, (char*)"Michael", (char*)"Brown"  , 3.7f, 8.4f, 9.2f);

    std::cout << "> Printeaza numer de studenti (inainte de purge): ";
    std::cout << grupa.getStudentCount() << '\n';
    std::cout << "\n\n";

    std::cout << "> Printeaza numere matricole (inainte de purge):\n";
    grupa.getStudentIDs();
    std::cout << "\n\n";

    std::cout << "> Printeaza nume/prenume student nr 6:\n";
    std::cout << grupa.getStudentByID(6).get_nume() << ' ' << grupa.getStudentByID(6).get_prenume() << '\n';
    std::cout << "\n\n";

    std::cout << "> Incearca sa elimini manual student gresit (9):\n";
    grupa.delStudent(9);
    std::cout << "\n\n";

    std::cout << "> Elimina manual student corect (8):\n";
    grupa.delStudent(8);
    std::cout << "(no output)\n\n\n";

    std::cout << "> (Printeaza numarul de studenti (inainte de purge automat): ";
    std::cout << grupa.getStudentCount() << '\n';
    std::cout << "\n\n";

    std::cout << "> Printeaza numere matricole (inainte de purge automat):\n";
    grupa.getStudentIDs();
    std::cout << "\n\n";

    std::cout << "> Elimina automat studentii inapti:\n";
    grupa.delStudentAuto();
    std::cout << "(no output)\n\n\n";

    std::cout << "> (Printeaza numarul de studenti (dupa purge automat): ";
    std::cout << grupa.getStudentCount() << '\n';
    std::cout << "\n\n";

    std::cout << "> Printeaza numere matricole (dupa purge automat):\n";
    grupa.getStudentIDs();
    std::cout << "\n\n";

    std::cout << "> Gaseste student prin ID corect (6):\n";
    try {
        grupa.getStudentByID(6);
        grupa.printStudentByID(6);
    }
    catch(...) {
        std::cerr << "\033[33mID invalid\033[0m\n";
    }
    std::cout << "\n\n";

    std::cout << "> Gaseste student prin ID incorect (0):\n";
    try {
        grupa.getStudentByID(0);
        grupa.printStudentByID(0);
    }
    catch(...) {
        std::cerr << "\033[33mID invalid\033[0m\n";
    }
    std::cout << "\n\n";


    std::cout << "> Printeaza studenti cu burse de studiu:\n";
    grupa.printAllBursaStudiu();
    std::cout << "\n\n";

    std::cout << "> Printeaza studenti cu burse de merit:\n";
    grupa.printAllBursaMerit();

    return 0;
}
