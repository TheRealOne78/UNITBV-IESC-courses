#include <iostream>

int main() {
    std::cout << "Caracter\tcodASCII"  << "\n";

    std::cout << static_cast<char>(35)  << "\t\t" << 35  << "\n";
    std::cout << static_cast<char>(64)  << "\t\t" << 64  << "\n";
    std::cout << static_cast<char>(65)  << "\t\t" << 65  << "\n";
    std::cout << static_cast<char>(96)  << "\t\t" << 96  << "\n";
    std::cout << static_cast<char>(97)  << "\t\t" << 97  << "\n";
    std::cout << static_cast<char>(122) << "\t\t" << 122 << "\n";
    std::cout << static_cast<char>(15)  << "\t\t" << 15  << std::endl;

    return 0;
}
