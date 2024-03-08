/*
 * Scrieţi o instrucţiune prin care să asignaţi valoarea true variabilei candidat
 * de tip bool daca notaBac este mai mare sau egală decât 9,35, mediaMate nu este
 * mai mică decât 9,15 şi varsta este mai mare de 18. În caz contrar, candidat
 * primeşte valoarea false.
 */

#include <iostream>

int main() {
    bool candidat;
    double notaBac, mediaMate;
    int varsta;

    std::cout << "Nota bac: ";
    std::cin  >> notaBac;

    std::cout << "Media Mate: ";
    std::cin  >> mediaMate;

    std::cout << "Varsta: ";
    std::cin  >> varsta;

    if (notaBac >= 9.35 && mediaMate > 9.15 && varsta > 18)
        candidat = true;
    else
        candidat = false;

    if (candidat)
        std::cout << "\nTrue" << std::endl;

    return 0;
}
