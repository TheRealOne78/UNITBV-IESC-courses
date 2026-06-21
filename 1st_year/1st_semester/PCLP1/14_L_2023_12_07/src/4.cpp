#include <iostream>

int main() {
    int number = 2;
    bool done = false;
    int i = 0;
    while (!done) {
        number = number * 2;
        if (number > 64)
            done = true;
        i++;
    }
    std::cout << i;
}
