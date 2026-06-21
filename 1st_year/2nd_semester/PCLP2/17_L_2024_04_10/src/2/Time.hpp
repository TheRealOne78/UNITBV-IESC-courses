#ifndef __TIME_HPP__
#define __TIME_HPP__

class Time {
    public:
        Time(); //constructor
        void setTime(int, int, int); //asignarea valorilor
        void printShort(); //tiparire in format scurt
        void printLong (); //tiparire in format lung
    protected:
        int hour; //0-23
        int minute; //0-59
        int second; //0-59
};


#endif // __TIME_HPP__
