#include "HourlyWorker.hpp"
#include <iomanip>
HourlyWorker::HourlyWorker(string fn, string ln,
                           double w, double h) {
    firstName = fn;
    lastName =ln;
    wage = w;
    hours = h;
}

void HourlyWorker::print() {
    cout << endl << "Se executa HourlyWorker::print()"
         << endl;
    Employee::print();
    cout << "Se revine la functia HourlyWorker::print()"
         << endl;
    cout << "--este platit cu "
         << setiosflags(ios::fixed | ios::showpoint)
         << setprecision(2) << getPay() << " Lei" << endl;
}

double HourlyWorker::getPay() {
    return wage * hours;
}
