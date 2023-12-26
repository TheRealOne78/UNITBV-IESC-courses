#include <iostream>
#include <fstream>
#include <math.h>

int main() {

    /*** == Initializare variable == ***/
    double entropy = 0;

    char parola[10];
    /* Initializare array cu NULL */
    for(unsigned int i = 0; i <= sizeof(parola) / sizeof(char); i++)
        parola[i] = '\0';

    int cnt[sizeof(parola) / sizeof(char)];
    /* Initializare array cu 0 */
    for(unsigned int i = 0; i <= sizeof(cnt) / sizeof(int); i++)
        cnt[i] = 0;



    /*** == Deschidere fisier == ***/
    std::ifstream file;
    file.open("parola.dat");

    /* Verificare accesibilitate fisier */
    if (!file) {
        std::cout << "parola.dat neaccesibil" << std::endl;
        exit(1);
    }



    /*** == Citire si validare fisier == ***/
    unsigned int nr = 0;
    while(file >> parola[nr++]) {
        if(nr >= sizeof(parola) / sizeof(char)) {
            std::cout << "Parola a ajuns la 10 cifre, in cazul in care sunt mai multe cifre in fisier, ele vor fi ignorate\n";
            break;
        }
    }

    if(nr == 0) {
        std::cout << "Fisier gol, nu se poate calcula nimic." << std::endl;
        exit(1);
    }

    for(unsigned int i = 0; i < nr; i++) {
        if(parola[i] == '\n' || parola[i] == '\0') {
            nr--;
            break;
        }
        else if(parola[i] < '0' || parola[i] > '9') {
            std::cout << "Eroare: Pozitia " << i << " contine un caracter non-numeric" << std::endl;
            exit(1);
        }

        /*
         * Contorizeaza fiecare aparitie de caracter, si indexeaza-l.
         * Exemplu: Daca in parola apare de 3 ori '6', atunci `cnt[6] == 3'
         *
         * In cazul in care un anumit caracter nu apare in parola, valoarea sa va fi 0.
         * Exemplu: Daca in parola nu apare '8', atunci `cnt[8] == 0`
         */
        cnt[parola[i] - '0']++;
    }



    /*** == Pregatire calculare entropie (probabilitati) == ***/
    int ratio[10];
    /* Initializare array cu 0 */
    for(unsigned int i = 0; i <= sizeof(ratio) / sizeof(int); i++)
        ratio[i] = 0;

    /* Calculare probabilitati */
    for(unsigned int i = 0; i <= (sizeof(ratio) / sizeof(int)); i++) {
        if(cnt[i] == 0)
            continue;

        (ratio[cnt[i] - 1])++;
    }



    /*** == Calculare entropie == ***/
    for(unsigned int i = 0; i <= (sizeof(cnt) / sizeof(int)); i++) {
        if (ratio[i] == 0)
            continue;

        entropy += -(ratio[i] * double(i + 1) / nr) * (log(double(i + 1) / nr) / log(2.f));
    }



    /*** == Afisare rezultat entropie == ***/
    std::cout << "Entropie: \e[32m" << entropy << std::endl;



    return 0;
}
