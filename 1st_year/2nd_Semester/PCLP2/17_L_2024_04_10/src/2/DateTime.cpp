#include <iostream>
#include "DateTime.hpp"

DateTime::DateTime() {
    year = month = day = hour = minute = second = 0;
}

void DateTime::setTime(int y, int month, int d, int h, int m, int s) {
    year = y;
    this->month = (month >= 1 && month <= 12) ? month : 1;
    day = (d >= 1 && d <= 30) ? d : 1;
    hour = (h >= 0 && h < 24) ? h : 0;
    minute = (m >= 0 && m < 60) ? m : 0;
    second = (s >= 0 && s < 60) ? s : 0;
}

void DateTime::printShort() {
    std::cout << (hour < 10 ? "0" : "") << hour << ":"
         << (minute < 10 ? "0" : "") << minute;
}

void DateTime::printLong() {
    std::cout
        << year << '.' << month << '.' << day << ' '
        << ((hour == 0 || hour == 12) ? 12 : hour % 12)
        << ":" << (minute < 10 ? "0" : "") << minute
        << ":" << (second < 10 ? "0" : "") << second
        << (hour < 12 ? " AM" : " PM");
}
