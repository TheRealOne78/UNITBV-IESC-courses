/*
 * 12. Scrieţi un program care afişează următoarele trei linii:
 * 7 / 4 folosind impartirea intreaga este <rezultat>
 * 7 / 4 folosind impartirea reala este <rezultat>
 * 7 modulo 4 este <rezultat>
 * unde <rezultat> este calculat în fiecare caz de programul vostru. Folosiţi
 * constante simbolice pentru 7 si 4 peste tot unde va apar in program, inclusiv
 * in instrucţiunile de afişare. Folosiţi comentarii în program, identificatori
 * cu nume semnificative şi aliniaţi instrucţiunile ca in programele de la
 * punctele 1 şi 2.
 */

#include <iostream>

int main() {
    std::cout << "7 / 4 folosind impartirea intreaga este " << 7 / 4 << "\n";
    std::cout << "7 / 4 folosind impartirea reala este " << 7.f / 4.f << "\n";
    std::cout << "7 modulo 4 este " << 7 % 4 << std::endl;

    return 0;
}
