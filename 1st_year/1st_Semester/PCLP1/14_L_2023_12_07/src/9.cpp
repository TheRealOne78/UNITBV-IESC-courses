#include <iostream>

int main() {

    std::cout << "n: \e[32m";

    int n;
    std::cin >> n;

    std::cout << "\e[0m";

    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <= i; j++) {
            std::cout << j << " ";
        }
        std::cout << "\n";
    }

}
