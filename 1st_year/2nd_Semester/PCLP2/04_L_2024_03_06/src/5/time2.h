#ifndef TIME2_H
#define TIME2_H
class Time {

public:
    Time();                      //constructor
    Time(int);                   //constructor
    Time(int, int);              //constructor
    Time(int, int, int);         //constructor
    void setTime(int, int, int); //asignarea valorilor
    void printShort();           //tiparire in format scurt
    void printLong ();           //tiparire in format lung
    void tick();                 //incrementare second
private:
    int hour;                    //0-23
    int minute;                  //0-59
    int second;                  //0-59
};

#endif /* TIME2_H */
