#include <iostream>
#include "point.h"
//Constructor pentru clasa Point
Point::Point(int a, int b)
{ setPoint(a, b); }

//Seteaza coordonatele x si y ale unui punct
void Point::setPoint(int a, int b)
{
    x = a;
    y = b;
}

//Afiseaza un punct
ostream& operator<<(ostream& output, const Point& p)
{
    output << '[' << p.x << ", " << p.y << ']';
    return output; //pentru cascadarea apelurilor
}

double Point::area() {
    return 0;
}
