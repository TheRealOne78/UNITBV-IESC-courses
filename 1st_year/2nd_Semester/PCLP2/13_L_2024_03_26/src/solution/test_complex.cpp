#include <iostream>
#include "complex.h"

using std::cout;
using std::endl;

int main() {
    Complex n1(2,4);
    Complex n2(1,-3);

    n2 = n1 + n2;
    cout << "Adunare:\n" << n2.getReal() << "; " << n2.getImaginar() << endl;

    cout << "\n\n== Rezolvare ==\n";

    n2 = n1 * n2;
    cout << "\nInmultire:\n" << n2.getReal() << "; " << n2.getImaginar() << endl;

    n2 = !n2;
    cout << "\n!:\n" << n2.getReal() << "; " << n2.getImaginar() << endl;

    cout << "\n<<:\n" << n2 << "\n";

    return 0;
}
