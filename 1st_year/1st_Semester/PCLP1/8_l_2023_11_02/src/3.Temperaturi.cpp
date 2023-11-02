//****************************************
//Temperaturi.cpp
//Acest program calculeaza temperatura de
//la jumatatea dintre punctul de inghet si
//cel de fierbere a apei
//****************************************

#include <iostream>
//using namespace std;

const float INGHET = 0.0;       //Punctul de inghet al apei
const float FIERBERE = 100.0;   //Punctul de fierbere

int main() {
    float temperaturaMedie; //Pastreaza rezultatul medierii
                            //dintre INGHET si FIERBERE

    std::cout << "Apa ingheata la " << INGHET << " grade";
    std::cout << " si fierbe la " << FIERBERE << " de grade." << std::endl;

    temperaturaMedie = INGHET + FIERBERE;
    temperaturaMedie = temperaturaMedie / 2.0;
    std::cout << "Temperatura medie este de ";
    std::cout << temperaturaMedie << " grade." << std::endl;

    return 0;
}
