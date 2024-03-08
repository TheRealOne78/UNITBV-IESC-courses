#include <iostream>

using namespace std;

int main() {

    int varsta;
    cin >> varsta;

    if (varsta > 64)
        cout << "Senior";
    else if (varsta < 18)
        cout << "Minor";
    else
        cout << "Adult";

    cout << endl;

    return 0;
}
