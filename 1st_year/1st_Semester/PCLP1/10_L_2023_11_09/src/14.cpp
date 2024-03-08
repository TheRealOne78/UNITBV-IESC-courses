#include <iostream>

int main() {
    const int numar = 42339;

    double temp1 = numar;

    /* Adu-l pe numar de la x la 0.x */
    while (temp1 > 10)
        temp1 = temp1 / 10.0;

    while (temp1 <= double(numar)) {
        std::cout << int(temp1) % 10 << "   ";
        temp1 = temp1 * 10;
    }

    std::cout << std::endl;

    return 0;
}
