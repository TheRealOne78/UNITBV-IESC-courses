#ifndef DATE1_H
#define DATE1_H

class Date {
public:
// constructor implicit
    Date(int = 1, int = 1, int = 1990);
    void print() const;
    ~Date();
private:
    int day; //1-12
    int month;//1-31
    int year;
// functie utilitara de testare a
// corectitudinii zilei pentru month si year
    int checkDay(int);
};

#endif // DATE_H
