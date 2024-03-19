#ifndef __PUNCT_HPP__
#define __PUNCT_HPP__

class Punct {
    public:
        Punct(double, double);

        void setPoint(double, double);
        double getCoordX();
        double getCoordY();

    private:
       double coord_x;
       double coord_y;
};

#endif // __PUNCT_HPP__
