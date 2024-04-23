#ifndef CIRCLE_H
#define CIRCLE_H
#include <iostream>
using std::ostream;
#include <iomanip>
using std::ios;
using std::setiosflags;
using std::setprecision;
#include "point.h"
class Circle : public Point //Circle derivata din Point
{
    friend ostream& operator<<(ostream&, const Circle&);
public:
//constructor implicit
    Circle(double r = 0.0, int x = 0, int y = 0);
    void setRadius(double); //seteaza radius
    double getRadius() const; //intoarce radius
    double area() const; //calculeaza aria
protected:
    double radius;
};
#endif
