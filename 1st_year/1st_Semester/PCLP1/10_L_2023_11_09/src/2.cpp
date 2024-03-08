//**********************************************************
//Programul Excursie.cpp
//Acest program calculeaza distanta totala parcursa
//intr-o excursie, date fiind masuratorile facute pe o harta
//**********************************************************

#include <iostream>
#include <iomanip>

using namespace std;

const double DISTANTA1 = 1.5;  //Masuratoarea primei distante
const double DISTANTA2 = 2.5;  //Masuratoarea celei de-a doua distante
const double DISTANTA3 = 5.0;  //Masuratoarea celei de-a treia distante
const double DISTANTA4 = 4.0;  //Masuratoarea celei de-a patra distante
const double SCARA     = 0.25; //Scara hartii

int main() {
    double distantaTotala;
    double km;

    cout.setf(ios::fixed, ios::floatfield);
    cout.setf(ios::showpoint);

    distantaTotala = 0.0;

    // Calculeaza distanta reala pentru fiecare citire de pe harta

    km = double(int( DISTANTA1 * SCARA * 10.0 +0.5)) / 10.0;
    cout << "Pentru masuratoarea " << setprecision(1)
         << DISTANTA1
         << " prima distanta este de " << km << " km."
         << endl;
    distantaTotala = distantaTotala + km;

    km = double(int( DISTANTA2 * SCARA * 10.0 +0.5)) / 10.0;
    cout << "Pentru masuratoarea " << setprecision(1)
         << DISTANTA2
         << " a doua distanta este de " << km << " km."
         << endl;
    distantaTotala = distantaTotala + km;

    km = double(int( DISTANTA3 * SCARA * 10.0 +0.5)) / 10.0;
    cout << "Pentru masuratoarea " << setprecision(1)
         << DISTANTA3
         << " a treia distanta este de " << km << " km."
         << endl;
    distantaTotala = distantaTotala + km;

    km = double(int( DISTANTA4 * SCARA * 10.0 +0.5)) / 10.0;
    cout << "Pentru masuratoarea " << setprecision(1)
         << DISTANTA4
         << " a patra distanta este de " << km << " km."
         << endl;
    distantaTotala = distantaTotala + km;

    // Afisarea distantei totale
    cout << endl;
    cout << "Distanta totala care trebuie parcursa este "
         << distantaTotala << " km."
         << endl;

    return 0;
}
