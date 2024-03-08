#include <iostream>

/* Valoarea Celsius */
#define Celsius 12

using namespace std;

int main() {
    /* Valoarea Fahrenheit */
    double Fahrenheit;

    /* Converteste din Celsius in Fehrenheit */
    Fahrenheit = 9 * double(Celsius) / 5 + 32;

    /* Tipareste C si F */
    cout << "Celsius: " << Celsius << "\n";
    cout << "Fahrenheit: " << Fahrenheit << std::endl;

    return 0;
}
