//********************************************
// Programul Dreptunghi.cpp
// Acest program calculeaza perimetrul si aria
// unui dreptunghi cand se cunosc lungimea si latimea sa.
//********************************************

#include <iostream>

using namespace std;

int main() {
    double lungime;    //Lungimea dreptunghiului
    double latime;     //Latimea dreptunghiului
    double perimetrul; //Perimetrul dreptunghiului
    double aria;       //Aria dreptunghiului

    lungime = 10.7;
    latime  = 5.2;

    perimetrul = (lungime * 2) + (latime * 2);
    aria       = lungime * latime;

    cout << "Perimetrul: " << perimetrul << "\n";
    cout << "Aria: " << aria << endl;

    return 0;
}
