#include <iostream>

int main() {
    char litera;
    std::cin >> litera;
    litera = toupper(litera);

    switch(litera) {
        case 'A':
        case 'B':
        case 'C':
            std::cout << 2 << std::endl;
            break;
        case 'D':
        case 'E':
        case 'F':
            std::cout << 3 << std::endl;
            break;
        case 'G':
        case 'H':
        case 'I':
            std::cout << 4 << std::endl;
            break;
        case 'J':
        case 'K':
        case 'L':
            std::cout << 5 << std::endl;
            break;
        case 'M':
        case 'N':
        case 'O':
            std::cout << 6 << std::endl;
            break;
        case 'P':
        case 'R':
        case 'S':
            std::cout << 7 << std::endl;
            break;
        case 'T':
        case 'U':
        case 'V':
            std::cout << 6 << std::endl;
            break;
        case 'W':
        case 'X':
        case 'Y':
            std::cout << 7 << std::endl;
            break;
        default:
            std::cout << "Incorect" << std::endl;
    }

    return 0;
}
