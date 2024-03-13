#include "dreapta.hpp"

Dreapta::Dreapta(double p1_x, double p1_y, double p2_x, double p2_y) {
    setDreapta(p1_x, p1_y, p2_x, p2_y);
}

void Dreapta::setDreapta(double p1_x, double p1_y, double p2_x, double p2_y) {
    p1.setPoint(p1_x, p1_y);
    p2.setPoint(p2_x, p2_y);
}

Punct Dreapta::getPoint1() {
    return p1;
}

Punct Dreapta::getPoint2() {
    return p2;
}
