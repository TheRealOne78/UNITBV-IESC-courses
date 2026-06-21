// Program CostLocuinta.cpp
// Acest program calculeaza costul pe metru patrat al spatiului locuibil
// dintr-o casa, date fiind dimensiunile casei, numarul de etaje
// si suprafata nelocuibila

#include <iostream>
#include <iomanip>   // Pentru setw() si setprecision()

using namespace std;

const double LATIME            = 15.0;     // Latimea casei
const double LUNGIME           = 12.0;     // Lungimea casei
const double ETAJE             = 2;        // Numarul de etaje, inclusiv parterul
const double SPATIU_NELOCUIBIL = 31.0;     // Garaj, WC, etc.
const double PRET              = 128000.0; // Pretul de vanzare

int main() {
    double suprafataTotala;    // Suprafata totala
    double suprafataLocuibila; // Suprafata locuibila
    double costPerMP;          // Costul pe metru patrat al suprafetei locuibile

    cout.setf(ios::fixed, ios::floatfield); // Stabilirea formatului de iesire
    cout.setf(ios::showpoint);              // pt. float

    suprafataTotala    = LUNGIME * LATIME * ETAJE;
    suprafataLocuibila = suprafataTotala - SPATIU_NELOCUIBIL;
    costPerMP          = PRET / suprafataLocuibila;

    cout << "Costul pe metru patrat este " << setw(6) << setprecision(2)
         << costPerMP << " lei." << endl;

    return 0;
}
