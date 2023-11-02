#include <iostream>

//using namespace std;

const float CANT1 = 23.2;
const float CANT2 = 17.4;
const float CANT3 = 19.8;
const float CANT4 = 16.7;
const float INDICATIE_PLECARE = 22451;
const float INDICATIE_SOSIRE = 23544;

int main() {
    float litriPerKm;

    litriPerKm = (CANT1 + CANT2 + CANT3 + CANT4) * 100.0 / (INDICATIE_SOSIRE-INDICATIE_PLECARE);

    std::cout << "Pentru cantitatile" << std::endl;
    std::cout << CANT1 << ' ' << CANT2 << ' ';
    std::cout << CANT3 << ' ' << CANT4 << std::endl;
    std::cout << "si indicatia de plecare " << INDICATIE_PLECARE << std::endl;
    std::cout << "si de sosire " << INDICATIE_SOSIRE << std::endl;
    std::cout << "consumul este " << litriPerKm << " litri per km." << std::endl;

    return 0;
}
