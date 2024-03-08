#include <iostream>
#include <math.h>

int main() {
    double a = 56, b = 200 , c = 80, y;

    y = -b + sqrt(b * b - (4.0 * a * c));

    std::cout << y << std::endl;
}
