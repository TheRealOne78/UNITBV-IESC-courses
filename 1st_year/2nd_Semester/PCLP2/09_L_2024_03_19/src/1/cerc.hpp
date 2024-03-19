#ifndef __CERC_HPP__
#define __CERC_HPP__

#include "punct.hpp"

class Cerc {
    public:
        Cerc(double, double, double);

        double getPointCoordX();
        double getPointCoordY();

        double getRadius();

    private:
        Punct point;
        double radius;
};

#endif // __CERC_HPP__
