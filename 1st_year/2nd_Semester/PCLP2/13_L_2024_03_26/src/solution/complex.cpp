#include "complex.h"
#include <ostream>

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
    nc.setReal(real + c.real);
    nc.setImaginar(imaginar + c.imaginar);
    return nc;
}

Complex operator*(Complex& a, Complex& b) {
    Complex nc;
    nc.setReal(a.getReal() * b.getReal());
    nc.setImaginar(a.getImaginar() * b.getImaginar());

    return nc;
}

Complex Complex::operator!() {
    Complex nc;
    nc.setReal(this->real);
    nc.setImaginar(-imaginar);

    return nc;
}

std::ostream& operator<<(std::ostream &out, Complex c) {
    out << c.getReal() << ", " << c.getImaginar();
    return out;
}
