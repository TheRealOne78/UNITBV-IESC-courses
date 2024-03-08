#include <iostream>
#include <iomanip>

/* PI */
#define PI 3.14159

int main() {
    /* Raza */
    double raza = 6.75;

    std::cout << "Raza: " << raza << "\n\n";

    double diametrul, lungimea, aria_cercului;

    diametrul = raza * 2;
    lungimea = 2 * PI * raza;
    aria_cercului = PI * raza * raza;

    std::cout << std::fixed << std::setprecision(5);
    std::cout << "Diametrul: " << diametrul << "\n";
    std::cout << "Lungimea: " << lungimea << "\n";
    std::cout << "Aria cercului: " << aria_cercului << std::endl;

    return 0;
}
