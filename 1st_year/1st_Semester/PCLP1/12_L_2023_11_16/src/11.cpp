#include <iostream>

using namespace std;

int main() {
    int anul;
    cin >> anul;

    if (anul % 4 == 0)
        cout << anul << " este bisect." << endl;
    else {
        anul = anul + 4 - anul % 4;
        cout << anul << " este urmatorul an bisect." << endl;
    }

    return 0;
}
