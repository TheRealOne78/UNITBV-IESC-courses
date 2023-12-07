//********************************************************
//Venituri.cpp
//Acest program citeste un fisier de venituri clasificate
//dupa sezul persoanelor care le realizeaza. Calculeaza
//media veniturilor pentru fiecare sex.
//********************************************************
#include <iostream>
#include <iomanip>
#include <fstream>
using namespace std;

int main() {
    char sex;
    int contorF;
    int contorB;
    double venit;
    double sumaF;
    double sumaB;
    double mediaF;
    double mediaB;
    ifstream fVenituri;

    cout.setf(ios::fixed, ios::floatfield);
    cout.setf(ios::showpoint);
    cout << setprecision(2);

//Initializeaza conditia de oprire
    fVenituri.open("venituri.dat");
    if(!fVenituri)
    {
        cout << "Eroare: Nu se poate deschide fisierul de venituri" << endl;
        return 1;
    }

    fVenituri >> sex >> venit;//Prima citire din fisier

//Initializarea procesului
    contorF = 0;
    sumaF = 0.0;
    contorB = 0;
    sumaB = 0.0;

    while(fVenituri)
    {
//Actualizarea procesului
        cout << "Sex: " << sex << " Venit: " << venit
             << endl;

        if(!(sex == 'B' || sex == 'F')) {
            cout << "\e[31m EROARE: Sex invalid!\n\e[0m";
        }
        else if(venit < 0) {
            cout << "\e[31m EROARE: venit negativ.. omitere\n\e[0m";
        }
        else if(sex == 'F')
        {
            contorF++;
            sumaF = sumaF + venit;
        }
        else
        {
            contorB++;
            sumaB = sumaB + venit;
        }

//Actualizarea conditiei de oprire
        fVenituri >> sex >> venit;
    }

    if(contorB != 0 && contorF != 0) {
//Calculeaza mediile veniturilor
    mediaF = sumaF / static_cast<double>(contorF);
    mediaB = sumaB / static_cast<double>(contorB);

//Afiseaza rezultatele
    cout << "Pentru " << contorF << " femei, "
         << "media veniturilor este " << mediaF << endl;
    cout << "Pentru " << contorB << " barbati, "
         << "media veniturilor este " << mediaB << endl;
    }
    else
        cout << "Fisier gol" << std::endl;

    return 0;
}
