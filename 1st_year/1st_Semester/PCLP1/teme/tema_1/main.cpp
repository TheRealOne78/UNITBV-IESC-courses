#include <iostream>
#include <fstream>

#ifndef Coeficient_CO2
# define Coeficient_CO2 420
#endif /* Coeficient_CO2 */

int main() {
    /* ==EXERCITIUL 1== */
    std::cout << "Exercitiul 1:\n";
    std::cout << "Introduceti Zi_1 Ora_1 Minutul_1 Zi_2 Ora_2 Minutul_2: \e[32m";

    int zi_1, ora_1, minutul_1, zi_2, ora_2, minutul_2;
    std::cin >> zi_1 >> ora_1 >> minutul_1 >> zi_2 >> ora_2 >> minutul_2;
    std::cout << "\e[0m\n";


    /* ==EXERCITIUL 2== */
    std::cout << "\nExercitiul 2:\n";
    std::ifstream csv;

    /* Deschidere fisier */
    csv.open("CPUPowerUse.csv");

    if(!csv.is_open()) {
        std::cout << "Eroare: Fișierul nu se poate citi" << std::endl;
        return 1;
    }

    /* Ignorare prima linie din CSV */
    while(csv.get() != '\n')
        continue;

    int temp, temp_zi, temp_ora, temp_min, temp_CPU_usage, suma_CPU_usage = 0, contor = 0;

    /* Start range */
    while(csv >> temp >> temp >> temp_zi >> temp_ora >> temp_min >> temp_CPU_usage) {
        if (temp_zi == zi_1 && temp_ora == ora_1 && temp_min == minutul_1) {
            suma_CPU_usage += temp_CPU_usage;
            contor++;
            break;
        }
    }

    /* Read range */
    while(csv >> temp >> temp >> temp_zi >> temp_ora >> temp_min >> temp_CPU_usage) {
        if (temp_zi == zi_2 && temp_ora == ora_2 && temp_min == minutul_2)
            break;
        suma_CPU_usage += temp_CPU_usage;
        contor++;
    }

    /* Inchidere fisier */
    csv.close();

    /* Printare rezultate exercitiul 2 */
    std::cout << "Contor: \e[31m" << contor;
    std::cout << "\e[0m\nSuma CPU Usage: \e[31m" << suma_CPU_usage;
    std::cout << "\e[0m\n";

    /* ==EXERCITIUL 3== */
    std::cout << "\nExercitiul 3:\n";

    /* calculare medie */
    std::cout << "Consum mediu: \e[33m" << suma_CPU_usage / contor << "\e[0m\n";

    /* ==EXERCITIUL 4== */
    std::cout << "\nExercitiul 4:\n";
    double suma_kwh = suma_CPU_usage / 1000.f;
    std::cout << "Amprenta de carbon: \e[34m" << (suma_kwh * Coeficient_CO2) << std::endl;

    return 0;
}
