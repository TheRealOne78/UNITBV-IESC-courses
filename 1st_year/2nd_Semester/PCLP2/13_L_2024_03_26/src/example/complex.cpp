#include "complex.h"

Complex:: Complex(double r, double i) {
    real = r;
    imaginar = i;
}

void Complex::setReal(double r) {
    real = r;
}

double Complex::getReal() {
    return real;
}

void Complex::setImaginar(double i) {
    imaginar = i;
}

double Complex::getImaginar() {
    return imaginar;
}

Complex Complex::operator+(Complex c) {
    Complex nc;
    nc.setReal(real+c.real);
    nc.setImaginar(imaginar+c.imaginar);
    return nc;
}
