#include <iostream>

int main() {
    int nr = 0, suma = 0;

    for(;;) {
        std::cout << "Nr: \e[32m";
        std::cin >> nr;

        if(nr < 0) {
            std::cout << "\e[0mNumăr invalid - negativ\n";
            continue;
        }
        else if(nr <= 1) {
            std::cout << "\e[0mNumăr invalid - mai mic decat 2\n";
            continue;
        }
        break;
    }

    for(int i = 1; i <= nr; i++) {
        suma = suma + (i * i);
    }

    std::cout << "Suma: \e[32m" << suma << std::endl;

    return 0;
}
