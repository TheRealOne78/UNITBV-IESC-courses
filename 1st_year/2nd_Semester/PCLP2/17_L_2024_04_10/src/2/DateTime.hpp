#ifndef __DATETIME_HPP__
#define __DATETIME_HPP__

#include "Time.hpp"

class DateTime : public Time {
    public:
        DateTime(); //constructor
        void setTime(int, int, int, int, int, int); //asignarea valorilor
        void printShort();
        void printLong();
    private:
        int year;
        int month;
        int day;
};


#endif // __DATETIME_HPP__
