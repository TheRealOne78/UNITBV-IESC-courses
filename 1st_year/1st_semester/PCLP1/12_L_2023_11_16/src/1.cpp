//****************************************************
//Notare.cpp
//Acest program determina
//(1) media unui student pe baza a trei teste partiale
//(2) calificativul acordat studentului
//****************************************************
#include <iostream>
#include <iomanip> //pentru setprecision()

using namespace std;

int main() {
    double media;
    int numarMatricol;
    int nota1;
    int nota2;
    int nota3;
    bool dataOK;

    cout.setf(ios::fixed, ios::floatfield);
    cout.setf(ios::showpoint);

    //Citeste datele
    cout << "Introduceti nr. matricol al studentului"
         << " si cele 3 note ca valori intregi: "
         << endl;
    cin >> numarMatricol >> nota1 >> nota2 >> nota3;
    cout << "Nr. matricol: " << numarMatricol
         << ". Cele trei note: " << nota1 << ", "
         << nota2 << ", " << nota3 << endl;

    //Testeaza datele
    if (nota1 < 0 || nota2 < 0 || nota3 < 0)
        dataOK = false;
    else
        dataOK = true;
    if (dataOK) {
        //Calculeaza media
        media = static_cast<double>(nota1 + nota2 + nota3)/static_cast<double>(3);

        //Tipareste mesajul
        cout << "Media este "
             << setprecision(2) << media << "--";
        if (media >= 5.0) {
            cout << "Admis";
            if (media < 6.0)
                cout << " cu nota sub 6";
            cout << '.' << endl;
        }
        else {
            cout << "Respins." << endl;
        }
    }
    else {
        cout << "Date incorecte" << endl;
    }

    return 0;
}
