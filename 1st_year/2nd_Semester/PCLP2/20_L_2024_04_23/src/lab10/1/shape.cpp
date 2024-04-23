#include <iostream>

using namespace std;

class Shape{
    public:
        virtual void printShapeName() const {
            cout << "Shape::printShapeName()" << endl;
        }

        void init() const {
            cout << "Shape::init()" << endl;
        }
};

class Point : public Shape{
    public:
        void printShapeName() const {
            cout << "Point::printShapeName()" << endl;
        }

        void init() const {
            cout << "Point::init()" << endl;
        }
};

int main() {
    cout << "Functii apelate prin pointer la Shape:" << endl;

    Shape* shapePtr = new Shape();
    shapePtr->printShapeName();
    shapePtr->init();
    cout << "\nFunctii apelate prin pointer la Shape "
         << "initializat prin pointer la Point:" << endl;

    Point* pointPtr = new Point();
    shapePtr = pointPtr;
    cout << "Comportament polimorfic: ";
    shapePtr->printShapeName();
    shapePtr->init();

    cout << "\nFunctii apelate prin obiect de tip Shape:"
         << endl;
    Shape shape;
    shape.printShapeName();
    shape.init();

    cout << "\nFunctii apelate prin obiect de tip Point:"
         << endl;
    Point point;
    point.printShapeName();
    point.init();

    cout << "\nFunctie non-virtuala apelata prin pointer la "
         << "Shape:" << endl;
    shapePtr = &point;
    cout << "Comportament non-polimorfic: ";
    shapePtr->init();
    return 0;
}
