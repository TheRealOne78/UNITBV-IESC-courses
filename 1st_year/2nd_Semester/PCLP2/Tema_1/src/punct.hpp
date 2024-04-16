#ifndef __PUNCT_HPP__
#define __PUNCT_HPP__

class Punct {
    public:
        /* Constructors */
        Punct(double, double);

        /* Setters */
        void set_x(double);
        void set_y(double);

        /* Getters */
        double get_x();
        double get_y();

    private:
        double x;
        double y;
};

#endif // __PUNCT_HPP__
