#include <iostream>
#include <fstream>

int main() {
    int contor = 0;
    int temp;

    std::ifstream file;
    file.open("fisier.txt");

    for(int i = 0; i <= 100; i++) {
        if(file >> temp && temp == 28) {
            contor++;
        }
    }

    std::cout << "Contor: " << contor << std::endl;
}
