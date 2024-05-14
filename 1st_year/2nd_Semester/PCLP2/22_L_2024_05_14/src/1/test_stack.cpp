#include <iostream>

using std::cout;
using std::cin;
using std::endl;

#include "stack.h"

int main() {
    Stack<double> doubleStack(5);
    double f = 1.1;
    cout << "Inserarea elementelor in doubleStack\n";
    while(doubleStack.push(f))
    {
        cout << f << ' ';
        f += 1.1;
    }
    cout << "\nStiva este plina. "
         << "Nu se mai poate insera elementul " << f
         << "\n\nExtragerea elementelor din doubleStack\n";
    while(doubleStack.pop(f))
        cout << f << ' ';
    cout << "\nStiva este goala. "
         << "Nu se mai pot extrage elemente\n";
    return 0;
}
