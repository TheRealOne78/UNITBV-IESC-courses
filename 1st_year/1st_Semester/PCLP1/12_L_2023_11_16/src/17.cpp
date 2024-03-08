#include <iostream>

int main() {
    int ziua_iuliana, ziua_din_saptamana;

    std::cout << "Ziua iuliana: ";
    std::cin >> ziua_iuliana;

    ziua_din_saptamana = (ziua_iuliana + 1) % 7;

    std::cout << "Ziua din saptamana este " << ziua_din_saptamana << std::endl;

    return 0;
}
