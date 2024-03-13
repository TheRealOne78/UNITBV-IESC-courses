#ifndef __DREAPTA_HPP__
#define __DREAPTA_HPP__

#include "punct.hpp"

class Dreapta {
    public:
        Dreapta(double = 0, double = 0, double = 0, double = 0);
        void setDreapta(double, double, double, double);
        Punct getPoint1();
        Punct getPoint2();

    private:
        Punct p1;
        Punct p2;

};

#endif // __DREAPTA_HPP__
