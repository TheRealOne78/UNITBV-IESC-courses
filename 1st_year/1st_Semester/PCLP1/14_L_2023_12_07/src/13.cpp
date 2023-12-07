#include <iostream>

int main() {
    char ch;
    int nr;

    std::cout << "Caracter: ";
    std::cin >> ch;

    std::cout << "Număr: ";
    std::cin >> nr;

    if (nr % 2 == 0)
        nr++;

    int spatii = nr / 2;
    int chars = 1;

    for (int i = 0; i < nr; i++) {
        for (int j = 0; j < spatii; j++) {
            std::cout << ' ';
        }
        for (int j = 0; j < chars; j++) {
            std::cout << ch;
        }
        std::cout << '\n';

        if (i < nr / 2) {
            spatii--;
            chars += 2;
        } else {
            spatii++;
            chars -= 2;
        }
    }

    return 0;
}
