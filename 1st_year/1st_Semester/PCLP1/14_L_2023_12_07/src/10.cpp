#include <iostream>
#include <fstream>

int main() {
    int temp;

    int negativ = 0, pozitiv = 0;

    std::ifstream file;
    file.open("fisier.txt");

    while(file >> temp) {
        if(temp == 0) {
            continue;
        }
        else if(temp < 0) {
            negativ++;
        }
        else {
            pozitiv++;
        }
    }

    std::cout << "Pozitive: " << pozitiv << '\n';
    std::cout << "Negative: " << negativ << '\n';
}
