#include <iostream>
#include "queue.hpp"

using std::cout;

int main() {
    Queue<double> doubleQueue(5);
    double f = 1.1;
    cout << "Inserarea elementelor in doubleQueue\n";

    while(doubleQueue.push(f)) {
        cout << f << ' ';
        f += 1.1;
    }

    cout << "\nStiva este plina. "
         << "Nu se mai poate insera elementul " << f
         << "\n\nExtragerea elementelor din doubleQueue\n";

    while(doubleQueue.pop(f))
        cout << f << ' ';
    cout << "\nStiva este goala. "
         << "Nu se mai pot extrage elemente\n";
    return 0;
}
