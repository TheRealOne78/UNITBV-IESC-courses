#include <iostream>

using namespace std;

int main() {
    int length, width, height;

    length = 25;
    width = 60;
    if (length == 50) /* era atribuire, trebuie schimbat in comparatie */
        height = 4;
    else
        height = 8;
    cout << length << ' ' << width << ' ' << height << endl;

    return 0;
}
