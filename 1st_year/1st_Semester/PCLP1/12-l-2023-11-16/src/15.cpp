#include <iostream>
#include <math.h>

int main() {
    double a, b, c, radacina1, radacina2, discriminant;

    std::cout << "a: ";
    std::cin >> a;

    std::cout << "b: ";
    std::cin >> b;

    std::cout << "c: ";
    std::cin >> c;

    discriminant = pow(b, 2) - 4 * a * c;

    radacina1 = (-b + sqrt(discriminant)) / (2 * a);
    radacina2 = (-b - sqrt(discriminant)) / (2 * a);

    if(discriminant < 0) {
        std::cout << "Rădăcinile sunt complexe" << std::endl;
        return 0;
    }

    printf("Radacina 1: %lf\nRadacina 2: %lf\n", radacina1, radacina2);

    return 0;
}
