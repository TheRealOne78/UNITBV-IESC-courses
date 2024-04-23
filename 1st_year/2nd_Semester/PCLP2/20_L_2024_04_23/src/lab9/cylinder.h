#ifndef CYLINDER_H
#define CYLINDER_H
#include <iostream>
using std::ostream;
#include "circle.h"
class Cylinder : public Circle
{
    friend ostream& operator<<(ostream&, const Cylinder&);
public:
//constructor implicit
    Cylinder(double h = 0.0, double r = 0.0,
             int x = 0, int y = 0);
    void setHeight(double); //seteaza inaltimea
    double getHeight() const; //returneaza inaltimea
    double area() const; //calculeaza aria cilindrului
    double volume() const; //calculeaza volumul cilindrului
protected:
    double height; //inaltimea cilindrului
};
#endif
