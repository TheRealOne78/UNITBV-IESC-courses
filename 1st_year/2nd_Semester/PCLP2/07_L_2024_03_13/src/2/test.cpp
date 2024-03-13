#include <iostream>

#include "dreapta.hpp"

int main(int argc, char* argv[]) {
    Dreapta d1(13.2, 12.0, -5.6, -9.3);

    /* Afiseaza valoare pentru d1 */
    std::cout << "Valoare curenta pentru d1:\n" <<
        "p1_x: " << d1.getPoint1().getCoordX() << '\t' <<
        "p1_y: " << d1.getPoint1().getCoordY() << "\n\n" <<

        "p2_x: " << d1.getPoint2().getCoordX() << '\t' <<
        "p2_y: " << d1.getPoint2().getCoordY() << "\n\n\n\n";

    /* Seteaza valoare pentru d2 */
    d1.setDreapta(1.5, 2.3, 12.5, 0.7);

    std::cout << "Valoare noua pentru d1:\n" <<
        "p1_x: " << d1.getPoint1().getCoordX() << '\t' <<
        "p1_y: " << d1.getPoint1().getCoordY() << "\n\n" <<

        "p2_x: " << d1.getPoint2().getCoordX() << '\t' <<
        "p2_y: " << d1.getPoint2().getCoordY() << "\n\n";

    return 0;
}
