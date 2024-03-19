#include "punct.hpp"

Punct::Punct(double coord_x, double coord_y) {
    this->setPoint(coord_x, coord_y);
}

void Punct::setPoint(double coord_x, double coord_y) {
    this->coord_x = coord_x;
    this->coord_y = coord_y;
}

double Punct::getCoordX() {
    return this->coord_x;
}

double Punct::getCoordY() {
    return this->coord_y;
}
