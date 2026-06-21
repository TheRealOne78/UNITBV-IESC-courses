#include "punct.hpp"

Punct::Punct(double x, double y) {
    set_x(x);
    set_y(y);
}

void Punct::set_x(double x) {
    this->x = x;
}

void Punct::set_y(double y) {
    this->y = y;
}

double Punct::get_x() {
    return this->x;
}

double Punct::get_y() {
    return this->y;
}
