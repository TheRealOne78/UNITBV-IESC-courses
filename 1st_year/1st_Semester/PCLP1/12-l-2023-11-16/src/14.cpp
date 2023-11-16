#include <iostream>

using namespace std;

int main() {

    int a, b;
    cin >> a;

    if (a < 20 && a > 0) {
        cout << "A este in domeniu." << endl;
        b = 5;
    }
    else if (a >= 20) {
        cout << "A este prea mare." << endl;
        b = 3;
    }
    else
        cout << "A este prea mic." << endl;

    cout << "Terminat." << endl;

    return 0;
}
