#ifndef __TRIUNGHI_HPP__
#define __TRIUNGHI_HPP__

#include "punct.hpp"

class Triunghi {
    public:
        /* Constructors */
        Triunghi(double, double, double, double, double, double);

        /* setters */
        void setV1(double, double);
        void setV2(double, double);
        void setV3(double, double);

        /* getters */
        double getV1x();
        double getV2x();
        double getV3x();

        double getV1y();
        double getV2y();
        double getV3y();

        /* Misc */
        int validate_triangle();
        double arie();
        bool isDreptunghic();
        double getLength(Punct, Punct);
        double getLengthLatura_1();
        double getLengthLatura_2();
        double getLengthLatura_3();

    private:
        Punct punct_1;
        Punct punct_2;
        Punct punct_3;
};


#endif // __TRIUNGHI_HPP__
