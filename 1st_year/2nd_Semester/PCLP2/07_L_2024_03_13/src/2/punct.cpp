#include "punct.hpp"

Punct::Punct(double coordX, double coordY) {
    Punct::setPoint(coordX, coordY);
}

void Punct::setPoint(double coordX, double coordY) {
    x = coordX;
    y = coordY;
}

double Punct::getCoordX() {
    return x;
}

double Punct::getCoordY() {
    return y;
}
