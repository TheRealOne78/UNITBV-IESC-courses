#ifndef DATEANDTIME_H
#define DATEANDTIME_H

#include "time2.h"

class DateAndTime: Time {
    public:
        DateAndTime(int = 0, int = 0, int = 0, int = 0, int = 0, int = 0);
        void setTime(int, int, int, int, int, int);

    private:
        int year;
        int month;
        int day;
};

#endif // DATEANDTIME_H
