#include <iostream>
#include "time2.h"

using std::cout;

Time::Time() {
    setTime(0, 0, 0);
}

Time::Time(int hr) {
    setTime(hr, 0, 0);
}

Time::Time(int hr, int min) {
    setTime(hr, min, 0);
}

Time::Time(int hr, int min, int sec) {
    setTime(hr, min, sec);
}

void Time::setTime(int h, int m, int s) {
    hour = (h >= 0 && h < 24) ? h : 0;
    minute = (m >= 0 && m < 60) ? m : 0;
    second = (s >= 0 && s < 60) ? s : 0;
}

void Time::printShort() {
    cout << (hour < 10 ? "0" : "") << hour << ":"
         << (minute < 10 ? "0" : "") << minute;
}

void Time::printLong() {
    cout << ((hour == 0 || hour == 12) ? 12 : hour % 12)
         << ":" << (minute < 10 ? "0" : "") << minute
         << ":" << (second < 10 ? "0" : "") << second
         << (hour < 12 ? " AM" : " PM");
}

void Time::tick() {
    if (second >= 59) {
        if (minute >= 59) {
            if (hour >= 23) {
                hour = 0;
            }
            else
                hour++;

            minute = 0;
        }
        else
            minute++;

        second = 0;
    }
    else
        second++;

    Time::setTime(hour, minute, second);
}
