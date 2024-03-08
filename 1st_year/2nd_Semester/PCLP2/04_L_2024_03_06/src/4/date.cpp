#include <iostream>
using std::cout;
using std::endl;
//Varianta simplificata a clasei Date
class Date {
    public:
//constructor implicit
        Date(int = 1, int = 1, int = 1990);
        void print();
    private:
        int day;
        int month;
        int year;
};

//constructor fara verificarea valorilor
Date::Date(int d, int m, int y) {
    day = d;
    month = m;
    year = y;
}

//Tipareste data in forma zi-luna-an
void Date::print() {
    cout << day << '-' << month << '-' << year;
}

int main() {
    Date date1(5, 3, 2007), date2;
    cout << "date1 = ";
    date1.print();
    cout << endl << "date2 = ";
    date2.print();
    date2 = date1;//asignare prin copierea membru cu membru
    cout << endl << endl
         << "Dupa copierea membru cu membru, date2 = ";
    date2.print();
    cout << endl;
    return 0;
}
