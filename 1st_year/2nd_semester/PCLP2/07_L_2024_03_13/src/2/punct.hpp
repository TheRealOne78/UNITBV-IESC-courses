#ifndef __PUNCT_HPP__
#define __PUNCT_HPP__

class Punct {
    public:
        Punct(double = 0, double = 0);
        void setPoint(double, double);
        double getCoordX();
        double getCoordY();

    private:
        double x, y;
};

#endif // __PUNCT_HPP__
