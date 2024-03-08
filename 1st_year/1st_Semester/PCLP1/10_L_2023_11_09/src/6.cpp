#include <iostream>

int main() {
    std::cout << "Ce valoare se păstrează în variabila rezultat de tip int în fiecare dintre următoarele instrucţiuni: \n\n";

    std::cout << "rezultat = 15 % 4;\n";
    std::cout << "rezultat = 7 / 3 + 2;\n";
    std::cout << "rezultat = 2 + 7 * 5;\n";
    std::cout << "rezultat = 45 / 8 * 4 + 2;\n";
    std::cout << "rezultat = 17 + (21 % 6) * 2;\n";
    std::cout << "rezultat = int(4.5 + 2.6 * 0.5);\n\n";

    std::cout << "Raspuns: Intotdeauna un intreg." << std::endl;

    return 0;
}
