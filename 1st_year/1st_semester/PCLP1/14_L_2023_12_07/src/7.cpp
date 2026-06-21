#include <iostream>

int main() {
    int i = 1, sum, j;
    while (i <= 5)
    {
        sum = 0;
        j = 1;
        while (j <= i) {
            sum = sum + 1;
            j++;
        }
        std::cout << sum << ' ';
        i++;
    }
}
