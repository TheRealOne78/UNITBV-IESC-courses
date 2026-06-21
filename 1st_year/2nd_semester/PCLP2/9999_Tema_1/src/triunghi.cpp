#include <iostream>
#include <cmath>

#include "triunghi.hpp"

/* Constructs */
Triunghi::Triunghi(double v1_x, double v1_y,
                   double v2_x, double v2_y,
                   double v3_x, double v3_y):
    punct_1(v1_x, v1_y),
    punct_2(v2_x, v2_y),
    punct_3(v3_x, v3_y) {

    if (Triunghi::validate_triangle() != 0) {
        std::cerr << "Triunghi invalid!" << std::endl;
    }
}

/* Setters */
void Triunghi::setV1(double v1_x, double v1_y) {
    punct_1.set_x(v1_x);
    punct_1.set_y(v1_y);
}

void Triunghi::setV2(double v2_x, double v2_y) {
    punct_2.set_x(v2_x);
    punct_2.set_y(v2_y);
}

void Triunghi::setV3(double v3_x, double v3_y) {
    punct_3.set_x(v3_x);
    punct_3.set_y(v3_y);
}

/* Getters */
double Triunghi::getV1x() {
    return punct_1.get_x();
}

double Triunghi::getV1y() {
    return punct_1.get_y();
}

double Triunghi::getV2x() {
    return punct_2.get_x();
}

double Triunghi::getV2y() {
    return punct_2.get_y();
}

double Triunghi::getV3x() {
    return punct_3.get_x();
}

double Triunghi::getV3y() {
    return punct_3.get_y();
}

/* Misc */
int Triunghi::validate_triangle() {
    double l1 = getLengthLatura_1();
    double l2 = getLengthLatura_2();
    double l3 = getLengthLatura_3();

    if(l1 + l2 <= l3 || l1 + l2 <= l3 || l1 + l2 <= l3)
        return 1; /* Invalid lengths */

    return 0; /* OK */
}

double Triunghi::arie() {
    double l1 = getLengthLatura_1();
    double l2 = getLengthLatura_2();
    double l3 = getLengthLatura_3();

    return 0.25 * std::sqrt((l1 + l2 + l3) *
                            (-l1 + l2 + l3) *
                            (l1 - l2 + l3) *
                            (l1 + l2 - l3));
}

bool Triunghi::isDreptunghic() {
    double l1 = getLengthLatura_1();
    double l2 = getLengthLatura_2();
    double l3 = getLengthLatura_3();

    if(((l1 * l1) + (l2 * l2) == (l3 * l3)) ||
       ((l1 * l1) + (l3 * l3) == (l2 * l2)) ||
       ((l2 * l2) + (l3 * l3) == (l1 * l1)))
        return true;

    return false;
}

double Triunghi::getLength(Punct p1, Punct p2) {
    return std::sqrt(
        std::pow((p2.get_x() - p1.get_x()), 2) +
        std::pow((p2.get_y() - p1.get_y()), 2)); /* return */
}

double Triunghi::getLengthLatura_1() {
    return Triunghi::getLength(this->punct_1, this->punct_2);
}

double Triunghi::getLengthLatura_2() {
    return Triunghi::getLength(this->punct_2, this->punct_3);
}

double Triunghi::getLengthLatura_3() {
    return Triunghi::getLength(this->punct_1, this->punct_3);
}
