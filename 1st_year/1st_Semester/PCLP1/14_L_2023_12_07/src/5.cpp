#include <iostream>

int main() {
    int i=4;
    while (i >= 1)
    {
        int j = 2;
        while(j >= 1)
        {
            std::cout << j << ' ';
            j--;
        }
        std::cout << i << std::endl;
        i--;
    }
}
