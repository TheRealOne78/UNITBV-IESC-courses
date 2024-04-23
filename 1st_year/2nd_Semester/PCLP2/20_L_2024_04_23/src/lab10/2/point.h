#ifndef POINT_H
#define POINT_H

#include <iostream>

using std::ostream;
class Point {
    friend ostream& operator<<(ostream&, const Point&);
public:
    Point(int = 0, int = 0); //constructor implicit
    void setPoint(int, int); //seteaza coordonatele
    int getX() const { return x; } //returneaza x
    int getY() const { return y; } //returneaza y
    virtual double area();
protected: //accesibil din clasele derivate
    int x, y; //x si y coordonatele unui punct
};

#endif
