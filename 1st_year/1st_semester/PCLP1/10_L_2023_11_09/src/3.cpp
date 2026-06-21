#include <iostream>

int main() {
    int unIntreg = 10;
    double unReal;

    unReal = double(5 + unIntreg);
    unIntreg = int(2.5 * unIntreg / unReal);

    std::cout << "unReal: " << unReal << "\n";
    std::cout << "unIntreg: " << unIntreg << std::endl;

    return 0;
}
