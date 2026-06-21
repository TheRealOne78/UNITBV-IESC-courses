#include "cerc.hpp"

Cerc::Cerc(double coord_x, double coord_y, double radius) : point(coord_x, coord_y) {
    /* Set radius length */
    this->radius = radius;
}

double Cerc::getPointCoordX() {
    return this->point.getCoordX();
}

double Cerc::getPointCoordY() {
    return this->point.getCoordY();
}

double Cerc::getRadius() {
    return this->radius;
}
