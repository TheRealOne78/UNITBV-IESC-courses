#ifndef __COMPLEX_H__
#define __COMPLEX_H__

class Complex {
    public:
        Complex(double=0, double=0);
        void setReal(double);
        double getReal();
        void setImaginar(double);
        double getImaginar();
        Complex operator+(Complex);
    private:
        double real;
        double imaginar;
};

#endif // __COMPLEX_H__
