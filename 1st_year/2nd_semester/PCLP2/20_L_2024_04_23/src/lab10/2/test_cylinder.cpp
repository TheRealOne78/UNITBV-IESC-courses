#include<iostream>

using std::cout;
using std::endl;

#include"point.h"
#include "circle.h"
#include "cylinder.h"

int main() {
    Circle *circle     = new Circle(2, 5, 6);
    Cylinder *cylinder = new Cylinder(5.7, 2.5, 12, 23);

    cout << "== non-poly ==\n"
        "circle: " << circle->area() << '\n' <<
        "cylinder: " << cylinder->area() << "\n\n\n";

    cout << "== poly ==\n";

    Circle *circle2     = circle;
    Cylinder *cylinder2 = cylinder;

    circle = cylinder2;

    cout <<
        "circle: " << circle->area() << '\n' <<
        "cylinder-base: " << cylinder << '\n';

    return 0;
}
